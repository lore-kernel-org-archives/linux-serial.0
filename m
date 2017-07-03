From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/7] serial: imx: update the stop rx,tx procedures
Date: Mon, 3 Jul 2017 09:03:35 +0200
Message-ID: <20170703070335.4c2g7zzd2d3vhoky@pengutronix.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-7-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630120446.13994-7-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 30, 2017 at 02:04:45PM +0200, Romain Perier wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> According to "Documentation/serial/driver" both procedures should stop
> receiving or sending data. Based on this the procedures should stop the
> activity regardless if DMA is enabled or not.
> 
> This commit updates both imx_stop_{rx|tx} procedures to stop the
> activity and disable the interrupts related to that. In case DMA is used
> the sg buffers are also un-maped.

This unmapping is implicit, becuae imx_stop_rx_dma unmaps since the
previous commit, right?
> 
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/tty/serial/imx.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 58d6b1c..d5b6e09 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -360,6 +360,9 @@ static void imx_port_rts_auto(struct imx_port *sport, unsigned long *ucr2)
>  	*ucr2 |= UCR2_CTSC;
>  }
>  
> +static void imx_stop_rx_dma(struct imx_port *sport);
> +static void imx_stop_tx_dma(struct imx_port *sport);

Is it possible to reshuffle the order of functions to make this forward
declaration redundant?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
