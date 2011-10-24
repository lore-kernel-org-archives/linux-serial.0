From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 9/9] serial: samsung: add device tree support
Date: Mon, 24 Oct 2011 13:38:16 +0200
Message-ID: <20111024113816.GJ8708@ponder.secretlab.ca>
References: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
 <1318241285-23568-10-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43263 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab1JXLiX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Oct 2011 07:38:23 -0400
Content-Disposition: inline
In-Reply-To: <1318241285-23568-10-git-send-email-thomas.abraham@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org

On Mon, Oct 10, 2011 at 03:38:05PM +0530, Thomas Abraham wrote:
> Add device tree based discovery support for Samsung's uart controller.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  .../devicetree/bindings/serial/samsung_uart.txt    |   14 ++++++++
>  drivers/tty/serial/samsung.c                       |   36 ++++++++++++++++++-
>  2 files changed, 48 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
> new file mode 100644
> index 0000000..2c8a17c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.txt
> @@ -0,0 +1,14 @@
> +* Samsung's UART Controller
> +
> +The Samsung's UART controller is used for interfacing SoC with serial communicaion
> +devices.
> +
> +Required properties:
> +- compatible: should be
> +  - "samsung,exynos4210-uart", for UART's compatible with Exynos4210 uart ports.
> +
> +- reg: base physical address of the controller and length of memory mapped
> +  region.
> +
> +- interrupts: interrupt number to the cpu. The interrupt specifier format depends
> +  on the interrupt controller parent.
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index c89987b..efe3756 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -42,6 +42,7 @@
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
> +#include <linux/of.h>
>  
>  #include <asm/irq.h>
>  
> @@ -1163,10 +1164,26 @@ static ssize_t s3c24xx_serial_show_clksrc(struct device *dev,
>  
>  static DEVICE_ATTR(clock_source, S_IRUGO, s3c24xx_serial_show_clksrc, NULL);
>  
> +
>  /* Device driver serial port probe */
>  
> +static const struct of_device_id s3c24xx_uart_dt_match[];
>  static int probe_index;
>  
> +static inline struct s3c24xx_serial_drv_data *s3c24xx_get_driver_data(
> +			struct platform_device *pdev)
> +{
> +#ifdef CONFIG_OF
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +		match = of_match_node(s3c24xx_uart_dt_match, pdev->dev.of_node);
> +		return (struct s3c24xx_serial_drv_data *)match->data;
> +	}
> +#endif
> +	return (struct s3c24xx_serial_drv_data *)
> +			platform_get_device_id(pdev)->driver_data;
> +}
> +
>  static int s3c24xx_serial_probe(struct platform_device *pdev)
>  {
>  	struct s3c24xx_uart_port *ourport;
> @@ -1176,8 +1193,11 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  
>  	ourport = &s3c24xx_serial_ports[probe_index];
>  
> -	ourport->drv_data = (struct s3c24xx_serial_drv_data *)
> -			platform_get_device_id(pdev)->driver_data;
> +	ourport->drv_data = s3c24xx_get_driver_data(pdev);
> +	if (!ourport->drv_data) {
> +		dev_err(&pdev->dev, "could not find driver data\n");
> +		return -ENODEV;
> +	}
>  
>  	ourport->info = ourport->drv_data->info;
>  	ourport->cfg = (pdev->dev.platform_data) ?
> @@ -1626,6 +1646,17 @@ static struct platform_device_id s3c24xx_serial_driver_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, s3c24xx_serial_driver_ids);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id s3c24xx_uart_dt_match[] = {
> +	{ .compatible = "samsung,exynos4210-uart",
> +		.data = &exynos4210_serial_drv_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
> +#else
> +#define s3c24xx_uart_dt_match NULL
> +#endif
> +
>  static struct platform_driver samsung_serial_driver = {
>  	.probe		= s3c24xx_serial_probe,
>  	.remove		= __devexit_p(s3c24xx_serial_remove),
> @@ -1634,6 +1665,7 @@ static struct platform_driver samsung_serial_driver = {
>  		.name	= "samsung-uart",
>  		.owner	= THIS_MODULE,
>  		.pm	= SERIAL_SAMSUNG_PM_OPS,
> +		.of_match_table	= s3c24xx_uart_dt_match,
>  	},
>  };
>  
> -- 
> 1.6.6.rc2
> 
