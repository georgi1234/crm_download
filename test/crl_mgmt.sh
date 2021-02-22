#!/bin/bash
##Created by Georgi Dimitrov
##CRL download and check

#vars
export home=/home/app/MontranConfig/etc/cli-dir/
download1=$(wget http://crltest.b-trust.org/repository/B-TrustTestOperationalQCA.crl -O $home/new/B-TrustTestOperationalQCA.crl)
download2=$(wget http://crltest.b-trust.org/repository/B-TrustTestOperationalACA.crl -O $home/new/B-TrustTestOperationalACA.crl)
new_crl1=$home/new/B-TrustTestOperationalQCA.crl
new_crl2=$home/new/B-TrustTestOperationalACA.crl
old_crl1=$home/B-TrustTestOperationalQCA.crl
old_crl2=$home/B-TrustTestOperationalACA.crl
#


${download1}

${download2}

openssl crl -in $home/new/B-TrustTestOperationalQCA.crl -inform DER -text -noout  > $home/new/report1
openssl crl -in $home/new/B-TrustTestOperationalACA.crl -inform DER -text -noout  > $home/new/report2

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
