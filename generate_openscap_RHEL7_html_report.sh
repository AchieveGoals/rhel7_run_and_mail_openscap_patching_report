#!/usr/bin/bash
# I also use bash <filename>, you can use start your bash script as you prefer
# Name: generate_openscap_RHEL6_HTML_report.sh
# Larry Timmins  / gh/AchieveGoals contributor

# To run:
#    bash generate_openscap_RHEL7_html_report.sh

# 12-11-2022 commit
# Larry Timmins, larry.timmins@gmail.com, 12-01-2022 
# License: Apache 2.0 (see NOTICE file)
# Non-commercial use only; any other use must get written permission from author


## housekeeping
rhdate=$(date +"%Y%m%d-%H%M%S")
#echo $rhdate

## 
cd
if [ -d ~/scans]; then
  cd scans
else 
  mkdir ~/scans
  cd ~/scans
fi 

# remove prior file
rm ~/scans/rhel-7.oval.xml

# get latest
wget -O - https://www.redhat.com/security/data/oval/v2/RHEL7/rhel-7.oval.xml.bz2 | bzip2 --decompress > rhel-7.oval.xml

# run oscal and generate (after some time) the the HTML report
oscap oval eval --report vulnerability-$rhdate-$(hostname -s).html rhel-7.oval.xml

mail -s "openscap-scanner results (post RHSA-$rhdate) - $(hostname -s)" -a $(ls -t1 vul*html) your.email@gmail.com

# hit enter, type optional message and then hit Ctrl-D to end email


