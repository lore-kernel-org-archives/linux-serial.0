From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH REPOST 1/2] serial/amba-pl011: Activate TX IRQ passively
Date: Thu, 12 Mar 2015 14:39:30 +0000
Message-ID: <20150312143930.GS8656@n2100.arm.linux.org.uk>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
 <1425472054-7543-2-git-send-email-Dave.Martin@arm.com>
 <20150312110344.GL8656@n2100.arm.linux.org.uk>
 <20150312125500.GA15596@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150312125500.GA15596@e103592.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 12, 2015 at 12:55:19PM +0000, Dave Martin wrote:
> I don't think my patches change this situation.  For normal printk,
> pl011_console_write() will disable IRQs at the CPU and take port->lock:
> so either pl011_int() finishes all its work safely before the console
> output is done, or the console output is done first.
> 
> In the latter case, the condition that triggered the IRQ (i.e., TX
> FIFO has space) may no longer be true: the lock protects pl011_int()
> from the race that would otherwise exist between the check on TXIS
> and the actual writes to the FIFO.
> 
> Only in special cases (sysrq and oopses) might the lock not be
> held.  But this problem exists independently of my changes AFAICT.
> Correct output seems to be best-effort in these cases, which is
> probably the right thing to do.

Actually, yes, you're right, I'm wrong.  The console won't drop the
spinlock until the last character has left the TX FIFO and has been
sent on the wire, so at the point I was originally thinking of, we
guarantee that the FIFO is empty (if it weren't like that, it'd
almost certainly be full.)

> > If hardware CTS flow control is enabled, the problem gets worse - in
> > that mode, the TX FIFO can remain fully occupied for an indeterminant
> > amount of time.
> 
> Not really?  Regardless of why the FIFO is full, pl011_int() won't
> call pl011_tx_chars() because a full FIFO means TXIS is deasserted.
> 
> In the start_tx/softirq case TXFF will be checked, as I try to
> explain above.

Yes, in that case, pl011_int() won't be called for transmit, but what
about the softirq case.

Looking at the patch again, I don't see pl011_tx_chars() ever returning
true - so the while (pl011_tx_chars()); in the softirq looks strange
(if it always returns false, we won't ever iterate.)

> Unless you have any other ideas I will try to simplify the code
> along the above lines.

I forget whether we have problems with UARTs which don't generate any TX
irqs - I hope we don't.

What about doing this instead, which should result in fewer changes to
the driver (especially to the fast paths):

- On startup, set a flag to indicate that the TX state is unknown (so we
  can detect the first start_tx().)
- When we get our first start_tx(), check the flag.
  - read the FIFO flags and interrupt status.  If the FIFO flags indicate
    that the TX FIFO is empty, but there is no transmit interrupt, read
    and load the first character into the FIFO.  Instead of just loading
    the first character, as we've checked the FIFO status, we could
    alternatively load the first half of the FIFO via a call to
    pl011_tx_chars().
  - clear the flag.

This should mean that we keep the driver structure we have today.

The only concern I have about that is (from what I remember) we don't
expect a call to ->start_tx to cause a tx stop event, though I don't
see anything in serial_core which would get upset if we did.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
