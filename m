From: Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>
Subject: Re: Serial port redirection
Date: Wed, 03 Dec 2003 07:23:04 -0600
Sender: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCDE3B8.3000609@acm.org>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se> <3FCE1101.40502@columbia.edu> <3FCDDEE6.4070905@acm.org> <3FCF6B4D.2050103@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FCF6B4D.2050103-WLbs8XpHrcb2fBVCVOL8/A@public.gmane.org>
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

Ah, I missed that.  Ideally, something (i would think kermit) should sit 
between the program and the socket to make it transparent.  But yes, I 
see what you are saying.

Thanks,

-Corey

Jeffrey Altman wrote:

> Corey Minyard wrote:
>
>> Jeffrey Altman wrote:
>>
>>> Its not a Kermit bug; If you pass the socket file descriptor to an 
>>> external program
>>> the external program must understand telnet protocol.  Otherwise, it 
>>> can't send the
>>> correct data format. 
>>
>>
>>
>> No, it *is* a kermit bug.  When kermit sends an 0xff character, it 
>> needs to escape it per the standard telnet protocol.  It's obviously 
>> not doing this.
>>
>> -Corey
>
>
>
> I agree, the IAC must be quoted.  The problem is that when an external 
> protocol handler is
> executed as a child process, Kermit is suspended and the child process 
> has complete control
> over the socket file descriptor.
> Kermit is not sitting between the external protocol and the host.
> Some versions of sz have a command line flag to handle this situation 
> such that IAC (0xff) are
> not sent but are instead escaped within the zmodem protocol.
>
> Jeffrey Altman
>
>




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_____________________________________________________________________
Ltsp-discuss mailing list.   To un-subscribe, or change prefs, goto:
      https://lists.sourceforge.net/lists/listinfo/ltsp-discuss
For additional LTSP help,   try #ltsp channel on irc.freenode.net
