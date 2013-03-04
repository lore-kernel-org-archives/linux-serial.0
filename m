From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH 1/1] serial: vt8500_serial: Convert to
 devm_ioremap_resource()
Date: Tue, 05 Mar 2013 06:09:27 +1300
Message-ID: <1362416967.24058.2.camel@gitbox>
References: <1362387279-31829-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:58059 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757912Ab3CDRJQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 12:09:16 -0500
In-Reply-To: <1362387279-31829-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, thierry.reding@avionic-design.de

On Mon, 2013-03-04 at 14:24 +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/tty/serial/vt8500_serial.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index a3f9dd5..f15f53f 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -35,6 +35,7 @@
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/err.h>
>  
>  /*
>   * UART Register offsets
> @@ -585,9 +586,9 @@ static int vt8500_serial_probe(struct platform_device *pdev)
>  	if (!vt8500_port)
>  		return -ENOMEM;
>  
> -	vt8500_port->uart.membase = devm_request_and_ioremap(&pdev->dev, mmres);
> -	if (!vt8500_port->uart.membase)
> -		return -EADDRNOTAVAIL;
> +	vt8500_port->uart.membase = devm_ioremap_resource(&pdev->dev, mmres);
> +	if (IS_ERR(vt8500_port->uart.membase))
> +		return PTR_ERR(vt8500_port->uart.membase);
>  
>  	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
>  	if (IS_ERR(vt8500_port->clk)) {

Acked-by: Tony Prisk <linux@prisktech.co.nz>

