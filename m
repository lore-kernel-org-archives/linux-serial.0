From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Thu, 13 Feb 2014 17:52:06 +0000 (UTC)
Message-ID: <ldj0o5$oq6$1@ger.gmane.org>
References: <ldgte5$kp1$1@ger.gmane.org>
 <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org>
 <52FC427A.8050907@hurleysoftware.com> <ldhlpd$bbr$1@ger.gmane.org>
 <52FCE506.2040801@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58296 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbaBMRwd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 12:52:33 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WE0Se-0003rv-9B
	for linux-serial@vger.kernel.org; Thu, 13 Feb 2014 18:52:32 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 18:52:32 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 18:52:32 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 02/13/2014 12:38 AM, Grant Edwards wrote:

>> That's the part I don't understand:
>>
>> How are drivers that use tty_insert_char() supposed to know when to
>> stop calling it?  tty_insert_char() doesn't return a status, so you
>> don't know even after the fact if the byte you just passed was
>> accepted. Do you?
>
> What tree are you looking at?

Rats.  I wasn't looking at tty_insert_char(), I was looking at
uart_insert_char() since that's what all the other drivers use.

> include/linux/tty_flip.h:tty_insert_flip_char() takes 1 byte and 1 flag
> and returns how many bytes were consumed (ie., 0 or 1). If it returned
> 0, the data was not accepted.

Right.

>> Similarly, how are drivers that use tty_insert_flip_string_flags()
>> supposed to know how much data they can pass to it?
>
> Drivers pass _all_ of the rx data to tty_insert_flip_string_flags(),

Except they don't.

They call tty_buffer_request_room() to decide how much data to pull
out of the rx FIFO/buffer.  Then they read only that much rx data and
pass it to tty_insert_flip_string_flags() ignoring the return value,
because the rx data has passed the point of no return. Once you pull
data out of the rx FIFO/buffer, you've got to do something with it.
If you can't transfer it to the line discipline layer, things get ugly
quickly.

> which returns how much was accepted. Eg.,
>
>          c = tty_insert_flip_string_flags(&my_port->port, rx_data, flags, n_rx);
>          if (c < 0) {
>                  /* actual error - none of the data was taken up */
>          }
>          if (c < n_rx) {
>                  /* tty buffer did not take up all the data */
>          }

That's not how tty_insert_flip_string_flags() is used by in-tree
drivers (at least not in 3.14rc2).

>> Are they expected to keep reading data from the rx FIFO and passing it
>> to tty_insert_flip_string_flags() until it returns a value smaller
>> than the requested transfer size and then buffer the "overflow" data
>> that has already been read from the rx FIFO but not accepted by
>> tty_insert_flip_string_flags()?  Then at some point in the future you
>> retry the old, buffered data, and once that's all been transferred you
>> start reading from the rx FIFO again? That would work, but it's a
>> little ugly.
>
> While this approach is possible, there is another way to look at
> this problem:
>
> The tty buffers are very deep (at least 64K+, as high as 128K).
> If data can't be taken in but the sender has not yet been throttled,
> then some error is occurring.

Not necessarily.

With modern UARTs, the way you throttle the sender is by not reading
data from the rx FIFO when there's nowhere to put that data.  When the
rx FIFO starts getting too full, the UART will send an XOFF or assirt
or de-assert RTS or DTR or whatever.

In order for that mechanism to work, you need to know when to stop
reading the rx FIFO.  That's what we had been using tty->receive_room
for, and now it appears I should be using tty_buffer_request_room()
for.

> Rather than buffering data outside the tty buffers (because
> eventually that will run out too causing a fifo overflow),

Not if flow control is enabled.  When you end up with data buffered in
the driver, the driver stops reading the rx FIFO, the rx FIFO fills
up, and the UART throttles the sender.  Once the buffered data has
been transferred, you start read the rx FIFO again and the UART
unthrottles the sender.  If flow control _isn't_ enable, and the
application isn't reading receive data, then there's going to be an
overflow error and data is lost no matter what approach you take. It
makes a lot more sense to let the UART do the overflow error detection
and discard the data than to do that in driver code.

> just drop the current rx and signal a condition to insert a
> TTY_OVERRUN at the beginning of the next rx (look at
> drivers/staging/fwserial/fwserial.c:fwtty_rx().

That seems like writing driver code to emulate functions that already
exist in the UART hardware.  I'd much rather just use the UART for
that.

> but don't use tty_buffer_space_avail() throttling part; that's only
> for very high speeds where the tty buffers can overflow even before
> the input processing worker runs).

The whole point of knowing when to stop reading the rx FIFO is to
_prevent_ data loss/overrun by allowing the UART to throttle the
sender before we get to the point where we've got nowhere to put data
we've read from the rx FIFO.

>> I must be missing something.
>
> tty_buffer_request_room() returns a buffer suitable for data + flags;
> you're just misreading the code.

Great!

That solves my problem.  I can call tty_buffer_request_room(), read
the indicated number of chars or char/flag pairs and then depend on
being able to call _either_ tty_insert_flip_string() or
tty_insert_flip_string_flags() to transfer the data I read.

When the application stops reading data and buffers fill up,
tty_buffer_request_room() will tell me to stop reading data from the
UART and everything will work the way it should.

> At least build against it; that's automatable.

Good point.  That would catch the obvious stuff with very little work.

> I don't mean to be critical but I can't really see that development
> model being sustainable.

We've been doing it for 20+ years (though I've only been involved for
the last 15).  We can't beat the Chinese on the price of boards, so we
had better beat them on support.

> There's no realistic way to single-source a driver across hundreds of
> kernel versions.

Maybe not hundreds.  Our current drivers only support 2.6.24 and
later.  We can still support previous driver versions if required for
customers running older 2.6 kernels.  We officially stopped supporting
2.4 several years ago.

> What was still being "maintained" for your driver for a 2.4 kernel
> (since any other active development there stopped years ago)?

We hadn't supported 2.4 for several years at that point -- I was just
illustrating how reluctant many customers are to upgrade kernels and
the infeasibility of depending on in-tree drivers to support customers
like that.

> One way to manage an in-kernel driver is to only have it support a
> minimum/common feature set. The advantage is you get automatic
> patches when the core changes -- and I don't just mean tty core but
> also locking, workqueues, etc -- which you can then pull into the
> out-of-tree driver (still adhering to the license requirements, of
> course). You just maintain the actual hardware changes/bug fixes.

A couple of our products do have in-tree drivers, but they've diverged
so far from the out-of-tree drivers that they aren't particularly
useful resources for maintaining the out-of-tree drivers.  It's
actually been more useful over the years to look at changes made to
other in-tree drivers.

> You have to deal with superseding the in-tree driver with the out-of-tree
> driver when both are present, but that's not insurmountable.

That doesn't seem to be an issue.  It's only been a problem a couple
times in the past couple decades when a customer has built a custom
configured kernel and configured the in-tree driver as built-in rather
than a module.

> [ For my own edification, why is the driver not a serial mini-port? ]

I don't know what a serial mini-port is.  We recently transitioned two
of our drivers from being tty drivers to being serial-core drivers.
Is mini-port something different that the serial core?

For another driver, it's still a tty driver because the serial-core
API just didn't fit the device well enough to make it work.  One issue
I recall is that our driver for that device needs to be able to cause
specific error returns for write() calls that are made when the
hardware is unavailable (and I think there are different errors
depending on why it's unavailable).

-- 
Grant Edwards               grant.b.edwards        Yow! BARBARA STANWYCK makes
                                  at               me nervous!!
                              gmail.com            

