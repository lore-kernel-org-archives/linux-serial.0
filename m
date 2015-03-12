From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH REPOST 1/2] serial/amba-pl011: Activate TX IRQ passively
Date: Thu, 12 Mar 2015 12:55:19 +0000
Message-ID: <20150312125500.GA15596@e103592.cambridge.arm.com>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
 <1425472054-7543-2-git-send-email-Dave.Martin@arm.com>
 <20150312110344.GL8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150312110344.GL8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 12, 2015 at 11:03:45AM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 04, 2015 at 12:27:33PM +0000, Dave Martin wrote:
> > The current PL011 driver transmits a dummy character when the UART
> > is opened, to assert the TX IRQ for the first time
> > (see pl011_startup()).  The UART is put in loopback mode temporarily,
> > so the receiver presumably shouldn't see anything.
> 
> We do this so that we know for certain that the PL011 has room to accept
> at least one character.

Thanks for taking a look at this.

[Greg, please hold these patches until I've reworked them]

> 
> > However...
> > 
> > At least some platforms containing a PL011 send characters down the
> > wire even when loopback mode is enabled.  This means that a
> > spurious NUL character may be seen at the receiver when the PL011 is
> > opened through the TTY layer.
> 
> ... which is an annoyance.
> 
> > The current code also temporarily sets the baud rate to maximum and
> > the character width to the minimum, to that the dummy TX completes
> > as quickly as possible.  If this is seen by the receiver it will
> > result in a framing error and can knock the receiver out of sync --
> > turning subsequent output into garbage until synchronisation
> > is reestablished.  (Particularly problematic during boot with systemd.)
> 
> Yea, I have my own issues with systemd, but let's stay away from that
> potential argument. :)

(dunno what you could be suggesting...)

> 
> > To avoid spurious transmissions, this patch removes assumptions about
> > whether the TX IRQ will fire until at least one TX IRQ has been seen.
> > 
> > Instead, the UART will unmask the TX IRQ and then slow-start via
> > polling and timer-based soft IRQs initially.  If the TTY layer writes
> > enough data to fill the FIFO to the interrupt threshold in one go,
> > the TX IRQ should assert, at which point the driver changes to
> > fully interrupt-driven TX.
> 
> I'm concerned about this.  What happens if the PL011 is also being used
> as a console, and the UART TX FIFO is fully stuffed?

I don't think my patches change this situation.  For normal printk,
pl011_console_write() will disable IRQs at the CPU and take port->lock:
so either pl011_int() finishes all its work safely before the console
output is done, or the console output is done first.

In the latter case, the condition that triggered the IRQ (i.e., TX
FIFO has space) may no longer be true: the lock protects pl011_int()
from the race that would otherwise exist between the check on TXIS
and the actual writes to the FIFO.

Only in special cases (sysrq and oopses) might the lock not be
held.  But this problem exists independently of my changes AFAICT.
Correct output seems to be best-effort in these cases, which is
probably the right thing to do.

> 
> Reading the updated code, it seems that we can call pl011_tx_chars()
> irrespective of whether the TX FIFO is full or not.  pl011_tx_chars()
> makes the assumption that the TX FIFO can always accept the next
> character, and it results in (eg, in the x_char handling) the next
> character being written, even if the FIFO is full.

There are multiple paths into pl011_tx_chars() now, and the original
invariant (TXIS is asserted and nothing else is filling the FIFO,
therefore the FIFO is at least half-empty) is replaced with a more
complex one.

Now, the FIFO is definitely half-empty if tx_irq_seen >= 2.  Otherwise,
the FIFO fill level is unknown, and TXFF is polled for each write.


I've been thinking about this, and my code is really more complex than
it needs to be here.

All that's really needed is an explicit argument to say whether
pl011_tx_chars() was called due to a FIFO-definitely-has-space
condition (IRQ or DMA underflow), or simply because there was
some data to write (the pl011_start_tx() and softirq cases) --
this just boils down to identifying the call site.

> If hardware CTS flow control is enabled, the problem gets worse - in
> that mode, the TX FIFO can remain fully occupied for an indeterminant
> amount of time.

Not really?  Regardless of why the FIFO is full, pl011_int() won't
call pl011_tx_chars() because a full FIFO means TXIS is deasserted.

In the start_tx/softirq case TXFF will be checked, as I try to
explain above.


> This introduces a whole new unreliability to the driver which wasn't
> there to start with.

I don't _think_ this adds unreliability (except for a dumbass bug I
noticed where I call spin_lock() instead of spin_lock_irq() in
pl011_tx_softirq()).

But it does add complexity and will likely make the code harder
to maintiain.


Unless you have any other ideas I will try to simplify the code
along the above lines.

> You need to check the TX FIFO status before trying to stuff it with
> characters.

Indeed.

Cheers
---Dave
