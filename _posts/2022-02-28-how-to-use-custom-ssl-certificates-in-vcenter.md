---
layout: post
title: "How to use custom SSL certificates in vCenter?"
date: 2022-02-28
categories: ['VMware', 'vCenter']
---

In this guide, we will examine the installation and update procedures for custom SSL certificates in vCenter.

1) /usr/lib/vmware-vmca/bin/certificate-manager
2) select option "1"

3) Enter the username (default to "Administrator@vsphere.local") and password for the user, then select option "2" to import the custom certificate and key.

4)  As per this article ([https://kb.vmware.com/s/article/2112277), provide the path to all keys and all certificate files in .cer format (base64 encoded).

***Note**:* If you have one or more intermediate certificate authorities, the `root64.cer` should be a chain of all intermediate CA and Root CA certificates. The `machine_name_ssl.cer` should be a full chain for certificate+inter(s)+root.

```
`The machine_name_ssl.cer should be a complete chain file similar to:
-----BEGIN CERTIFICATE-----
MIIFxTCCBK2gAwIBAgIKYaLJSgAAAAAAITANBgkqhkiG9w0BAQUFADBGMRMwEQYK
CZImiZPyLGQBGRYDbmV0MRYwFAYKCZImiZPyLGQBGRYGbW5uZXh0MRcwFQYDVQQD
Ew5tbm5leHQtQUQtMS1DQTAeFw0xMzAyMDExNjAxMDNaFw0xNTAyMDExNjExMDNa 
SMhYhbv3wr7XraAnsIaBYCeg+J7fKTFgjA8bTwC+dVTaOSXQuhnZfrOVxlfJ/Ydm
NS7WBBBFd9V4FPyRDPER/QMVl+xyoaMGw0QKnslmq/JvID4FPd0/QD62RAsTntXI
ATa+CS6MjloKFgRaGnKAAFPsrEeGjb2JgMOpIfbdx4KT3WkspsK3KPwFPoYza4ih
4eT2HwhcUs4wo7X/XQd+CZjttoLsSyCk5tCmOGU6xLaE1s08R6sz9mM=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDZzCCAk+gAwIBAgIQNO7aLfykR4pE94tcRe0vyDANBgkqhkiG9w0BAQUFADBG
K73RIKZaDkBOuUlRSIfgfovUFJrdwGtMWo3m4dpN7csQAjK/uixfJDVRG0nXk9pq
GXaS5/YCv5B4q4T+j5pa2f+a61ygjN1YQRoZf2CHLe7Zq89Xv90nhPM4foWdNNkr 
/Esf1E6fnrItsXpIchQOmvQViis12YyUvwko2aidjVm9sML0ANiLJZSoQ9Zs/WGC
TLqwbQm6tNyFB8c=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDZzCCAk+gAwIBAgIQNO7aLfykR4pE94tcRe0vyDANBgkqhkiG9w0BAQUFADBG
K73RIKZaDkBOuUlRSIfgfovUFJrdwGtMWo3m4dpN7csQAjK/uixfJDVRG0nXk9pq
GXaS5/YCv5B4q4T+j5pa2f+a61ygjN1YQRoZf2CHLe7Zq89Xv90nhPM4foWdNNkr 
/Esf1E6fnrItsXpIchQOmvQViis12YyUvwko2aidjVm9sML0ANiLJZSoQ9Zs/WGC
TLqwbQm6tNyFB8c=
-----END CERTIFICATE-----
`
```

5) You will now receive a prompt to replace the Machine SSL certificate using a custom certificate. Press "y" to continue the custom certificate installation in vCenter.

```
You are going to replace Machine SSL cert using custom cert
 Continue operation : Option[Y/N] ? : y
```

6) You will now receive a prompt to replace the Machine SSL certificate using a custom certificate. Press "y" to continue the custom certificate installation in vCenter.

Sure, here is the English grammar correction for the text:

**Issues Faced When Updating Custom SSL Certificates in vCenter**

**Issue:**
The vCenter GUI was displaying the error message "No healthy Upstream" and multiple services were stopped in vCenter.

**Solution:**

1) I checked the expiration dates of all certificates and found that the** vsphere-webclient Solution user certificate had expired**.

```
`for store in $(/usr/lib/vmware-vmafd/bin/vecs-cli store list | grep -v TRUSTED_ROOT_CRLS); do echo "[*] Store :" $store; /usr/lib/vmware-vmafd/bin/vecs-cli entry list --store $store --text | grep -ie "Alias" -ie "Not After";done;`
```

2) I attempted to reset the Solution Users certificates using the certificate-manager tool (using option "6") manually, but it failed with the error message "Access denied, reason = rpc_s_auth_method".

3) I examined the VMDird log (/var/log/vmware/vmdird/vmdird-syslog.log) and discovered password issues with the Machine account, resulting in LDAP 49 errors.

**Example:**

```
`2022-02-28T02:25:43.133044+00:00 err vmdird  t@139713625134848: SASLSessionStep: sasl error (-13)(SASL(-13): authentication failure: client evidence does not match what we calculated. Probably a password error)

2022-02-28T02:25:43.133211+00:00 err vmdird  t@139713625134848: VmDirSendLdapResult: Request (Bind), Error (LDAP_INVALID_CREDENTIALS(49)), Message ((49)(SASL step failed.)), (0) socket (192.168.1.1)

2022-02-28T02:25:43.133393+00:00 err vmdird  t@139713625134848: Bind Request Failed (172.17.10.10) error 49: Protocol version: 3, Bind DN: "cn=myvcenter.mylearningsguru.com,ou=Domain Controllers,dc=vsphere,dc=local", Method: SASL`
```

4) To ensure that the password for the machine account (myvcenter.mylearningsguru.com@vsphere.local) only contains valid characters, I reset it multiple times using the vdcadmin tool provided in this link: [https://kb.vmware.com/s/article/70756

To test if the new reset password is valid, we can use this handy command, 

```
`/opt/likewise/bin/ldapsearch -b "dc=vsphere,dc=local" -s sub -D "cn=myvcenter.mylearningsguru.com,ou=Domain Controllers,dc=vsphere,dc=local" -w "new-machine-account-password" > /tmp/PSC_FQDN.ldif`
```

[**NOTE:** This step is crucial because if the password is invalid, the error will persist even after resetting it. Therefore, it is essential to ensure the password is valid and free of invalid characters.

5) I also used the same vdcadmin tool to reset the password for the local Administrator account (Administrator@vsphere.local).
This is an **optional** step and is only necessary if you have forgotten the password for the local Administrator account. If you remember the password, you can skip this step.

To test if the new reset password is valid, we can again use the following command,

```
`/opt/likewise/bin/ldapsearch -b "dc=vsphere,dc=local" -s sub -D "cn=Administrator,cn=Users,dc=vsphere,dc=local" -w "new-admin-account-password" > /tmp/PSC_FQDN1.ldif`
```

6) Used the certificate manager tool (option "4") to reset the** Root CA **and **all other certificates** with the native VMCA certificate.

7) The replacement process was successful, and all services were restored.

8) Imported the custom certificates again using the certificate manager tool (option "1", followed by option "2" in the next step). The Machine SSL certificate was successfully replaced with externally issued certificates.

9) Verified that all services were running using the command "service-control --status"

10) Confirmed that the GUI was now functional and no longer displayed the error "No healthy Upstream".
