From: Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>
Subject: Re: Serial port redirection
Date: Wed, 03 Dec 2003 07:45:32 -0600
Sender: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCDE8FC.3070400@acm.org>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se> <3FCE1267.3040204@columbia.edu> <3FCDE364.1080005@acm.org> <3FCF7026.6070109@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FCF7026.6070109-WLbs8XpHrcb2fBVCVOL8/A@public.gmane.org>
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

> The reality is RFC is experimental and not authoritative.  The only 
> thing that really counts is what Cisco actually shipped in their IOS 
> implementation.  Lucky me I actually have a terminal
> server that implements it.  If you look at the C-Kermit sources you 
> will see that the client is written to accept both values from the 
> server.  You will also find that Cisco does not send the baudrates as 
> specified in the RFC but instead uses an enumeration. 

True.  But if I had been lucky and had a terminal server, I would not 
have written ser2net :).

So Cisco uses a enumeration?  Do you think it is possible to make them 
compatible and do both in ser2net, or is it a non-issue?

>
>
> With regards to the comment about the use of separate codes to 
> indicate direction, this was written without a good understanding of 
> the Telnet Option negotiation.  The reality is that there is no need 
> for a telnet protocol option to have separate commands for each 
> direction as the option itself must be negotiated separately in each 
> direction.  Therefore, there is no possibility of confusion. 

Also true.  It seemed silly to have it this way.

-Corey



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_____________________________________________________________________
Ltsp-discuss mailing list.   To un-subscribe, or change prefs, goto:
      https://lists.sourceforge.net/lists/listinfo/ltsp-discuss
For additional LTSP help,   try #ltsp channel on irc.freenode.net
