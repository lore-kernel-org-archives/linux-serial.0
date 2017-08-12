From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: Improve PIO prevention if TX DMA has been
 started
Date: Sat, 12 Aug 2017 21:54:51 +0200
Message-ID: <20170812195451.2g65wifawouz4t7d@pengutronix.de>
References: <20170812151210.10420-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170812151210.10420-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org, Ian Jamison <ian.dev@arkver.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Aug 12, 2017 at 05:12:10PM +0200, Clemens Gruber wrote:
> The imx_transmit_buffer function should return if TX DMA has already
> been started and not just skip over the buffer PIO write loop. (Which
> did fix the initial problem, but could have unintentional side-effects)
> 
> Tested on an i.MX6Q board with half-duplex RS-485 and with RS-232.
> 
> Cc: Ian Jamison <ian.dev@arkver.com>
> Cc: Uwe-Kleine König <u.kleine-koenig@pengutronix.de>
> Fixes: 514ab34dbad6 ("serial: imx: Prevent TX buffer PIO write when a
> DMA has been started")

AFAIK no newline in the Fixes: line.

> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/tty/serial/imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 80934e7bd67f..fce538eb8c77 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -452,13 +452,14 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
>  		if (sport->dma_is_txing) {
>  			temp |= UCR1_TDMAEN;
>  			writel(temp, sport->port.membase + UCR1);
> +			return;
>  		} else {
>  			writel(temp, sport->port.membase + UCR1);
>  			imx_dma_tx(sport);
>  		}

Shouldn't the return go here?

Did you understand the problem? Can you say why this only hurts in RS485
half-duplex but not (as it seems) in regular rs232 mode?

>  	}
>  
> -	while (!uart_circ_empty(xmit) && !sport->dma_is_txing &&
> +	while (!uart_circ_empty(xmit) &&
>  	       !(readl(sport->port.membase + uts_reg(sport)) & UTS_TXFULL)) {
>  		/* send xmit->buf[xmit->tail]
>  		 * out the port here */

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
