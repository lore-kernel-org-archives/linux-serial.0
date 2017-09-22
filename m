From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 02/10] drivers:tty: imx: use setup_timer() helper.
Date: Fri, 22 Sep 2017 11:05:30 +0200
Message-ID: <20170922090530.wyqyctpvihdc6bvo@pengutronix.de>
References: <1506068812-8496-1-git-send-email-allen.lkml@gmail.com>
 <1506068812-8496-3-git-send-email-allen.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506068812-8496-3-git-send-email-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Allen Pais <allen.lkml@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

Hello,

$Subject ~= s/:/: /

On Fri, Sep 22, 2017 at 01:56:44PM +0530, Allen Pais wrote:
>     Use setup_timer function instead of initializing timer with the
>     function and data fields.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index dfeff39..64f57c6 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2115,9 +2115,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  	sport->port.rs485.flags =
>  		SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX;
>  	sport->port.flags = UPF_BOOT_AUTOCONF;
> -	init_timer(&sport->timer);
> -	sport->timer.function = imx_timeout;
> -	sport->timer.data     = (unsigned long)sport;
> +	setup_timer(&sport->timer, imx_timeout, (unsigned long)sport);

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
