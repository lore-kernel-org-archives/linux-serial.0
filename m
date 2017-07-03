From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/7] serial: imx: only set DMA rx-ing when DMA starts
Date: Mon, 3 Jul 2017 08:48:40 +0200
Message-ID: <20170703064840.pttfudcv7xsnbki3@pengutronix.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-2-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630120446.13994-2-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri, Jun 30, 2017 at 02:04:40PM +0200, Romain Perier wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> Avoid the situation when `dma_is_rxing` could incorrectly signal that
> DMA RX channel is receiving data in case DMA preparation or sg mapping
> fails.

Just from reading the commit log and the patch I didn't understand the
problem that is supposed to be fixed here. After looking at it for some
I understood. I don't suggest a new commit log here as it has to look
different if you pick up my comment below.

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 5437b34..1d35293 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -725,11 +725,11 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void imx_disable_rx_int(struct imx_port *sport)
> +static void imx_disable_rx_int(struct imx_port *sport, bool is_rxing)
>  {
>  	unsigned long temp;
>  
> -	sport->dma_is_rxing = 1;
> +	sport->dma_is_rxing = is_rxing;
>  
>  	/* disable the receiver ready and aging timer interrupts */
>  	temp = readl(sport->port.membase + UCR1);
> @@ -762,7 +762,7 @@ static void imx_dma_rxint(struct imx_port *sport)
>  	temp = readl(sport->port.membase + USR2);
>  	if ((temp & USR2_RDR) && !sport->dma_is_rxing) {
>  
> -		imx_disable_rx_int(sport);
> +		imx_disable_rx_int(sport, false);
>  
>  		/* tell the DMA to receive the data. */
>  		start_rx_dma(sport);
> @@ -1083,6 +1083,7 @@ static int start_rx_dma(struct imx_port *sport)
>  	desc->callback_param = sport;
>  
>  	dev_dbg(dev, "RX: prepare for the DMA.\n");
> +	sport->dma_is_rxing = 1;
>  	sport->rx_cookie = dmaengine_submit(desc);
>  	dma_async_issue_pending(chan);
>  	return 0;
> @@ -1362,7 +1363,7 @@ static int imx_startup(struct uart_port *port)
>  		spin_unlock(&tty->files_lock);
>  
>  		if (readcnt > 0) {
> -			imx_disable_rx_int(sport);
> +			imx_disable_rx_int(sport, true);

I wonder if it would be saner to not assign to dma_is_rxing in
imx_disable_rx_int() at all but do this only in start_rx_dma() and
imx_dma_rxint().

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
