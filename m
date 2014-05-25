From: Prasad Koya <prasad.koya@gmail.com>
Subject: Re: UART_IIR_BUSY set for 16550A
Date: Sat, 24 May 2014 23:21:38 -0700
Message-ID: <CAGXD9Of8-v9TJ-0uuQ3TDzo5QYhB3uA=B5kMGQkiABSzFrWDng@mail.gmail.com>
References: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
	<20140525003642.GC6946@thunk.org>
	<CAGXD9Odvyd_go-x9-gR7Q7_etYPLHekDM3SKRN+PCvDHc__LHg@mail.gmail.com>
	<20140525024414.GF6946@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:64786 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaEYGVj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 May 2014 02:21:39 -0400
Received: by mail-ve0-f177.google.com with SMTP id db11so7874692veb.8
        for <linux-serial@vger.kernel.org>; Sat, 24 May 2014 23:21:38 -0700 (PDT)
In-Reply-To: <20140525024414.GF6946@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

In our systems, serial port interrupt is not shared between any devices.

In the first iteration, I see

 [  480.972099] BUG1027: I0: 1571:0xc2 1551:0x21 1449:2 1492:1

IIR as 0xc2 and LSR as 0x21 and it read 2 chars in that iteration and
sent 1 byte of data.

Since the interrupt handler services all ports before it returns, in
next iteration it sees:

[  480.972102] BUG1027: I1: 1571:0xcc 1551:0x0

and it continues to see that till iteration 349. and nothing was read
from FIFO or transmitted from iteration 1 to 349.

[  480.972525] BUG1027: I349: 1571:0xcc 1551:0x0

At next iteration it had 0x60 in LSR and again nothing is read or sent
out. This continues till we see that "too much work".

[  480.972526] BUG1027: I350: 1571:0xcc 1551:0x60
:
[  480.972737] serial8250: too much work for irq4

#define UART_LSR_TEMT           0x40 /* Transmitter empty */
#define UART_LSR_THRE           0x20 /* Transmit-hold-register empty */

After it exits interrupt handler above, on next interrupt handler
IIR_NO_INT is still 0 and LSR reads 0x60 the whole PASS_LIMIT
iterations.

[  480.975458] BUG1027: I0: 1571:0xcc 1551:0x60

So the "too much work" happens back to back and only once at random time.

In our case the serial console ports on our systems are connected to a
serial concentrator. Like the KVM situation you mentioned, is it
possible our serial port concentrator is behaving bad? In 2.6.38 this
PASS_LIMIT is 256. I'll also check with our h/w lab admin to see if
there is anything special with serial port concentrator.

thanks again.

On Sat, May 24, 2014 at 7:44 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Sat, May 24, 2014 at 06:22:02PM -0700, Prasad Koya wrote:
>> Thanks for looking into this.
>>
>> With 16550A, I'm seeing this weird issue with 3.4 kernel. At random
>> times 8250 driver reads 0xcc out of IIR. I'm not sure why bit 2 is
>> set.
>
> The high two bits mean the FIFO enabled -- so that's the 0xCX bits.
> The 0x0C bits means that there is an interrupt pending (the low bit is
> 0).  Bit 2 means that data is available in the FIFO:
>
> #define UART_IIR_RDI            0x04 /* Receiver data interrupt */
>
> Not that this matters; in the 8250 driver we simply check to see if
> the UART_IIR_NO_INT bit is not set, and then instead of actually
> checking the rest of the IIR register, we just check (a) if there is
> incoming characters to read, (b) if the transmit FIFO has room
> available and we have characters waiting to be sent, or (c) if the
> modem status lines have changed and we care about that.
>
>> Soon after this I'm running into "serial8250: too much work for irq4".
>> And this is printed after iterating 512 times in 8250_interrupt
>> handler. This message is printed one more time right after this and it
>> appears that console does not work after those messages. I was
>> suspicious about that 'busy detect' bit. Am trying to reproduce this
>> and see what is in LCR when this hits. Can I (or how do I) reset the
>> device if I see this bit set?
>
> So what this means is that the serial port is apparently continuously
> active.  Because legacy ISA bus interrupts were edge triggered we
> needed to make sure the all of the sources of interrupts for that irq
> have been cleared before we return.  To do this, we check all of the
> UART's assocated with the irq (you should check and see if you have
> more than one serial port associated with the irq) and only return
> once all of the UART's report that they are not ready (i.e., that
> we've serviced all possible receive, transmit, and modem status
> register changes).  But if the UART's are constantly reporting lots of
> work, as a safety measure so that we don't completely hang the kernel,
> we check the PASS_LIMIT and if that gets exceeded we print the "too
> much work" message and break out.  On ISA bus systems, this could
> cause the interrupt to no longer signal.  To prevent this, there was a
> backup serial timeout that would allow the system to automatically recover.
>
> None of this should be necessary on modern systems.  I do see this
> message using KVM, with a virtual serial console which is faster than
> any real RS-232 port, so it's possible to trigger the "too much work"
> message.  But since any modern/sane bus uses level-triggered
> interrupts, and KVM emulates a sane bus, the fact that we exit via the
> "too much work" interrupt doesn't cause the interrupt to go dead.
>
> If you are seeing the serial console go dead after this message, it
> implies that you might have an edge-triggered interupt.  But if that's
> true, I'd call this a case of "the 1980's are calling and they want
> their crappy ISA bus back"....
>
>                                                         - Ted
