From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 2/2] serial: imx: disable the receiver ready interrupt
 for imx_stop_rx
Date: Fri, 23 May 2014 08:10:36 +0200
Message-ID: <537EE65C.5010700@de.bosch.com>
References: <1400819575-20435-1-git-send-email-b32955@freescale.com> <1400819575-20435-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:60934 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaEWGLv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 May 2014 02:11:51 -0400
In-Reply-To: <1400819575-20435-2-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 23.05.2014 06:32, Huang Shijie wrote:
> This patch disables the receiver ready interrupt for imx_stop_rx.
> It reduces the interrupt numbers when the uart is going to close
> or suspend.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>   drivers/tty/serial/imx.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index ed6cdf7..6026101 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -440,6 +440,10 @@ static void imx_stop_rx(struct uart_port *port)
>
>   	temp = readl(sport->port.membase + UCR2);
>   	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
> +
> +	/* disable the `Receiver Ready Interrrupt` */
> +	temp = readl(sport->port.membase + UCR1);
> +	writel(temp & ~UCR1_RRDYEN, sport->port.membase + UCR1);
>   }

While this is about the RX irq, I've a slightly off-topic general 
question regarding the usage of the *TX* irq in TX DMA mode:

It seems to me that the TX irq is kept enabled while the TX DMA is 
running/enabled? Looking e.g. into the amba-pl011.c there it seems there 
the logic is:

- Set up/start the TX DMA
- Disable the TX irq while the TX DMA is running (only waiting for the 
TX DMA callback, then)
- Re-enable the TX irq in the TX DMA callback
- Let the TX irq fire, then. And if there are still data, set up the TX 
DMA again.

This sounds quite more logical than the implementation in imx.c.

Or is my understanding completely wrong, here?

Thanks

Dirk

