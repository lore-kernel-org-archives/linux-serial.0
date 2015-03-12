From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH REPOST 1/2] serial/amba-pl011: Activate TX IRQ passively
Date: Thu, 12 Mar 2015 16:34:39 +0000
Message-ID: <20150312163432.GA14601@e103592.cambridge.arm.com>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
 <1425472054-7543-2-git-send-email-Dave.Martin@arm.com>
 <20150312110344.GL8656@n2100.arm.linux.org.uk>
 <20150312125500.GA15596@e103592.cambridge.arm.com>
 <20150312143930.GS8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150312143930.GS8656@n2100.arm.linux.org.uk>
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

On Thu, Mar 12, 2015 at 02:39:30PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 12, 2015 at 12:55:19PM +0000, Dave Martin wrote:
> > I don't think my patches change this situation.  For normal printk,
> > pl011_console_write() will disable IRQs at the CPU and take port->lock:
> > so either pl011_int() finishes all its work safely before the console
> > output is done, or the console output is done first.
> > 
> > In the latter case, the condition that triggered the IRQ (i.e., TX
> > FIFO has space) may no longer be true: the lock protects pl011_int()
> > from the race that would otherwise exist between the check on TXIS
> > and the actual writes to the FIFO.
> > 
> > Only in special cases (sysrq and oopses) might the lock not be
> > held.  But this problem exists independently of my changes AFAICT.
> > Correct output seems to be best-effort in these cases, which is
> > probably the right thing to do.
> 
> Actually, yes, you're right, I'm wrong.  The console won't drop the
> spinlock until the last character has left the TX FIFO and has been
> sent on the wire, so at the point I was originally thinking of, we
> guarantee that the FIFO is empty (if it weren't like that, it'd
> almost certainly be full.)

Yes, that's also true.

> > > If hardware CTS flow control is enabled, the problem gets worse - in
> > > that mode, the TX FIFO can remain fully occupied for an indeterminant
> > > amount of time.
> > 
> > Not really?  Regardless of why the FIFO is full, pl011_int() won't
> > call pl011_tx_chars() because a full FIFO means TXIS is deasserted.
> > 
> > In the start_tx/softirq case TXFF will be checked, as I try to
> > explain above.
> 
> Yes, in that case, pl011_int() won't be called for transmit, but what
> about the softirq case.
> 
> Looking at the patch again, I don't see pl011_tx_chars() ever returning
> true - so the while (pl011_tx_chars()); in the softirq looks strange
> (if it always returns false, we won't ever iterate.)

Oops, you're right.  This is a legacy from an older spin of the patches,
where tx_softirq had to spin around tx_chars in the case of an xchar,
just like pl011_int must at present.

That seemed contrived, so I got rid of this requirement, but that
makes the return value and the loop redundant.

> 
> > Unless you have any other ideas I will try to simplify the code
> > along the above lines.
> 
> I forget whether we have problems with UARTs which don't generate any TX
> irqs - I hope we don't.

Currently the code relies on a working TX IRQ anyway, so I'm hoping
it's safe to assume we don't have to cope with that.

> What about doing this instead, which should result in fewer changes to
> the driver (especially to the fast paths):
> 
> - On startup, set a flag to indicate that the TX state is unknown (so we
>   can detect the first start_tx().)
> - When we get our first start_tx(), check the flag.
>   - read the FIFO flags and interrupt status.  If the FIFO flags indicate
>     that the TX FIFO is empty, but there is no transmit interrupt, read
>     and load the first character into the FIFO.  Instead of just loading
>     the first character, as we've checked the FIFO status, we could
>     alternatively load the first half of the FIFO via a call to
>     pl011_tx_chars().
>   - clear the flag.
> 
> This should mean that we keep the driver structure we have today.

I had originally hoped to do things that way, but there is a problem:
unless pl011_tx_chars() sees TXFF at some point, there is no way to
know how full the FIFO got.  For example, if there are fifosize/2
chars queued from serial_core initially, it's likely that the FIFO
won't get half-full.  This permits a situation where we have to leave
the flag set (to be on the safe side), but a TX IRQ does actually
happen.

So, the flag can't be cleared unconditionally -- I took an "I'll believe
it when I see it" approach to the TX IRQ.  tx_irq_seen should really be
a bool though -- the counter-style thing works around a race which could
only happen because I mastakenly wasn't disabling interrupts in
pl011_tx_softirq().

There could still be merit in transmitting the initial chars directly
instead of waiting for a TX IRQ, even if we already know the TX IRQ
works, especially if start_tx() is called because of a newly pending
x_char.  But this is really an optimisation, so I may present it as
a separate patch.

> The only concern I have about that is (from what I remember) we don't
> expect a call to ->start_tx to cause a tx stop event, though I don't
> see anything in serial_core which would get upset if we did.

That's a fair point.  stop_tx will normally happen asynchronously, but
the port lock has to be released first.  8250 does stop_tx from its
softirq in the analogous situation, so we could do the same here.


I'll rework the series around my current ideas first, and then we
can see if it needs further restructuring...

Cheers
---Dave
