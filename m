Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2893E7BBF;
	Mon, 27 Jul 2026 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142281; cv=none; b=Itl9WsD0JIzzwzXxfGjuxJfFpEul7wpHBQtGcQOhTq8ObNz3k2l33XsWZ/jDj12jVPvrhvvq2H7oYdZEOjQAJVCHMlE0vxGrv7WDAk/ePTOvHpOwF+KX8OoZ5OCZqj6fLlVDrQDDCo0b1JFROWHuk4k0xhHQYlak9DOhv7uqTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142281; c=relaxed/simple;
	bh=9b7uugP4w9jpqm5V73sYAbmSgZ8DzMVjAZ386oiW0xc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p+7GhNygjb+b6XQ3bli48p75bB8ANT8XS4L/BxDgc0UIQhNR7uBQQEIKvVH+w5a3tdUxhYEZViSHs55fG6f7OUY3Yjidmyu9d/ZUjNOmJqaWnqPAH2+lxBNxZEGOtatA5SjMimNKezVBC+rmZjvallyu8SN6yNe5AXjRoenxbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G70m8AY6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G70m8AY6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785142278; x=1816678278;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9b7uugP4w9jpqm5V73sYAbmSgZ8DzMVjAZ386oiW0xc=;
  b=G70m8AY6mATbcK+1F+X2ycb38yzSGW0x9uqiOTfCqbdDV8go6KI2HmZq
   EOFJdXk3AioqHdkrYCDF4A//SNzal//w7+h3lBOx3xpu/byvKdVb02grG
   cmAd7kNAGdG0kUOCzKag5XxyuV+BGKMuj0fA4WEHbMdDziyxgzHuyBCw+
   VkRc+iAkYqm8eZLS+obNZNs9pN+kv8aG1lLYSsQqujvlKEZVOe6MeOFVA
   XVLLtzouLSo4a3uXJRHFy1VI1PHFwp6yJ43M1VU1zO1Yv2ww+B3cvq7NF
   Sthdb3rZnWiuskp6PLOr8nlpu12ibLsJbb/WwQ5fZZgFZUtmxnP4sl8d3
   Q==;
X-CSE-ConnectionGUID: dH0KMZhFRI+8oYV0g8qgPQ==
X-CSE-MsgGUID: 9pOvFY1HTkqFKBo6Im4FCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="89598709"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="89598709"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:51:15 -0700
X-CSE-ConnectionGUID: OKdZnSZ0S6+fCM7MKyh1iw==
X-CSE-MsgGUID: 1iHU9vvQQau9t4DKLJ1jfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="264350112"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.226])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:51:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 Jul 2026 11:51:01 +0300 (EEST)
To: Christian Marangi <ansuelsmth@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Benjamin Larsson <benjamin.larsson@genexis.eu>, 
    John Ogness <john.ogness@linutronix.de>, 
    Peng Zhang <zhangpeng.00@bytedance.com>, Jacques Nilo <jnilo@free.fr>, 
    Rong Zhang <rongrong@oss.cipunited.com>, Gerhard Engleder <eg@keba.com>, 
    Jiaxun Yang <jiaxun.yang@flygoat.com>, 
    Randy Dunlap <rdunlap@infradead.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
    Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add Airoha SoC UART and HSUART
 support
In-Reply-To: <20260724183007.188172-3-ansuelsmth@gmail.com>
Message-ID: <6ade8574-1ba6-3a9a-e1ab-4f0ce9c1d8ab@linux.intel.com>
References: <20260724183007.188172-1-ansuelsmth@gmail.com> <20260724183007.188172-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Jul 2026, Christian Marangi wrote:

> Add support for Airoha AN7523 UART and AN7581 HSUART.
> 
> These implement a standard 16550 UART with only some custom logic
> for baud rate handling.
> 
> Co-developed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/tty/serial/8250/8250.h        |   6 +
>  drivers/tty/serial/8250/8250_airoha.c | 190 ++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c   |  16 +++
>  drivers/tty/serial/8250/Kconfig       |  11 ++
>  drivers/tty/serial/8250/Makefile      |   1 +
>  5 files changed, 224 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_airoha.c
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 77fe0588fd6b..e6b2b9431229 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -73,6 +73,12 @@ struct serial8250_config {
>  	unsigned int	flags;
>  };
>  
> +enum uart_port_type {
> +	/* Internal 8250 only */
> +	UART_PORT_AIROHA		= 124,
> +	UART_PORT_AIROHA_HS		= 125,
> +};
> +
>  #define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
>  #define UART_CAP_EFR	BIT(9)	/* UART has EFR */
>  #define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
> diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
> new file mode 100644
> index 000000000000..5d6d998bebd6
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_airoha.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Airoha UART driver
> + *
> + * Copyright (c) 2025 Genexis Sweden AB
> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + *	   Christian Marangi <ansuelsmth@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/math64.h>
> +#include <linux/property.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_8250.h>
> +
> +#include "8250.h"
> +
> +#define UART_AIROHA_BRDL	0
> +#define UART_AIROHA_BRDH	1
> +#define UART_AIROHA_XINCLKDR	10
> +#define UART_AIROHA_XYD		11
> +#define   UART_AIROHA_XYD_X	GENMASK(31, 16)
> +#define   UART_AIROHA_XYD_Y	GENMASK(15, 0)

Please add linux/bits.h include.

> +
> +struct airoha_8250_priv {
> +	int line;
> +};
> +
> +struct airoha_8250_clk_div_info {
> +	unsigned int div;
> +	u32 mask;
> +};
> +
> +#define UART_BRDL_20M		0x01
> +#define UART_BRDH_20M		0x00
> +
> +#define XINDIV_CLOCK		20000000
> +#define XYD_Y			65000
> +
> +static const struct airoha_8250_clk_div_info airoha_clk_div_info[] = {
> +	{ .div = 10, .mask = BIT(2) },
> +	{ .div = 4, .mask = BIT(1) },
> +	{ .div = 2, .mask = BIT(0) },
> +};
> +
> +static unsigned int airoha_get_divisor(struct uart_port *port,
> +				       unsigned int baud,
> +				       unsigned int *frac)
> +{
> +	/* Hardware always uses BRDIV = 1. */
> +	*frac = 0;
> +
> +	return 1;
> +}
> +
> +/*
> + * Airoha UART baud rate calculation logic
> + *
> + * crystal_clock = 20 MHz (fixed frequency)
> + * xindiv_clock = crystal_clock / clock_div
> + * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
> + * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
> + *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
> + *
> + * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
> + *
> + * Selecting divider needs to fulfill
> + * 1.8432 MHz <= xindiv_clk <= APB clock / 2
> + * The clocks are unknown but a divider of value 1 did not result in a valid
> + * waveform.
> + *
> + * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
> + * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 gives even values
> + * for usual baud rates.
> + */
> +static void airoha_set_divisor(struct uart_port *port, unsigned int baud,
> +			       unsigned int quot, unsigned int quot_frac)
> +{
> +	const struct airoha_8250_clk_div_info *clk_div_info;
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	u32 xindiv_clk;
> +	u64 xyd_x, nom;
> +	int i;
> +
> +	/* Set DLAB to access the baud rate divider registers (BRDH, BRDL) */
> +	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
> +
> +	/* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */
> +	serial_port_out(port, UART_AIROHA_BRDL, UART_BRDL_20M);
> +	serial_port_out(port, UART_AIROHA_BRDH, UART_BRDH_20M);
> +
> +	/*
> +	 * Calculate XYD_x and XINCLKDR register by searching
> +	 * through a table of crystal_clock divisors.
> +	 */
> +	nom = baud * XYD_Y;
> +	for (i = 0 ; i < ARRAY_SIZE(airoha_clk_div_info) ; i++) {

Please add include for ARRAY_SIZE()

> +		clk_div_info = &airoha_clk_div_info[i];
> +
> +		xindiv_clk = XINDIV_CLOCK / clk_div_info->div;
> +		xyd_x = div_u64(nom, xindiv_clk) * 16;
> +
> +		/* For the HSUART xyd_x needs to be scaled by a factor of 2 */
> +		if (port->type == UART_PORT_AIROHA_HS)
> +			xyd_x /= 2;
> +
> +		if (xyd_x < XYD_Y)
> +			break;
> +	}
> +
> +	serial_port_out(port, UART_AIROHA_XINCLKDR, clk_div_info->mask);
> +	serial_port_out(port, UART_AIROHA_XYD,
> +			FIELD_PREP(UART_AIROHA_XYD_X, xyd_x) |
> +			FIELD_PREP(UART_AIROHA_XYD_Y, XYD_Y));
> +
> +	/* Restore normal register access. */
> +	serial_port_out(port, UART_LCR, up->lcr);
> +}
> +
> +static int airoha_8250_probe(struct platform_device *pdev)

You need to add include for platform_device as you'll be dereferencing it 
below.

> +{
> +	struct uart_8250_port uart = { };
> +	struct device *dev = &pdev->dev;
> +	struct airoha_8250_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return dev_err_probe(dev, -EINVAL, "invalid address\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	uart.port.dev = dev;
> +	if (device_is_compatible(dev, "airoha,an7581-hsuart"))
> +		uart.port.type = UART_PORT_AIROHA_HS;
> +	else
> +		uart.port.type = UART_PORT_AIROHA;
> +	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
> +			  UPF_FIXED_TYPE | UPF_IOREMAP;
> +	uart.port.set_divisor = airoha_set_divisor;
> +	uart.port.get_divisor = airoha_get_divisor;
> +	uart.port.mapbase = res->start;
> +	uart.port.mapsize = resource_size(res);
> +
> +	ret = uart_read_and_validate_port_properties(&uart.port);

Add include for this.

> +	if (ret)
> +		return ret;
> +
> +	ret = serial8250_register_8250_port(&uart);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->line = ret;
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static void airoha_8250_remove(struct platform_device *ofdev)
> +{
> +	struct airoha_8250_priv *priv = platform_get_drvdata(ofdev);
> +
> +	serial8250_unregister_port(priv->line);
> +}
> +
> +static const struct of_device_id airoha_8250_dt_ids[] = {

Add include for of_device_id.

I think linux/of.h is the one you want here, as it will be including the 
new linux/device-id/of.h.

> +	{ .compatible = "airoha,en7523-uart" },
> +	{ .compatible = "airoha,an7581-hsuart" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, airoha_8250_dt_ids);

+ linux/module.h

> +
> +static struct platform_driver airoha_8250_driver = {
> +	.driver = {
> +		.name = "8250_airoha",
> +		.of_match_table = airoha_8250_dt_ids,
> +	},
> +	.probe = airoha_8250_probe,
> +	.remove = airoha_8250_remove,
> +};
> +
> +module_platform_driver(airoha_8250_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Airoha UART driver");
> +MODULE_AUTHOR("Benjamin Larsson <benjamin.larsson@genexis.eu>");
> +MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");

These too would need include but it will be the same module.h as earlier.

It seems you've not really paid attention to includes so far, so you 
should do a pass through you code and check you're directly including this 
you use (defines, macros, functions, structs you're dereferencing). I 
might have missed some.

Do not rely on indirect includes as they're fragile and hamper (potential) 
header refactoring efforts by introducing build landmines. Only when the 
include path is "guaranteed" such as linux/of.h -> linux/device-id/of.h or 
linux/xx.h -> asm/xx.h you can rely on the linux/ one.

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 630deb7dd344..22dd114256b3 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -311,6 +311,22 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes	= {1, 8, 16, 30},
>  		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>  	},
> +	[UART_PORT_AIROHA] = {
> +		.name		= "Airoha UART",
> +		.fifo_size	= 8,
> +		.tx_loadsz	= 1,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
> +		.rxtrig_bytes	= {1, 4},
> +		.flags		= UART_CAP_FIFO,
> +	},
> +	[UART_PORT_AIROHA_HS] = {
> +		.name		= "Airoha HSUART",
> +		.fifo_size	= 128,
> +		.tx_loadsz	= 128,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
> +		.rxtrig_bytes	= {1, 4},
> +		.flags		= UART_CAP_FIFO,
> +	},

Not exactly a problem in your patch but I really which this whole 
uart_config[] thing would be deprecated properly.

We already have fifosize and fcr in uart_port, that should already cover 
most of the variations but I guess a bit of supporting code would be 
needed. serial8250_config_port() assigns fcr from uart_config[] and I'm 
not entire sure if it would be enough to just do like

	if (up->fcr)
		up->fcr = uart_config[up->port.type].fcr;

(That is, is this also used to reset configuration? I dunno for sure.)


-- 
 i.

