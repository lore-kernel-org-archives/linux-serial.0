Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2885A95B;
	Sun,  4 Aug 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722785601; cv=none; b=gimSd+C+anPO40bA3Z8e6na59aPQPbZgf3lM9mnhGODIRSfwTzQGVqmjokJcuc/NGs4+USIbwgQuxxSzBGTdhbPcQI4Ri5xPsh6k4dUQKeTF5yGnNGLuDbnE8H6suOW7ZgmJftXEyXXhL4znjz+N86D+MlbAypw+qSWxqFxREIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722785601; c=relaxed/simple;
	bh=pMFr/e0KsbkJrhJe9wfumPNt3xbbmQcMZktr3u4sg0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4dxdSL97sBHcCBfZZ53MG7rsf/zgWDTq6kNnSRm/6Tz9DahagTdhY0MP2MJgs568xnIJN61xhT/gnY1aXZKdHDqtIi1twr8gMNgrx0yntoi+Ae73MYG3/85W7LuPmUECe8/5FiBcW/kIH+ANtg13nbc0GZL82KCHiFlsJYl+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo1E1CoL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo1E1CoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48220C32786;
	Sun,  4 Aug 2024 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722785601;
	bh=pMFr/e0KsbkJrhJe9wfumPNt3xbbmQcMZktr3u4sg0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fo1E1CoLq7eWS5NjwZFhoaVmkfhTPdJKOGqgNsGzBcI0L+OYhiefH9kMAD3HqN05e
	 N7iiV/LfbMEypsjssqAClEE1UTpYtuXb3mb+bissM1a91bnlfctIOGNFduqSelcPC8
	 IF6cgBU7fEUmzOBv25b6jNNobjAkfqXMAT38/o4GCPsFUlSXqYAnc6J0OpnhCB92sv
	 8gtGz+2a7dSkntKJwIwqWW5o1pNmYRwCqXf3GDiwAqiuF0pDAG8XQVhPTbwm5uQlC/
	 ahTFR1gKoYbZeTTppzFzQkkcM8w4FM+Oe9/X2WfrVfZktssKiMKddPBYhvpyAP3F6v
	 A6XM1tUes8lOQ==
Message-ID: <84ff11bd-1d11-4d66-a56b-84bf915af346@kernel.org>
Date: Sun, 4 Aug 2024 17:33:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tty: serial: 8250: Add loongson uart driver
 support
To: zhenghaowei@loongson.cn, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
 <20240804063834.70022-2-zhenghaowei@loongson.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240804063834.70022-2-zhenghaowei@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/08/2024 08:38, zhenghaowei@loongson.cn wrote:
> From: Haowei Zheng <zhenghaowei@loongson.cn>
> 
> Due to certain hardware design challenges, we have opted to
> utilize a dedicated UART driver to probe the UART interface.
> 
> Presently, we have defined four parameters — 'fractional-division',
> 'invert-rts', 'invert-dtr', 'invert-cts', and 'invert-dsr' — which
> will be employed as needed.
> 
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> ---
>  drivers/tty/serial/8250/8250_loongson.c | 208 ++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c     |   8 +
>  drivers/tty/serial/8250/Kconfig         |   9 +
>  drivers/tty/serial/8250/Makefile        |   1 +
>  include/uapi/linux/serial_core.h        |   1 +
>  5 files changed, 227 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_loongson.c
> 
> diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
> new file mode 100644
> index 000000000000..eb16677f1dde
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_loongson.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020-2024 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/acpi.h>

How is this used?

> +#include <linux/clk.h>

And this?

> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/reset.h>
> +
> +#include "8250.h"
> +
> +struct loongson_uart_data {
> +	struct reset_control *rst;
> +	int line;
> +	int mcr_invert;
> +	int msr_invert;
> +};

...

> +static int loongson_uart_probe(struct platform_device *pdev)
> +{
> +	struct uart_8250_port uart = {};
> +	struct loongson_uart_data *data;
> +	struct uart_port *port;
> +	struct resource *res;
> +	int ret;
> +
> +	port = &uart.port;
> +	spin_lock_init(&port->lock);
> +
> +	port->flags		= UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
> +	port->iotype		= UPIO_MEM;
> +	port->regshift		= 0;
> +	port->dev		= &pdev->dev;
> +	port->type		= (unsigned long)device_get_match_data(&pdev->dev);
> +	port->serial_in		= loongson_serial_in;
> +	port->serial_out	= loongson_serial_out;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	port->membase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!port->membase)
> +		return -ENOMEM;
> +

Use wrapper combining both calls.

> +	port->mapbase = res->start;
> +	port->mapsize = resource_size(res);
> +
> +	port->irq = platform_get_irq(pdev, 0);
> +	if (port->irq < 0)
> +		return -EINVAL;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	port->private_data = data;
> +
> +	if (device_property_read_bool(&pdev->dev, "fractional-division")) {
> +		port->get_divisor = loongson_frac_get_divisor;
> +		port->set_divisor = loongson_frac_set_divisor;
> +	}
> +
> +	if (device_property_read_bool(&pdev->dev, "rts-invert"))
> +		data->mcr_invert |= UART_MCR_RTS;
> +
> +	if (device_property_read_bool(&pdev->dev, "dtr-invert"))
> +		data->mcr_invert |= UART_MCR_DTR;
> +
> +	if (device_property_read_bool(&pdev->dev, "cts-invert"))
> +		data->msr_invert |= UART_MSR_CTS;
> +
> +	if (device_property_read_bool(&pdev->dev, "dsr-invert"))
> +		data->msr_invert |= UART_MSR_DSR;
> +
> +	data->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +	if (IS_ERR(data->rst))
> +		return PTR_ERR(data->rst);
> +
> +	device_property_read_u32(&pdev->dev, "clock-frequency", &port->uartclk);
> +
> +	ret = reset_control_deassert(data->rst);
> +	if (ret)
> +		goto err_unprepare;
> +
> +	ret = serial8250_register_8250_port(&uart);
> +	if (ret < 0)
> +		goto err_unprepare;
> +
> +	platform_set_drvdata(pdev, data);
> +	data->line = ret;
> +
> +	return 0;
> +
> +err_unprepare:
> +
> +	return ret;
> +}
> +
> +static void loongson_uart_remove(struct platform_device *pdev)
> +{
> +	struct loongson_uart_data *data = platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(data->line);
> +	reset_control_assert(data->rst);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int loongson_uart_suspend(struct device *dev)
> +{
> +	struct loongson_uart_data *data = dev_get_drvdata(dev);
> +
> +	serial8250_suspend_port(data->line);
> +
> +	return 0;
> +}
> +
> +static int loongson_uart_resume(struct device *dev)
> +{
> +	struct loongson_uart_data *data = dev_get_drvdata(dev);
> +
> +	serial8250_resume_port(data->line);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops loongson_uart_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(loongson_uart_suspend, loongson_uart_resume)
> +};
> +
> +static const struct of_device_id of_platform_serial_table[] = {
> +	{.compatible = "loongson,ls7a-uart", .data = (void *)PORT_LOONGSON},

Why do you need match data if there is no choice?

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_platform_serial_table);
> +
> +static struct platform_driver loongson_uart_driver = {
> +	.probe = loongson_uart_probe,
> +	.remove = loongson_uart_remove,
> +	.driver = {
> +		.name = "ls7a-uart",
> +		.pm = &loongson_uart_pm_ops,
> +		.of_match_table = of_match_ptr(of_platform_serial_table),

Except that this does not build... drop of_match_ptr(), not needed and
causes warnings.

> +	},
> +};
> +
> +module_platform_driver(loongson_uart_driver);
> +
> +MODULE_DESCRIPTION("LOONGSON 8250 Driver");
> +MODULE_AUTHOR("Haowei Zheng <zhenghaowei@loongson.cn>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 2786918aea98..60b72c785028 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -319,6 +319,14 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes	= {1, 8, 16, 30},
>  		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>  	},
> +	[PORT_LOONGSON] = {
> +		.name		= "Loongson",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> +		.rxtrig_bytes   = {1, 4, 8, 14},
> +		.flags		= UART_CAP_FIFO,
> +	},
>  };
>  
>  /* Uart divisor latch read */
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 47ff50763c04..a696afc4f8a8 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -568,6 +568,15 @@ config SERIAL_8250_BCM7271
>  	  including DMA support and high accuracy BAUD rates, say
>  	  Y to this option. If unsure, say N.
>  
> +config SERIAL_8250_LOONGSON
> +	tristate "Loongson 8250 serial port support"
> +	default SERIAL_8250
> +	depends on SERIAL_8250
> +	depends on LOONGARCH || MIPS

MIPS? Why?

You also miss COMPILE_TEST.



Best regards,
Krzysztof

