#!/bin/bash
gr='\033[1;32m'
re='\033[1;31m'
xx='\033[0m'
yw='\033[1;33m'
bl='\033[0;34m'
mstnode1="1.1.1 The API server pod specification file permissions are set to 644 or more restrictive by this script"
mstnode2="1.1.2 The API server pod specification file ownership is set to root:root by this script"
mstnode3="1.1.3 The Controller Manager pod specification file permissions are set to 644 or more restrictive by this script"
mstnode4="1.1.4 The Controller Manager pod specification file ownership is set to root:root by this script"
mstnode5="1.1.5 The Scheduler pod specification file permissions are set to 644 or more restrictive by this script"
mstnode6="1.1.6 The Scheduler pod specification file ownership is set to root:root by this script"
mstnode7="1.1.7 The ETCD pod specification file permissions are set to 644 or more restrictive by this script"
mstnode8="1.1.8 The ETCD pod specification file ownership is set to root:root by this script"
mstnode9="1.1.13 The admin.conf file permissions are set to 644 or more restrictive by this script"
mstnode10="1.1.14 The admin.conf file ownership is set to root:root by this script"
apid1="1.2.1 The --anonymous-auth argument is set to false by this script"
apid2="1.2.2 The --basic-auth-file argument is not set by this script"
apid3="1.2.4 The --kubelet-https argument is set to true by this script"
apid4="1.2.11 The admission control plugin is not set to AlwaysAdmit by this script"
apid5="1.2.12 The admission control plugin is set to AlwaysPullImages by this script"
apid6="1.2.13 The admission control plugin is set to SecurityContextDeny by this script"
apid7="1.2.18 The --insecure-bind-address argument is not set by this script"
apid8="1.2.20 The --secure-port argument is not set to 0 by this script"
cntmgr1="1.3.2 The --profiling argument is set to false by this script"
cntmgr2="1.3.3 The --use-service-account-credentials argument is set to true by this script"
cntmgr3="1.3.4 The --service-account-private-key-file argument is set as appropriate by this script"
cntmgr4="1.3.5 The --root-ca-file argument is set as appropriate by this script"
cntmgr5="1.3.7 The --bind-address argument is set to 127.0.0.1 by this script"
scheduler1="1.4.1 The --profiling argument is set to false by this script"
scheduler2="1.4.2 The --bind-address argument is set to 127.0.0.1 by this script"
workernode1="4.1.1 Kubelet service file permissions are set to 644 or more restrictive by this script"
workernode2="4.1.2 Kubelet service file ownership is set to root:root by this script"
workernode3="4.1.5 --kubeconfig kubelet.conf file permissions are set to 644 or more restrictive by this script"
workernode4="4.1.6 --kubeconfig kubelet.conf file ownership is set to root:root by this script"
workernode5="4.1.9 The Kubelet --config configuration file has permissions set to 644 or more restrictive by this script"
workernode6="4.1.10 The Kubelet --config configuration file ownership is set to root:root by this script"
show() {
	printf "${!1}\n"
}

echo ""
echo "																";
echo "##    ##  #######   ######          ##     ##    ###    ########  ########  ######## ##    ## #### ##    ##  ######   "
echo "##   ##  ##     ## ##    ##         ##     ##   ## ##   ##     ## ##     ## ##       ###   ##  ##  ###   ## ##    ##  "
echo "##  ##   ##     ## ##               ##     ##  ##   ##  ##     ## ##     ## ##       ####  ##  ##  ####  ## ##        "
echo "#####     #######   ######  ####### ######### ##     ## ########  ##     ## ######   ## ## ##  ##  ## ## ## ##   #### "
echo "##  ##   ##     ##       ##         ##     ## ######### ##   ##   ##     ## ##       ##  ####  ##  ##  #### ##    ##  "
echo "##   ##  ##     ## ##    ##         ##     ## ##     ## ##    ##  ##     ## ##       ##   ###  ##  ##   ### ##    ##  "
echo "##    ##  #######   ######          ##     ## ##     ## ##     ## ########  ######## ##    ## #### ##    ##  ######   "
echo "                                                                                                                          ";
echo -en '\n'
echo -en "_________________________________________________________________________________________________________"
echo -en '\n'
echo ""
echo -e "${bl} ~Kubernetes Auditing & Hardening Tool~${xx}"
echo -en '\n'
echo -e "Script made by:"
echo -e "Om Patil-240340123013"
echo -e "Atharv Sathe-240340123013"
echo -e "Pratham Ingole-240340123037"
echo -e "Peeyush Shaligram-240340123036"
echo -e "Uttkarsh Yadav-240340123051"

echo -en '\n'
echo -e "Scanning and Hardening starting at..." `date`
echo -en "__________________________________________________________________________________________________________"
echo -en '\n'
echo ""
echo -en "${bl} Master Node Configuration,API Server,Controller Manager,Scheduler & Worker Node Configuration${xx}"
echo ""
echo -en "__________________________________________________________________________________________________________"
echo ""
echo -en '\n'
echo -e "######################## MASTER NODE CONFIGURATION #########################"
echo -en '\n'
mstnode1(){
node1=$(stat -c %a /etc/kubernetes/manifests/kube-apiserver.yaml)
if [[ "$node1" == 644 ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode1`
else
chmod 644 /etc/kubernetes/manifests/kube-apiserver.yaml
echo -en "${gr}[PASS]${xx}" `show mstnode1`
fi
}
mstnode1
echo -en '\n'
mstnode2(){
node2=$(stat -c %U:%G /etc/kubernetes/manifests/kube-apiserver.yaml)
if [[ "$node2" == "root:root" ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode2`
else
chown root:root /etc/kubernetes/manifests/kube-apiserver.yaml
echo -en "${gr}[PASS]${xx}" `show mstnode2`
fi
}
mstnode2
echo -en '\n'
mstnode3(){
node3=$(stat -c %a /etc/kubernetes/manifests/kube-controller-manager.yaml)
if [[ "$node3" == 644 ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode3`
else
chmod 644 /etc/kubernetes/manifests/kube-controller-manager.yaml
echo -en "${gr}[PASS]${xx}" `show mstnode3`
fi
}
mstnode3
echo -en '\n'
mstnode4(){
node4=$(stat -c %U:%G /etc/kubernetes/manifests/kube-controller-manager.yaml)
if [[ "$node4" == "root:root" ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode4`
else
chown root:root /etc/kubernetes/manifests/kube-controller-manager.yaml
echo -en "${gr}[PASS]${xx}" `show mstnode4`
fi
}
mstnode4
echo -en '\n'
mstnode5(){
node5=$(stat -c %a /etc/kubernetes/manifests/kube-scheduler.yaml)
if [[ "$node5" == 644 ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode5`
else
chmod 644 /etc/kubernetes/manifests/kube-scheduler.yaml
echo -en "${gr}[PASS]${xx}" `show mstnode5`
fi
}
mstnode5
echo -en '\n'
mstnode6(){
node6=$(stat -c %U:%G /etc/kubernetes/manifests/kube-scheduler.yaml)
if [[ "$node6" == "root:root" ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode6`
else
chown root:root /etc/kubernetes/manifests/kube-scheduler.yaml
echo -en "${gr}[PASS]${xx}" `show mstnode6`
fi
}
mstnode6
echo -en '\n'
mstnode7(){
node7=$(stat -c %a /etc/kubernetes/manifests/etcd.yaml)
if [[ "$node7" == 644 ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode7`
else
chmod 644 /etc/kubernetes/manifests/etcd.yaml
echo -en "${gr}[PASS]${xx}" `show mstnode7`
fi
}
mstnode7
echo -en '\n'
mstnode8(){
node8=$(stat -c %U:%G /etc/kubernetes/manifests/etcd.yaml)
if [[ "$node8" == "root:root" ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode8`
else
chown root:root /etc/kubernetes/manifests/etcd.yaml
echo -en "${gr}[PASS]${xx}" `show mstnode8`
fi
}
mstnode8
echo -en '\n'
mstnode9(){
node9=$(stat -c %a /etc/kubernetes/admin.conf)
if [[ "$node9" == 644 ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode9`
else
chmod 644 /etc/kubernetes/admin.conf
echo -en "${gr}[PASS]${xx}" `show mstnode9`
fi
}
mstnode9
echo -en '\n'
mstnode10(){
node10=$(stat -c %U:%G /etc/kubernetes/admin.conf)
if [[ "$node10" == "root:root" ]];then
echo -en "${gr}[PASS]${xx}" `show mstnode10`
else
chown root:root /etc/kubernetes/admin.conf
echo -en "${gr}[PASS]${xx}" `show mstnode10`
fi
}
mstnode10
echo -en '\n'
echo -en '\n'
echo -e "######################## API SERVER CONFIGURATION #########################"
echo -en '\n'
api1(){
anon_auth=$(ps -ef | grep kube-apiserver | grep -o 'anonymous-auth=[^ ,]\+' | awk -F "=" '{print $2}')
if [ "$anon_auth" == "false" ];then
echo -en "${gr}[PASS]${xx}" `show apid1`
elif [ "$anon_auth" == "" ]
then
echo -en "${gr}[PASS]${xx}" `show apid1`
else
echo -en "${re}[WARN]${xx}" `show apid1`
fi
}
api1
api2(){
basic_aufi=$(ps -ef | grep kube-apiserver | grep -o 'basic-auth-file=[^ ,]\+' | awk -F "=" '{print $2}')
if [ "$basic_aufi" == "" ];then
echo -en "${gr}[PASS]${xx}" `show apid2`
else
echo -en "${re}[WARN]${xx}" `show apid2`
fi
}
echo ""
api2
echo -en '\n'
api3(){
kube_http=$(ps -ef | grep kube-apiserver | grep -o 'kubelet-https=[^ ,]\+' | awk -F "=" '{print $2}')
if [ "$kube_http" == "" ];then
echo -en "${gr}[PASS]${xx}" `show apid3`
elif [ "$kube_http" == "true"];then
echo -en "${gr}[PASS]${xx}" `show apid3`
else
echo -en "${re}[WARN]${xx}" `show apid3`
fi
}
api3
echo -en '\n'
api4(){
alw_admit=$(ps -ef | grep kube-apiserver | grep -o 'admission-control=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$alw_admit" == "" ]];then
echo -en "${gr}[PASS]${xx}" `show apid4`
else
echo -en "${re}[WARN]${xx}" `show apid4`
fi
}
api4
echo -en '\n'
api5(){
alw_pull=$(ps -ef | grep kube-apiserver | grep -o 'admission-control=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$alw_pull" == "AlwaysPullImages" ]];then
echo -en "${gr}[PASS]${xx}" `show apid5`
elif [ "$alw_pull" == "" ];then
echo -en "${gr}[PASS]${xx}" `show apid5`
else
echo -en "${re}[WARN]${xx}" `show apid5`
fi
}
api5
echo -en '\n'
api6(){
sec_cont=$(ps -ef | grep kube-apiserver | grep -o 'admission-control=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$sec_cont" == "SecurityContextDeny" ]];then
echo -en "${gr}[PASS]${xx}" `show apid6`
elif [ "$sec_cont" == "" ];then
echo -en "${gr}[PASS]${xx}" `show apid6`
else
echo -en "${re}[WARN]${xx}" `show apid6`
fi
}
api6
echo -en '\n'
api7(){
ins_bind=$(ps -ef | grep kube-apiserver | grep -o 'insecure-bind-address=[^ ,]\+' | awk -F "=" '{print $2}')
if [ "$ins_bind" == "" ];then
echo -en "${gr}[PASS]${xx}" `show apid7`
else
echo -en "${re}[WARN]${xx}" `show apid7`
fi
}
api7
echo -en '\n'
api8(){
sec_port=$(ps -ef | grep kube-apiserver | grep -o 'secure-port=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$sec_port" == "0" ]];then
echo -en "${re}[WARN]${xx}" `show apid8`
elif [ "$sec_port" == "" ];then
echo -en "${gr}[PASS]${xx}" `show apid8`
else
echo -en "${gr}[PASS]${xx}" `show apid8`
fi
}
api8
echo -en '\n'
echo -en '\n'
echo -e "######################## CONTROLLER MANAGER CONFIGURATION ########################"
echo -en '\n'
cntmgr1(){
profiling=$(ps -ef | grep kube-controller-manager | grep -o 'profiling=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$profiling" == "false" ]];then
echo -en "${gr}[PASS]${xx}" `show cntmgr1`
else
sed -i '/- --authentication-kubeconfig/i \ \- --profiling=false' /etc/kubernetes/manifests/kube-controller-manager.yaml
echo -en "${gr}[PASS]${xx}" `show cntmgr1`
fi
}
cntmgr1
echo -en '\n'
cntmgr2(){
uservice=$(ps -ef | grep kube-controller-manager | grep -o 'use-service-account-credentials=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$uservice" == "true" ]];then
echo -en "${gr}[PASS]${xx}" `show cntmgr2`
else
sed -i '/- --authentication-kubeconfig/i \ \- --use-service-account-credentials=true' /etc/kubernetes/manifests/kube-controller-manager.yaml
echo -en "${gr}[PASS]${xx}" `show cntmgr2`
fi
}
cntmgr2
echo -en '\n'
cntmgr3(){
ackey=$(ps -ef | grep kube-controller-manager | grep -o 'service-account-private-key-file=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$ackey" == "/etc/kubernetes/pki/sa.key" ]];then
echo -en "${gr}[PASS]${xx}" `show cntmgr3`
else
sed -i '/- --authentication-kubeconfig/i \ \- --service-account-private-key-file=/etc/kubernetes/pki/sa.key' /etc/kubernetes/manifests/kube-controller-manager.yaml
echo -en "${gr}[PASS]${xx}" `show cntmgr3`
fi
}
cntmgr3
echo -en '\n'
cntmgr4(){
rtca=$(ps -ef | grep kube-controller-manager | grep -o 'root-ca-file=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$rtca" == "/etc/kubernetes/pki/ca.crt" ]];then
echo -en "${gr}[PASS]${xx}" `show cntmgr4`
else
sed -i '/- --authentication-kubeconfig/i \ \- --root-ca-file=/etc/kubernetes/pki/ca.crt' /etc/kubernetes/manifests/kube-controller-manager.yaml
echo -en "${gr}[PASS]${xx}" `show cntmgr4`
fi
}
cntmgr4
echo -en '\n'
cntmgr5(){
bdaddress=$(ps -ef | grep kube-controller-manager | grep -o 'bind-address=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$bdaddress" == 127.0.0.1 ]];then
echo -en "${gr}[PASS]${xx}" `show cntmgr5`
else
sed -i '/- --authentication-kubeconfig/i \ \- --bind-address=127.0.0.1' /etc/kubernetes/manifests/kube-controller-manager.yaml
echo -en "${gr}[PASS]${xx}" `show cntmgr5`
fi
}
cntmgr5
echo -en '\n'
echo -en '\n'
echo -e "######################## SCHEDULER CONFIGURATION ########################"
echo -en '\n'
scheduler1(){
scprofile=$(ps -ef | grep kube-scheduler | grep -o 'profiling=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$scprofile" == "false" ]];then
echo -en "${gr}[PASS]${xx}" `show scheduler1`
else
sed -i '/- --authentication-kubeconfig/i \ \- --profiling=false' /etc/kubernetes/manifests/kube-scheduler.yaml
echo -en "${gr}[PASS]${xx}" `show scheduler1`
fi
}
scheduler1
echo -en '\n'
scheduler2(){
bdaddr=$(ps -ef | grep kube-scheduler | grep -o 'bind-address=[^ ,]\+' | awk -F "=" '{print $2}')
if [[ "$bdaddr" == 127.0.0.1 ]];then
echo -en "${gr}[PASS]${xx}" `show scheduler2`
else
sed -i '/- --authentication-kubeconfig/i \ \- --bind-address=127.0.0.1' /etc/kubernetes/manifests/kube-scheduler.yaml
echo -en "${gr}[PASS]${xx}" `show scheduler2`
fi
}
scheduler2
echo -en '\n'
echo -en '\n'
echo -e "######################## WORKER NODE CONFIGURATION ########################"
echo -en '\n'
workernode1(){
wrknode1=$(stat -c %a /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf)
if [[ "$wrknode1" == 644 ]];then
echo -en "${gr}[PASS]${xx}" `show workernode1`
else
chmod 644 /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
echo -en "${gr}[PASS]${xx}" `show workernode1`
fi
}
workernode1
echo -en '\n'
workernode2(){
wrknode2=$(stat -c %U:%G /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf)
if [[ "$wrknode2" == "root:root" ]];then
echo -en "${gr}[PASS]${xx}" `show workernode2`
else
chown root:root /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
echo -en "${gr}[PASS]${xx}" `show workernode2`
fi
}
workernode2
echo -en '\n'
workernode3(){
wrknode3=$(stat -c %a /etc/kubernetes/kubelet.conf)
if [[ "$wrknode3" == 644 ]];then
echo -en "${gr}[PASS]${xx}" `show workernode3`
else
chmod 644 /etc/kubernetes/kubelet.conf
echo -en "${gr}[PASS]${xx}" `show workernode3`
fi
}
workernode3
echo -en '\n'
workernode4(){
wrknode4=$(stat -c %U:%G /etc/kubernetes/kubelet.conf)
if [[ "$wrknode4" == "root:root" ]];then
echo -en "${gr}[PASS]${xx}" `show workernode4`
else
chown root:root /etc/kubernetes/kubelet.conf
echo -en "${gr}[PASS]${xx}" `show workernode4`
fi
}
workernode4
echo -en '\n'
workernode5(){
wrknode5=$(stat -c %a /var/lib/kubelet/config.yaml)
if [[ "$wrknode5" == 644 ]];then
echo -en "${gr}[PASS]${xx}" `show workernode5`
else
chmod 644 /var/lib/kubelet/config.yaml
echo -en "${gr}[PASS]${xx}" `show workernode5`
fi
}
workernode5
echo -en '\n'
workernode6(){
wrknode6=$(stat -c %U:%G /var/lib/kubelet/config.yaml)
if [[ "$wrknode6" == "root:root" ]];then
echo -en "${gr}[PASS]${xx}" `show workernode6`
else
chown root:root /var/lib/kubelet/config.yaml
echo -en "${gr}[PASS]${xx}" `show workernode6`
fi
}
workernode6
echo -en '\n'
echo -en '\n'
