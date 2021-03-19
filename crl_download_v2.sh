#!/bin/bash
##Created by Georgi Dimitrov
##CRL download and check

#vars
export home=/app/ips-node/etc/
download1=$(wget http://crl.b-trust.org/repository/B-TrustOperationalQCA.crl -O $home/new/B-TrustOperationalQCA.crl)
download2=$(wget http://crl.b-trust.org/repository/B-TrustOperationalACA.crl -O $home/new/B-TrustOperationalACA.crl)
download3=$(wget http://crltest.b-trust.org/repository/B-TrustTestOperationalQCA.crl -O $home/new/B-TrustTestOperationalQCA.crl)
download4=$(wget http://crltest.b-trust.org/repository/B-TrustTestOperationalACA.crl -O $home/new/B-TrustTestOperationalACA.crl)
new_crl1=/app/ips-node/etc/new/B-TrustOperationalQCA.crl
new_crl2=/app/ips-node/etc/new/B-TrustOperationalACA.crl
new_crl3=/app/ips-node/etc/new/B-TrustTestOperationalQCA.crl
new_crl4=/app/ips-node/etc/new/B-TrustTestOperationalACA.crl
old_crl1=/app/ips-node/etc/crl-dir/B-TrustOperationalQCA.crl
old_crl2=/app/ips-node/etc/crl-dir/B-TrustOperationalACA.crl
old_crl3=/app/ips-node/etc/crl-dir/B-TrustTestOperationalQCA.crl
old_crl4=/app/ips-node/etc/crl-dir/B-TrustTestOperationalACA.crl
#



${download1}

${download2}

${download3}

${download4}

openssl crl -in $home/crl-dir/B-TrustOperationalQCA.crl -inform DER -text -noout  > $home/new/report1
openssl crl -in $home/crl-dir/B-TrustOperationalACA.crl -inform DER -text -noout  > $home/new/report2
openssl crl -in $home/crl-dir/B-TrustTestOperationalQCA.crl -inform DER -text -noout  > $home/new/report3
openssl crl -in $home/crl-dir/B-TrustTestOperationalACA.crl -inform DER -text -noout  > $home/new/report4
md5sum $new_crl1 >> $home/new/report1
md5sum $new_crl2 >> $home/new/report2
md5sum $old_crl1 >> $home/new/report1
md5sum $old_crl2 >> $home/new/report2

md5sum $new_crl3 >> $home/new/report3
md5sum $new_crl4 >> $home/new/report4
md5sum $old_crl3 >> $home/new/report3
md5sum $old_crl4 >> $home/new/report4



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
if [ -s $home/new/report3 ]
 then
  if ! diff ${new_crl3}  ${old_crl3}
   then
    mv ${new_crl3}  ${old_crl3}
  fi
fi
if [ -s $home/new/report4 ]
 then
  if ! diff ${new_crl4}  ${old_crl4}
   then
    mv ${new_crl4}  ${old_crl4}
  fi
fi
