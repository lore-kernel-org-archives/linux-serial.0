From: Peter Stuge <peter-Y+HMSxxDrH8@public.gmane.org>
Subject: Re: g_serial hangs on write when the cable is disconnected
Date: Wed, 5 Aug 2015 19:09:27 +0200
Message-ID: <20150805170927.20219.qmail@stuge.se>
References: <CAOMwXhNwVKCK1+-q+fAgMc0ebpremXd+S1kUvZ9Ank-5BTMLCA@mail.gmail.com> <20150805145627.GA610@kroah.com> <CAOMwXhM7TNZAGOUAC=gcwjqTz8y7FGs0FRbJb4SQO+VfbzYJJA@mail.gmail.com> <20150805162923.GC21870@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150805162923.GC21870-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Greg KH wrote:
> > >>     int fd = open("/dev/ttyGS0", O_RDWR | O_NONBLOCK);
> > >
> > > This line discipline is very different from the "traditional" tty
> > > line discipline
..
> this is a character device, with a very specific line discipline
> that works in a very specific way and assumes you know exactly how
> to talk to it and communicate with it properly.

If the character device is called tty* then I think it is appropriate
to expect that it (by default) behaves like a "traditional" tty device.

How the kernel implements this device internally (ldisc or no)
shouldn't matter to the user, and if it does I'd consider that a bug.
(Sadly unfixable, because public API.)

=> Rather than defending unexpected behavior, why not admit that the
name was poorly chosen and point to the device-specific requirements?


Thanks

//Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
