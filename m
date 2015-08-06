From: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>
Subject: Re: g_serial hangs on write when the cable is disconnected
Date: Thu, 6 Aug 2015 15:03:22 +0100
Message-ID: <CAOMwXhPpqEPV+PqM6BgJNByGCKVT4-a3s49iGdrk37VCcX+jQg@mail.gmail.com>
References: <CAOMwXhNPi-5iF7BDnb0FTCA885yYJd_UdZyU2RtUL13gw08Z4g@mail.gmail.com>
	<Pine.LNX.4.44L0.1508060951250.1844-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1508060951250.1844-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 6, 2015 at 2:52 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Thu, 6 Aug 2015, Laszlo Papp wrote:
>
>> Hi Alan,
>>
>> On Wed, Aug 5, 2015 at 7:15 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
>> > On Wed, 5 Aug 2015, Greg KH wrote:
>> >
>> >> hm, wait, is this really the n_gsm line discipline?  Or is it something
>> >> else?
>> >>
>> >> g_serial is the device side of a serial connection, there is no "cable
>> >> removed" notification that it even knows about, that has to come from
>> >> the gadget driver somehow, which you should listen for and then kick
>> >> your userspace program.
>> >
>> > There is the gserial_disconnect() callback, which gets invoked when the
>> > Vbus power (provided by the host) is removed.  It's a pretty good
>> > indicator that the USB cable has been unplugged.
>> >
>> > I don't understand all the stuff that gserial_disconnect() does, but it
>> > ought to be more or less equivalent to a "hangup" -- as the kerneldoc
>> > says.  If it doesn't do what users expect, there's probably a bug
>> > somewhere.
>> >
>> > Of course, it's possible that the callback does not get invoked in
>> > Laszlo's case.  Then the question would be: Why not?
>>
>> Hmm, that is a good question. I wonder if there had been any recent
>> fixes for that lately... I suppose that I will need to skim through
>> the git log. Thank you for the hints!
>
> You should also add a printk statement to the disconnect callback so
> that you can verify whether it really is getting called.

Thanks. Should that also be called if I just boot up the board with
Linux on it while the cable is not attached. In other words, the
problem that I am also experiencing is that it blocks even when no
cable is attached to the board and there has been no cable ever
attached for the last boot.

>
> Alan Stern
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
