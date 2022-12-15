# I use bash <filename>, you can use start your bash script as you prefer

# Name: generate_openscap_RHEL6_HTML_report.sh
# Larry Timmins  / gh/AchieveGoals contributor


## housekeeping
alias currdate="date +%Y%m%d-%H%M%S"

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
wget -O - https://www.redhat.com/security/data/oval/v2/RHEL7/rhel7-oval.xml.bz2 | bzip2 --decompress > rhel-7.oval.xml

# run oscal and generate (after some time) the the HTML report
oscap oval eval --report vulnerability-$(currdate)-$(hostname -s).html rhel-7.oval.xml

mail -s "openscap-scanner results (post RHSA-$(currdate)) - $(hostname -s)" -a $(ls -t1 vul*html) your.email@gmail.com

# hit enter, type optional message and then hit Ctrl-D to end email


