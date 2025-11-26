Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6D221F15
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163068; cv=none; b=PB7AHllBDIJN3potnGcTTuMueMYsB2zgBU9oObV0bU/0ZWGbQobgfPZGzN+htuhqWLGNzmIBDTUug8kJUlAJWHQOc37dG+jE8l4YCpC6q6ybcTPubNqhwm/yTrWK+t/jkHSX8sPn5wreYk2+0C/ZuIgJGUAnlUsD0IMwjXsjsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163068; c=relaxed/simple;
	bh=nftcvYNBgY3IVHB+BNsMzNQ5peLLjjlBWREQgEz6GNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6nuWNrPJq/MBlzazaFrKzraQpmiNkQD/Ty+4U/OBxjphMcYnj7uvD3hx2iYY2yfUvWNZyx649NM1AybjS0CdSq32XmgCOGfEim382eVJjOt0YXsWB63aqRURGukXNUbuWWj73P6sAj3nJDn/Yn+3uQkIYBmmDFgIMon4geu28M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilkD67rb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilkD67rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764163067; x=1795699067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nftcvYNBgY3IVHB+BNsMzNQ5peLLjjlBWREQgEz6GNs=;
  b=ilkD67rbH0CHtxVRJF5BHIcF23GI0Xw64nSjfkPY+vNTOuAqVCugE1PI
   0MJNQ07DZqryQumEDAzUDloChqmb5GwNZMBVzmx+2YfqhnuqJqInmFD3O
   GcfuPt67tAvs5MN36ezAlJ4RBY7w4o26TFCo9tDxCFlZApk7WsP6u+Cm1
   QY5LU26kadU17VF1bRU6fdImGIlOX17R/m+MKvzQkHgkl//0zOnJiVo7d
   DwvooaOyU/Yp0wSOt5Bf/xrJHn3RJ7KnyTCn8Shwz8axwz/xhqxw2fcco
   j+2FiIJBb+YDVw0aam0g+PiGMtrWTJtceHNKbDsDcnpjmU0TJXfnrm4g5
   A==;
X-CSE-ConnectionGUID: Mhq1KYHEQI6mij0pIthuEg==
X-CSE-MsgGUID: z3f4eerGTO2KtM83xhmdCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76884495"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="76884495"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 05:17:46 -0800
X-CSE-ConnectionGUID: /25hQ24WRgq9i2CfSD5oFA==
X-CSE-MsgGUID: rq9PaEQ3T3O3mT5vCVE9jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="193172762"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 26 Nov 2025 05:17:45 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A9ACCA0; Wed, 26 Nov 2025 14:17:43 +0100 (CET)
Date: Wed, 26 Nov 2025 14:17:43 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, lukas@wunner.de,
	Gerhard Engleder <eg@keba.com>, Daniel Gierlinger <gida@keba.com>
Subject: Re: [PATCH v4 2/2] serial: 8250: add driver for KEBA UART
Message-ID: <aSb99zuXhUh3VD4J@black.igk.intel.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-3-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023151229.11774-3-gerhard@engleder-embedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 23, 2025 at 05:12:29PM +0200, Gerhard Engleder wrote:
> 
> The KEBA UART is found in the system FPGA of KEBA PLC devices. It is
> mostly 8250 compatible with extension for some UART modes.
> 
> 3 different variants exist. The simpliest variant supports only RS-232
> and is used for debug interfaces. The next variant supports only RS-485
> and is used mostly for communication with KEBA panel devices. The third
> variant is able to support RS-232, RS-485 and RS-422. For this variant
> not only the mode of the UART is configured, also the physics and
> transceivers are switched according to the mode.

...

> +#include <linux/auxiliary_bus.h>

+ bits.h
+ container_of.h

> +#include <linux/device.h>

I don't see how it's being used.
What I see are

+ dev_printk.h
+ device/devres.h

+ err.h

> +#include <linux/io.h>
> +#include <linux/misc/keba.h>

+ mod_devicetable.h

> +#include <linux/module.h>

+ spinlock.h
+ types.h

...

> +static int kuart_probe(struct auxiliary_device *auxdev,
> +		       const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct uart_8250_port uart = {};
> +	struct resource res;
> +	struct kuart *kuart;
> +	int retval;
> +
> +	kuart = devm_kzalloc(dev, sizeof(*kuart), GFP_KERNEL);
> +	if (!kuart)
> +		return -ENOMEM;
> +	kuart->auxdev = container_of(auxdev, struct keba_uart_auxdev, auxdev);
> +	kuart->flags = id->driver_data;
> +	auxiliary_set_drvdata(auxdev, kuart);
> +
> +	/*
> +	 * map only memory in front of UART registers, UART registers will be
> +	 * mapped by serial port
> +	 */
> +	res = kuart->auxdev->io;
> +	res.end = res.start + KUART_BASE - 1;
> +	kuart->base = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(kuart->base))
> +		return PTR_ERR(kuart->base);
> +
> +	if (kuart->flags & KUART_USE_CAPABILITY) {
> +		/*
> +		 * supported modes are read from capability register, at least
> +		 * one mode other than none must be supported
> +		 */
> +		kuart->capability = ioread8(kuart->base + KUART_CAPABILITY) &
> +				    KUART_CAPABILITY_MASK;
> +		if ((kuart->capability & ~KUART_CAPABILITY_NONE) == 0)
> +			return -EIO;
> +	}
> +
> +	spin_lock_init(&uart.port.lock);
> +	uart.port.dev = dev;
> +	uart.port.mapbase = kuart->auxdev->io.start + KUART_BASE;
> +	uart.port.irq = kuart->auxdev->irq;
> +	uart.port.uartclk = KUART_CLK;
> +	uart.port.private_data = kuart;
> +
> +	/* 8 bit registers are 32 bit aligned => shift register offset */
> +	uart.port.iotype = UPIO_MEM32;
> +	uart.port.regshift = KUART_REGSHIFT;

Can't you call uart_read_port_properties()?

If ever you gain some properties either via FW description or via software
nodes, they will be automatically used without need to update the driver!

> +	/*
> +	 * UART mixes 16550, 16750 and 16C950 (for RS485) standard => auto
> +	 * configuration works best
> +	 */
> +	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_IOREMAP;
> +
> +	/*
> +	 * UART supports RS485, RS422 and RS232 with switching of physical
> +	 * interface
> +	 */
> +	uart.port.rs485_config = kuart_rs485_config;
> +	if (kuart->flags & KUART_RS485) {
> +		uart.port.rs485_supported.flags = SER_RS485_ENABLED |
> +						  SER_RS485_RTS_ON_SEND;
> +		uart.port.rs485.flags = SER_RS485_ENABLED |
> +					SER_RS485_RTS_ON_SEND;
> +	}
> +	if (kuart->flags & KUART_USE_CAPABILITY) {
> +		/* default mode priority is RS485 > RS422 > RS232 */
> +		if (kuart->capability & KUART_CAPABILITY_RS422) {
> +			uart.port.rs485_supported.flags |= SER_RS485_ENABLED |
> +							   SER_RS485_RTS_ON_SEND |
> +							   SER_RS485_MODE_RS422;
> +			uart.port.rs485.flags = SER_RS485_ENABLED |
> +						SER_RS485_RTS_ON_SEND |
> +						SER_RS485_MODE_RS422;
> +		}
> +		if (kuart->capability & KUART_CAPABILITY_RS485) {
> +			uart.port.rs485_supported.flags |= SER_RS485_ENABLED |
> +							   SER_RS485_RTS_ON_SEND;
> +			uart.port.rs485.flags = SER_RS485_ENABLED |
> +						SER_RS485_RTS_ON_SEND;
> +		}
> +	}
> +
> +	retval = serial8250_register_8250_port(&uart);
> +	if (retval < 0) {

> +		dev_err(&auxdev->dev, "UART registration failed!\n");
> +		return retval;

		return dev_err_probe(...);

> +	}
> +	kuart->line = retval;
> +
> +	return 0;
> +}

...

Since driver is about to be applied to serial-next, I suggest to send a
followup(s) to address my comments.

-- 
With Best Regards,
Andy Shevchenko


