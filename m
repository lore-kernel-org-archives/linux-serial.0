From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] serial: SAMSUNG: Fix dev_name and driver_name
Date: Tue, 18 May 2010 03:48:20 +0100
Message-ID: <20100518024820.GK27571@trinity.fluff.org>
References: <4BF13ABA.3090504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:57612 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149Ab0ERCsZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 May 2010 22:48:25 -0400
Content-Disposition: inline
In-Reply-To: <4BF13ABA.3090504@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: ben-linux@fluff.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com

On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
> Thd dev_name and driver_name should be switched each other.

Hmm, this doesn't seem to have appeard on the linux-arm-kernel list yet.
 
Please provide some information about what problem that this is fixing
and the impact on any existing systems.

> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  drivers/serial/samsung.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
> index a9d6c56..6f3cf70 100644
> --- a/drivers/serial/samsung.c
> +++ b/drivers/serial/samsung.c
> @@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops = {
>  
>  static struct uart_driver s3c24xx_uart_drv = {
>  	.owner		= THIS_MODULE,
> -	.dev_name	= "s3c2410_serial",
> +	.dev_name	= S3C24XX_SERIAL_NAME,
>  	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
>  	.cons		= S3C24XX_SERIAL_CONSOLE,
> -	.driver_name	= S3C24XX_SERIAL_NAME,
> +	.driver_name	= "s3c2410_serial",
>  	.major		= S3C24XX_SERIAL_MAJOR,
>  	.minor		= S3C24XX_SERIAL_MINOR,
>  };
> -- 
> 1.7.0.4

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

