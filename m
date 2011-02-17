From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [Nios2-dev] [PATHV v2] tty: serial: altera_uart: Add devicetree
  support
Date: Thu, 17 Feb 2011 10:24:01 +0800
Message-ID: <4D5C86C1.8070404@wytron.com.tw>
References: <c7a7085602687d2f1b6ac505c030f19bafda04e3.1297245277.git.tklauser@distanz.ch> <1297872732-10207-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:38321 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab1BQCVE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Feb 2011 21:21:04 -0500
In-Reply-To: <1297872732-10207-1-git-send-email-tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: nios2-dev@sopc.et.ntust.edu.tw
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hi Tobias,

On 02/17/2011 12:12 AM, Tobias Klauser wrote:
> With the recent switch of the (currently still out-of-tree) Nios2 Linux
> port to devicetree we want to be able to retreive the resources and
> properties from dts.
>
> The old method to retreive resources and properties from platform data
> is still supported.
>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Signed-off-by: Tobias Klauser<tklauser@distanz.ch>
> ---
>   Thanks to Grant Likely for the review.
>
>   changes in v2:
>   - fall back to uartclk from platform data if the device tree property
>     is not available.
>   - Only include MODULE_DEVICE_TABLE if CONFIG_OF is set so we don't
>     advertise device tree support if CONFIG_OF isn't active.
>   - change vendor prefix in match table to be uppercase for consistency
>     with documentation
>
>   .../devicetree/bindings/serial/altera_uart.txt     |    7 +++
>   drivers/tty/serial/altera_uart.c                   |   50 ++++++++++++++++++--
>   2 files changed, 53 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/serial/altera_uart.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/altera_uart.txt b/Documentation/devicetree/bindings/serial/altera_uart.txt
> new file mode 100644
> index 0000000..71cae3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/altera_uart.txt
> @@ -0,0 +1,7 @@
> +Altera UART
> +
> +Required properties:
> +- compatible : should be "ALTR,uart-1.0"
> +
> +Optional properties:
> +- clock-frequency : frequency of the clock input to the UART
> diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
> index 5e80977..4f0898c 100644
> --- a/drivers/tty/serial/altera_uart.c
> +++ b/drivers/tty/serial/altera_uart.c
> @@ -24,6 +24,7 @@
>   #include<linux/serial.h>
>   #include<linux/serial_core.h>
>   #include<linux/platform_device.h>
> +#include<linux/of.h>
>   #include<linux/io.h>
>   #include<linux/altera_uart.h>
>
> @@ -484,6 +485,29 @@ static struct uart_driver altera_uart_driver = {
>   	.cons		= ALTERA_UART_CONSOLE,
>   };
>
> +#ifdef CONFIG_OF
> +static int altera_uart_get_of_uartclk(struct platform_device *pdev,
> +				      struct uart_port *port)
> +{
> +	int len;
> +	const __be32 *clk;
> +
> +	clk = of_get_property(pdev->dev.of_node, "clock-frequency",&len);
> +	if (!clk || len<  sizeof(__be32))
> +		return -ENODEV;
> +
> +	port->uartclk = be32_to_cpup(clk);
> +
> +	return 0;
> +}
> +#else
> +static int altera_uart_get_of_uartclk(struct platform_device *pdev,
> +				      struct uart_port *port)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_OF */
> +
>   static int __devinit altera_uart_probe(struct platform_device *pdev)
>   {
>   	struct altera_uart_platform_uart *platp = pdev->dev.platform_data;
> @@ -491,6 +515,7 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
>   	struct resource *res_mem;
>   	struct resource *res_irq;
>   	int i = pdev->id;
> +	int ret;
>
>   	/* -1 emphasizes that the platform must have one port, no .N suffix */
>   	if (i == -1)
> @@ -515,6 +540,14 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
>   	else if (platp->irq)
>   		port->irq = platp->irq;
>
> +	/* Try to get the uartclk from devicetree, fall back to platform data
> +	 * otherwise */

Please follow multi-line comment style.

/*
  * xxxx
  * xxxx
  */

> +	ret = altera_uart_get_of_uartclk(pdev, port);
> +	if (ret&&  platp)
> +		port->uartclk = platp->uartclk;
> +	else if (ret)
> +		return ret;
> +

Better reverse the priority, with platform data checked first.

	if (platp)
		port->uartclk = platp->uartclk;
	else {
		ret = altera_uart_get_of_uartclk(pdev, port);
		if (ret)
			return ret;
	}


>   	port->membase = ioremap(port->mapbase, ALTERA_UART_SIZE);
>   	if (!port->membase)
>   		return -ENOMEM;
> @@ -527,7 +560,6 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
>   	port->line = i;
>   	port->type = PORT_ALTERA_UART;
>   	port->iotype = SERIAL_IO_MEM;
> -	port->uartclk = platp->uartclk;
>   	port->ops =&altera_uart_ops;
>   	port->flags = UPF_BOOT_AUTOCONF;
>
> @@ -550,13 +582,23 @@ static int __devexit altera_uart_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF
> +static struct of_device_id altera_uart_match[] = {
> +	{ .compatible = "ALTR,uart-1.0", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, altera_uart_match);
> +#else
> +#define altera_uart_match NULL
> +#endif /* CONFIG_OF */
> +
>   static struct platform_driver altera_uart_platform_driver = {
>   	.probe	= altera_uart_probe,
>   	.remove	= __devexit_p(altera_uart_remove),
>   	.driver	= {
> -		.name	= DRV_NAME,
> -		.owner	= THIS_MODULE,
> -		.pm	= NULL,
> +		.name		= DRV_NAME,
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= altera_uart_match,
>   	},
>   };
>

Regards,
Thomas

