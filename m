From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for
 ZTE device
Date: Sat, 17 Sep 2016 13:26:05 +0800
Message-ID: <20160917052605.GF7398@tiger>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 16, 2016 at 03:23:57PM +0100, Sudeep Holla wrote:
> >@@ -2303,13 +2325,16 @@ static struct console amba_console = {
> >
> > static void pl011_putc(struct uart_port *port, int c)
> > {
> >+	struct uart_amba_port *uap =
> >+		container_of(port, struct uart_amba_port, port);
> >+
> > 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
> > 		cpu_relax();
> > 	if (port->iotype == UPIO_MEM32)
> > 		writel(c, port->membase + UART01x_DR);
> > 	else
> > 		writeb(c, port->membase + UART01x_DR);
> >-	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
> >+	while (readl(port->membase + UART01x_FR) & uap->vendor->fr_busy)
> > 		cpu_relax();
> > }
> 
> The above hunk won't work for early console devices. The earlycon_device
> just has uart_port and is not uart_amba_port. I don't know how to fix
> this properly but I thought we could reuse private_data in uart_port for
> early_con devices. Something like below(incomplete for other vendors,
> works only for ARM)

Hi Sudeep,

Thanks much for the report.  I think the best way to fix this is that we
revert the change for pl011_putc() function, and figure out a correct
approach adding earlycon support for ZTE hardware later.

I will send a patch to revert pl011_putc() changes shortly.

Thanks,
Shawn
