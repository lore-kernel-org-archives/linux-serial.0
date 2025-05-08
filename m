Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24372163BD;
	Thu,  8 May 2025 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742164; cv=none; b=O18erAEIZdri5DLC6G7FzeWSln3DUzUrTX6I1oJsaHwKhLE2DcTZS4kYdgDTBpQKV2FXTp2mFSjZfLlAZpQKArawU6U2xQkIScdaPQrqSIyfU23WF1qNXSRnILYHxIcsQa4xtTw59GpjxEe2737y+pWXTUmQ5q/lg+jOwlnr1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742164; c=relaxed/simple;
	bh=egHYxqj0bWWunEcBmTylm/eROF1lCTJhp6N+avmAXyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aH/nnEhPVeb45UMbQ9CHPVn9wLQiy3Re1o3BlUvs6eFvX0wOasl/MC35N0sGOew1rvOT56keyB7rCCUXD1+DDs907Vw2NZIPeI4vp+Vp7HghXy1zI7w9Z2SA1V3/ZMG6c7um6YZhiXwEf2EkjP4G1iCRIkovm4oYoHCaIrqvfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OjgnPe3W; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OjgnPe3W"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 548M93xW1774021
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 17:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746742143;
	bh=7dDNWEqEjVREwNa4Z70pStXKY/PnHroLXyWgJW6Hb0I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OjgnPe3WQUs0+cOHej8WqKm3BcAYjYyMbPq/LVVa0fijiTUgafBV8ZbJLKXyOJjPa
	 Bd9zpc2O0zp+I7AohrDyy3SR8YpqoBwLdcA6+2awqcRdqH3/fzksX0/7XElJkMP5C7
	 odmENxm/RPbbiab5P5gFIsxOv1gNMkFy3DxVQdro=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 548M93L5007262
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 17:09:03 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 May 2025 17:09:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 May 2025 17:09:03 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 548M93sk039289;
	Thu, 8 May 2025 17:09:03 -0500
Message-ID: <22de0384-974d-4170-8181-e43cc90aab9d@ti.com>
Date: Thu, 8 May 2025 17:09:03 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] serial: 8250: Add PRUSS UART driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Hari Nagalla
	<hnagalla@ti.com>
References: <20250501003113.1609342-1-jm@ti.com>
 <20250501003113.1609342-3-jm@ti.com> <aBSVeKoR0j4J0ruz@smile.fi.intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <aBSVeKoR0j4J0ruz@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andy

On 5/2/25 4:50 AM, Andy Shevchenko wrote:
> On Wed, Apr 30, 2025 at 07:31:13PM -0500, Judith Mendez wrote:
>> From: Bin Liu <b-liu@ti.com>
>>
>> This adds a new serial 8250 driver that supports the UART in PRUSS
>> module.
>>
>> The PRUSS has a UART sub-module which is based on the industry standard
>> TL16C550 UART controller, which has 16-bytes FIFO and supports 16x and
>> 13x over samplings.
> 
>> Signed-off-by: Bin Liu <b-liu@ti.com>
>> Signed-off-by: Judith Mendez <jm@ti.com>
> 
> Are you just a committer and not a co-developer of this code?

Commiter only. I am only carrying the driver across kernel version,
fixing merge conflicts, testing the driver, and now up-streaming it.

> 
> ...
> 
>> +/*
>> + *  Serial Port driver for PRUSS UART on TI platforms
>> + *
>> + *  Copyright (C) 2020-2021 by Texas Instruments Incorporated - http://www.ti.com/
> 
> My calendar shows 2025...
> 
>> + *  Author: Bin Liu <b-liu@ti.com>
>> + */
> 
> ...
> 
> The list of the inclusions is semi-random. Please, follow the IWYU principle.
> 
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <linux/serial_reg.h>
>> +#include <linux/serial_core.h>
> 
>> +#include <linux/of_irq.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
> 
> Please, no of*.h in a new code.

Will only keep linux/of_platform.h for of_device_id struct.

> 
>> +#include <linux/remoteproc.h>
> 
> Keep them ordered as well.
> 
> + blank line here.
> 
>> +#include "8250.h"
> 
> ...
> 
>> +#define DEFAULT_CLK_SPEED	192000000
> 
> Units as a suffix? HZ_PER_MHZ?
> You can also fix 8250_omap in the same way.
> 
> ...
> 
>> +static inline void uart_writel(struct uart_port *p, u32 offset, int value)
>> +{
>> +	writel(value, p->membase + (offset << p->regshift));
>> +}
> 
> Why? Or how does it differ from the ones that serial core provides?
> 
> ...
> 
>> +static int pruss8250_startup(struct uart_port *port)
>> +{
>> +	int ret;
>> +
>> +	uart_writel(port, PRUSS_UART_PEREMU_MGMT, 0);
>> +
>> +	ret = serial8250_do_startup(port);
>> +	if (!ret)
> 
> Please, use usual pattern, check for errors first
> 
> 	if (ret)
> 		return ret;
> 	...
> 	return 0;
> 
>> +		uart_writel(port, PRUSS_UART_PEREMU_MGMT, PRUSS_UART_TX_EN |
>> +							  PRUSS_UART_RX_EN |
>> +							  PRUSS_UART_FREE_RUN);
>> +	return ret;
>> +}
> 
> ...
> 
>> +static unsigned int pruss8250_get_divisor(struct uart_port *port,
>> +					  unsigned int baud,
>> +					  unsigned int *frac)
>> +{
>> +	unsigned int uartclk = port->uartclk;
>> +	unsigned int div_13, div_16;
>> +	unsigned int abs_d13, abs_d16;
>> +	u16 quot;
> 
>> +	/* Old custom speed handling */
>> +	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
>> +		quot = port->custom_divisor & UART_DIV_MAX;
>> +		if (port->custom_divisor & (1 << 16))
>> +			*frac = PRUSS_UART_MDR_13X_MODE;
>> +		else
>> +			*frac = PRUSS_UART_MDR_16X_MODE;
>> +
>> +		return quot;
>> +	}
> 
> Why?! Please, try to avoid adding more drivers with this ugly hack.

My understanding is that this is not a hack, for 38400 we need to pass
as custom baud. What is the alternative here?

I see other drivers are doing this as well, will look into this further
but not sure if there is a better solution for this.

> 
>> +	div_13 = DIV_ROUND_CLOSEST(uartclk, 13 * baud);
>> +	div_16 = DIV_ROUND_CLOSEST(uartclk, 16 * baud);
>> +	div_13 = div_13 ? : 1;
>> +	div_16 = div_16 ? : 1;
>> +
>> +	abs_d13 = abs(baud - uartclk / 13 / div_13);
>> +	abs_d16 = abs(baud - uartclk / 16 / div_16);
>> +
>> +	if (abs_d13 >= abs_d16) {
>> +		*frac = PRUSS_UART_MDR_16X_MODE;
>> +		quot = div_16;
>> +	} else {
>> +		*frac = PRUSS_UART_MDR_13X_MODE;
>> +		quot = div_13;
>> +	}
>> +
>> +	return quot;
> 
> Are you sure it doesn't repeat existing things from other driver(s)?

core driver does this differently so we cant use that.

> 
>> +}
> 
> ...
> 
>> +static int pruss8250_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
> 
> You don't need this.
> 
>> +	struct uart_8250_port port8250;
>> +	struct uart_port *up = &port8250.port;
>> +	struct pruss8250_info *info;
>> +	struct resource resource;
>> +	unsigned int port_type;
>> +	struct clk *clk;
>> +	int ret;
>> +
>> +	port_type = (unsigned long)of_device_get_match_data(&pdev->dev);
>> +	if (port_type == PORT_UNKNOWN)
>> +		return -EINVAL;
>> +
>> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	memset(&port8250, 0, sizeof(port8250));
>> +
>> +	ret = of_address_to_resource(np, 0, &resource);
> 
> Yeah, no modifications from 2021?
> 
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "invalid address\n");
>> +		return ret;
>> +	}
> 
>> +	ret = of_alias_get_id(np, "serial");
>> +	if (ret > 0)
>> +		up->line = ret;
> 
> Use uart_read_port_properties() instead of this and other related code.
> 
>> +	clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(clk)) {
>> +		if (PTR_ERR(clk) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
> 
> We have other errors which are effectively being ignored here, why?
> 
>> +		up->uartclk = DEFAULT_CLK_SPEED;
>> +	} else {
>> +		up->uartclk = clk_get_rate(clk);
> 
>> +		devm_clk_put(&pdev->dev, clk);
> 
> Why? Maybe you should not to try devm_ to begin with?
> 
>> +	}
>> +
>> +	up->dev = &pdev->dev;
>> +	up->mapbase = resource.start;
>> +	up->mapsize = resource_size(&resource);
>> +	up->type = port_type;
>> +	up->iotype = UPIO_MEM;
>> +	up->regshift = 2;
>> +	up->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
>> +		    UPF_FIXED_TYPE | UPF_IOREMAP;
>> +	up->irqflags |= IRQF_SHARED;
>> +	up->startup = pruss8250_startup;
>> +	up->rs485_config = serial8250_em485_config;
>> +	up->get_divisor = pruss8250_get_divisor;
>> +	up->set_divisor = pruss8250_set_divisor;
>> +
>> +	ret = of_irq_get(np, 0);
>> +	if (ret < 0) {
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(&pdev->dev, "missing irq\n");
>> +		return ret;
>> +	}
> 
> A lot of this will be simplified by using the above mentioned API.
> 
>> +	up->irq = ret;
>> +	spin_lock_init(&port8250.port.lock);
>> +	port8250.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
>> +
>> +	ret = serial8250_register_8250_port(&port8250);
>> +	if (ret < 0)
>> +		goto err_dispose;
>> +
>> +	info->type = port_type;
>> +	info->line = ret;
>> +	platform_set_drvdata(pdev, info);
>> +
>> +	return 0;
> 
>> +err_dispose:
>> +	irq_dispose_mapping(port8250.port.irq);
> 
> Why this is needed?

No longer needed will remove

> 
>> +	return ret;
>> +}
> 
> ...
> 
>> +static const struct of_device_id pruss8250_table[] = {
>> +	{ .compatible = "ti,pruss-uart", .data = (void *)PORT_16550A, },
> 
> Inner comma is redundant.
> 
>> +	{ /* end of list */ },
> 
> No trailing comma in the terminator.
> 
>> +};
> 
> ...
> 
>> +config SERIAL_8250_PRUSS
>> +	tristate "TI PRU-ICSS UART support"
>> +	depends on SERIAL_8250
> 
>> +	depends on PRU_REMOTEPROC && TI_PRUSS_INTC
> 
> No COMPILE_TEST?
> 
>> +	help
>> +	  This driver is to support the UART module in PRU-ICSS which is
>> +	  available in some TI platforms.
>> +	  Say 'Y' here if you wish to use PRU-ICSS UART.
>> +	  Otherwise, say 'N'.
> 
> If m, how would the module be called? See many new driver examples in Kconfigs
> (in particular IIO follows this pattern).
> 

All other comments I will fix for v1, thanks for reviewing.

~ Judith



