From: Jeffrey Altman <jaltman@columbia.edu>
Subject: Re: Serial port redirection
Date: Thu, 04 Dec 2003 12:52:36 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3FCF7464.9030000@columbia.edu>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se> <3FCE1267.3040204@columbia.edu> <3FCDE364.1080005@acm.org> <3FCF7026.6070109@columbia.edu> <3FCDE8FC.3070400@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070506040803010807030505"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from jalapeno.cc.columbia.edu ([128.59.59.238]:40369 "EHLO
	jalapeno.cc.columbia.edu") by vger.kernel.org with ESMTP
	id S262591AbTLDRw6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Dec 2003 12:52:58 -0500
In-Reply-To: <3FCDE8FC.3070400@acm.org>
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Peter Astrand <peter@cendio.se>, ltsp-discuss@lists.sourceforge.net, d.sbragion@infotecna.it, linux-serial@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070506040803010807030505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Corey Minyard wrote:

> Jeffrey Altman wrote:
>
>> The reality is RFC is experimental and not authoritative.  The only 
>> thing that really counts is what Cisco actually shipped in their IOS 
>> implementation.  Lucky me I actually have a terminal
>> server that implements it.  If you look at the C-Kermit sources you 
>> will see that the client is written to accept both values from the 
>> server.  You will also find that Cisco does not send the baudrates as 
>> specified in the RFC but instead uses an enumeration. 
>
>
> True.  But if I had been lucky and had a terminal server, I would not 
> have written ser2net :).
>
> So Cisco uses a enumeration?  Do you think it is possible to make them 
> compatible and do both in ser2net, or is it a non-issue?

Clients can use heuristics to determine which should be used.  Servers 
must choose one; but I would make a configurable option.

(The clock is off by one day 4 hours and 12 minutes.  This causes your 
e-mail to get lost way down in my queue.)



--------------ms070506040803010807030505
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJUDCC
AwYwggJvoAMCAQICAwpxijANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAzMDczMDAyMDkyOFoXDTA0MDcyOTAyMDkyOFowRjEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEjMCEGCSqGSIb3DQEJARYUamFsdG1h
bkBjb2x1bWJpYS5lZHUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBtDG6ZyGA
sK+rZOfKPKGBn6oCTLYSLk/mpeX9QTmTG71qh308KUeN35qqoRXjLvscfw6NPOYXiuxE/RqL
sx7WKEnK3C4gzzpioCTX1b7o4M7YbpvCRBFPE9Jgsd0yz2EN+mk/pPuK1GP+iQNot2m4A56A
aPe6F5T25GqffU535GNIdAtWPao6wHcOm17se25ny/TNzb9mlA4UzYl9XP7MF1fkpJyaDDAy
DNNTSSjxBdPVs2EaYq1p/xadXbIpysQiySXAxoeiZusgJopRHLcBsBmmY9QVD4QnUqZVmfJ5
f1CiNri5vlexKCmdFSrxMLuoLr4EQZCECdusp6ZnIt75AgMBAAGjMTAvMB8GA1UdEQQYMBaB
FGphbHRtYW5AY29sdW1iaWEuZWR1MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEA
DPKe/CuAgEUxsrPskJQx2fL6soAEG2iqrqOGIRREHDaXWDBNMEWEbOEMLvh3+yhqHOUc9x3r
2IfsP/XHnujaqsMVXLagokVTnpPN675wv8LZ8hLHblLnykaTCq6RZpVskh2iAiJwpYMcKNF6
jyYaQyGHBGT3PK8uVGVCG4Pp9k4wggMGMIICb6ADAgECAgMKcYowDQYJKoZIhvcNAQEEBQAw
gZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
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
AgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGrBgkrBgEEAYI3
EAQxgZ0wgZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNV
BAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBT
ZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAIDCnGK
MIGtBgsqhkiG9w0BCRACCzGBnaCBmjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rl
cm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0Eg
MjAwMC44LjMwAgMKcYowDQYJKoZIhvcNAQEBBQAEggEAVzef18TN8k+nlHSVG7r+LA8CMy7j
SaMdErVRzEcnHa++xbb5blSnfTn7lg6gIbnyI0Hj5BlxumpJiekCK0fXJrsZ+nMCeSl6AuHy
WqnbGg/jSLdNcvmONqDa58tqXXAdIkkSj8wmynYVd0yp5+irhZgxexPXQm3pcnSWq+oVM4AP
A/yOiynlPpmvRIKRFolCwGzKfYpeU19tJBg501uIIbPXiTdRkaEqXejnSXM/TEPUxM60rHKC
c9m0QTwiO7b2cFCjM/SythVbFT9LUVUvXQyLzF/vwJ3dIMT4/mg+XNPsFRbLge3nDVmTh8MC
YXOTyZhrbjQtaWNwdsJ0Nb1h5gAAAAAAAA==
--------------ms070506040803010807030505--
