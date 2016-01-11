From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V2 2/2] serial: bcm2835: add driver for bcm2835-aux-uart
Date: Mon, 11 Jan 2016 10:52:32 +0100
Message-ID: <56937B60.5020200@i2se.com>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
 <1452344854-2576-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452344854-2576-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Martin,

Am 09.01.2016 um 14:07 schrieb kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> The bcm2835 SOC contains an auxiliary uart, which is very close
> to the ns16550 with some differences.
>
> The big difference is that the uart HW is not using an internal divider
> of 16 but 8, which results in an effictive baud-rate being twice
> the requested baud-rate.
>
> This driver handles this device correctly and handles the difference in
> the HW divider by scaling up the clock ba a factor of 2.
>
> The approach to write a separate (wrapper) driver instead of using a
> multiplying clock and "ns16550" as compatibility in the device-tree
> has been recommended by Stephen Warren.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  drivers/tty/serial/8250/8250_bcm2835aux.c |  143 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig           |    8 ++
>  drivers/tty/serial/8250/Makefile          |    1 +
>  3 files changed, 152 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_bcm2835aux.c
>
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> new file mode 100644
> index 0000000..718c357
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -0,0 +1,143 @@
> +/*
> + * Serial port driver for BCM2835AUX UART
> + *
> + * Copyright (C) 2016 Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> + *
> + * Based on 8250_lpc18xx.c:
> + * Copyright (C) 2015 Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include "8250.h"
> +
> +struct bcm2835aux_data {
> +	struct uart_8250_port uart;
> +	struct clk *clk;
> +};
> +
> +static int bcm2835aux_serial_probe(struct platform_device *pdev)
> +{
> +	struct bcm2835aux_data *data;
> +	struct resource *res;
> +	int ret;
> +
> +	/* allocate the custom structure */
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* initialize data */
> +	spin_lock_init(&data->uart.port.lock);
> +	data->uart.port.dev = &pdev->dev;
> +	data->uart.port.regshift = 2;
> +	data->uart.port.type = PORT_16550;
> +	data->uart.port.iotype = UPIO_MEM;
> +	data->uart.port.fifosize = 8;

data->uart.capabilities = UART_CAP_FIFO; ?

> +	data->uart.port.flags = UPF_SHARE_IRQ |
> +				UPF_FIXED_PORT |
> +				UPF_FIXED_TYPE |
> +				UPF_SKIP_TEST;
> +
> +	/* get the clock - this also enables the HW */
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	ret = PTR_ERR_OR_ZERO(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* get the interrupt */
> +	data->uart.port.irq = platform_get_irq(pdev, 0);
> +	if (data->uart.port.irq < 0) {
> +		dev_err(&pdev->dev, "irq not found - %i",
> +			data->uart.port.irq);
> +		return data->uart.port.irq;
> +	}
> +
> +	/* map the main registers */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "memory resource not found");
> +		return -EINVAL;
> +	}
> +	data->uart.port.membase = devm_ioremap_resource(&pdev->dev, res);
> +	ret = PTR_ERR_OR_ZERO(data->uart.port.membase);
> +	if (ret)
> +		return ret;
> +
> +	/* Check for a fixed line number */
> +	ret = of_alias_get_id(pdev->dev.of_node, "serial");
> +	if (ret >= 0)
> +		data->uart.port.line = ret;
> +
> +	/* enable the clock as a last step */
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to enable uart clock\n");
> +		return ret;
> +	}
> +
> +	/* the HW-clock divider for bcm2835aux is 8,
> +	 * but 8250 expects a divider of 16,
> +	 * so we have to multiply the actual clock by 2
> +	 * to get identical baudrates.
> +	 */
> +	data->uart.port.uartclk = clk_get_rate(data->clk) * 2;
> +
> +	/* register the port */
> +	ret = serial8250_register_8250_port(&data->uart);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"unable to register 8250 port - %d\n", ret);

This should fit in one line.

> +		goto dis_clk;
> +	}
> +	data->uart.port.line = ret;

This looks wrong because it overwrites the result of of_alias_get_id.
Either
you store it in a new member of bcm2835aux_data or drop the assignment.

> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +
> +dis_clk:
> +	clk_disable_unprepare(data->clk);
> +	return ret;
> +}
> +
> +static int bcm2835aux_serial_remove(struct platform_device *pdev)
> +{
> +	struct bcm2835aux_data *data = platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(data->uart.port.line);
> +	clk_disable_unprepare(data->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm2835aux_serial_match[] = {
> +	{ .compatible = "brcm,bcm2835-aux-uart" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835aux_serial_match);
> +
> +static struct platform_driver bcm2835aux_serial_driver = {
> +	.driver = {
> +		.name = "bcm2835-aux-uart",
> +		.of_match_table = bcm2835aux_serial_match,
> +	},
> +	.probe  = bcm2835aux_serial_probe,
> +	.remove = bcm2835aux_serial_remove,
> +};
> +module_platform_driver(bcm2835aux_serial_driver);
> +
> +MODULE_DESCRIPTION("BCM2835 auxiliar UART driver");
> +MODULE_AUTHOR("Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 6412f14..105aa19 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -272,6 +272,14 @@ config SERIAL_8250_ACORN
>  	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
>  	  cards.  If unsure, say N.
>  
> +config SERIAL_8250_BCM2835AUX
> +	tristate "BCM2835 auxiliar uart support"

BCM2835 auxiliary mini UART support

> +	depends on ARCH_BCM2835 || COMPILE_TEST
> +	depends on SERIAL_8250 && SERIAL_8250_SHARE_IRQ
> +	help
> +	  support for the BCM2835 auxiliar uart.

auxiliary UART

Since it's a mini UART it would be helpful to write down the
limitiations here.

> +	  If unsure, say N.
> +
>  config SERIAL_8250_FSL
>  	bool
>  	depends on SERIAL_8250_CONSOLE
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
