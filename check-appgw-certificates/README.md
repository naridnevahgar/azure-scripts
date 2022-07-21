# Check Application Gateway certificates

Create a CSV file with below format and run `check.sh` file.

```csv
<custom domain name>, <subscription id>, <resource group name>, <application gateway name>
```

The script extracts the custom domain's certificate in use from the mentioned application gateway, parses it from PKCS7 format and prints the expiry date. 
