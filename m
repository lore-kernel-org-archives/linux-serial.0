From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: USB-serial console and lockdep
Date: Mon, 05 Jan 2015 10:26:20 -0500
Message-ID: <54AAAD1C.8090106@hurleysoftware.com>
References: <20141118161833.GA22786@localhost> <54A4ABFF.5000304@hurleysoftware.com> <20150103162642.GC12203@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150103162642.GC12203@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 01/03/2015 11:26 AM, Johan Hovold wrote:
> On Wed, Dec 31, 2014 at 09:07:59PM -0500, Peter Hurley wrote:
>> Hi Johan,
>>
>> On 11/18/2014 11:18 AM, Johan Hovold wrote:
>>> I get this missing-lockdep-annotation warning which I haven't seen
>>> before when booting with a usb-serial console on 3.18-rc5. It's been a
>>> while since I last tested this, though, and the tty_ldisc_ref wasn't
>>> introduced until 833efc0ed19c ("USB: serial: invoke dcd_change ldisc's
>>> handler.").
>>
>> Sorry it took me so long to finally look at this -- at least I'm looking
>> at it in the same year ;)  (in my tzone anyway)
> 
> No worries. Wasn't a top prio of mine either. :)
> 
> Thanks for taking a look.
> 
>> Is this easily reproducible?
> 
> Yes, happens on every boot with the pl2303 driver.
> 
>> Because for lockdep to be trying to register the ldsem lock class
>> from the tty_ldisc_ref() means that no tty has yet been opened [see 1].
>> So how did the call to tty_port_tty_get() in pl2303_update_line_status()
>> return a tty?
> 
> Because the USB console driver is using a only partially initialised,
> "fake" tty struct to pass terminal settings to the underlying driver.
> So no wonder things can blow up.

Ahh, I did not know that.

> This particular issue can be fixed by making sure to initialise the
> ldisc semaphore, but there are likely more potential problems here,
> including use-after-free as the fake tty wasn't released using the
> kref. I'll post two fixes as a follow up.
> 
> A more long term solution might be to rewrite all usb-serial drivers to
> handle a NULL termios and pass a ktermios to set_termios similar to how
> serial-core does this.

I agree that this definitely needs a more robust solution.
FWIW, I don't think serial-core is a particularly good model.

Regards,
Peter Hurley



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
