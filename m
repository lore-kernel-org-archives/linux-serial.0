From: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Mon, 18 Aug 2014 13:19:41 +0200
Message-ID: <53F1E14D.7000408@ts.fujitsu.com>
References: <53F1CD68.9080901@ts.fujitsu.com> <20140818105307.GA5811@kroah.com> <53F1DF48.8000007@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms010803070704000007090700"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:3067 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbaHRLSp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 07:18:45 -0400
In-Reply-To: <53F1DF48.8000007@ts.fujitsu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms010803070704000007090700
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

Hmm or not :( ... at a first glance it was.

But this is for a driver which implements the UART support but I want to =

use the UART but not implement it's hw support.

As a i2c_module doesn't implement the i2c controller support but uses it.=


Or do I miss something?

Cheers,
Thilo

On 18.08.2014 13:11, Cestonaro Thilo wrote:
> Thx Greg. This one I missed!
>
> But it's what I searched for.
>
> Cheers,
> Thilo
>
> On 18.08.2014 12:53, Greg KH wrote:
>> On Mon, Aug 18, 2014 at 11:54:48AM +0200, Cestonaro Thilo wrote:
>>> Hey,
>>>
>>> I need to write a driver which communicates with it's chip via uart.
>>> So I was wondering which the best way is to do this.
>>>
>>> For a i2c device there is the i2c subsystem with it's
>>> "module_i2c_driver(foo_driver);" and so on.
>>> But I couldn't find any equivalent for a uart device.
>> Did you see include/linux/serial_core.h ?
>>
>
>


--=20
With best regards
Thilo Cestonaro

FTS PSO PM&D CCD E EPC

Fujitsu Technology Solutions GmbH
Buergermeister-Ulrich-Str. 100
86199 Augsburg
Germany

Tel.: +49 (0)821 804 2328
Fax: +49 (0)821 804 82328
E-mail: thilo.cestonaro@ts.fujitsu.com

Web: http://ts.fujitsu.com
Company details: http://ts.fujitsu.com/imprint



--------------ms010803070704000007090700
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIIYDCC
A9QwggK8oAMCAQICEDTNElfINoNG4L/3PTADbgUwDQYJKoZIhvcNAQEFBQAwLzEtMCsGA1UE
AxMkRnVqaXRzdSBUZWNobm9sb2d5IFNvbHV0aW9ucyBSb290IENBMB4XDTA5MDMxMjEyMjQ1
OVoXDTE5MDMxMTEyMjQ1OVowLzEtMCsGA1UEAxMkRnVqaXRzdSBUZWNobm9sb2d5IFNvbHV0
aW9ucyBVc2VyIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsBtNf0fN8EkW
9y6QqoQGS6LUwezenV2BnDzORdGanukRtpGzYMAPdyiwtlp0/zONa+jCJGzkX4iYCjTsiJvx
01SPRNZ24fHaFGXpJBX599q6ZF0isu+h1aIas1tfyCBalAbKKLvNgIuQjnXhdffVk4vSuByt
O3OGcULtJ2+lYVSEvxzGt9iTSwT5RnEvKpR0iOC+9/UNVOiPK9XCz5u7bg3iehP5gD+v5uu3
YIRwV/5gyd7AZPcckTfYP/GZcybcAXfEl5nb/bZiSLHeZEjxMMM8YZqFKhH9xymIdjkcRK7N
J2j8OD708QFv4b4bme1mHGfTjSbxb1nOoUTsNtshZwIDAQABo4HrMIHoMB0GA1UdDgQWBBQI
9chqv4Dje1DEOfQHmEbobX6XqDALBgNVHQ8EBAMCAYYwHwYDVR0jBBgwFoAUFHXiV7YVNxWA
KpflUUhlrM+GkMswEgYDVR0TAQH/BAgwBgEB/wIBADBHBggrBgEFBQcBAQQ7MDkwNwYIKwYB
BQUHMAKGK2h0dHA6Ly9haWEudHMuZnVqaXRzdS5jb20vYWlhL2Z0czAxcm9vdC5jZXIwPAYD
VR0fBDUwMzAxoC+gLYYraHR0cDovL2NkcC50cy5mdWppdHN1LmNvbS9jZHAvZnRzMDFyb290
LmNybDANBgkqhkiG9w0BAQUFAAOCAQEAQ7pQP9Lw9bcnt1DhvV5UWb1zmnACSo6n6x+bupck
Qzlrf3aJ7HQZigZuaCak+dexL18I86iNDDOJBBsrz0DcD4XPszcLTUezqqGlAyIbviBq5mwD
HAWBA9F11GRx6LdrHMKNdHPwAWyC3r6qv4GO6A+z16KUZFSP4kvuaN5YHI481T7FFxEmntky
lphndX+6mQ1NABApMMhX0aN5dVhPAMAP8nENJ1hGk81IG8gzkoHDPSoLCtffAnNhYAqhvrDO
2ybXb/9x+Sf3DQuzBg3hpB1yJM3K8foQaS3uTpFITfdMprcQyrIdl4Jw26s/6vpIs0siLVTp
3yAwgNaqQSgxSTCCBIQwggNsoAMCAQICCiWUlIAAAAACJH0wDQYJKoZIhvcNAQEFBQAwLzEt
MCsGA1UEAxMkRnVqaXRzdSBUZWNobm9sb2d5IFNvbHV0aW9ucyBVc2VyIENBMB4XDTE0MDMy
MTEyMTM1M1oXDTE3MDMyMDEyMTM1M1owQjEZMBcGA1UEAwwQQ2VzdG9uYXJvLCBUaGlsbzEl
MCMGA1UECgwcRnVqaXRzdSBUZWNobm9sb2d5IFNvbHV0aW9uczCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAqP3ld/ylkJOTj2rXQ+VrRf/+YMgZS5CGDnMWk+sMoS5f6JqtwfGcfBU/
DhfnLsePut2q+ex/RDZFM6yCraPS0vdnTKm2O3Q7/UhhAV1Mi4XzzGeY1Y0qm+85EgMBISPw
B5mThLYPsun5UIFs6e8tvlwZRzp/jrv/AzAfsSbHGXcCAwEAAaOCAhEwggINMAsGA1UdDwQE
AwIFoDByBgNVHREEazBpgR50aGlsby5jZXN0b25hcm9AdHMuZnVqaXRzdS5jb22BI1RoaWxv
LkNlc3RvbmFyb0BmdWppdHN1LXNpZW1lbnMuY29tgSIrNDk4MjE4MDQ4MjMyOEBpbmNvbWlu
Z2ZheC5mc2MubmV0MB0GA1UdDgQWBBSiHLgIjjo+7KxLJ4t1+YZxgBSn8TAfBgNVHSMEGDAW
gBQI9chqv4Dje1DEOfQHmEbobX6XqDA8BgNVHR8ENTAzMDGgL6AthitodHRwOi8vY2RwLnRz
LmZ1aml0c3UuY29tL2NkcC9mdHMwMXVzZXIuY3JsMEcGCCsGAQUFBwEBBDswOTA3BggrBgEF
BQcwAoYraHR0cDovL2FpYS50cy5mdWppdHN1LmNvbS9haWEvZnRzMDF1c2VyLmNlcjAMBgNV
HRMBAf8EAjAAMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCIWFxDKBh/9hgYWBBIbsgiCB
x4EaeYOIoHGH0vEvAgFkAgEIMBMGA1UdJQQMMAoGCCsGAQUFBwMEMBsGCSsGAQQBgjcVCgQO
MAwwCgYIKwYBBQUHAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBBQUAA4IBAQAEGTAy
HPmTyCR029H+P/u9xRezlfA2OVvV97Ls/oLCXGGr6EkMvpHodTc6n4EWSb2ul3VPSRQfuSmB
gIcHQJykHdSChisaqkeOpHG0rjM9GXh2eQ7ECovpQIfdIbRZKNxlJihSDsDWHyZldBlPVbDh
xMeT6xJ/ylF8UQ8FXKUir6W/BSPZF5kLdsmCeOpWC4jOGNPEMUAcuiHZPyqAhjlWk750I4oJ
JKvDbwO8/mkxmzOjpOsk8O3CdljCjYPoYtJPI/oNVsYdmiokzne4FusPYKDzv5i0dN74KLR4
8maXvi3/WsTFqwks45QeBJT/z+1sYy+dYWpv9XGN+jR1o4ImMYICUDCCAkwCAQEwPTAvMS0w
KwYDVQQDEyRGdWppdHN1IFRlY2hub2xvZ3kgU29sdXRpb25zIFVzZXIgQ0ECCiWUlIAAAAAC
JH0wCQYFKw4DAhoFAKCCAWkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTQwODE4MTExOTQxWjAjBgkqhkiG9w0BCQQxFgQUUI+OM0cRBfQoKmiMhgiDabgY
bwEwTAYJKwYBBAGCNxAEMT8wPTAvMS0wKwYDVQQDEyRGdWppdHN1IFRlY2hub2xvZ3kgU29s
dXRpb25zIFVzZXIgQ0ECCiWUlIAAAAACJH0wTgYLKoZIhvcNAQkQAgsxP6A9MC8xLTArBgNV
BAMTJEZ1aml0c3UgVGVjaG5vbG9neSBTb2x1dGlvbnMgVXNlciBDQQIKJZSUgAAAAAIkfTBs
BgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEo
MA0GCSqGSIb3DQEBAQUABIGAKSVNclUygEtScsZ+GKUGw3cLRVfveX+5+JxXvU3ty3Qfj7DZ
JQo5zeInvEqTZNCypi1Kl2VTsqS76RIRvtlkkSgZCesiVAPqPQ8lC7Zq25P3TNj2oDfvi6XC
Ubnf6UunAJu5IDghdTtiePIm9AunAlrtAHxw6eiRunAfTefrOZoAAAAAAAA=
--------------ms010803070704000007090700--
