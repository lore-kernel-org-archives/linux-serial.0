From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Wed, 30 Jan 2013 17:57:40 +0000 (UTC)
Message-ID: <kebmuj$64o$1@ger.gmane.org>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
 <CAJa4H3eWaZH0p8+48Kq4RPEyDiAZfsiX801CBqJ7_CrTw688yw@mail.gmail.com>
 <kdu8ur$kav$1@ger.gmane.org>
 <CAJa4H3cCwpsJr8urNPH0XWO9YruDpxs3a5sgRBS_hEteN5SEEw@mail.gmail.com>
 <ke9ifp$sp$1@ger.gmane.org>
 <CAJa4H3ebkp=J6+==nW0JpTTO8pkM_8J7EEfxTytwe-p+zweqog@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38066 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756578Ab3A3R57 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2013 12:57:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1U0bvI-0006ej-Do
	for linux-serial@vger.kernel.org; Wed, 30 Jan 2013 18:58:12 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 30 Jan 2013 18:58:12 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 30 Jan 2013 18:58:12 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-30, Guido Classen <clagix@gmail.com> wrote:
>> What I'm thinking about doing is instead of using a tty driver,
>> writing a char driver.  That eliminates the whole tty/ldisc tangle and
>> allows you to implement read()/write() as packet operations rather
>> than bytestream operations.  You can still implement whatever subset
>> of the termios ioctl() calls make sense along with whatever new
>> ioctl() calls are needed to control/configure things like inter-byte
>> timeouts, 9th-bit addressing modes, frame-recognition state-machines,
>> etc.
>
> If I understand this right, you suggest to introduce a new subsystem for
> half-duplex field-bus style communication which is fully independent from
> the existing POSIX tty subsystem. This subsystem will include own ioctls
> for settings timeouts, addressing, turn on and turn off times and so on,
> will support some temios ioctls which are applicable like setting baud-rates.

It wouldn't have to be half-duplex.

> There will be plugable frame-recognition state-machines. How will the
> low-level side look like? Will it use the existing serial drivers
> (over some kind of new interface?)

I haven't gotten that far.  Since the existing serial drivers assume
the existance and use of the tty layer, they probably can't be used
as-is.

> Or will it have it's own set of serial drivers which are designed for
> frame based half duplex communication. This means duplicate drivers
> for each kind of UART hardware (8250, atmel, ...)

Unfortunately, that's probably what it would take.

> I am not sure if this is a good design, but on other hand there are
> already duplicate drivers for 16550 style UARTs in the kernel for
> special purposes like bluetooth, irda and MIDI-interfaces.
>
> From userspace view this will make thinks much easier, so I
> personally will support this approach. But we have to be aware that
> this will introduce a new API which is not standardized and portable
> to other OSs.

That's a very real issue.  The applications I'm initially interested
in porting aren't Unix/Linux apps anyway, so for my particular project
the applications have to be ported to something, and the existing tty
API just doesn't provide the required features.

> Furthermore there must be some way to have access to the same
> hardware either over this API or over the TTY API.

That's not one of my requirements.  My plan is that you either enable
the serial_core driver or my "low-level char/frame" driver -- you
can't use both.  You could, of course, build them both as modules and
switch back and forth without rebooting.

There's no reason that the driver I'm thinking about can't be
partially API compatible so that you can use the same libc calls to do
common things like set baud rate/parity, get/set modem status/control
lines, and so on.

-- 
Grant Edwards               grant.b.edwards        Yow! I can't decide which
                                  at               WRONG TURN to make first!!
                              gmail.com            I wonder if BOB GUCCIONE
                                                   has these problems!

