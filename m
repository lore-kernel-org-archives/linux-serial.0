From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: UART_IIR_BUSY set for 16550A
Date: Sat, 24 May 2014 22:44:14 -0400
Message-ID: <20140525024414.GF6946@thunk.org>
References: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
 <20140525003642.GC6946@thunk.org>
 <CAGXD9Odvyd_go-x9-gR7Q7_etYPLHekDM3SKRN+PCvDHc__LHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:59519 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbaEYCoR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 May 2014 22:44:17 -0400
Content-Disposition: inline
In-Reply-To: <CAGXD9Odvyd_go-x9-gR7Q7_etYPLHekDM3SKRN+PCvDHc__LHg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Prasad Koya <prasad.koya@gmail.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

On Sat, May 24, 2014 at 06:22:02PM -0700, Prasad Koya wrote:
> Thanks for looking into this.
> 
> With 16550A, I'm seeing this weird issue with 3.4 kernel. At random
> times 8250 driver reads 0xcc out of IIR. I'm not sure why bit 2 is
> set.

The high two bits mean the FIFO enabled -- so that's the 0xCX bits.
The 0x0C bits means that there is an interrupt pending (the low bit is
0).  Bit 2 means that data is available in the FIFO:

#define UART_IIR_RDI		0x04 /* Receiver data interrupt */

Not that this matters; in the 8250 driver we simply check to see if
the UART_IIR_NO_INT bit is not set, and then instead of actually
checking the rest of the IIR register, we just check (a) if there is
incoming characters to read, (b) if the transmit FIFO has room
available and we have characters waiting to be sent, or (c) if the
modem status lines have changed and we care about that.

> Soon after this I'm running into "serial8250: too much work for irq4".
> And this is printed after iterating 512 times in 8250_interrupt
> handler. This message is printed one more time right after this and it
> appears that console does not work after those messages. I was
> suspicious about that 'busy detect' bit. Am trying to reproduce this
> and see what is in LCR when this hits. Can I (or how do I) reset the
> device if I see this bit set?

So what this means is that the serial port is apparently continuously
active.  Because legacy ISA bus interrupts were edge triggered we
needed to make sure the all of the sources of interrupts for that irq
have been cleared before we return.  To do this, we check all of the
UART's assocated with the irq (you should check and see if you have
more than one serial port associated with the irq) and only return
once all of the UART's report that they are not ready (i.e., that
we've serviced all possible receive, transmit, and modem status
register changes).  But if the UART's are constantly reporting lots of
work, as a safety measure so that we don't completely hang the kernel,
we check the PASS_LIMIT and if that gets exceeded we print the "too
much work" message and break out.  On ISA bus systems, this could
cause the interrupt to no longer signal.  To prevent this, there was a
backup serial timeout that would allow the system to automatically recover.

None of this should be necessary on modern systems.  I do see this
message using KVM, with a virtual serial console which is faster than
any real RS-232 port, so it's possible to trigger the "too much work"
message.  But since any modern/sane bus uses level-triggered
interrupts, and KVM emulates a sane bus, the fact that we exit via the
"too much work" interrupt doesn't cause the interrupt to go dead.

If you are seeing the serial console go dead after this message, it
implies that you might have an edge-triggered interupt.  But if that's
true, I'd call this a case of "the 1980's are calling and they want
their crappy ISA bus back"....

							- Ted
