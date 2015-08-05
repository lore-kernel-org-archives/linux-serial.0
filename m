From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: g_serial hangs on write when the cable is disconnected
Date: Wed, 5 Aug 2015 14:15:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1508051411090.1713-100000@iolanthe.rowland.org>
References: <20150805172640.GB25008@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150805172640.GB25008-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 5 Aug 2015, Greg KH wrote:

> hm, wait, is this really the n_gsm line discipline?  Or is it something
> else?
> 
> g_serial is the device side of a serial connection, there is no "cable
> removed" notification that it even knows about, that has to come from
> the gadget driver somehow, which you should listen for and then kick
> your userspace program.

There is the gserial_disconnect() callback, which gets invoked when the 
Vbus power (provided by the host) is removed.  It's a pretty good 
indicator that the USB cable has been unplugged.

I don't understand all the stuff that gserial_disconnect() does, but it 
ought to be more or less equivalent to a "hangup" -- as the kerneldoc 
says.  If it doesn't do what users expect, there's probably a bug 
somewhere.

Of course, it's possible that the callback does not get invoked in 
Laszlo's case.  Then the question would be: Why not?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
