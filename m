From: Dirk Behme <dirk.behme@gmail.com>
Subject: Re: [PATCH 2/2] serial: imx: disable the receiver ready interrupt
 for imx_stop_rx
Date: Fri, 30 May 2014 07:52:25 +0200
Message-ID: <53881C99.1090207@gmail.com>
References: <1400819575-20435-1-git-send-email-b32955@freescale.com> <1400819575-20435-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:49062 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbaE3Fw2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 30 May 2014 01:52:28 -0400
In-Reply-To: <1400819575-20435-2-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

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

Will this change cause a loss or a processing delay of RX characters 
pending in the RX FIFO ?

It is not clear whether disabling the receiver will clear the RX FIFO. 
My guess is that the contents of the RX FIFO will remain intact when 
the receiver is disabled. The RX interrupt has an opportunity to mop 
up these pending characters in the RX FIFO but disabling the RX 
interrupt has potential to leave those characters in the RX FIFO. Does 
it matter ?

Thanks

Dirk

