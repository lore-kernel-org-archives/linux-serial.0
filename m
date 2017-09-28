From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Use RX_BUF_SIZE to set size of RX buffer
Date: Thu, 28 Sep 2017 12:00:19 +0200
Message-ID: <20170928100019.ynpbdctn65vxf7kq@pengutronix.de>
References: <1506592335-12623-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506592335-12623-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 28, 2017 at 10:52:15AM +0100, Martyn Welch wrote:
> The imx serial driver uses PAGE_SIZE when allocating rx_buf, but then
> uses RX_BUF_SIZE (which is currently defined as PAGE_SIZE) to describe
> the length of the buffer when initialising the scatter gather list.
> 
> In order to ensure that this stays consistent, use RX_BUF_SIZE in both
> locations.

Missing SoB Line

> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index fe368a4..bc2f2a2f 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1165,7 +1165,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
>  		goto err;
>  	}
>  
> -	sport->rx_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	sport->rx_buf = kzalloc(RX_BUF_SIZE, GFP_KERNEL);
>  	if (!sport->rx_buf) {
>  		ret = -ENOMEM;
>  		goto err;
Acked-by: Uwe Kleine-König <u.kleine-könig@pengtronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
