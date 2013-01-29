From: Guido Classen <clagix@gmail.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Tue, 29 Jan 2013 22:56:48 +0100
Message-ID: <CAJa4H3cCwpsJr8urNPH0XWO9YruDpxs3a5sgRBS_hEteN5SEEw@mail.gmail.com>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
	<CAJa4H3eWaZH0p8+48Kq4RPEyDiAZfsiX801CBqJ7_CrTw688yw@mail.gmail.com>
	<kdu8ur$kav$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:57629 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3A2V4t (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jan 2013 16:56:49 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so534969pbc.11
        for <linux-serial@vger.kernel.org>; Tue, 29 Jan 2013 13:56:49 -0800 (PST)
In-Reply-To: <kdu8ur$kav$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

> Our Linux tty/serial drivers do support "plain" a RS-485 mode without
> pre/post RTS hold times (the plain RS-485 mode is supported by the
> UART itself).  The pre/post RTS hold times feature can be used from
> Linux applications, but to take advantage of those sort of features we
> don't use Linux tty/serial device drivers.  For many industrial I/O
> applications we've found it much simpler to avoid the termios/tty
> stuff and connect to the serial hardware via Ethernet and TCP/IP
> instead.
>
> Over the years we've found that the Unix "tty" API is rather
> ill-suited for doing things other than talking to terminals.  In other
> news, we've found that a screwdriver is ill-suited for doing things
> other than driving screws. :)

You are absolutely right, the "TTY" API is ill-suited for fieldbus style
half-duplex communication. But in my opinion this form of communication is
still very common and even today not every device has an ethernet connector.
So what are the consequences?

1. Don't use Linux at all for this purpose. For PCs and Server it may
be indeed the better solution to use TCP/IP instead. But for embedded
Linux the situation is different. One important application here is to
implement exactly these Ethernet/TCP/IP to "some lowlevel stuff"
boxes!

2. Sole Userspace software using Posix TTY API. This will work (more
or less) if the speed (baudrate) is relatively low and the time
between sending and receiving is long enough. You also can not benefit
from serial hardware which have special support for fieldbus style
communication like the Atmel AT91 USARTS.

3. Use some board specific drivers or modifications to the drivers and
Linux TTY stack (E.G. additional ioctls). I think this way is mostly
used in practically embedded Linux. Drawbacks are, that userspace
software must include support for each specific board it is intend to
run on.

4. The TIOCSRS485 ioctl may open new doors, but as I see there are
only few drivers implementing it.


Maybe someone else on this list will share his thoughts about this issues


>
> For example, our serial interfaces are used quite a bit in traffic and
> parking applications, but in those cases the long-haul connections are
> TCP/IP over fiber, and the serial ports are only used to communicate
> locally within a roadside cabinet.  To the user application, each of
> the serial devices (camera controller, inductive loop sensor, ramp
> light controller, card reader, gate arm, etc.) is just another network
> device addressed via an <ipaddr,ipport> tuple.
>
> Programmers seem to get themselves into much less trouble with the TCP
> socket API than they do with the tty API

That's crazy, It seems we are working almost with the same things. I am
a software developer and so I also prefer TCP. It's much simpler to
use and has a clean, portable API. In new installations, TCP is quite
common. We also have fiber optics and copper rings for long-haul
connections. But there also very old copper wires which are to long to
be used with SHDSL. Sensors and actors are mostly connected serial. At least
in Germany for road traffic equipments protocols are often specified by
national standards. There also old installations which should be extended or
modified. So at the end we don't get rid of serial and we must be able to
support it in parallel to the TCP/IP infrastructure!

Regards,
  Guido Classen
