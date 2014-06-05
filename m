From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] serial: samsung: Use %pa to print 'resource_size_t' type
Date: Thu, 05 Jun 2014 10:12:56 +0900
Message-ID: <006f01cf805b$48589d60$d909d820$%han@samsung.com>
References: <1401923201-5477-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:12362 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbaFEBM7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jun 2014 21:12:59 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6O0049O8PKGM50@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 05 Jun 2014 10:12:56 +0900 (KST)
In-reply-to: <1401923201-5477-1-git-send-email-festevam@gmail.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Fabio Estevam' <festevam@gmail.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Fabio Estevam' <fabio.estevam@freescale.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, June 05, 2014 8:07 AM, Fabio Estevam wrote:
> 
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When building multi_v7_defconfig with CONFIG_ARM_LPAE=y the following warning
> is seen:
> 
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_init_port':
> drivers/tty/serial/samsung.c:1229:2: warning: format '%x' expects argument of type 'unsigned int', but
> argument 2 has type 'resource_size_t' [-Wformat]
> 
> Use %pa to print 'resource_size_t' type to fix the warning.
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/tty/serial/samsung.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 3293377..b7b8185 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1226,8 +1226,8 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  		wr_regl(port, S3C64XX_UINTSP, 0xf);
>  	}
> 
> -	dbg("port: map=%08x, mem=%p, irq=%d (%d,%d), clock=%u\n",
> -	    port->mapbase, port->membase, port->irq,
> +	dbg("port: map=%pa, mem=%p, irq=%d (%d,%d), clock=%u\n",
> +	    &port->mapbase, port->membase, port->irq,
>  	    ourport->rx_irq, ourport->tx_irq, port->uartclk);
> 
>  	/* reset the fifos (and setup the uart) */
> --
> 1.8.3.2

