Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5419E82A;
	Fri,  2 May 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179456; cv=none; b=Y32nYWVcvm/aHzIx6cA10xRtnBDU+cXhJPs5zU9/YLUzlwCNzSMZIs1rK/YhW0k5U+mzdeQWthRcj0PizLwO1LsnHKhouZtRbuAoEeXp2SekHMjlnanND7XSWDSG0x2ZKrP+qeGBuc7/UvkDkqbbn6aosEArTIeTB36ldrgnvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179456; c=relaxed/simple;
	bh=yRqzO+dAlnKgkS3KjhK1tFMaIGGotqG+8EEqgCollYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWul/SLAMRq5jztLMmKsJbBIniq3mSzBQ/SnPACm4GPeLFHZZ752W5UWwmFJwuttRJWPVnQufnT0VL7aYrSp1PPH0k8Ye9g8wyzVQZUHRNDze3Q7wo/ffOmZzP/52YqNwBysU2FuLwv6OkSE71Cj/UZFrER1NwXfy0cmecRo2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiB5nXBm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiB5nXBm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746179455; x=1777715455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yRqzO+dAlnKgkS3KjhK1tFMaIGGotqG+8EEqgCollYI=;
  b=iiB5nXBmGLorCMwhWbBHF8qOooATqRiptrWZNFBMInJUNp8vEm3Wy0vu
   9EfZtdloYQWhQS34Igp/0TeZkgMsdq7M3ytaKlek9shGzrvbZ7Q6/todt
   4E7skNl/cQWUBB5wLtL9hxY0BTXLvJvrkgjML3GLjxLqNVMDcSdLVQjp+
   2PAlDYkliLlT3ZzBBSXEtvQOhIXcSEswxQF81met1UiwfihzRoE41Nj5d
   VzjcBa2MotcZ8nfyfKUC+SW66qZ73mV/Y/yUJYNwOiks6pGXHmhvIHlRx
   2zGmjiJCdhlrRj3jiBnCTbHEwP1xgtNj1hRls622+YcIorNTG0T6vHIwO
   A==;
X-CSE-ConnectionGUID: 1F/gutt0RFir3jnR2Lby4Q==
X-CSE-MsgGUID: DYLwJGTrSG6EwzJYBFIbyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47998568"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="47998568"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:50:54 -0700
X-CSE-ConnectionGUID: JUlkgVADRM2rxIdXQ6QjaQ==
X-CSE-MsgGUID: Z1eWQmo9T1+7x4HiXK7iGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165526037"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:50:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uAn2f-000000029R3-0WZC;
	Fri, 02 May 2025 12:50:49 +0300
Date: Fri, 2 May 2025 12:50:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Judith Mendez <jm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH RFC 2/2] serial: 8250: Add PRUSS UART driver
Message-ID: <aBSVeKoR0j4J0ruz@smile.fi.intel.com>
References: <20250501003113.1609342-1-jm@ti.com>
 <20250501003113.1609342-3-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501003113.1609342-3-jm@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 30, 2025 at 07:31:13PM -0500, Judith Mendez wrote:
> From: Bin Liu <b-liu@ti.com>
> 
> This adds a new serial 8250 driver that supports the UART in PRUSS
> module.
> 
> The PRUSS has a UART sub-module which is based on the industry standard
> TL16C550 UART controller, which has 16-bytes FIFO and supports 16x and
> 13x over samplings.

> Signed-off-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Judith Mendez <jm@ti.com>

Are you just a committer and not a co-developer of this code?

...

> +/*
> + *  Serial Port driver for PRUSS UART on TI platforms
> + *
> + *  Copyright (C) 2020-2021 by Texas Instruments Incorporated - http://www.ti.com/

My calendar shows 2025...

> + *  Author: Bin Liu <b-liu@ti.com>
> + */

...

The list of the inclusions is semi-random. Please, follow the IWYU principle.

> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_core.h>

> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>

Please, no of*.h in a new code.

> +#include <linux/remoteproc.h>

Keep them ordered as well.

+ blank line here.

> +#include "8250.h"

...

> +#define DEFAULT_CLK_SPEED	192000000

Units as a suffix? HZ_PER_MHZ?
You can also fix 8250_omap in the same way.

...

> +static inline void uart_writel(struct uart_port *p, u32 offset, int value)
> +{
> +	writel(value, p->membase + (offset << p->regshift));
> +}

Why? Or how does it differ from the ones that serial core provides?

...

> +static int pruss8250_startup(struct uart_port *port)
> +{
> +	int ret;
> +
> +	uart_writel(port, PRUSS_UART_PEREMU_MGMT, 0);
> +
> +	ret = serial8250_do_startup(port);
> +	if (!ret)

Please, use usual pattern, check for errors first

	if (ret)
		return ret;
	...
	return 0;

> +		uart_writel(port, PRUSS_UART_PEREMU_MGMT, PRUSS_UART_TX_EN |
> +							  PRUSS_UART_RX_EN |
> +							  PRUSS_UART_FREE_RUN);
> +	return ret;
> +}

...

> +static unsigned int pruss8250_get_divisor(struct uart_port *port,
> +					  unsigned int baud,
> +					  unsigned int *frac)
> +{
> +	unsigned int uartclk = port->uartclk;
> +	unsigned int div_13, div_16;
> +	unsigned int abs_d13, abs_d16;
> +	u16 quot;

> +	/* Old custom speed handling */
> +	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
> +		quot = port->custom_divisor & UART_DIV_MAX;
> +		if (port->custom_divisor & (1 << 16))
> +			*frac = PRUSS_UART_MDR_13X_MODE;
> +		else
> +			*frac = PRUSS_UART_MDR_16X_MODE;
> +
> +		return quot;
> +	}

Why?! Please, try to avoid adding more drivers with this ugly hack.

> +	div_13 = DIV_ROUND_CLOSEST(uartclk, 13 * baud);
> +	div_16 = DIV_ROUND_CLOSEST(uartclk, 16 * baud);
> +	div_13 = div_13 ? : 1;
> +	div_16 = div_16 ? : 1;
> +
> +	abs_d13 = abs(baud - uartclk / 13 / div_13);
> +	abs_d16 = abs(baud - uartclk / 16 / div_16);
> +
> +	if (abs_d13 >= abs_d16) {
> +		*frac = PRUSS_UART_MDR_16X_MODE;
> +		quot = div_16;
> +	} else {
> +		*frac = PRUSS_UART_MDR_13X_MODE;
> +		quot = div_13;
> +	}
> +
> +	return quot;

Are you sure it doesn't repeat existing things from other driver(s)?

> +}

...

> +static int pruss8250_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;

You don't need this.

> +	struct uart_8250_port port8250;
> +	struct uart_port *up = &port8250.port;
> +	struct pruss8250_info *info;
> +	struct resource resource;
> +	unsigned int port_type;
> +	struct clk *clk;
> +	int ret;
> +
> +	port_type = (unsigned long)of_device_get_match_data(&pdev->dev);
> +	if (port_type == PORT_UNKNOWN)
> +		return -EINVAL;
> +
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	memset(&port8250, 0, sizeof(port8250));
> +
> +	ret = of_address_to_resource(np, 0, &resource);

Yeah, no modifications from 2021?

> +	if (ret) {
> +		dev_err(&pdev->dev, "invalid address\n");
> +		return ret;
> +	}

> +	ret = of_alias_get_id(np, "serial");
> +	if (ret > 0)
> +		up->line = ret;

Use uart_read_port_properties() instead of this and other related code.

> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		if (PTR_ERR(clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

We have other errors which are effectively being ignored here, why?

> +		up->uartclk = DEFAULT_CLK_SPEED;
> +	} else {
> +		up->uartclk = clk_get_rate(clk);

> +		devm_clk_put(&pdev->dev, clk);

Why? Maybe you should not to try devm_ to begin with?

> +	}
> +
> +	up->dev = &pdev->dev;
> +	up->mapbase = resource.start;
> +	up->mapsize = resource_size(&resource);
> +	up->type = port_type;
> +	up->iotype = UPIO_MEM;
> +	up->regshift = 2;
> +	up->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
> +		    UPF_FIXED_TYPE | UPF_IOREMAP;
> +	up->irqflags |= IRQF_SHARED;
> +	up->startup = pruss8250_startup;
> +	up->rs485_config = serial8250_em485_config;
> +	up->get_divisor = pruss8250_get_divisor;
> +	up->set_divisor = pruss8250_set_divisor;
> +
> +	ret = of_irq_get(np, 0);
> +	if (ret < 0) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "missing irq\n");
> +		return ret;
> +	}

A lot of this will be simplified by using the above mentioned API.

> +	up->irq = ret;
> +	spin_lock_init(&port8250.port.lock);
> +	port8250.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
> +
> +	ret = serial8250_register_8250_port(&port8250);
> +	if (ret < 0)
> +		goto err_dispose;
> +
> +	info->type = port_type;
> +	info->line = ret;
> +	platform_set_drvdata(pdev, info);
> +
> +	return 0;

> +err_dispose:
> +	irq_dispose_mapping(port8250.port.irq);

Why this is needed?

> +	return ret;
> +}

...

> +static const struct of_device_id pruss8250_table[] = {
> +	{ .compatible = "ti,pruss-uart", .data = (void *)PORT_16550A, },

Inner comma is redundant.

> +	{ /* end of list */ },

No trailing comma in the terminator.

> +};

...

> +config SERIAL_8250_PRUSS
> +	tristate "TI PRU-ICSS UART support"
> +	depends on SERIAL_8250

> +	depends on PRU_REMOTEPROC && TI_PRUSS_INTC

No COMPILE_TEST?

> +	help
> +	  This driver is to support the UART module in PRU-ICSS which is
> +	  available in some TI platforms.
> +	  Say 'Y' here if you wish to use PRU-ICSS UART.
> +	  Otherwise, say 'N'.

If m, how would the module be called? See many new driver examples in Kconfigs
(in particular IIO follows this pattern).

-- 
With Best Regards,
Andy Shevchenko


