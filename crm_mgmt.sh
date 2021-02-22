#!/bin/bash
##Created by Georgi Dimitrov
##CRL download and check

#vars
export home=/home/app/MontranConfig/etc/cli-dir/
download1=$(wget http://crl.b-trust.org/repository/B-TrustOperationalQCA.crl -O $home/new/B-TrustOperationalQCA.crl)
download2=$(wget http://crl.b-trust.org/repository/B-TrustOperationalACA.crl -O $home/new/B-TrustOperationalACA.crl)
new_crl1=$home/new/B-TrustOperationalQCA.crl
new_crl2=$home/new/B-TrustOperationalACA.crl
old_crl1=$hoem/B-TrustOperationalQCA.crl
old_crl2=$home/B-TrustOperationalACA.crl
#


${download1}

${download2}

openssl crl -in $home/new/B-TrustOperationalQCA.crl -inform DER -text -noout  > $home/new/report1
openssl crl -in $home/new/B-TrustOperationalACA.crl -inform DER -text -noout  > $home/new/report2

md5sum $new_crl1 >> $home/new/report1
md5sum $new_crl2 >> $home/new/report2
md5sum $old_crl1 >> $home/new/report1
md5sum $old_crl2 >> $home/new/report2

if [ -s $home/new/report1 ]
 then
  if ! diff ${new_crl1}  ${old_crl1}
     then
        mv ${new_crl1}  ${old_crl1}
  fi
fi
if [ -s $home/new/report2 ]
 then
  if ! diff ${new_crl2}  ${old_crl2}
   then
    mv ${new_crl2}  ${old_crl2}
  fi
fi
