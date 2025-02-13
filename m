Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF409267B1C;
	Thu, 13 Feb 2025 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444746; cv=none; b=fGyJhKFcYpfY+/UHUta9LDRRRjglCle6gim8+8K08lK0+9n9baigg4sMmw01nZXZ+7eREcE89VMRXnbKQSswVYpCUvUFhkd19bIvSuJd9Z0TsD2kC4XclOFOmHl+BF6B++yZjbDgBElmhhn5hlSE0LrPGsNBRFGvteZiL3C8k3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444746; c=relaxed/simple;
	bh=u3jhAvzTfEh3CdzEn3BAjSF63/UVzzb34kvFb3VtIos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRmTE2B26lgundaXJ4UJlmFeHMyaw0/FoFDEpL13idm0zAr6nVl184ta78uNiBAuH0UgMObJa8NJxxw2cIc52g9xbfhHjZywTY8J+SQX+tvc/paYIFKtN+nv90ExQVa/VPSMh2YDafFKq7rAiwZM7AZyQy7adtcg+qzpcqJgkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyW+u0qL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyW+u0qL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739444745; x=1770980745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u3jhAvzTfEh3CdzEn3BAjSF63/UVzzb34kvFb3VtIos=;
  b=eyW+u0qLewW4A6bDhLLh4JFhmGzofLoGdrs4UA2msi9UeFhfXB4rWceh
   V3e39QizHbvXVn7gh6Qd3sAC6DmEWWE6mGqRti32PYZ8gfZZl4mAQbCgb
   BRMlec5YvL3muZeMRwqLsnjycbWHmFLtNOnXiCgkx7m6rOsQhgkj8HBHN
   zXWRjdtQZDsBrq7/hK+LNWOI6jLUxL+o8PRBvVB4o7jKqaAPq9gsD9vFI
   5dYHrgprK9H8An+WmCH7td+OpISG5eEFG/f1+mTXh0MwWe253DYMG7uwT
   z9iaRmiUMV2lYOZstMXdMw/yizpJSH4ixOrrC7MSlZM1US1+SNT/zid6a
   Q==;
X-CSE-ConnectionGUID: ZsTqD4jCS+2WBWZOQv6Iiw==
X-CSE-MsgGUID: 1U4e5sFnREeHx9nm8qrt6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="42976571"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="42976571"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 03:05:44 -0800
X-CSE-ConnectionGUID: P128WeynQ/WkMPJRXWsfcw==
X-CSE-MsgGUID: ETfIGN2oS7CuNCAvKhDUjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112978940"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 03:05:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiX2G-0000000B8rH-2sEK;
	Thu, 13 Feb 2025 13:05:36 +0200
Date: Thu, 13 Feb 2025 13:05:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hvilleneuve@dimonoff.com, arnd@kernel.org,
	geert+renesas@glider.be, robert.marko@sartura.hr,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z63SAPtHXR6KN9qa@smile.fi.intel.com>
References: <20250213100442.45773-1-kkartik@nvidia.com>
 <20250213100442.45773-3-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213100442.45773-3-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 03:34:42PM +0530, Kartik Rajput wrote:
> The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
> multiple firmware clients (up to 16) to share a single physical UART.
> Each client is provided with its own interrupt and has access to a
> 128-character wide FIFO for both transmit (TX) and receive (RX)
> operations.
> 
> Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
> client.

Btw, neither the commit message nor cover letter explain why the new driver
is needed. There are some serial Tegra drivers already. Is this one completely
different from the existing drivers?

...

> +#define TEGRA_UTC_ENABLE			0x0

It would be nice to use fixed width values for the register offsets,
e.g., 0x000 here.

> +#define TEGRA_UTC_ENABLE_CLIENT_ENABLE		BIT(0)
> +
> +#define TEGRA_UTC_FIFO_THRESHOLD		0x8
> +
> +#define TEGRA_UTC_COMMAND			0xc

Ditto.

> +#define TEGRA_UTC_COMMAND_RESET			BIT(0)
> +#define TEGRA_UTC_COMMAND_FLUSH			BIT(1)

> +#define TEGRA_UTC_DATA				0x20

Ditto.

> +#define TEGRA_UTC_FIFO_STATUS			0x100
> +#define TEGRA_UTC_FIFO_EMPTY			BIT(0)
> +#define TEGRA_UTC_FIFO_FULL			BIT(1)
> +#define TEGRA_UTC_FIFO_REQ			BIT(2)
> +#define TEGRA_UTC_FIFO_OVERFLOW			BIT(3)
> +#define TEGRA_UTC_FIFO_TIMEOUT			BIT(4)
> +
> +#define TEGRA_UTC_FIFO_OCCUPANCY		0x104
> +
> +#define TEGRA_UTC_INTR_STATUS			0x108
> +#define TEGRA_UTC_INTR_SET			0x10c
> +#define TEGRA_UTC_INTR_MASK			0x110
> +#define TEGRA_UTC_INTR_CLEAR			0x114
> +#define TEGRA_UTC_INTR_EMPTY			BIT(0)
> +#define TEGRA_UTC_INTR_FULL			BIT(1)
> +#define TEGRA_UTC_INTR_REQ			BIT(2)
> +#define TEGRA_UTC_INTR_OVERFLOW			BIT(3)
> +#define TEGRA_UTC_INTR_TIMEOUT			BIT(4)

...

> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_UTC_CONSOLE)
> +#define TEGRA_UTC_DEFAULT_FIFO_THRESHOLD	0x4

Hmm... Is this a register offset? If not, why it's in a hexadecimal format?

> +#define TEGRA_UTC_EARLYCON_MAX_BURST_SIZE	128

...

> +static int tegra_utc_probe(struct platform_device *pdev)
> +{
> +	const unsigned int *soc_fifosize;
> +	struct device *dev = &pdev->dev;
> +	struct tegra_utc_port *tup;
> +	int ret;
> +
> +	tup = devm_kzalloc(&pdev->dev, sizeof(*tup), GFP_KERNEL);

Use dev?

> +	if (!tup)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32(dev, "tx-threshold", &tup->tx_threshold);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing %s property\n", "tx-threshold");
> +
> +	ret = device_property_read_u32(dev, "rx-threshold", &tup->rx_threshold);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing %s property\n", "rx-threshold");
> +
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

> +	ret = tegra_utc_setup_port(&pdev->dev, tup);

Ditto.

> +	if (ret)
> +		dev_err_probe(dev, ret, "failed to setup uart port\n");
> +
> +	platform_set_drvdata(pdev, tup);
> +
> +	return tegra_utc_register_port(tup);
> +}

...

With the above being addressed, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


