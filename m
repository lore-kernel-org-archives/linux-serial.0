From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 2/2] serial: imx: disable the receiver ready interrupt
 for imx_stop_rx
Date: Fri, 23 May 2014 16:04:46 +0800
Message-ID: <20140523080445.GB12044@shlinux1.ap.freescale.net>
References: <1400819575-20435-1-git-send-email-b32955@freescale.com>
 <1400819575-20435-2-git-send-email-b32955@freescale.com>
 <537EE65C.5010700@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <537EE65C.5010700@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, May 23, 2014 at 08:10:36AM +0200, Dirk Behme wrote:
> On 23.05.2014 06:32, Huang Shijie wrote:
> >This patch disables the receiver ready interrupt for imx_stop_rx.
> >It reduces the interrupt numbers when the uart is going to close
> >or suspend.
> >
> >Signed-off-by: Huang Shijie <b32955@freescale.com>
> >---
> >  drivers/tty/serial/imx.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> >diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >index ed6cdf7..6026101 100644
> >--- a/drivers/tty/serial/imx.c
> >+++ b/drivers/tty/serial/imx.c
> >@@ -440,6 +440,10 @@ static void imx_stop_rx(struct uart_port *port)
> >
> >  	temp = readl(sport->port.membase + UCR2);
> >  	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
> >+
> >+	/* disable the `Receiver Ready Interrrupt` */
> >+	temp = readl(sport->port.membase + UCR1);
> >+	writel(temp & ~UCR1_RRDYEN, sport->port.membase + UCR1);
> >  }
> 
> While this is about the RX irq, I've a slightly off-topic general
> question regarding the usage of the *TX* irq in TX DMA mode:
> 
> It seems to me that the TX irq is kept enabled while the TX DMA is
Not really :)

We disable the TXMPTYEN when the DMA is enabled.

thanks
Huang Shijie
