Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03841F236C;
	Tue, 11 Feb 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268081; cv=none; b=Z/vYmrFjoHmMxr12dyNtbu6S6sCf1ghBDNZGW1PhmmttTcGYzW/HcJLWZ/E1h7fomsnyI2P79efoWNnBEWnoRp+j/eXTf9CejJHBvtEgMYkREjGpzTmNTYOjDUsGNe3K6xw/fZhBNAmFb42QiFPvQacOWxO7htvYuxYKVDLAvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268081; c=relaxed/simple;
	bh=i/UWN6+Zo3Up1MyDrnVPoEjsrILRNVSTzrQOYOGxI6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe+fUFfUMVwLjfH1LQFg3jkQhB+BsDtdcv2SBTVY61hRq9OF5yFbUBQTUhDBudQdIc+aex0Cn774uF6VT2/pEvAyzgQ3kvD6Q1+M2o0ZD5EktNHGZtWHR+i+Ra+4bE7WN+9zWSMdTUfJulf8cAa2HFUY3na0vtLTEjHUlWWUVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lR0Z70hh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lR0Z70hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739268080; x=1770804080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i/UWN6+Zo3Up1MyDrnVPoEjsrILRNVSTzrQOYOGxI6c=;
  b=lR0Z70hhYtj8o/FXJM43PEudClTb3rsmPT86UoY4tTwA6o3hG7GjjQ6N
   a8F5Z9YAJA0bphBApQLfWT561IcmlTWuuRbfhIK5a6IImrBQvVV1Mk7PO
   vppJ+iczoxCLAkKx6d1aSfpLWYsrurwyKJNutRo7hN1sZSD4kkwcCtP44
   gpznLBcdB0NgsEKZR9x5B6SkF1OjMUaBrbEIAIOAeREJmpqM6qFa2WRMT
   S9QNI0agWH37fBa8XDDjkkuUSDoIcbEtAiqRv7tWXYizj9wlQ3SsmgXa7
   wMPfhjrJLKPFVdLIMUvKJh0DEEh+yzrzo82feA18kjCPdPIaKEm40t7wl
   Q==;
X-CSE-ConnectionGUID: PW0MFhMSTEGbMadY6zQj+g==
X-CSE-MsgGUID: kQuAdhoBTtGJA3rZz4NtFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39997094"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39997094"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 02:01:19 -0800
X-CSE-ConnectionGUID: NfExqI3kSEmUUUZ+FrIquQ==
X-CSE-MsgGUID: 5OMbKx/6T7+Y4X/1vqhczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="112978375"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 02:01:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thn4p-0000000ASpV-2z65;
	Tue, 11 Feb 2025 12:01:11 +0200
Date: Tue, 11 Feb 2025 12:01:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hvilleneuve@dimonoff.com, arnd@kernel.org,
	geert+renesas@glider.be, robert.marko@sartura.hr,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z6sf58j4HJH4OCX9@smile.fi.intel.com>
References: <20250211061945.18836-1-kkartik@nvidia.com>
 <20250211061945.18836-3-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211061945.18836-3-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 11:49:45AM +0530, Kartik Rajput wrote:
> The Tegra264 SoC supports the UTC (UART Trace Controller), which allows
> multiple firmware clients (up to 16) to share a single physical UART.
> Each client is provided with its own interrupt and has access to a
> 128-character wide FIFO for both transmit (TX) and receive (RX)
> operations.
> 
> Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
> client.

...

+ bits.h

> +#include <linux/console.h>

+ container_of.h
+ device.h
+ err.h
+ io.h

> +#include <linux/kthread.h>

+ kfifo.h

> +#include <linux/module.h>

+ mod_devicetable.h

> +#include <linux/of.h>

> +#include <linux/of_device.h>

Use property.h (see also below).

> +#include <linux/platform_device.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>

+ types.h

...

> +static void tegra_utc_rx_chars(struct tegra_utc_port *tup)
> +{
> +	struct tty_port *port = &tup->port.state->port;
> +	unsigned int max_chars = 256;
> +	unsigned int flag;
> +	u32 status;
> +	int sysrq;
> +	u32 ch;
> +
> +	while (--max_chars) {

Wouldn't while (max_chars--) { suffice?

> +		status = tegra_utc_rx_readl(tup, TEGRA_UTC_FIFO_STATUS);
> +		if (status & TEGRA_UTC_FIFO_EMPTY)
> +			break;
> +
> +		ch = tegra_utc_rx_readl(tup, TEGRA_UTC_DATA);
> +		flag = TTY_NORMAL;
> +		tup->port.icount.rx++;
> +
> +		if (status & TEGRA_UTC_FIFO_OVERFLOW)
> +			tup->port.icount.overrun++;
> +
> +		uart_port_unlock(&tup->port);
> +		sysrq = uart_handle_sysrq_char(&tup->port, ch & 0xff);
> +		uart_port_lock(&tup->port);
> +
> +		if (!sysrq)
> +			tty_insert_flip_char(port, ch, flag);
> +	}
> +
> +	tty_flip_buffer_push(port);
> +}

...

> +static irqreturn_t tegra_utc_isr(int irq, void *dev_id)
> +{
> +	struct tegra_utc_port *tup = dev_id;
> +	unsigned long flags;
> +	u32 status;

> +	uart_port_lock_irqsave(&tup->port, &flags);

As said previously, why _irqsave?

> +	/* Process RX_REQ and RX_TIMEOUT interrupts. */
> +	do {
> +		status = tegra_utc_rx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->rx_irqmask;
> +		if (status) {
> +			tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_CLEAR);
> +			tegra_utc_rx_chars(tup);
> +		}
> +	} while (status);
> +
> +	/* Process TX_REQ interrupt. */
> +	do {
> +		status = tegra_utc_tx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->tx_irqmask;
> +		if (status) {
> +			tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_CLEAR);
> +			tegra_utc_tx_chars(tup);
> +		}
> +	} while (status);
> +
> +	uart_port_unlock_irqrestore(&tup->port, flags);
> +
> +	return IRQ_HANDLED;
> +}

...

> +{
> +	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
> +	int ret;
> +
> +	tegra_utc_hw_init(tup);
> +
> +	ret = request_irq(tup->irq, tegra_utc_isr, 0, dev_name(port->dev), tup);
> +	if (ret < 0) {
> +		dev_err(port->dev, "failed to register interrupt handler\n");

Instead of these LoCs...

> +		return ret;
> +	}
> +
> +	return 0;

	return ret;

> +}

...

> +static int tegra_utc_get_poll_char(struct uart_port *port)
> +{
> +	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
> +
> +	while (tegra_utc_rx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_EMPTY)
> +		cpu_relax();

No way out? HW might get stuck...

> +	return tegra_utc_rx_readl(tup, TEGRA_UTC_DATA);
> +}

...

> +static void tegra_utc_put_poll_char(struct uart_port *port, unsigned char ch)
> +{
> +	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
> +
> +	while (tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_FULL)
> +		cpu_relax();

Ditto.

> +	tegra_utc_tx_writel(tup, ch, TEGRA_UTC_DATA);
> +}

...

> +static struct uart_driver tegra_utc_driver = {
> +	.driver_name	= "tegra-utc",
> +	.dev_name	= "ttyUTC",

> +	.nr		= UART_NR

Leave trailing comma.

> +};

...

> +static void tegra_utc_setup_port(struct device *dev, struct tegra_utc_port *tup)
> +{
> +	tup->port.dev		= dev;
> +	tup->port.fifosize	= tup->soc->fifosize;
> +	tup->port.flags		= UPF_BOOT_AUTOCONF;
> +	tup->port.iotype	= UPIO_MEM;
> +	tup->port.ops		= &tegra_utc_uart_ops;
> +	tup->port.type		= PORT_TEGRA_TCU;
> +	tup->port.private_data	= tup;
> +
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
> +	strscpy(tup->console.name, "ttyUTC", sizeof(tup->console.name));
> +	tup->console.write	= tegra_utc_console_write;
> +	tup->console.device	= uart_console_device;
> +	tup->console.setup	= tegra_utc_console_setup;
> +	tup->console.flags	= CON_PRINTBUFFER | CON_CONSDEV | CON_ANYTIME;
> +	tup->console.data	= &tegra_utc_driver;
> +#endif
> +
> +	uart_read_port_properties(&tup->port);

No failure handling? In some cases it might return an error.

> +}

...

> +static int tegra_utc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct tegra_utc_port *tup;
> +	int ret;
> +
> +	tup = devm_kzalloc(&pdev->dev, sizeof(struct tegra_utc_port), GFP_KERNEL);

sizeof(*tup)

> +	if (!tup)
> +		return -ENOMEM;

> +	ret = of_property_read_u32(np, "tx-threshold", &tup->tx_threshold);

device_property_read_u32()

> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing tx-threshold device-tree property\n");
> +
> +	ret = of_property_read_u32(np, "rx-threshold", &tup->rx_threshold);

Ditto.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing rx-threshold device-tree property\n");

> +	tup->irq = platform_get_irq(pdev, 0);
> +	if (tup->irq < 0)
> +		return tup->irq;

uart_read_port_properties() does this for you.

> +	tup->soc = of_device_get_match_data(&pdev->dev);

device_get_match_data()

> +	tup->tx_base = devm_platform_ioremap_resource_byname(pdev, "tx");
> +	if (IS_ERR(tup->tx_base))
> +		return PTR_ERR(tup->tx_base);
> +
> +	tup->rx_base = devm_platform_ioremap_resource_byname(pdev, "rx");
> +	if (IS_ERR(tup->rx_base))
> +		return PTR_ERR(tup->rx_base);
> +
> +	tegra_utc_setup_port(&pdev->dev, tup);
> +	platform_set_drvdata(pdev, tup);
> +
> +	return tegra_utc_register_port(tup);
> +}

-- 
With Best Regards,
Andy Shevchenko


