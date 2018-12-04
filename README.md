The purpose of this repository is to properly configure and install Red Hat Openshift as a homework assignment

Getting files and installing OpenShift:
1.	Login into Bastion
2.	Login to installation user:
    sudo -i
3.	Download files from GitHub:
    git clone https://github.com/ox-prolifics/rhocp_homework.git
4.	Change to the repository directory:
    cd /root/rhocp_homework
5.	Change permissions for the rhocp.sh script to run:
    chmod +x /root/rhocp_homework/rhocp.sh
6.	Install OpenShift and output the install to a log file at /var/logs/rhocp.log:
    /root/rhocp_homework/rhocp.sh install | tee /var/log rhocp.log

