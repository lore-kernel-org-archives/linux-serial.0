Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE97155325;
	Fri, 24 Jan 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731359; cv=none; b=BBO8h+ZAhjH6P4gT7H83Ybo+s2/u8Qj0833rcjQrhQkGw9ZiEHDPt0Bqv4Lm8z6yJozkRgG0wDiFN32YLZZRdNBU3hiEK1ItsR9NvT7R1PPHRT+zmBjM0zuuCquJGygz5mMfCfQhK2x82CH8eSSDlK9cF/zjlgo6n9rXXLd2688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731359; c=relaxed/simple;
	bh=nu5L0oHkKO/XvEtpmpggRMODnIIoAWZ2OPQcpyBS/x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATI7JtQfThl0V3LNkeCNzitcJbfqD3yvawGwEb9woNJ/KqpMydDszb1Th+yqe0kI4CRLyOy4CLeuLVmTgtHYm88AGMW3WYyVfe9DaYnJ2aLHD4dvAyx/DMKQHZXm791sLQHqPAF5mlTynaU0PJCs3+OvNmtlC0gHcEm15LE4SyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiM0s3nZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiM0s3nZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737731358; x=1769267358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nu5L0oHkKO/XvEtpmpggRMODnIIoAWZ2OPQcpyBS/x8=;
  b=QiM0s3nZzI6Gbt6BrPIVA/ui1O4o3Lxuvmqu05M3sVzPZ7pLYGDnBjy9
   +V07nknvMxrdvGOHSUlV8hmyUsuLZpIdbcwODVfBMITJH2oCLAqCdOElT
   8URFiaHsr/qA748hS/17Em4Q3IhEFdC/DC1vUIk4pBQnfi7TaRD2pmPUo
   Q3hZik5l6mcgQqB3xJhSWHsLuLbXDOYlujpTwpKOdxDgjsScDR3XOieyj
   vsLZElFyz1/ln86/VxYWQdIN+J9GVLEu3c0zR87oX3ccKQnh+RGhm1cPM
   cVqvXXZmJ/ytk+Amn3RDjNGAdmtFz7F83fRPwCAcPm2yIDl0pZGhz/QKS
   Q==;
X-CSE-ConnectionGUID: 245y7rFlQiCmhFQzI9fXsg==
X-CSE-MsgGUID: YH+BQRhvQIO0N07xPDZ/pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48773113"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="48773113"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 07:09:17 -0800
X-CSE-ConnectionGUID: FGtdc2FbRdObUS8rE2/eYQ==
X-CSE-MsgGUID: QpmEVMWQQXS0uR6y2gE0SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="131087548"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 07:09:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tbLJ0-00000004qdD-3BFn;
	Fri, 24 Jan 2025 17:09:10 +0200
Date: Fri, 24 Jan 2025 17:09:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	yj.chiang@mediatek.com, tbergstrom@nvidia.com,
	treapking@chromium.org, u.kleine-koenig@baylibre.com,
	yujiaoliang@vivo.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] serial: 8250_mtk: Add ACPI support
Message-ID: <Z5OtFqtf4dpvvc9v@smile.fi.intel.com>
References: <20250124031835.1788995-1-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124031835.1788995-1-yenchia.chen@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 24, 2025 at 11:18:32AM +0800, Yenchia Chen wrote:
> Add ACPI support to 8250_mtk driver. This makes it possible to
> use UART on ARM-based desktops with EDK2 UEFI firmware.

...

> +#include <linux/acpi.h>

This will not be needed (see below)

>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -15,6 +16,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>

> +#include <linux/units.h>

This might not be needed either (see below)

>  #include <linux/console.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/tty.h>

You probably want to sort header inclusions first for easier maintenance and
feature additions like this one.

Can you add that one?

...

> +	} else if (!acpi_dev_handle) {

> +	}

This should look like

	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
	...
	if (is_of_node(fwnode)) {
		...parse OF...
	} else if (!fwnode) {
		return -ENODEV;
	}

...

>  	uart.port.uartclk = clk_get_rate(data->uart_clk);
> +	if (!uart.port.uartclk)
> +		uart.port.uartclk = 26 * HZ_PER_MHZ;

Why doesn't your table provide the clock-frequency property?

What I expect to see is the use of uart_read_port_properties().

...

>  #ifdef CONFIG_SERIAL_8250_DMA
>  	if (data->dma)
>  		uart.dma = data->dma;
>  #endif

Btw, how do you handle DMA in ACPI case?

...

> -	/* Disable Rate Fix function */
> -	writel(0x0, uart.port.membase +
> +	if (!acpi_dev_handle) {
> +		/* Disable Rate Fix function */
> +		writel(0x0, uart.port.membase +
>  			(MTK_UART_RATE_FIX << uart.port.regshift));
> +	}

	if (is_of_node()) {
		...
	}

...

> +static const struct acpi_device_id mtk8250_acpi_match[] = {
> +	{ "MTKI0511", 0 },

No ', 0' part, please.

> +	{},

No comma in the terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko


