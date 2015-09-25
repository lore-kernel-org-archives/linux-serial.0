From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 02/11] drivers: PL011: refactor pl011_startup()
Date: Fri, 25 Sep 2015 16:30:35 +0100
Message-ID: <20150925153035.GP21513@n2100.arm.linux.org.uk>
References: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
 <1432225584-4655-3-git-send-email-andre.przywara@arm.com>
 <CAOZdJXVxDjkoCJsqE6zH_UEQcxp9T2fY1YTfV7zvWjXwwbziEw@mail.gmail.com>
 <5605668C.5020407@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5605668C.5020407@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <moorray3@wp.pl>, GregKH <gregkh@linuxfoundation.org>, Timur Tabi <timur@codeaurora.org>, Naresh Bhat <nareshgbhat@gmail.com>, "mlangsdo@redhat.com" <mlangsdo@redhat.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 25, 2015 at 04:21:48PM +0100, Andre Przywara wrote:
> Hi Timur,
> 
> On 25/09/15 00:11, Timur Tabi wrote:
> > On Thu, May 21, 2015 at 11:26 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> >> +static void pl011_enable_interrupts(struct uart_amba_port *uap)
> >> +{
> >> +       spin_lock_irq(&uap->port.lock);
> >> +
> >> +       /* Clear out any spuriously appearing RX interrupts */
> >> +       writew(UART011_RTIS | UART011_RXIS,
> >> +              uap->port.membase + UART011_ICR);
> >> +       uap->im = UART011_RTIM;
> >> +       if (!pl011_dma_rx_running(uap))
> >> +               uap->im |= UART011_RXIM;
> >> +       writew(uap->im, uap->port.membase + UART011_IMSC);
> >> +       spin_unlock_irq(&uap->port.lock);
> >> +}
> > 
> > Shouldn't this function be using spin_lock_irqsave() and
> > spin_unlock_irqrestore()?  If interrupts are generally disabled before
> > calling this function, then they will be enabled by the
> > spin_unlock_irq() call, and I don't think we want that.  This function
> > is only supposed to enable pl011 interrupts, not all interrupts.
> 
> Are you seeing an actual issue with this? Does changing it fix anything?
> Looking at the history I see that these locks predate git history.
> If I get this correctly, going from spin_{un,}lock_irq to the _irqsave
> variants should always be safe, but I'd like to hear more opinions on this.

If code is only called from process sleepable context, then using the
_irq variants is a sane thing to do, and avoids the extra work to
read and store the interrupt state prior to the protected code.
Currently that's true in mainline.

I'd encourage people not to jump on the "you're using _irq variants,
the code must be bad!" wagon, and instead spend time reading the code
and checking whether it's safe.

If the code path is suitable for a mutex, it's suitable for _irq()
variants too: you're not allowed to sleep with IRQs disabled.

If you want to have some runtime validation, add WARN_ON(!irqs_disabled());
before it, but I'd recommend against littering mainline with that.
Arguably, it's something that the _irq() variants should do, and I
think it's been proposed in the past, but rejected.  I forget why.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
