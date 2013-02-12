From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] serial: samsung: remove the use of statically remapped
 controller address
Date: Tue, 12 Feb 2013 10:23:14 -0800
Message-ID: <1d6d01ce094e$06f1ebe0$14d5c3a0$@samsung.com>
References: <1357028515-17794-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46301 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933484Ab3BLSXg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Feb 2013 13:23:36 -0500
In-reply-to: <1357028515-17794-1-git-send-email-thomas.abraham@linaro.org>
Content-language: en-us
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-samsung-soc@vger.kernel.org

Thomas Abraham wrote:
> 
> The address S3C_VA_UART is a statically ioremapped address. The driver
> should not be using this. Instead, the driver should setup a mapping
> during probe.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Looks good to me:
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Greg, if you're ok on this, please pick this up in your tree :-)

Thanks.

- Kukjin

> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/tty/serial/samsung.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index e514b3a..d6c4f659 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -47,7 +47,6 @@
>  #include <asm/irq.h>
> 
>  #include <mach/hardware.h>
> -#include <mach/map.h>
> 
>  #include <plat/regs-serial.h>
>  #include <plat/clock.h>
> @@ -1143,8 +1142,13 @@ static int s3c24xx_serial_init_port(struct
> s3c24xx_uart_port *ourport,
> 
>  	dbg("resource %p (%lx..%lx)\n", res, res->start, res->end);
> 
> +	port->membase = devm_ioremap(port->dev, res->start,
> resource_size(res));
> +	if (!port->membase) {
> +		dev_err(port->dev, "failed to remap controller address\n");
> +		return -EBUSY;
> +	}
> +
>  	port->mapbase = res->start;
> -	port->membase = S3C_VA_UART + (res->start & 0xfffff);
>  	ret = platform_get_irq(platdev, 0);
>  	if (ret < 0)
>  		port->irq = 0;
> --
> 1.7.5.4

