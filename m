From: Jeffrey Altman <jaltman-WLbs8XpHrcb2fBVCVOL8/A@public.gmane.org>
Subject: Re: Serial port redirection
Date: Wed, 03 Dec 2003 11:36:17 -0500
Sender: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCE1101.40502@columbia.edu>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050809050707030705060809"
Return-path: <ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0312031557190.12826-100000-K9BqGu7AvB3wj5YHdwD3Ga2PxDmRETKR@public.gmane.org>
Errors-To: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltsp-discuss>,
	<mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:ltsp-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltsp-discuss>,
	<mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ltsp-discuss>
To: Peter Astrand <peter-+4tYiAq3b6azQB+pC5nmwQ@public.gmane.org>
Cc: ltsp-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>, d.sbragion-eDKEdzQQoQ4L5bzFcGmneg@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050809050707030705060809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Its not a Kermit bug; If you pass the socket file descriptor to an 
external program
the external program must understand telnet protocol.  Otherwise, it 
can't send the
correct data format.



Peter Astrand wrote:

>>Hi. I'm trying to find a generic serial port redirection solution for a
>>Linux terminal server environment. I'd like a solution based on RFC2217.  
>>I'm particularly interested in syncing Palm Pilot PDAs. 
>>    
>>
>...
>  
>
>>ser2net/sredird + Kermit
>>------------------------
>>Kermit has built-in RFC2217 support, but it doesn't work for me:
>>
>>---
>>C-Kermit>set host localhost:4911
>> DNS Lookup...  Trying 127.0.0.1...  Reverse DNS Lookup... (OK)
>> localhost.localdomain connected on port 4911
>>C-Kermit>set speed 2400
>>localhost.localdomain:4911, 2400 bps
>>C-Kermit>connect
>>Connecting to host localhost.localdomain:4911
>> Escape character: Ctrl-\ (ASCII 28, FS): enabled
>>Type the escape character followed by C to get back,
>>or followed by ? to see other options.
>>----------------------------------------------------
>>,
>>Communications disconnect
>>---
>>    
>>
>
>Well, this was my fault: I didn't understand how Kermit worked. When using 
>"set carrier-watch off", things worked much better. 
>
>* BUT: When using Kermit as a RFC2217 client for transferring files with
>ZMODEM, I get "Bad CRC" pretty much all the time. This happens *both* with
>the sredird, ser2net and Tactical Softwares Dialout/Server for Windows.
>The problem seems to go away if I transfer files without "0xff" bytes(!)  
>This looks like a Kermit bug to me. I'll guess I have to talk to the
>Kermit folks about this.
>
>
>* ser2net is totally incompatible with cyclades-serial-client. This is
>because ser2net interprets RFC2217 a bit differently. sredird sends
>command "101" as ack for command "1", while ser2net sends "1". RFC2217 is
>not very explicit about which way is most correct. The ser2net approach
>looks better to me, but the sredird one is probably more widely used
>(since Cyclades terminal server uses it, for example.) Probably, RFC2217
>software needs to handle both cases.
>
>
>Some more test cases:
>
>* minicom + cyclades-serial-client + sredird:
>  Works
>
>* pilot-link + cyclades-serial-client + sredird:
>  Does not work (see my previous mail)
>
>* pilot-link + cyclades-serial-client + Dialout/Server:
>  Works perfectly. 
>
>* photopc + cyclades-serial-client + sredird:
>  Does not work. I get "excessive retries". 
>
>* photopc + cyclades-serial-client + Dialout/Server:
>  Works perfectly. 
>
>So, the combination of sredird + cyclades-serial-client does not work 
>correctly. 
>
>Also, I tried running "Contract I.T. Communications Analyzer" on a Windows
>machine. One physical port was connected to a Linux machine via a null
>modem cable. This machine ran sredird. One virtual port was created with
>Tactical Softwares Dialout software, connecting to sredird. Communications
>Analyzer indicated 90% Byte Error Rate! Since cyclades-serial-client was
>not involved in this test, I would say that it looks like sredird is doing
>something wrong.
>
>
>If *anyone* has any ideas of how to solve these problem, please let me
>know. I'm starting to run out of time and patience...
>
>
>(Which mailing list is best for this topic?)
>
>  
>

--------------ms050809050707030705060809
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
MjAwMC44LjMwAgMKcYowDQYJKoZIhvcNAQEBBQAEggEAf4wllCEliBAM3586LALqScNfjc4E
xtbOIsZEvxXQpHbtn3oJW1hTjcXQR9AhxyA+PXV3Op3UPo/C3C/4IfBsU1h6RQhyKaxq/EdF
ClFSeK14NDlSvLQNbg6qfL92XT5iJbmItY7Lgf72wZbPAiakyn4r62PtSuVKjbOfk57tnqdR
vN5IqqxaTiewEaFZu1b/NrniQJP5QbjZQnushUlyIwf7wJcrFs+pxXEHPlHVM4SXTACgVLWg
acvXMV3mHmYQk290l43q1XxsbLPH8dZ44ZmEWYSlYehCnzxs+75hIkLFdLkaDPI6fuHiUBUq
I/e+gojVWaQxLvcp/EP46hA1tAAAAAAAAA==
--------------ms050809050707030705060809--


-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
_____________________________________________________________________
Ltsp-discuss mailing list.   To un-subscribe, or change prefs, goto:
      https://lists.sourceforge.net/lists/listinfo/ltsp-discuss
For additional LTSP help,   try #ltsp channel on irc.freenode.net
