From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] tty: amba-pl011: Make TX optimisation conditional
Date: Fri, 12 Jul 2019 17:35:06 +0100
Message-ID: <20190712163506.GI2790@e103592.cambridge.arm.com>
References: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
 <20190712112105.GH2790@e103592.cambridge.arm.com>
 <20190712121000.GK11350@BitWizard.nl>
 <5bf03345-6a36-1b87-ca0c-e918b6030a74@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5bf03345-6a36-1b87-ca0c-e918b6030a74@raspberrypi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Elwell <phil@raspberrypi.org>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 12, 2019 at 01:20:42PM +0100, Phil Elwell wrote:
> Hi Rogier,
> 
> On 12/07/2019 13:10, Rogier Wolff wrote:
> > On Fri, Jul 12, 2019 at 12:21:05PM +0100, Dave Martin wrote:
> >> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> >> index 89ade21..1902071 100644
> >> --- a/drivers/tty/serial/amba-pl011.c
> >> +++ b/drivers/tty/serial/amba-pl011.c
> >> @@ -1307,6 +1307,13 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
> >>  /* Start TX with programmed I/O only (no DMA) */
> >>  static void pl011_start_tx_pio(struct uart_amba_port *uap)
> >>  {
> >> +	/*
> >> +	 * Avoid FIFO overfills if the TX IRQ is active:
> >> +	 * pl011_int() will comsume chars waiting in the xmit queue anyway.
> >> +	 */
> >> +	if (uap->im & UART011_TXIM)
> >> +		return;
> >> +
> > 
> > I'm no expert on PL011, have no knowledge of the current bug, but have
> > programmed serial drivers in the past.
> > 
> > This looks "dangerous" to me.
> > 
> > The normal situation is that you push the first few characters into
> > the FIFO with PIO and then the interrupt will trigger once the FIFO
> > empties and then you can refil the FIFO until the buffer empties.
> > 
> > The danger in THIS fix is that you might have a race that causes those
> > first few PIO-ed characters not to be put in the hardware resulting in
> > the interrupt never triggering.... If you can software-trigger the
> > interrupt just before the "return" here that'd be a way to fix things.

This is the thing that can't really be done with PL011.  The only way to
trigger a TX FIFO interrupt is to fill the TX FIFO and wait for it to
drain back to the threshold.

SBSA UART is particularly dumb in this regard: you can't disable the
FIFOs, change the irq trigger thresholds or do anything else that might
help here.

Historically, the PL011 was configured for maximum speed and put in
loopback mode to send some initial dummy chars and bootstrap the
interrupt state machine, but this has problems with some newer variants,
and doesn't work at all with SBSA uart.

> I'm also not a serial driver expert, but I think this simplified patch is safe.
> The reason is that the UART011_TXIM flag is only set after the pio thread has failed
> to write some data into the FIFO because it is full, which would guarantee that
> an interrupt is generated once the fill level drops below the half-way mark.

I think it's the spin_lock_irq(&uap->port.lock) done by serial_core
around pl011_start_tx() that we're relying on here.

This protects us against most potential races.

The trickiest path is when we are in pl011_int() having temporarily
released the lock, and pl011_start_tx() gets called on another cpu.

One thing that makes me uneasy is that there is one thing other than
pl011_int() than can clear uap->im &= ~UART011_TXIM: pl011_stop_tx() is
also called from uart_stop(), which the TTY layer may call at random
times for flow control reasons.

pl011_int() can miss this change and and write the FIFO a final time,
but pl011_start_tx_pio() can now race even with my patch (because TXIM
is now clear) and overfill the FIFO.

This problem arises from the cached interrupt status bits becoming
stale while the lock is released.

We might be able to solve this just be reordering pl011_int() so that
the un-locky rx handing code is done after the TX handling.

Does this make sense?


> > I'm ok with a reaction like "I've thought about this, it's not a
> > problem, now shut up".
> 
> I don't think that reaction would be justified - these things are difficult, and having
> many minds on the problem helps to avoid bugs like this.

Ack!  These things are properly fiddly to get right.  Please do try to
shoot holes in the code :)

I am still trying to resurrect my understanding of how this code
works...

Cheers
---Dave
