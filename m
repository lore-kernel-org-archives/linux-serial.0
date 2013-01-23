From: Guido Classen <clagix@gmail.com>
Subject: RS485 implementation questions (primarly in atmel_serial.c)
Date: Wed, 23 Jan 2013 23:56:25 +0100
Message-ID: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:61833 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3AWW4Z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jan 2013 17:56:25 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so4960416pbc.37
        for <linux-serial@vger.kernel.org>; Wed, 23 Jan 2013 14:56:25 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Hi everyone on linux serial list,

I'm currently working on upgrading ARM-Linux board of our company
to a recent Linux kernel and am glad to see, that RS485 support has
reached the mainline. Firstly many thanks to Claudio Scordino and
the other contributers, I really appreciate their work. I've contacted
Claudio, to discuss some issues about RS485. But he is currently to bus, so
I hope to find others here to discuss my questions and concerns.

I personally work for over 10 years with RS485 stuff (even on
microprocessor systems from the pre-Linux era) and also implemented
several years ago RS485 for our company's own AT91 Linux based boards.
My old implementation was based on the 1ms tick timer and supported
both, the 16550 chips and at Atmel AT91 USARTS.

I've recently looked at the current atmel_serial.c sources and have
trouble to understand why RS485 is implemented in this way.

First question is about what is the exact meaning of the
delay_rts_before/after_send fields in the RS485 ioctl?  Unfortunately
there is no explanation (except from the sample code) in
Documentation/serial serial-rs485.txt. It's not even clear in which
Units this parameters are given. The crisv10.c driver gets the
delay_before_send in milliseconds and atmel_serial
delay_rts_after_send in bit-times (means depending on baud rate).

In my opinion (and according the practice in our company) the purpose
of delay_rts_before/after_send is to make the time in which RTS is
asserted a bit longer (at choice before and / or after) as the actual
transmission of the characters take. The reason is that longs lines
need some time for the transition from tri-state (open circuit voltage
supplied by pull-up / pull-down resistors) to the active transmission
level (logical "1"). I think this is called transient oscillation (I'm
not sure if this is the right English term). Furthermore active
devices in the RS485 line (repeater, party-line modems) often need to
know if you want to send a bit earlier than the first character
arrives to have some time to do internal switching from receiving to
transmission.

I this cases you need a way to assert RTS some milliseconds before the
first character of a frame is transmitted and leave it on some
milliseconds after the end of the frame. In my opinion that is what
delay_rts_before/after_send should be for. (In other equipment this
feature is also called turn on / turn off delay)

I've a short look to the sources of the crisv10.c driver (I don't
actually have such hardware).  Assuming that a frame is written using
a single write() operation (and I have understood the code right...)
it will work as I expect. (Doing a single mssleep() per frame
afterwards RTS is asserted). delay_after_send seems not to be
implement at all (perhaps its not easly possible to detect when the
transmitter has shifted out the last bit of the frame).

But in the atmel_serial.c driver rthe Transmit Timeguard function of
the AT91 USART is used to implement this.  The purpose of the Transmit
Timeguard function is to throttle transmission in case the receiving
device is able to receive/process incoming characters at line
speed. This means the USART will insert a gap between EACH transmitted
byte and not only the last of a frame.  Atmel surely had its reasons
to implement such a function, but luckily nowadays such devices are
rare.  But this function is not especially related to RS485. It is
also applicable in RS232 mode.  So in my view it is not the
functionality which is meant by the delay_rts_before/after_send
fields.  Traditional field bus protocols like Modbus or Profibus use
an idle gap between the transmitter characters (typically lager 3 char
length) as a new frame indicator. Also it is not possible to implement
such a (slave) device in a linux userland application, there are a lot
of devices which implement this scheme in hardware out there.  But I
would appreciate if there is some other way to activate it from
usermode applications.

I think a more general way is an implementation using hrtimers, which
also can implement delay_rts_before_send.

An other point I don't understand is why ATMEL_US_TXEMPTY interrupt is
used when in RS485 mode insted of the normal ATMEL_US_TXRDY or
ATEM_US_ENDTX interrupts. In the RS485 mode the AT91 USART will
connect the RTS pin to the internal TXEMPTY signal to drive the RTS
until the last bit is shifted out. But this should not have any affect
on ow the drive will pump out the bytes to the USART's transmit hold register?

I'm happy if anyone can give me some explanation on this topics.

Regards from Germany
