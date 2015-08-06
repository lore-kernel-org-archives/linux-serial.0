From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: g_serial hangs on write when the cable is disconnected
Date: Thu, 6 Aug 2015 10:15:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1508061013280.1268-100000@iolanthe.rowland.org>
References: <CAOMwXhPpqEPV+PqM6BgJNByGCKVT4-a3s49iGdrk37VCcX+jQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMwXhPpqEPV+PqM6BgJNByGCKVT4-a3s49iGdrk37VCcX+jQg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, 6 Aug 2015, Laszlo Papp wrote:

> > You should also add a printk statement to the disconnect callback so
> > that you can verify whether it really is getting called.
> 
> Thanks. Should that also be called if I just boot up the board with
> Linux on it while the cable is not attached.

No.  It gets called only at the time you unplug the cable.

> In other words, the
> problem that I am also experiencing is that it blocks even when no
> cable is attached to the board and there has been no cable ever
> attached for the last boot.

You didn't mention this before.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
