Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E51211276;
	Wed, 12 Feb 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372998; cv=none; b=rw2shQa+oFloqsqcM1X8Njz8vDe2z+662FxvOUN4x7P8uV/Kl53EenixDUcbifjyn1QsfqgqXyNUraaU8BM4KhAzZoLBUEXr7slDgcYlxa2Ga5adMJUMMBbk5edMd9wk+k6epuMBkDYJikZpLUl71smYIHyD+ZjNt9ehRws6htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372998; c=relaxed/simple;
	bh=V9cYHTBHlxp0mj0yzBd78kjLBKIcJazGxvhjpg7B2Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoAuPR9/srMy149Y/r5g9PTSmUFYYpEtIaajgl087iW6YnUKBxcnXqLCA02c+p8z8oSr+UsC1CqGWx6tQ1pLIJaeFC/7qGgcCxgKEYIoRfkVjm8qquDMc0ZlPEvxTXBeWThbw1VuOR42/1Wpc20t4nFh9t+bbXOSTPki4S2V3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4ESI5nM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4ESI5nM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739372997; x=1770908997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V9cYHTBHlxp0mj0yzBd78kjLBKIcJazGxvhjpg7B2Ec=;
  b=l4ESI5nMavKgIHWFsxG7T3hsRYppOx1ocAdOOK1+Q7Qy43W48iKXyt4k
   WybTncKLmG6f2xyH93oIzW81ivVlfKGbxcZh8Tc4/cJR66oEh+ci+Xyia
   MQ7mtzbvH4C8L7HDtrZHN8nn4wP5rfbvDbTMupyPsBd+rrZx6oZDl6NTO
   ebI4nfrQEcQe2JB1OCxSSeLElsvDMSDOu+10FIlZEyb/uPht/DxFzmhCX
   lWnFE7RtCHBD8yfxL4c85yoJwXMPNPtG3TwgBwtLoe1/2BP/3hIyiW0uf
   dtZaSu0TYWK5LDEjbs0SbxDfgwLSMi1IDgeCHdaqnOq6VyzEo4nbbzGvF
   A==;
X-CSE-ConnectionGUID: GbdIhUefRZCfKgSHu/lLIw==
X-CSE-MsgGUID: +3QNuzJYQnq+iDbsXZXGJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51428116"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="51428116"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 07:09:56 -0800
X-CSE-ConnectionGUID: hHmx6jl3SBS3vZ7cUSkE2w==
X-CSE-MsgGUID: rT9bbs6LQzKvmJ6cgaz9iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116970329"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 07:09:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiEN3-0000000As2N-35AY;
	Wed, 12 Feb 2025 17:09:49 +0200
Date: Wed, 12 Feb 2025 17:09:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hvilleneuve@dimonoff.com, arnd@kernel.org,
	geert+renesas@glider.be, robert.marko@sartura.hr,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z6y5vRGyouZsQWyj@smile.fi.intel.com>
References: <20250212104132.61060-1-kkartik@nvidia.com>
 <20250212104132.61060-3-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212104132.61060-3-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 04:11:32PM +0530, Kartik Rajput wrote:
> The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
> multiple firmware clients (up to 16) to share a single physical UART.
> Each client is provided with its own interrupt and has access to a
> 128-character wide FIFO for both transmit (TX) and receive (RX)
> operations.
> 
> Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
> client.

...

> +/*
> + * NVIDIA Tegra UTC (UART Trace Controller) driver.
> + */

Can be a single line.

...

> +#include <linux/bits.h>
> +#include <linux/console.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/err.h>

> +#include <linux/io.h>
> +#include <linux/iopoll.h>

iopoll.h guarantees to include io.h in case you want to have less lines here.
(yeah, I know that the header guarantees is a tribal knowledge, it's undocumented)

> +#include <linux/kfifo.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>

> +#include <linux/of.h>

Is this being used now?

> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/types.h>

...

> +#define UART_NR					16

Bad naming, calling for collisions. Move it to the driver's namespace.

...

> +static void tegra_utc_init_tx(struct tegra_utc_port *tup)
> +{
> +	/* Disable TX. */
> +	tegra_utc_tx_writel(tup, 0x0, TEGRA_UTC_ENABLE);
> +
> +	/* Update the FIFO Threshold. */
> +	tegra_utc_tx_writel(tup, tup->tx_threshold, TEGRA_UTC_FIFO_THRESHOLD);
> +
> +	/* Clear and mask all the interrupts. */
> +	tegra_utc_tx_writel(tup, TEGRA_UTC_INTR_REQ | TEGRA_UTC_INTR_FULL | TEGRA_UTC_INTR_EMPTY,
> +			    TEGRA_UTC_INTR_CLEAR);

Here...

> +	tegra_utc_disable_tx_irq(tup);
> +
> +	/* Enable TX. */
> +	tegra_utc_tx_writel(tup, TEGRA_UTC_ENABLE_CLIENT_ENABLE, TEGRA_UTC_ENABLE);
> +}
> +
> +static void tegra_utc_init_rx(struct tegra_utc_port *tup)
> +{
> +	tup->rx_irqmask = TEGRA_UTC_INTR_REQ | TEGRA_UTC_INTR_TIMEOUT;
> +
> +	tegra_utc_rx_writel(tup, TEGRA_UTC_COMMAND_RESET, TEGRA_UTC_COMMAND);
> +	tegra_utc_rx_writel(tup, tup->rx_threshold, TEGRA_UTC_FIFO_THRESHOLD);
> +
> +	/* Clear all the pending interrupts. */
> +	tegra_utc_rx_writel(tup, TEGRA_UTC_INTR_TIMEOUT | TEGRA_UTC_INTR_OVERFLOW |
> +			    TEGRA_UTC_INTR_REQ | TEGRA_UTC_INTR_FULL |
> +			    TEGRA_UTC_INTR_EMPTY, TEGRA_UTC_INTR_CLEAR);

...and here the potential of deduplication by introducing an additional constant:

#define TEGRA_UTC_INTR_COMMON	\
	(...)

(choose better name)

> +	tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_MASK);
> +	tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_SET);
> +
> +	/* Enable RX. */
> +	tegra_utc_rx_writel(tup, TEGRA_UTC_ENABLE_CLIENT_ENABLE, TEGRA_UTC_ENABLE);
> +}

...

> +static bool tegra_utc_tx_chars(struct tegra_utc_port *tup)
> +{
> +	struct uart_port *port = &tup->port;
> +	unsigned int pending;
> +	u8 c;
> +
> +	pending = uart_port_tx(port, c,
> +		     !(tegra_utc_tx_readl(tup, TEGRA_UTC_FIFO_STATUS) & TEGRA_UTC_FIFO_FULL),
> +		     tegra_utc_tx_writel(tup, c, TEGRA_UTC_DATA));

Make the last two to reside in temporary variables with self-explanatory names.

> +

Redundant blank line.

> +	if (pending)
> +		return true;
> +
> +	return false;

	return pending;

> +}

...

> +static int tegra_utc_startup(struct uart_port *port)
> +{
> +	struct tegra_utc_port *tup = container_of(port, struct tegra_utc_port, port);
> +	int ret;
> +
> +	tegra_utc_hw_init(tup);
> +
> +	ret = request_irq(port->irq, tegra_utc_isr, 0, dev_name(port->dev), tup);

Seems the same Q stands about sharing, perhaps a comment why it's expected to
be always exclusive?

> +	if (ret < 0)
> +		dev_err(port->dev, "failed to register interrupt handler\n");
> +
> +	return ret;
> +}

...

> +	for (i = 0; i < len; i++) {
> +		if (!nbcon_enter_unsafe(wctxt))
> +			break;
> +
> +		read_poll_timeout_atomic(tegra_utc_tx_readl, val, !(val & TEGRA_UTC_FIFO_FULL),
> +					 0, USEC_PER_SEC, false, tup, TEGRA_UTC_FIFO_STATUS);

No error check?

> +		uart_console_write(&tup->port, wctxt->outbuf + i, 1, tegra_utc_console_putchar);
> +
> +		if (!nbcon_exit_unsafe(wctxt))
> +			break;
> +	}

> +

Unneeded blank line.

> +}

...

> +static int tegra_utc_probe(struct platform_device *pdev)
> +{
> +	const unsigned int *soc_fifosize;
> +	struct device *dev = &pdev->dev;
> +	struct tegra_utc_port *tup;
> +	int ret;
> +
> +	tup = devm_kzalloc(&pdev->dev, sizeof(*tup), GFP_KERNEL);
> +	if (!tup)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32(dev, "tx-threshold", &tup->tx_threshold);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing tx-threshold device-tree property\n");

' device-tree' is redundant part.

> +	ret = device_property_read_u32(dev, "rx-threshold", &tup->rx_threshold);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing rx-threshold device-tree property\n");

Ditto.

Also in a form of

		return dev_err_probe(dev, ret, "missing %s property\n", "rx-threshold");

in both cases the size of the object file will be smaller by a couple of dozens
of bytes.

> +	soc_fifosize = device_get_match_data(&pdev->dev);
> +	tup->fifosize = *soc_fifosize;
> +
> +	tup->tx_base = devm_platform_ioremap_resource_byname(pdev, "tx");
> +	if (IS_ERR(tup->tx_base))
> +		return PTR_ERR(tup->tx_base);
> +
> +	tup->rx_base = devm_platform_ioremap_resource_byname(pdev, "rx");
> +	if (IS_ERR(tup->rx_base))
> +		return PTR_ERR(tup->rx_base);
> +
> +	ret = tegra_utc_setup_port(&pdev->dev, tup);
> +	if (ret)
> +		dev_err_probe(dev, ret, "failed to setup uart port\n");
> +
> +	platform_set_drvdata(pdev, tup);
> +
> +	return tegra_utc_register_port(tup);
> +}

...

> +static int __init tegra_utc_init(void)
> +{
> +	int ret;
> +
> +	ret = uart_register_driver(&tegra_utc_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&tegra_utc_platform_driver);
> +	if (ret) {
> +		uart_unregister_driver(&tegra_utc_driver);

> +		return ret;
> +	}
> +
> +	return 0;

Just

	return ret;

will be good instead of the above 4 LoCs.

> +}

-- 
With Best Regards,
Andy Shevchenko


