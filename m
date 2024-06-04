Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52134144D23;
	Tue,  4 Jun 2024 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508568; cv=none; b=N2xcvVfvZArCPxsHCOUKes8lOL6iAtPLLQ942yEjnFQ8b2sGF0Z+X8O+OD/tN5LqqmFfX1wr8MsjNWExTwWEfecU/asa485gQ8VA62vUtukqFhobr5449Li3NHdc8eLYQU7rUL9bMRlcsenNmqYnu3hVTJdfs/IWod6MGIXRxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508568; c=relaxed/simple;
	bh=s9jorCC0Kz5QVXr/FMWGCkCEOFoEknLcEnB+NvHF23s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4gP3FXFcHsEobxjGOoavW4TGCCb6Se3Ps5DxwCogbncJJG2TUYxbDUseaUcIYpwgJ5amT6nrNGHvderZ4Z9NMxHs4X13UZdlw6cKEmQjqzRe5TR1SKG9zeYJDiBmWzx3Py1tFOq4E6ks4qsFESfFCI/7L9r6UKqnSC/4CXO+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: PrK6St7FTYOx/bEw+Yr86g==
X-CSE-MsgGUID: ggJlzeqTR3KJvi1NNYviDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13804447"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13804447"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:42:39 -0700
X-CSE-ConnectionGUID: 4glOrNphSqK1K7vVcaKRcw==
X-CSE-MsgGUID: wLNwisYiQpiheSKeXvd/NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37884952"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:42:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1sEUQs-0000000DZRW-0Ahy;
	Tue, 04 Jun 2024 16:42:34 +0300
Date: Tue, 4 Jun 2024 16:42:33 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lech.perczak@camlingroup.com
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
Message-ID: <Zl8ZyZ6ftvNTusFi@smile.fi.intel.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604132726.1272475-2-hui.wang@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 04, 2024 at 09:27:26PM +0800, Hui Wang wrote:
> Certain designs connect a gpio to the reset pin, and the reset pin

GPIO

> needs to be setup correctly before accessing the chip.
> 
> Here adding a function to handle the chip reset. If the reset-gpios is
> defined in the dt, do the hard reset through this gpio, othwerwise do

DT

> the soft reset as before.

...

> +static int sc16is7xx_reset(struct device *dev, struct regmap *regmaps[])
> +{
> +	struct gpio_desc *reset_gpiod;

> +	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (!reset_gpiod)
> +		/* soft reset device, purging any pending irq / data */
> +		regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
> +			     SC16IS7XX_IOCONTROL_SRESET_BIT);
> +	else if (!IS_ERR(reset_gpiod)) {
> +		/* delay 5 us (at least 3 us) and deassert the gpio to exit the hard reset */
> +		udelay(5);
> +		gpiod_set_value_cansleep(reset_gpiod, 0);
> +	} else
> +		return PTR_ERR(reset_gpiod);

You can do better here.

	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
	if (IS_ERR(reset_gpiod))
		return PTR_ERR(reset_gpiod);

	if (reset_gpiod) {
		/* delay 5 us (at least 3 us) and deassert the GPIO to exit the hard reset */
		fsleep(5);
		gpiod_set_value_cansleep(reset_gpiod, 0);
	} else {
		/* soft reset device, purging any pending IRQ / data */
		regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
			     SC16IS7XX_IOCONTROL_SRESET_BIT);
	}

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


