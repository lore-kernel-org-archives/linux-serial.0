From: Jeffrey Altman <jaltman@columbia.edu>
Subject: Re: Serial port redirection
Date: Thu, 04 Dec 2003 12:34:30 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3FCF7026.6070109@columbia.edu>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se> <3FCE1267.3040204@columbia.edu> <3FCDE364.1080005@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080908090800080906070000"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pecan.cc.columbia.edu ([128.59.59.178]:36250 "EHLO
	pecan.cc.columbia.edu") by vger.kernel.org with ESMTP
	id S262360AbTLDRe5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Dec 2003 12:34:57 -0500
In-Reply-To: <3FCDE364.1080005@acm.org>
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Peter Astrand <peter@cendio.se>, ltsp-discuss@lists.sourceforge.net, d.sbragion@infotecna.it, linux-serial@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080908090800080906070000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The reality is RFC is experimental and not authoritative.  The only 
thing that really counts is what Cisco actually shipped in their IOS 
implementation.  Lucky me I actually have a terminal
server that implements it.  If you look at the C-Kermit sources you will 
see that the client is written to accept both values from the server.  
You will also find that Cisco does not send the baudrates as specified 
in the RFC but instead uses an enumeration.

With regards to the comment about the use of separate codes to indicate 
direction, this was written without a good understanding of the Telnet 
Option negotiation.  The reality is that there is no need for a telnet 
protocol option to have separate commands for each direction as the 
option itself must be negotiated separately in each direction.  
Therefore, there is no possibility of confusion.

Jeffrey Altman




Corey Minyard wrote:

> Jeffrey Altman wrote:
>
>> Peter Astrand wrote:
>>
>>> * ser2net is totally incompatible with cyclades-serial-client. This is
>>> because ser2net interprets RFC2217 a bit differently. sredird sends
>>> command "101" as ack for command "1", while ser2net sends "1". 
>>> RFC2217 is
>>> not very explicit about which way is most correct. The ser2net approach
>>> looks better to me, but the sredird one is probably more widely used
>>> (since Cyclades terminal server uses it, for example.) Probably, 
>>> RFC2217
>>> software needs to handle both cases.
>>>
>>>  
>>>
>> ser2net is wrong
>>
>>
> Umm, no.  Cyclades and sredird are wrong.  And it's pretty clear.  
> From RFC2217:
>
>                   Client to Access Server   Access Server to Client
>       SIGNATURE            text                      text
>       SET-BAUDRATE            1                      101
>       SET-DATASIZE            2                      102
>       SET-PARITY              3                      103
>       SET-STOPSIZE            4                      104
>       SET-CONTROL             5                      105
>       NOTIFY-LINESTATE        6                      106
>       NOTIFY-MODEMSTATE       7                      107
>       FLOWCONTROL-SUSPEND     8                      108
>       FLOWCONTROL-RESUME      9                      109
>       SET-LINESTATE-MASK     10                      110
>       SET-MODEMSTATE-MASK    11                      111
>       PURGE-DATA             12                      112
>                                                                               
>   Discussion: As initially proposed, com port configuration
>               commands are only sent from the client to the access
>               server.  There is no current vision that the access
>               server would initiate the use of a com port configuration
>               command, only the notify commands. However, to allow for
>               access server initiated com port configurations different
>               command values have been established.
>
> That last sentence of the discussion says it.  The 1xx commands are 
> there to allow the access server to *initiate* com port configuration 
> changes.  Not to ack the changes.  Unless you can point me to 
> something in the manual to say that I am wrong.
>
> I am willing to change this in the spirit of keeping things 
> consistent, though.
>
> -Corey


--------------ms080908090800080906070000
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
MjAwMC44LjMwAgMKcYowDQYJKoZIhvcNAQEBBQAEggEAXcBut3+Bc5fQMwFoTrlmWlHTsITu
M31mH2+UBxR1F1L0LyPaXGPdYrNYyw6FCN7L1srbPpMyxDN1Ng0r6epZvsziIi2fWNRY/kjv
Bli32fOfuXakAU7uBJS+qS6fKNkrJf5qDS4qmHMWPcELQ2SD/YmzukWRlhmgmzF9FPiaWNV8
RFTkRNRN5Qn0Pu8gd7GA1NFc2eM34I7ndbO/PsNB8ibo8CeMKJ1Pz/96bFqiquZKT1r9If9k
D3G+sa4EO/EiXd12CtYP8/xjXmJwGpJ+S88OZ9S25d172WBW/9nwccas/+3TuxjnpLeNbTEY
qDfmQgGmNMYVcd7fOzWU21x2IwAAAAAAAA==
--------------ms080908090800080906070000--
