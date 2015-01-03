From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: USB-serial console and lockdep
Date: Sat, 3 Jan 2015 17:26:42 +0100
Message-ID: <20150103162642.GC12203@localhost>
References: <20141118161833.GA22786@localhost>
 <54A4ABFF.5000304@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54A4ABFF.5000304-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 31, 2014 at 09:07:59PM -0500, Peter Hurley wrote:
> Hi Johan,
> 
> On 11/18/2014 11:18 AM, Johan Hovold wrote:
> > I get this missing-lockdep-annotation warning which I haven't seen
> > before when booting with a usb-serial console on 3.18-rc5. It's been a
> > while since I last tested this, though, and the tty_ldisc_ref wasn't
> > introduced until 833efc0ed19c ("USB: serial: invoke dcd_change ldisc's
> > handler.").
> 
> Sorry it took me so long to finally look at this -- at least I'm looking
> at it in the same year ;)  (in my tzone anyway)

No worries. Wasn't a top prio of mine either. :)

Thanks for taking a look.

> Is this easily reproducible?

Yes, happens on every boot with the pl2303 driver.

> Because for lockdep to be trying to register the ldsem lock class
> from the tty_ldisc_ref() means that no tty has yet been opened [see 1].
> So how did the call to tty_port_tty_get() in pl2303_update_line_status()
> return a tty?

Because the USB console driver is using a only partially initialised,
"fake" tty struct to pass terminal settings to the underlying driver.
So no wonder things can blow up.

This particular issue can be fixed by making sure to initialise the
ldisc semaphore, but there are likely more potential problems here,
including use-after-free as the fake tty wasn't released using the
kref. I'll post two fixes as a follow up.

A more long term solution might be to rewrite all usb-serial drivers to
handle a NULL termios and pass a ktermios to set_termios similar to how
serial-core does this.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
