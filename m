From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Tue, 29 Jan 2013 22:29:13 +0000 (UTC)
Message-ID: <ke9ifp$sp$1@ger.gmane.org>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
 <CAJa4H3eWaZH0p8+48Kq4RPEyDiAZfsiX801CBqJ7_CrTw688yw@mail.gmail.com>
 <kdu8ur$kav$1@ger.gmane.org>
 <CAJa4H3cCwpsJr8urNPH0XWO9YruDpxs3a5sgRBS_hEteN5SEEw@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52892 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067Ab3A2W30 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jan 2013 17:29:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1U0JgV-0008Lm-59
	for linux-serial@vger.kernel.org; Tue, 29 Jan 2013 23:29:43 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 29 Jan 2013 23:29:43 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 29 Jan 2013 23:29:43 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-29, Guido Classen <clagix@gmail.com> wrote:
>> Our Linux tty/serial drivers do support "plain" a RS-485 mode without
>> pre/post RTS hold times (the plain RS-485 mode is supported by the
>> UART itself).  The pre/post RTS hold times feature can be used from
>> Linux applications, but to take advantage of those sort of features we
>> don't use Linux tty/serial device drivers.  For many industrial I/O
>> applications we've found it much simpler to avoid the termios/tty
>> stuff and connect to the serial hardware via Ethernet and TCP/IP
>> instead.
>>
>> Over the years we've found that the Unix "tty" API is rather
>> ill-suited for doing things other than talking to terminals.  In other
>> news, we've found that a screwdriver is ill-suited for doing things
>> other than driving screws. :)
>
> You are absolutely right, the "TTY" API is ill-suited for fieldbus style
> half-duplex communication. But in my opinion this form of communication is
> still very common and even today not every device has an ethernet connector.
> So what are the consequences?
>
> 1. Don't use Linux at all for this purpose. For PCs and Server it may
> be indeed the better solution to use TCP/IP instead. But for embedded
> Linux the situation is different. One important application here is
> to implement exactly these Ethernet/TCP/IP to "some lowlevel stuff"
> boxes!
>
> 2. Sole Userspace software using Posix TTY API. This will work (more
> or less) if the speed (baudrate) is relatively low and the time
> between sending and receiving is long enough. You also can not benefit
> from serial hardware which have special support for fieldbus style
> communication like the Atmel AT91 USARTS.
>
> 3. Use some board specific drivers or modifications to the drivers and
> Linux TTY stack (E.G. additional ioctls). I think this way is mostly
> used in practically embedded Linux. Drawbacks are, that userspace
> software must include support for each specific board it is intend to
> run on.

What I'm thinking about doing is instead of using a tty driver,
writing a char driver.  That eliminates the whole tty/ldisc tangle and
allows you to implement read()/write() as packet operations rather
than bytestream operations.  You can still implement whatever subset
of the termios ioctl() calls make sense along with whatever new
ioctl() calls are needed to control/configure things like inter-byte
timeouts, 9th-bit addressing modes, frame-recognition state-machines,
etc.

> 4. The TIOCSRS485 ioctl may open new doors, but as I see there are
> only few drivers implementing it.

Too bad about the name.

It doesn't actually select RS485 mode (I work with board that _do_
have software-selectable electrical interfaces and can be set to
RS2323, RS485, RS422 modes).  What's called "RS485" moide controls
enabling the use of RTS for half-duplex operation. RS485 is _one_
electrical interface that uses RTS like that, but there are lots of
others (RS232 and half-duplex modems is one).  And not all use-cases
for RS485 use RTS for half-duplex communications either.

>> For example, our serial interfaces are used quite a bit in traffic and
>> parking applications, but in those cases the long-haul connections are
>> TCP/IP over fiber, and the serial ports are only used to communicate
>> locally within a roadside cabinet.  To the user application, each of
>> the serial devices (camera controller, inductive loop sensor, ramp
>> light controller, card reader, gate arm, etc.) is just another network
>> device addressed via an <ipaddr,ipport> tuple.
>>
>> Programmers seem to get themselves into much less trouble with the TCP
>> socket API than they do with the tty API
>
> That's crazy, It seems we are working almost with the same things.

Well, some of my customers do that sort of stuff. :)

-- 
Grant Edwards               grant.b.edwards        Yow! What I want to find
                                  at               out is -- do parrots know
                              gmail.com            much about Astro-Turf?

