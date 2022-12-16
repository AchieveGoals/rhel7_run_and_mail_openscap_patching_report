# rhel7_run_and_mail_openscap_patching_report
Quick commands in RHEL7 to create and email HTML report of most recent OpenSCAP missing patches

![Sample Report](https://github.com/AchieveGoals/rhel7_run_and_mail_openscap_patching_report/blob/main/sample-report.png?raw=true "Sample Report")

## Purpose:
     
     I like to run before and after 'evidence gathering' before I patch.
     
     Administrating RHEL 7, I focus on checking for 
     1. security speciifc patches, 
     2. changes to kernel and drivers that could affect Oracle dependencies on RHEL, and
     3. any other non-security patch
     
     In this part 1 of at least 2 rhel7 patching repo, I want to demonstrate a few commands, 
     provided you have access and can download the [RHEL7 "rhel7.oval.xml.bz2" file]
     (https://www.redhat.com/security/data/oval/v2/RHEL7/rhel-7.oval.xml.bz2).
     
## Before using this script

   For RHEL7, see if you can download this file:
          https://www.redhat.com/security/data/oval/v2/RHEL7/rhel-7.oval.xml.bz2
          
   On RHEL use yum to install utils and 'openscap-scanner' if you have active Redhat subscription:
   
  ```sudo yum install openscap-scanner wget curl bzip2```
  
  ```sudo yum install scap-security-guide```
   
## What's provided

     Simple bash commands I run from a 'scans' directory in "/home/user"
     
     In my case, I always start by deleting the previous "rhel-7.oval.xml" file and then get 
     the latest OpenSCAP from Red Hat, unpack it and use the oscap command to run it while
     creating an HTML report that is then emailed (interactively) to your admins, etc.
     
     A fictional email will be substituted in this script - please change to your lab's or company's email
     
     On last email step, it is interactive mail - so you have to hit enter and then ctrl-D to exit (and send) mail
     with the attached HTML report. 
     
     Provided AS IS, and without the oval.xml file that I download via my my RHEL subscription.
     
     This process has worked flawlessly.
     
## TODO
 
   - provide crosslinks with related bash patching repos (not uploaded yet)
   - [IN PROGRESS] combining lxc and openscap for Alma Linux 9 cloud image (status: 70%) - 12/15 PM
   
## ISSUES

   One growing issue is how RedHat tends to downplay CVE/NVD scores from 7 to 9.5, and rate them as 1.2 (LOW).
   
   In this case, they appear to remove the CVE check from their oval file as there is "no missing patch" (per bugzilla.redhat.com) so the vulnerability doesn't show in the report as missing because they have internally agreed to ignore the issue. I don't think this is responsible vendor behavior, and would love Congress or regulators take a look at how many vendors knowingly take steps to give false positive that your staff has addressed all available patches, rather just the patches they are willing to ship.
   
   In RHEL7, a great example is "mpfr" while not used a lot, RH (and Ubuntu): rate it a LOW (1.2) score, but
   CVSS v2 has 7.5 score, and CVSS v3 rate it a 9.8 score (as I'm recently told) and the NVD/CVE response is to demand to patch mpfr 3.1.2-patch11 or greater.

   In bugzilla.redhat.com, Red Hat simply states issue is LOW and "WONTFIX" status despite the most meager amount
   of work to just patch and ship with RHEL7 updates.
   
   Controversy?   Not sure.   Most MDR and vulnerability scanning vendors recommend patch OR dispose mpfr rather than living with this vulnerability.   Is this a reaction to IBM purchase of REDHAT?  Don't know.  Is this a one off?  For RHEL 7.9 and newer, openssh, openssl and many other libraries are in the same WONTFIX status for know vulnerabilities.  TO BE CONTINUED??? 
