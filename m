From: Jeffrey Altman <jaltman-WLbs8XpHrcb2fBVCVOL8/A@public.gmane.org>
Subject: Re: Serial port redirection
Date: Thu, 04 Dec 2003 14:12:57 -0500
Sender: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCF8739.8060200@columbia.edu>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se> <3FCE1101.40502@columbia.edu> <3FCDDEE6.4070905@acm.org> <3FCF6B4D.2050103@columbia.edu> <3FCDE3B8.3000609@acm.org> <3FCF70E0.4000302@columbia.edu> <3FCF73BE.1010707@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms000406010406070500090307"
Return-path: <ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FCF73BE.1010707-HInyCGIudOg@public.gmane.org>
Errors-To: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltsp-discuss>,
	<mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:ltsp-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltsp-discuss>,
	<mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ltsp-discuss>
To: Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>
Cc: Peter Astrand <peter-+4tYiAq3b6azQB+pC5nmwQ@public.gmane.org>, ltsp-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, d.sbragion-eDKEdzQQoQ4L5bzFcGmneg@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000406010406070500090307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

That would not help you.  Its not simply a question of mapping escaping 
the IAC.  You must be prepared to process and respond to telnet option 
negotiations during the file transfer.  This is especially true with the 
Remote Com Port option since the host is likely to be sending flow 
control and signal status messages to the client. 

This change really does need to be added to C-Kermit.  Unfortunately, as 
I am no longer employed by Columbia to work on Kermit this is very very 
very low on my stack.

Jeffrey Altman


Corey Minyard wrote:

> It would be fairly trivial to write such a program, though.  You could 
> pass it the actual program you want, and it could make the protocol 
> transparent.
>
> -Corey


--------------ms000406010406070500090307
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
MjAwMC44LjMwAgMKcYowDQYJKoZIhvcNAQEBBQAEggEAevlL0aOe7AixivqfqL5W98T9/bfq
BLHDOO8vkuVwiJOq1/aGROF6SJDURNrMqrNnWrMotMvwyQPTPvrvo3YP1tt901rLcTRuVMv4
I4R8SXyMoHQWtq82QXAVDKF+jXjmVCPIDAtshTcr5o1y1eyAEQQmX9qHe4kUSkQ1TNySvojE
XNNQof4bRnuAu0yE+az+qzPLS56ECVHiu+xnBpGTtiKbmPmR/l/hfYjfFkDpFEkm14ePm99h
HMIAFvGAWzk7S8tXL37dnGLomSZwAmHaqgH9hqeGOSHp7G/dNlU96LtXr0Pf/Ux1mM3ly+Ik
9lQO9Kx2wkuBu/KJOmqKQE1bDgAAAAAAAA==
--------------ms000406010406070500090307--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_____________________________________________________________________
Ltsp-discuss mailing list.   To un-subscribe, or change prefs, goto:
      https://lists.sourceforge.net/lists/listinfo/ltsp-discuss
For additional LTSP help,   try #ltsp channel on irc.freenode.net
