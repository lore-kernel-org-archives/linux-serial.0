From: Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>
Subject: Re: Serial port redirection
Date: Wed, 03 Dec 2003 07:02:30 -0600
Sender: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCDDEE6.4070905@acm.org>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se> <3FCE1101.40502@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FCE1101.40502-WLbs8XpHrcb2fBVCVOL8/A@public.gmane.org>
Errors-To: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltsp-discuss>,
	<mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:ltsp-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltsp-discuss>,
	<mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ltsp-discuss>
To: Jeffrey Altman <jaltman-WLbs8XpHrcb2fBVCVOL8/A@public.gmane.org>
Cc: Peter Astrand <peter-+4tYiAq3b6azQB+pC5nmwQ@public.gmane.org>, ltsp-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, d.sbragion-eDKEdzQQoQ4L5bzFcGmneg@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Jeffrey Altman wrote:

> Its not a Kermit bug; If you pass the socket file descriptor to an 
> external program
> the external program must understand telnet protocol.  Otherwise, it 
> can't send the
> correct data format. 

No, it *is* a kermit bug.  When kermit sends an 0xff character, it needs 
to escape it per the standard telnet protocol.  It's obviously not doing 
this.

-Corey

>
>
>
>
> Peter Astrand wrote:
>
>>> Hi. I'm trying to find a generic serial port redirection solution for a
>>> Linux terminal server environment. I'd like a solution based on 
>>> RFC2217.  I'm particularly interested in syncing Palm Pilot PDAs.   
>>
>> ...
>>  
>>
>>> ser2net/sredird + Kermit
>>> ------------------------
>>> Kermit has built-in RFC2217 support, but it doesn't work for me:
>>>
>>> ---
>>> C-Kermit>set host localhost:4911
>>> DNS Lookup...  Trying 127.0.0.1...  Reverse DNS Lookup... (OK)
>>> localhost.localdomain connected on port 4911
>>> C-Kermit>set speed 2400
>>> localhost.localdomain:4911, 2400 bps
>>> C-Kermit>connect
>>> Connecting to host localhost.localdomain:4911
>>> Escape character: Ctrl-\ (ASCII 28, FS): enabled
>>> Type the escape character followed by C to get back,
>>> or followed by ? to see other options.
>>> ----------------------------------------------------
>>> ,
>>> Communications disconnect
>>> ---
>>>   
>>
>>
>> Well, this was my fault: I didn't understand how Kermit worked. When 
>> using "set carrier-watch off", things worked much better.
>> * BUT: When using Kermit as a RFC2217 client for transferring files with
>> ZMODEM, I get "Bad CRC" pretty much all the time. This happens *both* 
>> with
>> the sredird, ser2net and Tactical Softwares Dialout/Server for Windows.
>> The problem seems to go away if I transfer files without "0xff" 
>> bytes(!)  This looks like a Kermit bug to me. I'll guess I have to 
>> talk to the
>> Kermit folks about this.
>>
>>
>> * ser2net is totally incompatible with cyclades-serial-client. This is
>> because ser2net interprets RFC2217 a bit differently. sredird sends
>> command "101" as ack for command "1", while ser2net sends "1". 
>> RFC2217 is
>> not very explicit about which way is most correct. The ser2net approach
>> looks better to me, but the sredird one is probably more widely used
>> (since Cyclades terminal server uses it, for example.) Probably, RFC2217
>> software needs to handle both cases.
>>
>>
>> Some more test cases:
>>
>> * minicom + cyclades-serial-client + sredird:
>>  Works
>>
>> * pilot-link + cyclades-serial-client + sredird:
>>  Does not work (see my previous mail)
>>
>> * pilot-link + cyclades-serial-client + Dialout/Server:
>>  Works perfectly.
>> * photopc + cyclades-serial-client + sredird:
>>  Does not work. I get "excessive retries".
>> * photopc + cyclades-serial-client + Dialout/Server:
>>  Works perfectly.
>> So, the combination of sredird + cyclades-serial-client does not work 
>> correctly.
>> Also, I tried running "Contract I.T. Communications Analyzer" on a 
>> Windows
>> machine. One physical port was connected to a Linux machine via a null
>> modem cable. This machine ran sredird. One virtual port was created with
>> Tactical Softwares Dialout software, connecting to sredird. 
>> Communications
>> Analyzer indicated 90% Byte Error Rate! Since cyclades-serial-client was
>> not involved in this test, I would say that it looks like sredird is 
>> doing
>> something wrong.
>>
>>
>> If *anyone* has any ideas of how to solve these problem, please let me
>> know. I'm starting to run out of time and patience...
>>
>>
>> (Which mailing list is best for this topic?)
>>
>>  
>>




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_____________________________________________________________________
Ltsp-discuss mailing list.   To un-subscribe, or change prefs, goto:
      https://lists.sourceforge.net/lists/listinfo/ltsp-discuss
For additional LTSP help,   try #ltsp channel on irc.freenode.net
