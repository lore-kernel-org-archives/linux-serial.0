From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Wed, 28 Oct 2015 13:33:42 +0100
Message-ID: <1446035622.15140.17.camel@suse.com>
References: <1445958479.2043.6.camel@suse.com>
	 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
	 <5630BE5E.6040204@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5630BE5E.6040204-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2015-10-28 at 08:23 -0400, Peter Hurley wrote:
> On 10/28/2015 07:04 AM, Oliver Neukum wrote:
> > On Tue, 2015-10-27 at 16:45 +0100, Sven Brauch wrote:
> >> Hey Oliver,
> >>
> >> On 27/10/15 16:07, Oliver Neukum wrote:

> > That is unfortunate. So your problem is with not enough buffers.
> 
> Well, not necessarily.
> 
> As I wrote in the original thread, I changed the way input work is
> scheduled which should impact Sven's use-case. Those patches are
> on Greg's tty-next branch; afaik Sven has not tested with those.
> 
> Sven, please test Oliver's patch on that tree.

It can be found at
https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty/

And yes, that is the much preferable option.

> Also, please attach your target .config here.
> Lastly, please confirm your test method/termios settings (iow, are
> you using a reproducer or just 'cat big_file > /dev/ttyACM1')
> 
> >> the patch I originally sent to the list for comparison still fixed the
> >> issue.
> > 
> > Peter, what to do about this?
> 
> 1. Re-evaluate the input kworker latency with my patches in tty-next.
>    If the max input kworker latency can be cut in 1/2, then Sven's use
>    case will be comfortably in only 1/2 the tty buffer space.
> 
>    I have a quick howto doc in progress for measuring that scheduling
>    lag with ftrace, and a simple awk script for processing that ftrace
>    output to aid in determining why.
> 
>    This is the fundamental problem.
> 
> 2. Fix unthrottle
> 
>    Ever since my work on firewire tty, I've known throttle/unthrottle
>    needed rework, but the i/o path and locking problems were more
>    pressing.
> 
>    This is near top of my TODO list.
> 
> 
> > I think there are issues with Sven's
> > original patch. In particular I can't see how it can guarantee
> > progress. Is there a way to just really increase tty buffers,
> > e.g. quadruple them?
> 
> Yes, this can be done per tty port (typically by the port driver
> install() method). Code fragment below doubles the tty buffer ceiling:
> 
> 	retval = tty_buffer_set_limit(port, 128 * 1024);
> 	if (retval)
> 		goto error....;
> 
> 
> > Sven, could we run a few more tests before we look at your patch
> > again? It really has issues, but it does help and nothing else
> > does. If necessary I will merge an improved version of your patch.
> 
> I would much rather rework URB flow + unthrottle, as I previously
> outlined in the original thread instead of introducing another
> buffering layer.

So would I. I merely am ready to do it as the very last resort.
Sven, could you do the test Peter indicated?
If his tty update and my patch still fail together, could you also
ramp up the tty buffer in the manner he described?

Peter, do you think I ought to upstream the support for put_char() ?

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
