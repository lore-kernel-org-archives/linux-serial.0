Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89018C31;
	Wed, 29 Jan 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134861; cv=none; b=lQrpJ+mR3tZPoId8tUZBdz9G5xNuVQtG3pfVk5RU7Py/bIiLthcCUpYM2rHr+XdLsd5XZViItXWdZ7Pxsq3gIHHZMJDxNMCJJYHPlQ7Uf6GooI8fES8w5Baw0nKe8uilxZxkC/HidTyB3SHeSXcaQNVLe5enPYpLEylvpgPgdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134861; c=relaxed/simple;
	bh=q2fZTrf+p76HbbhOg0Lfy3JFC8YSrP6AIb0gvUBhDPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF99jmEba0+IDPLCg4R5OZv+VJ1qxy1WzX/oU4w3sUlsP2V9VvFTcuOHtTSL5QRD7PoGjUGZ5LC1A6c5XjS2Dkmbd7RpOFlLfAe51wQd+aGK2/I4dRz6UrRDkRNlfqjvcpvteVFL/fv1t1oYXlTFjmM//RzTB/TB3AbeHVFDoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fxj2WebV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fxj2WebV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738134860; x=1769670860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2fZTrf+p76HbbhOg0Lfy3JFC8YSrP6AIb0gvUBhDPQ=;
  b=Fxj2WebVqeWkOW3do1gu+bfOQwukF6A9GczR7vNejYgsdI/QLhgaOUD3
   0n9AbGSucB/johW0j7KqNOJcm09Y3Jep/Uzh3LcMPtETep/cVTMsA7JS0
   RueobO4ioG8aAA48n0EJuXLl8kQIGKR4BCVDGz8jT7oXa5SOo66p2GmOy
   +2S8Hvu5JF2dnuIYy+YmEWn0Jtq8vzRnFG3ab3X/5ja2We25H4ryAL4H+
   itWKPw5UsyDJ2eJbvGMN+mTdlh759eZupOM89zeEMKmWi7IhAGWcadRrB
   k/A3f7UYoGpEJs1ZP7VKPL/HXhXuYK7GlaLGxQ5+ZnHuGSY6Ke69MMXQk
   Q==;
X-CSE-ConnectionGUID: XY5HcmqCRbisI0nSHmAz1w==
X-CSE-MsgGUID: u/W8PCqqRCqaaq/Kz71UVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="56063559"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="56063559"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 23:07:18 -0800
X-CSE-ConnectionGUID: lQJssghITJeIx0dTqI9b3A==
X-CSE-MsgGUID: yczFgM7ISj2LG9DDHeTbMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="109530878"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 23:07:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1td2AF-00000006Irk-1ebN;
	Wed, 29 Jan 2025 09:07:07 +0200
Date: Wed, 29 Jan 2025 09:07:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hvilleneuve@dimonoff.com, arnd@kernel.org,
	geert+renesas@glider.be, robert.marko@sartura.hr,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: tegra-utc: Add driver for Tegra UART Trace
 Controller (UTC)
Message-ID: <Z5nTm9UniwCgGNOY@smile.fi.intel.com>
References: <20250128064633.12381-1-kkartik@nvidia.com>
 <20250128064633.12381-3-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128064633.12381-3-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 28, 2025 at 12:16:33PM +0530, Kartik Rajput wrote:
> The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
> multiple firmware clients (up to 16) to share a single physical UART.
> Each client is provided with its own interrupt and has access to a
> 128-character wide FIFO for both transmit (TX) and receive (RX)
> operations.
> 
> Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
> client.

...

> +static int tegra_utc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct tegra_utc_port *tup;
> +	int index;
> +	int ret;
> +
> +	index = of_alias_get_id(np, "serial");
> +	if (index < 0) {
> +		dev_err(&pdev->dev, "failed to get alias id, err %d\n", index);
> +		return index;
> +	}

Can we please use uart_read_port_properties() instead of open-coding everything
again and again?

> +	tup = devm_kzalloc(&pdev->dev, sizeof(struct tegra_utc_port), GFP_KERNEL);
> +	if (!tup)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32(np, "current-speed", &tup->baudrate);

Why not clock-frequency? But if needed, add this to the above mentioned API as
I know more than one driver may utilise this.


> +	if (ret) {
> +		dev_err(&pdev->dev, "missing current-speed device-tree property\n");

With

	struct device *dev = &pdev-dev;

this and other lines will be neater.

> +		return ret;

		return dev_err_probe(...);

> +	}
> +
> +	ret = of_property_read_u32(np, "nvidia,utc-fifo-threshold", &tup->fifo_threshold);
> +	if (ret) {
> +		dev_err(&pdev->dev, "missing nvidia,fifo-threshold device-tree property\n");
> +		return ret;
> +	}
> +
> +	tup->irq = platform_get_irq(pdev, 0);
> +	if (tup->irq < 0) {

> +		dev_err(&pdev->dev, "failed to get interrupt\n");

Dup. This error report is done by the above API.

> +		return tup->irq;
> +	}

> +	tup->soc = of_device_get_match_data(&pdev->dev);

> +	tup->tx_base = devm_platform_ioremap_resource_byname(pdev, "tx");
> +	if (IS_ERR(tup->tx_base))
> +		return PTR_ERR(tup->tx_base);
> +
> +	tup->rx_base = devm_platform_ioremap_resource_byname(pdev, "rx");
> +	if (IS_ERR(tup->rx_base))
> +		return PTR_ERR(tup->rx_base);
> +
> +	tegra_utc_setup_port(&pdev->dev, tup, index);
> +	platform_set_drvdata(pdev, tup);
> +
> +	return tegra_utc_register_port(tup);
> +}

...

> +static const struct of_device_id tegra_utc_of_match[] = {
> +	{ .compatible = "nvidia,tegra264-utc", .data = &tegra264_utc_soc },
> +	{},

No comma for the terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko


