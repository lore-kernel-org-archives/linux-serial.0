From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: API to flush rx fifo?
Date: Fri, 14 Jun 2013 18:41:45 +0000 (UTC)
Message-ID: <kpfo59$b6p$1@ger.gmane.org>
References: <kpak75$9ko$1@ger.gmane.org>
 <51BB2C2A.9050601@hurleysoftware.com> <kpfc5k$5u4$1@ger.gmane.org>
 <51BB3AD0.50201@hurleysoftware.com> <kpfgdu$nfb$1@ger.gmane.org>
 <51BB4E64.2000705@hurleysoftware.com> <20130614173941.GA15623@grante>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54580 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab3FNSmD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 14:42:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UnYwj-0003Fu-0r
	for linux-serial@vger.kernel.org; Fri, 14 Jun 2013 20:42:01 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2013 20:42:01 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2013 20:42:01 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-06-14, Grant Edwards <grant.b.edwards@gmail.com> wrote:

>> the serial core and other tty drivers continue to empty the rx fifo
>> -- throttle only shuts off the transmitter on the other end.

Let's say that the tty layer fills up, and calls the uart driver's
throttle() callback.  Now, instead of stopping the unloading of the rx
FIFO (like my drivers do), we explicitly send an XOFF and continue to
unload the rx FIFO.  Will the tty layer accept the 1KB (or 4KB or 8KB)
of data that's already in the rx FIFO without any loss/overrun? AFAIK,
it can't.  That's why my drivers (and the USB drivers) do what they do.

>From another point of view: not reading the rx fifo is how one "shuts
off the transmitter on the other end" (eventually) when one is using
the UART's flow control support -- at least that's how all the
flow-control-supporting UARTs I've seen work.  Stopping the other end
just because the tty layer is full is also wasteful: some of my
"UARTs" can buffer up to 9KB of receive data in the rx fifo[1] after
the tty layer fills up. They'll tell the other end to stop when it
needs to be stopped. Aside from that, having the flow state controlled
from two places (serial_core and the UART itself) tends to be
error-prone.

When you're dealing with high baud rates (e.g. 921K) and a bus like
USB or Ethernet, where there may be tens or hundreds of milliseconds
of latency between the serial_core and the physical UART chip, and
FIFO sizes are measured in KB.  In those situations there just isn't
any way for either the serial_core or tty layer to know when the
transmitter on the other end needs to be turned on or off.  You have
to let the UART handle it. All the tty/serial_core layer knows is
whether or not it has room for more receive data, and that's not the
same thing as knowing when the transmitter on other end of the serial
cable needs to be turned on/off.

So, when I add the UART-driver callbacks for throttle/unthrottle, what
they'll have to do is control whether we read data from the rx FIFO or
not.

So that implies that for tcflush(TCIFLUSH) to reliably do what a user
would expect, there needs to be an input_flush() callback so that the
uart driver can be told to flush the rx fifo.  [Yes, flushing the "rx
fifo" in some of these configurations isn't a simple task that takes a
negligible amount of time, but it can be done.]

>> Without handling throttle/unthrottle, how are you determining that the
>> tty layer is "full"?  Return code from tty_insert_flip_xxxx()?
>
> I check tty->receive_room.  What are you supposed to do for kernel
> versions that don't have the throttle()/unthrottle() callbacks?

Actually, in another driver I check the return value from 
tty_prepare_flip_string_flags().  For various (mostly historical)
reaons, one driver uses tty_prepare_flip_string_flags() and the other
uses uart_insert_char() [both followed later by a call to
tty_flip_buffer_push()].

And in yet another driver (that talks to the tty layer instead of
using the serial_core), I call the line discipline's receive_room()
method -- but that's moot for this thread.


[1] For ethernet/usb attached UARTs the "rx fifo" includes (from
    serial_core's POV) not only the hardware fifo in the UART (up to
    1KB), but also software buffers at either end of the network
    "connection" (up to 4KB at each end).

-- 
Grant Edwards               grant.b.edwards        Yow! Is this an out-take
                                  at               from the "BRADY BUNCH"?
                              gmail.com            

