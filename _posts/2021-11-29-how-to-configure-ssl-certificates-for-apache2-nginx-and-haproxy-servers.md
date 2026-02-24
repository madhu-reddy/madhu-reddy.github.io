---
layout: post
title: How to configure SSL Certificates for Apache2, Nginx and HaProxy servers?
date: 2021-11-29
categories: ['Sysadmin', 'SSL']
---

To configure the SSL certificate, follow these steps:

1) First, generate a private key and a CSR, a process common to all three servers (Apache2, Nginx, HAProxy).

```
**openssl req –new –newkey rsa:2048 –nodes –keyout mylearningsguru.key –out mylearningsguru.csr**
```

**Example:**

```
root@madhuserver:~# **openssl req -new -newkey rsa:2048 -nodes -keyout mylearningsguru.key -out mylearningsguru.csr**
Generating a 2048 bit RSA private key
.................+++
.....................................................................................+++
writing new private key to 'mylearningsguru.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:**IN**
State or Province Name (full name) [Some-State]:**TS**
Locality Name (eg, city) []:**HYD**
Organization Name (eg, company) [Internet Widgits Pty Ltd]:**mylearningsguru**
Organizational Unit Name (eg, section) []:**BLOG**
Common Name (e.g. server FQDN or YOUR name) []:**mylearningsguru.com**
Email Address []:**madhukunta@mylearningsguru.com**

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:

```

2) Upload the CSR file to your certificate provider's portal (e.g., GoDaddy, DigiCert, Comodo, etc.) to obtain the new SSL certificate.

3) Download the SSL certificate bundle, which includes the **actual certificate file and the intermediate CA certificate chain files,** from the certificate provider after the certificate has been issued.

                                                                                                                                                                                                             .

## **SSL certificate for apache2**

In your Apache2 server, access the related site config file (e.g., /etc/apache2/sites-enabled/mylearningsguru). Insert the specified directives and their corresponding values within the suitable <VirtualHost> block.

```
SSLEngine on
SSLCertificateFile /path/to/actualcertificate/mylearningsguru.crt
SSLCertificateKeyFile /path/to/privatekey/mylearningsguru.key
SSLCACertificateFile /path/to/intermediate-CA-certificate-chain-bundle.crt
```

                                                                                                                                                                                                             .

## **SSL certificate for Nginx**

For Nginx, open the relevant site config file (e.g., /etc/nginx/sites-enabled/mylearningsguru). Insert the directives and their respective values within the appropriate "server" block.

```
ssl on
ssl_certificate /path/to/actualcert-and-CA-bundle/mylearningsguru-nginx.crt
ssl_certificate_key /path/to/privatekey/mylearningsguru.key

```

**NOTE: **
Unlike Apache2, in Nginx, both the actual certificate and intermediate CA certificate chain bundle are combined into a single file.

```
cat mylearningaguru.crt intermediate-CA-certificate-chain-bundle.crt > mylearningsguru-nginx.crt
```

                                                                                                                                                                                               .

## **SSL certificate for HaProxy**

For HAProxy, access the related haproxy config file (e.g., /etc/haproxy/haproxy.conf). Within the suitable "frontend" section, include the specified directive with its related value.

```
bind *:443 ssl crt /etc/ssl/mylearningsguru-haproxy.pem
```

**NOTE: **
In HAProxy, the actual certificate, intermediate CA certificate chain bundle, and the private key are combined into a single file with a .pem extension.

```
cat mylearningaguru.crt intermediate-CA-certificate-chain-bundle.crt mylearningsguru.key  > mylearningsguru-haproxy.pem
```
