#!/bin/sh

domainName=""
subscriptionId=""
resourceGroupName=""
appGWName=""
endDate=""

while read line;
do
  domainName=`echo $line | cut -d',' -f1`
  subscriptionId=`echo $line | cut -d',' -f2`
  resourceGroupName=`echo $line | cut -d',' -f3`
  appGWName=`echo $line | cut -d',' -f4`

  echo "-----BEGIN PKCS7-----" > temp.cert;

  az account set --subscription $subscriptionId;

  az network application-gateway ssl-cert show -g $resourceGroupName --gateway-name $appGWName --name $domainName --query publicCertData -o tsv | fold -w 64 >> temp.cert;

  echo "-----END PKCS7-----" >> temp.cert;

  endDate=`cat temp.cert | openssl pkcs7 -print_certs | openssl x509 -noout -enddate | cut -d'=' -f2`

  echo "App GW - "$appGWName", Domain - "$domainName" is expiring on "$endDate

  rm temp.cert

done < input.csv
