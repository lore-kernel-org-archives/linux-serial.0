From: Peter Astrand <peter-+4tYiAq3b6azQB+pC5nmwQ@public.gmane.org>
Subject: Re: Re: Serial port redirection
Date: Wed, 3 Dec 2003 18:04:06 +0100 (CET)
Sender: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0312031752220.12826-100000@maggie.lkpg.cendio.se>
References: <3FCE13B3.2020406@iplink.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FCE13B3.2020406-in1zDm/uaHCsTnJN9+BGXg@public.gmane.org>
Errors-To: ltsp-discuss-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltsp-discuss>,
	<mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:ltsp-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltsp-discuss>,
	<mailto:ltsp-discuss-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ltsp-discuss>
To: alvin <alvin-in1zDm/uaHCsTnJN9+BGXg@public.gmane.org>
Cc: ltsp-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 3 Dec 2003, alvin wrote:

> have you taken a look at comserv. I ran it up and did a few simple tests 
> on my Xyplex terminal server. It did not do what I wanted and I put it 
> aside for later use.
> 
> http://www.bsdhome.com/comserv/

Also, there is a package called termpkg 
(http://www.linuxlots.com/~termpkg/). The problem with all these packages 
are that they only uses simple pseduo ttys. This means that 
ioctls/tcsetattr syscalls won't work (at least not with Linux 2.4; I've 
heard that 2.6 fixes this). 

To be able to "interpret" ioctl/tcsetattr correctly, one needs to use a
LD_PRELOAD:ed library. It's not pretty, but this is the best solution I've
found for current Linux distros. cyclades-serial-client is the only 
package I've found which uses this approach. 


-- 
Peter Åstrand		www.thinlinc.com
Cendio			www.cendio.se
Teknikringen 3		Phone: +46-13-21 46 00
583 30 Linköping








-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
_____________________________________________________________________
Ltsp-discuss mailing list.   To un-subscribe, or change prefs, goto:
      https://lists.sourceforge.net/lists/listinfo/ltsp-discuss
For additional LTSP help,   try #ltsp channel on irc.freenode.net
