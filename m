From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
Date: Mon, 30 Mar 2015 16:26:52 +0200
Message-ID: <20150330162652.0f0c7a18@north>
References: <20150327191040.1119319d@north>
 <20150330122840.GA22949@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150330122840.GA22949@e103592.cambridge.arm.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, Jakub Kicinski <kubakici@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, 30 Mar 2015 13:28:40 +0100, Dave Martin wrote:
> On Fri, Mar 27, 2015 at 07:10:40PM +0100, Jakub Kicinski wrote:
> 
> [Gaah -- resend again!  Looks like most recipients didn't get this :( ]
> 
> > On Fri, 27 Mar 2015 17:42:24 +0000, Dave P Martin wrote:
> > > [Resend -- apologies again for any duplicates received]
> > > 
> > > On Fri, Mar 27, 2015 at 05:40:55PM +0100, Jakub Kicinski wrote:
> 
> [...]
> 
> > > > Dave, I'd prefer if you kept my .prev_from_irq thing.  If .start_tx()
> > > > races with the IRQ we may have a situation where the IRQ arrives
> > > > but .start_tx() already filled the FIFO.  The guarantee of half of the
> > > > FIFO being empty will not hold in this case.  That's why I use the
> > > > guarantee only if the previous load was also from FIFO.
> > > 
> > > I thought about this, but I think port->lock prevents this from
> > > happening.  I was overly defensive about this in the earlier versions
> > > of the patches, and that made the code a fair bit more complicated...
> > > I was hoping it could just go away ;)
> > > 
> > > 
> > > In pl011_int(), we have
> > > 
> > > -8<-
> > > 
> > > spin_lock_irqsave(&uap->port.lock, flags);
> > > 
> > > [...]
> > > 
> > > while (status = readw(uap->port.membase + UART012_MIS), status != 0) {
> > > 
> > > [...]
> > > 
> > > 	if (status & UART011_TXIS)
> > > 		pl011_tx_chars(uap, true);
> > > 
> > > } while (status != 0);
> > > 
> > > [...]
> > > 
> > > spin_unlock_irqrestore(&uap->port.lock, flags);
> > > 
> > > ->8-
> > > 
> > > 
> > > serial_core always holds port->lock around _start_tx(), so it should be
> > > impossible for any part of _start_tx() to run in parallel with this.  If
> > > TXIS is asserted and nothing can write the FIFO in the meantime, then
> > > that should mean that the FIFO is definitely half-empty on entry to
> > > pl011_tx_chars(..., from_irq=true) -- this is also why it's safe for
> > > pl011_int() to loop and potentially make repeated calls to
> > > pl011_tx_chars().
> > > 
> > > Can you see a way this could break, or does this reasoning sound good to
> > > you?
> > 
> > It doesn't have to run in parallel, perhaps using the word "race" was
> > not entirely justified on my side.  Sorry if my English is not
> > super-clear ;)  Even when the accesses are serialized the problem
> > remains.
> 
> [...]
> 
> > I think this would require some adverse condition to trigger (high load
> > + high baudrate) or IRQ pending during first unmask (which I think
> > shouldn't happen, but hey, let's not trust HW too much...).
> 
> Ah, I see where you're coming from.
> 
> TXIS reflects the live status of the FIFO, except that it is
> "spuriously" deasserted betweem reset/clear of the interrupt and the
> first TX IRQ, even though the FIFO may be empty.

I missed that IRQ is cleared by writing data.
