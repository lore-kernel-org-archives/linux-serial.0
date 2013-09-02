From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] serial: imx: Use NULL as the last argument of
 add_preferred_console()
Date: Mon, 2 Sep 2013 10:18:13 +0200
Message-ID: <20130902081813.GM30088@pengutronix.de>
References: <1378085075-25227-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50068 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab3IBISU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Sep 2013 04:18:20 -0400
Content-Disposition: inline
In-Reply-To: <1378085075-25227-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sun, Sep 01, 2013 at 10:24:35PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Commit f7d2c0bbd (serial: i.MX: evaluate linux,stdout-path property) introduced
> the following sparse warning:
> 
> drivers/tty/serial/imx.c:1916:77: warning: Using plain integer as NULL pointer
> 
> Pass NULL as the last argument of add_preferred_console() instead of zero.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>


Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/tty/serial/imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 2c13155..9a66dc5 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1913,7 +1913,8 @@ static int serial_imx_probe_dt(struct imx_port *sport,
>  	sport->devdata = of_id->data;
>  
>  	if (of_device_is_stdout_path(np))
> -		add_preferred_console(imx_reg.cons->name, sport->port.line, 0);
> +		add_preferred_console(imx_reg.cons->name, sport->port.line,
> +				      NULL);
>  
>  	return 0;
>  }
> -- 
> 1.8.1.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
