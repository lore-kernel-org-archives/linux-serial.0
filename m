From: 'Greg KH' <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: Linux USB Serial
Date: Mon, 17 Sep 2012 15:08:13 -0700
Message-ID: <20120917220813.GA7780@kroah.com>
References: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com>
 <87zk4o1kh4.fsf@nemi.mork.no>
 <00b801cd9518$715dd160$54197420$@acscontrol.com>
 <20120917214136.GA20773@kroah.com>
 <00c101cd951f$55626910$00273b30$@acscontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <00c101cd951f$55626910$00273b30$@acscontrol.com>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Steven J. Ackerman" <steve-I01wfHm1r9xGyKhy+UYuEA@public.gmane.org>
Cc: =?iso-8859-1?Q?'Bj=F8rn?= Mork' <bjorn-yOkvZcmFvRU@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Sep 17, 2012 at 05:56:46PM -0400, Steven J. Ackerman wrote:
> Greg-
> 
> Thanks for your response.
> 
> Not sure if I need the cdc-acm functionality or not.
> 
> This is a color lcd display that supports a usb serial interface to
> interact. I really 
> just need to be able to send and receive characters and NAK the pipe back 
> temporarily when my input buffer is full.

That's fine, the cdc-acm interface will work for that.

> The descriptors were supplied by the chip vendor - Renesas - as part of a 
> CDC demo application. The VID/PID is ours. The device works great under 
> Windows XP with the descriptors as shown previously - even with the 
> Communications bInterfaceSubClass value wrong.

But is your device really a CDC ACM device?  Or is it something else?

> Doing the modprobe, etc. was based upon some blog posts that purported
> to show how to add support for an unknown usb serial device.

Yes, but that's a one-off, and your kernel should have told you that you
shouldn't be doing that, if you are using a modern kernel release.

> Looking at the descriptor for a FTDI USB serial to TTL cable it seems a lot
> simpler,
> but it does indicate vendor specific class, subclass and protocol - which
> means 
> that it requires a custom driver - ftdi_sio - right ?  I don't really want
> to have to 
> develop and support that.

You wouldn't, if you use the ftdi serial chip in your device.  Which
begs me to ask, what type of usb to serial chip is in your device?  What
protocol does it use to talk to the host?

> I don't think that I have enough Linux experience to be able to test a patch
> and rebuild of the kernel, and I don't think that I can ask my customers to
> do that it order to use our product as a simple serial display.  

They shouldn't have to do that, once we get it working, they get the
update automatically from their distro.  But if you can't test any
changes we make to try to get this to work, there's not much we can do
here, right?

I think you need to figure out the protocol used by your device to talk
to the host.  If you get that worked out, we can help to get Linux
working with it.

Oh, and fix that descriptor up in your firmware, that might solve
everything :)

Hope this helps,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
