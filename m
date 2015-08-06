From: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>
Subject: Re: g_serial hangs on write when the cable is disconnected
Date: Thu, 6 Aug 2015 17:16:26 +0100
Message-ID: <CAOMwXhPyrMODhhToGmLD_WcB4QMcj8QQE443dS7nXtLrqUp-+Q@mail.gmail.com>
References: <CAOMwXhNPi-5iF7BDnb0FTCA885yYJd_UdZyU2RtUL13gw08Z4g@mail.gmail.com>
	<Pine.LNX.4.44L0.1508060951250.1844-100000@iolanthe.rowland.org>
	<CAOMwXhPpqEPV+PqM6BgJNByGCKVT4-a3s49iGdrk37VCcX+jQg@mail.gmail.com>
	<55C37A49.3020503@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55C37A49.3020503-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 6, 2015 at 4:16 PM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
> [ +cc Felipe ]
>
> Hi Laszlo,
>
> On 08/06/2015 10:03 AM, Laszlo Papp wrote:
>> On Thu, Aug 6, 2015 at 2:52 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
>>> On Thu, 6 Aug 2015, Laszlo Papp wrote:
>>>> On Wed, Aug 5, 2015 at 7:15 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
>>>>> On Wed, 5 Aug 2015, Greg KH wrote:
>>>>>
>>>>>> hm, wait, is this really the n_gsm line discipline?  Or is it something
>>>>>> else?
>>>>>>
>>>>>> g_serial is the device side of a serial connection, there is no "cable
>>>>>> removed" notification that it even knows about, that has to come from
>>>>>> the gadget driver somehow, which you should listen for and then kick
>>>>>> your userspace program.
>>>>>
>>>>> There is the gserial_disconnect() callback, which gets invoked when the
>>>>> Vbus power (provided by the host) is removed.  It's a pretty good
>>>>> indicator that the USB cable has been unplugged.
>>>>>
>>>>> I don't understand all the stuff that gserial_disconnect() does, but it
>>>>> ought to be more or less equivalent to a "hangup" -- as the kerneldoc
>>>>> says.  If it doesn't do what users expect, there's probably a bug
>>>>> somewhere.
>>>>>
>>>>> Of course, it's possible that the callback does not get invoked in
>>>>> Laszlo's case.  Then the question would be: Why not?
>>>>
>>>> Hmm, that is a good question. I wonder if there had been any recent
>>>> fixes for that lately... I suppose that I will need to skim through
>>>> the git log. Thank you for the hints!
>>>
>>> You should also add a printk statement to the disconnect callback so
>>> that you can verify whether it really is getting called.
>>
>> Thanks. Should that also be called if I just boot up the board with
>> Linux on it while the cable is not attached. In other words, the
>> problem that I am also experiencing is that it blocks even when no
>> cable is attached to the board and there has been no cable ever
>> attached for the last boot.
>
> You have everyone hopelessly confused about what your problem actually is.
>
> Your $subject says that "g_serial hangs on write" and for a reproducer
> you provide:
>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
>
> int main()
> {
>     const char buf[] = "Hello World!\n";
>     int fd = open("/dev/ttyGS0", O_RDWR | O_NONBLOCK);
>     int sent = write(fd, buf, sizeof(buf)-1);
>     close(fd);
>     return 0;
> }
>
> Only a careful reader would have caught this in your subsequent reply:
>
> On Wed, Aug 05, 2015 at 04:40:21PM +0100, Laszlo Papp wrote:
>> Wow, I managed to mess it up in my original email! So, this code above
>> made it working, but without O_NONBLOCK, it was not working. Using
>> O_NONBLOCK is my current nasty workaround.

Yes, of course. I made a mistake with that and I apologise.

> To answer your original question, yes, the write() is behaving as expected.
> If you open a tty without O_NONBLOCK, then both read() and write() to that
> tty will _block_ until the operation is successful or the tty is hung up.
>
> Your comparison with how ttyS* ports behave when a cable is not connected
> is based on incorrect assumptions. When a ttyS port is in CLOCAL mode
> (the default), the cable state is ignored when _opening_. On write(),
> without hardware flow control (CRTSCTS), the serial port is successfully
> writing the data out without knowing that nothing is listening.

Yes, you are right with that. There is no way to detect errors without
some handshaking on the serial port.

For now, O_NONBLOCK, it is, until I find a better example to work with.

> I don't see a bug here.

It is very likely just a missing example in the documentation. I do
not think that there is a bug in here.

> Regards,
> Peter Hurley
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
