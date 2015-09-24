From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 02/11] drivers: PL011: refactor pl011_startup()
Date: Thu, 24 Sep 2015 18:11:35 -0500
Message-ID: <CAOZdJXVxDjkoCJsqE6zH_UEQcxp9T2fY1YTfV7zvWjXwwbziEw@mail.gmail.com>
References: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
 <1432225584-4655-3-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432225584-4655-3-git-send-email-andre.przywara@arm.com>
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
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, G Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <moorray3@wp.pl>, GregKH <gregkh@linuxfoundation.org>, Naresh Bhat <nareshgbhat@gmail.com>, mlangsdo@redhat.com, linux-serial@vger.kernel.org, rmk+kernel@arm.linux.org.uk, Jiri Slaby <jslaby@suse.cz>, dave.martin@arm.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, May 21, 2015 at 11:26 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> +static void pl011_enable_interrupts(struct uart_amba_port *uap)
> +{
> +       spin_lock_irq(&uap->port.lock);
> +
> +       /* Clear out any spuriously appearing RX interrupts */
> +       writew(UART011_RTIS | UART011_RXIS,
> +              uap->port.membase + UART011_ICR);
> +       uap->im = UART011_RTIM;
> +       if (!pl011_dma_rx_running(uap))
> +               uap->im |= UART011_RXIM;
> +       writew(uap->im, uap->port.membase + UART011_IMSC);
> +       spin_unlock_irq(&uap->port.lock);
> +}

Shouldn't this function be using spin_lock_irqsave() and
spin_unlock_irqrestore()?  If interrupts are generally disabled before
calling this function, then they will be enabled by the
spin_unlock_irq() call, and I don't think we want that.  This function
is only supposed to enable pl011 interrupts, not all interrupts.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
