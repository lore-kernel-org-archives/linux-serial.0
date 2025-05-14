Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E51F8676;
	Wed, 14 May 2025 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225300; cv=none; b=MdOiZST2s8fyQyYFzcDeuwUrDuL/Sf0d8iBtbb4EczOHkTMlGr+8rz4mAC6Q1Ghz/98OgqeBFfc/P3ROXioZJ2YtPBHLQncWojqCF/wBW1jQIEvZ1wOjTuL7YFYb3J7Q0vZrzreTTwIq9HmiXNnjmlUhCTmNfDNFgHx3+VOIrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225300; c=relaxed/simple;
	bh=EoXutM9PbRThg+M3pY+4biVE8gUy8AVfCsmM3x3cWtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9GanbnkryUfnYL383KE16yMGCvXjfFrbGj22owl8ZEoboelb+a0obV5SSnmqNlDTboFPvlnfxD5lMShqauLwkWWReH1mFGiVDoMaaVQHsjOj6SK1Ve453ENSA/YIc4lz/zwEngzcSG1pKW1TkoUR2CFtT+R08ZRY3gjs7EuVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFyB6TpE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFyB6TpE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747225299; x=1778761299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EoXutM9PbRThg+M3pY+4biVE8gUy8AVfCsmM3x3cWtE=;
  b=LFyB6TpEmyR42RhjG30hgnWj2H5u6NIgfmZO99Oc9T16qcQ74SddN3NF
   qSbOJ/aIs0NEPeNzgXEO987gekoJmCmKeU0C2KDh5Hl8o7g7Dkus9IPb8
   KTbnwbJArS3AsvBQrB4BNnUZL1dF3PPexevi+yqVSov6DrvRdHrR+L42B
   FwBrFV8uDZAL4EB6eJpDlMfC4ph1O64UBO4BzUmPLTMgpUWuxVxM5EwW3
   NdCGjVkfdMa9VfoM9lzfiymgE+Bk8TFqgtBO7DVsEsRYZo0SPJMauvWCz
   ga4R8niu6ok2rtfc+aMR7zNrWlmHeKbGFg5t0uzW0Pwa0G0myqNTj63Rz
   A==;
X-CSE-ConnectionGUID: DKcVDr2WRkK+M6EmAJMipA==
X-CSE-MsgGUID: W6pv7AgORfGb/pArtVAvpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66526126"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="66526126"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:21:38 -0700
X-CSE-ConnectionGUID: dCU4ZW5WSYWQffXhrmD5IA==
X-CSE-MsgGUID: jUhGvMw4T0OxK6yb6BEz7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138946674"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:21:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFB76-00000001Y0G-1JFE;
	Wed, 14 May 2025 15:21:32 +0300
Date: Wed, 14 May 2025 15:21:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Judith Mendez <jm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
	Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] serial: 8250: Add PRUSS UART driver
Message-ID: <aCSKzFHGl5ua3rrP@smile.fi.intel.com>
References: <20250513215934.933807-1-jm@ti.com>
 <20250513215934.933807-4-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513215934.933807-4-jm@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 13, 2025 at 04:59:30PM -0500, Judith Mendez wrote:
> From: Bin Liu <b-liu@ti.com>
> 
> This adds a new serial 8250 driver that supports the UART in PRUSS or
> PRU_ICSS*.
> 
> The UART sub-module is based on the industry standard TL16C550 UART
> controller, which has 16-bytes FIFO and supports 16x and 13x over
> samplings.

...

+ bits.h

> +#include <linux/clk.h>

+ math.h

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_core.h>

Can you keep them sorted?



...

> +static int pruss8250_startup(struct uart_port *port)
> +{
> +	int ret;
> +
> +	port->serial_out(port, PRUSS_UART_PEREMU_MGMT, 0);
> +
> +	ret = serial8250_do_startup(port);

Please, use standard pattern, i.e.

	if (ret)
		return ret;
	...
	return 0;

I believe I have told this previously. Can you double check that you read and
addressed all of the comments?

> +	if (!ret)
> +		port->serial_out(port, PRUSS_UART_PEREMU_MGMT, PRUSS_UART_TX_EN |
> +							       PRUSS_UART_RX_EN |
> +							       PRUSS_UART_FREE_RUN);
> +
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
> +
> +	div_13 = DIV_ROUND_CLOSEST(uartclk, 13 * baud);
> +	div_16 = DIV_ROUND_CLOSEST(uartclk, 16 * baud);
> +	div_13 = div_13 ? : 1;
> +	div_16 = div_16 ? : 1;
> +
> +	abs_d13 = abs(baud - uartclk / 13 / div_13);
> +	abs_d16 = abs(baud - uartclk / 16 / div_16);
> +
> +	if (abs_d13 >= abs_d16) {

Isn't this something like abs_diff() ?

> +		*frac = PRUSS_UART_MDR_16X_MODE;
> +		quot = div_16;
> +	} else {
> +		*frac = PRUSS_UART_MDR_13X_MODE;
> +		quot = div_13;
> +	}
> +
> +	return quot;
> +}

> +static int pruss8250_probe(struct platform_device *pdev)
> +{
> +	struct uart_8250_port port8250;
> +	struct uart_port *port = &port8250.port;
> +	struct device *dev = &pdev->dev;
> +	struct pruss8250_data *data;
> +	struct resource *res;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);

Needs device/devres.h.

> +	if (!data)
> +		return -ENOMEM;

Needs err.h (actually errno.h, but that's not enough for the following IS_ERR()
et al.)

> +	memset(&port8250, 0, sizeof(port8250));

Instead of having dependency on string.h (which is missed) just assign it to {}
in the definition.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get resource");
> +		return -EINVAL;

	return dev_err_probe();

> +	}

> +	if (!port->uartclk) {
> +		data->clk = devm_clk_get(dev, NULL);
> +		if (IS_ERR(data->clk)) {
> +			dev_err(dev, "Failed to get clock!\n");
> +			return -ENODEV;
> +		} else {
> +			port->uartclk = clk_get_rate(data->clk);
> +			devm_clk_put(dev, data->clk);

I think you completely ignored my review I have done in previous version...

> +		}
> +	}

Should be done after uart_read_properties().

> +	port->dev = dev;
> +	port->mapbase = res->start;
> +	port->mapsize = resource_size(res);
> +	port->type = PORT_16550A;
> +	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE |
> +		      UPF_IOREMAP;
> +	port->startup = pruss8250_startup;
> +	port->rs485_config = serial8250_em485_config;
> +	port->get_divisor = pruss8250_get_divisor;
> +	port->set_divisor = pruss8250_set_divisor;
> +
> +	ret = uart_read_port_properties(port);
> +	if (ret)
> +		return ret;
> +
> +	port->iotype = UPIO_MEM32;
> +	port->regshift = 2;
> +
> +	spin_lock_init(&port8250.port.lock);
> +	port8250.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
> +
> +	ret = serial8250_register_8250_port(&port8250);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Unable to register 8250 port.\n");
> +
> +	data->line = ret;
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


