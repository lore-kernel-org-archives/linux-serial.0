From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Fri, 25 Jan 2013 15:39:08 +0000 (UTC)
Message-ID: <kdu8ur$kav$1@ger.gmane.org>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
 <CAJa4H3eWaZH0p8+48Kq4RPEyDiAZfsiX801CBqJ7_CrTw688yw@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34874 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754620Ab3AYPjV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 10:39:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TylNR-0000Pu-B1
	for linux-serial@vger.kernel.org; Fri, 25 Jan 2013 16:39:37 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 25 Jan 2013 16:39:37 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 25 Jan 2013 16:39:37 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-25, Guido Classen <clagix@gmail.com> wrote:
> On 2014-01-23, Grant Edwards wrote:
>
>> In applications like links using half-duplex modems, you may have to
>> assert RTS for many hundreds of millisconds to allow the modulator to
>> key up and stabilze and the demodulator to lock onto the signal before
>> you can send data.  Some modems will let you know when they're ready
>> by asserting CTS, and for others you just have to have a fixed delay.
>> In those cases, you also typically hold RTS for some time after the
>> end of the data for a time ranging up to several byte times.
>
>> In our non-Linux based products, we implement pre/pose data RTS "hold"
>> times as you describe in our device driver.  Our Linux-based products
>> can't handle those applications.

> I am glad to hear that there is at lease someone else out there who
> is using such old technology. We still use a kind of V.23 modems
> which work as you described in some projects in road traffic
> applications. Why haven't you tried to implement that applications on
> Linux?

Our Linux tty/serial drivers do support "plain" a RS-485 mode without
pre/post RTS hold times (the plain RS-485 mode is supported by the
UART itself).  The pre/post RTS hold times feature can be used from
Linux applications, but to take advantage of those sort of features we
don't use Linux tty/serial device drivers.  For many industrial I/O
applications we've found it much simpler to avoid the termios/tty
stuff and connect to the serial hardware via Ethernet and TCP/IP
instead.

Over the years we've found that the Unix "tty" API is rather
ill-suited for doing things other than talking to terminals.  In other
news, we've found that a screwdriver is ill-suited for doing things
other than driving screws. :)

For example, our serial interfaces are used quite a bit in traffic and
parking applications, but in those cases the long-haul connections are
TCP/IP over fiber, and the serial ports are only used to communicate
locally within a roadside cabinet.  To the user application, each of
the serial devices (camera controller, inductive loop sensor, ramp
light controller, card reader, gate arm, etc.) is just another network
device addressed via an <ipaddr,ipport> tuple.

Programmers seem to get themselves into much less trouble with the TCP
socket API than they do with the tty API

> On slow baud-rates even an user-mode implementation should be
> possible in most cases?

Yes, it should be possible, but customers seem quite happy using the
TCP socket API rather than a tty API, so we've never attempted it.

-- 
Grant Edwards               grant.b.edwards        Yow! Maybe we could paint
                                  at               GOLDIE HAWN a rich PRUSSIAN
                              gmail.com            BLUE --

