From: Guido Classen <clagix@gmail.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Wed, 30 Jan 2013 16:24:35 +0100
Message-ID: <CAJa4H3ebkp=J6+==nW0JpTTO8pkM_8J7EEfxTytwe-p+zweqog@mail.gmail.com>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
	<CAJa4H3eWaZH0p8+48Kq4RPEyDiAZfsiX801CBqJ7_CrTw688yw@mail.gmail.com>
	<kdu8ur$kav$1@ger.gmane.org>
	<CAJa4H3cCwpsJr8urNPH0XWO9YruDpxs3a5sgRBS_hEteN5SEEw@mail.gmail.com>
	<ke9ifp$sp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:45425 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab3A3PYh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2013 10:24:37 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so814690dam.4
        for <linux-serial@vger.kernel.org>; Wed, 30 Jan 2013 07:24:37 -0800 (PST)
In-Reply-To: <ke9ifp$sp$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> What I'm thinking about doing is instead of using a tty driver,
> writing a char driver.  That eliminates the whole tty/ldisc tangle and
> allows you to implement read()/write() as packet operations rather
> than bytestream operations.  You can still implement whatever subset
> of the termios ioctl() calls make sense along with whatever new
> ioctl() calls are needed to control/configure things like inter-byte
> timeouts, 9th-bit addressing modes, frame-recognition state-machines,
> etc.

If I understand this right, you suggest to introduce a new subsystem for
half-duplex field-bus style communication which is fully independent from
the existing POSIX tty subsystem. This subsystem will include own ioctls
for settings timeouts, addressing, turn on and turn off times and so on,
will support some temios ioctls which are applicable like setting baud-rates.
There will be plugable frame-recognition state-machines. How will the
low-level side look like? Will it use the existing serial drivers (over some
kind of new interface?) Or will it have it's own set of serial drivers which
are designed for frame based half duplex communication.
This means duplicate drivers for each kind of UART hardware (8250,
atmel, ...) I am not sure if this is a good design, but on other hand there
are already duplicate drivers for 16550 style UARTs in the kernel for
special purposes like bluetooth, irda and MIDI-interfaces.

>From userspace view this will make thinks much easier, so I personally
will support this approach. But we have to be aware that this will
introduce a new API which is not standardized and portable to other
OSs.  Furthermore there must be some way to have access to the same
hardware either over this API or over the TTY API.

>
>> 4. The TIOCSRS485 ioctl may open new doors, but as I see there are
>> only few drivers implementing it.
>
> Too bad about the name.
>
> It doesn't actually select RS485 mode (I work with board that _do_
> have software-selectable electrical interfaces and can be set to
> RS2323, RS485, RS422 modes).  What's called "RS485" moide controls
> enabling the use of RTS for half-duplex operation. RS485 is _one_
> electrical interface that uses RTS like that, but there are lots of
> others (RS232 and half-duplex modems is one).  And not all use-cases
> for RS485 use RTS for half-duplex communications either.
>
Your fully right. RS232 on the one side and RS485/RS422 on the other are
different physical layers. RS485 is always half-duplex. All RS232 and RS485
can be full or half-duplex. As you said there are RS232 half-duplex modems and
there are also external RS232 to RS485 converters which can be used on all
systems with a RS232 port.

So you have to differ about the hardware design of a port:
  - fixed wired RS232 / RS485 / RS422 transceiver
    operation mode can be hard coded in board code
  - RS232 / RS485 / RS422 configurable by hardware (jumper or piggybacks)
    operation mode must be configurable and must be set by the user
    according the actual hardware configuration
  - RS232 / RS485 / RS422 configurable from software
    operation mode of the driver and configuration of the hardware
must be changed

An on other hand you have the kind of communication (full-duplex or
half-duplex).
which is as said not necessary bound  to the physical variant of the port.
