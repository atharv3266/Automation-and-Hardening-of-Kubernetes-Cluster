#!/bin/bash
echo "Disable Selinux"
setenforce 0

echo "Download required kernel packages"
sudo dnf install kernel-devel-$(uname -r) -y


echo "Adding Kernel modules"
sudo modprobe br_netfilter
sudo modprobe ip_vs
sudo modprobe ip_vs_rr
sudo modprobe ip_vs_wrr
sudo modprobe ip_vs_sh
sudo modprobe overlay


echo "Next, create a configuration file (as the root user on each node) to ensure these modules load at system boot"
cat > /etc/modules-load.d/kubernetes.conf << EOF
br_netfilter
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
overlay
EOF


echo "set specific sysctl settings (on each node) that Kubernetes relies on"
cat > /etc/sysctl.d/kubernetes.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

echo "Applying sysctl changes"
sysctl --system

echo "Disabling Swap"
sudo swapoff -a
sed -e '/swap/s/^/#/g' -i /etc/fstab


echo "Add the Docker CE Repository"
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo


echo "Update Package Cache"
sudo dnf makecache

echo "install the containerd.io package"
sudo dnf -y install containerd.io

echo "Building default container configuration"
sudo sh -c "containerd config default > /etc/containerd/config.toml"


#vim /etc/containerd/config.toml
CONFIG_FILE="/etc/containerd/config.toml"
# Check if SystemdCgroup is set to false
if grep -q "SystemdCgroup = false" "$CONFIG_FILE"; then
    echo "SystemdCgroup is set to false. Changing it to true..."
    # Change SystemdCgroup to true
    sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' "$CONFIG_FILE"
    echo "SystemdCgroup has been updated to true."
else
    echo "SystemdCgroup is already set to true or not set at all. No changes made."
fi

# Verify the change
echo "Verifying the change..."
grep "SystemdCgroup = true" "$CONFIG_FILE"

if [ $? -eq 0 ]; then
    echo "SystemdCgroup is correctly set to true."
else
    echo "Failed to update SystemdCgroup."
fi


echo "Start the container service at boot"
sudo systemctl enable --now containerd.service

systemctl unmask firewalld
systemctl enable firewalld
systemctl start firewalld

sudo firewall-cmd --zone=public --permanent --add-port=6443/tcp
sudo firewall-cmd --zone=public --permanent --add-port=2379-2380/tcp
sudo firewall-cmd --zone=public --permanent --add-port=10250/tcp
sudo firewall-cmd --zone=public --permanent --add-port=10251/tcp
sudo firewall-cmd --zone=public --permanent --add-port=10252/tcp
sudo firewall-cmd --zone=public --permanent --add-port=10255/tcp
sudo firewall-cmd --zone=public --permanent --add-port=5473/tcp


sudo firewall-cmd --reload

echo "Add Kubernetes Repository"
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
EOF

echo "Install Kubernetes Packages" 
dnf makecache
dnf install -y kubelet kubeadm kubectl --disableexcludes=Kubernetes

echo "Start and Enable kubelet Service"
systemctl enable --now kubelet.service

echo "Initializing Kubernetes Control Plane"
sudo kubeadm config images pull


sudo kubeadm init --pod-network-cidr=10.244.0.0/16


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml




#######################################################################################################
# Get worker IP
echo "Please enter the worker IP:"
read -r ip

# Copy worker.sh to worker node
scp ./worker.sh root@"$ip":/root/

# Execute worker.sh on worker node
ssh root@"$ip" "bash /root/worker.sh"

# Retrieve the kubeadm join command and store it in /root/join-token
kubeadm token create --print-join-command --v=5 > /root/join-token

# Make the join-token script executable
chmod +x /root/join-token

# Copy the join-token script to the worker node
scp /root/join-token root@"$ip":/root/

# Execute the join-token script on the worker node to join the cluster
ssh root@"$ip" "bash /root/join-token"

echo "####### Clustering is DONE!!!! ######"
kubectl get pods --all-namespaces
kubectl get nodes
sleep 5s

echo "####### Cluster hardening ######"
bash hardening.sh

echo "#*#*#*#*#* Cluster Hardening Completed *#*#*#*#*#"