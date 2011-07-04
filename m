From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] serial/imx: add device tree probe support
Date: Mon, 4 Jul 2011 08:58:20 +0200
Message-ID: <20110704065820.GY6069@pengutronix.de>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
 <1309679760-22796-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52504 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab1GDG6X (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 02:58:23 -0400
Content-Disposition: inline
In-Reply-To: <1309679760-22796-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Jeremy Kerr <jeremy.kerr@canonical.com>, Jason Liu <jason.hui@linaro.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Likely <grant.likely@secretlab.ca>

On Sun, Jul 03, 2011 at 03:56:00PM +0800, Shawn Guo wrote:
> It adds device tree probe support for imx tty/serial driver.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++++
>  drivers/tty/serial/imx.c                           |   82 +++++++++++++++++---
>  2 files changed, 91 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> new file mode 100644
> index 0000000..a9c0406
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> @@ -0,0 +1,19 @@
> +* Freescale i.MX Universal Asynchronous Receiver/Transmitter (UART)
> +
> +Required properties:
> +- compatible : Should be "fsl,<soc>-uart"
> +- reg : Address and length of the register set for the device
> +- interrupts : Should contain uart interrupt
> +
> +Optional properties:
> +- fsl,uart-has-rtscts : Indicate the uart has rts and cts
> +- fsl,irda-mode : Indicate the uart supports irda mode
> +
> +Example:
> +
> +uart@73fbc000 {
> +	compatible = "fsl,imx51-uart", "fsl,imx21-uart";
> +	reg = <0x73fbc000 0x4000>;
> +	interrupts = <31>;
> +	fsl,uart-has-rtscts;
> +};
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 983f3bd..483c447 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -45,6 +45,8 @@
>  #include <linux/delay.h>
>  #include <linux/rational.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <asm/io.h>
>  #include <asm/irq.h>
> @@ -239,6 +241,12 @@ static struct platform_device_id imx_uart_devtype[] = {
>  	}
>  };
>  
> +static struct of_device_id imx_uart_dt_ids[] = {
> +	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
> +	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX2_UART], },
> +	{ /* sentinel */ },
> +};

Isn't this table a bit too small? What about the other SoCs?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
