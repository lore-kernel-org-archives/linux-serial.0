Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7848EC68;
	Tue, 15 Sep 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478481; cv=none; b=Z+VwsHhGT5wYtHxSUTCsd+82pd8xDSEBsgKP6ChsW3NLxSSW2xsPxz0/rV41sSwPchSMWqRowqz2UD3D4FUEM75PRAcDRSxTQNTinmcPo5oecyqmxvQEmPOdyh0Jrw3nWeK186/Lp/xYl7s2cmFdncAdtpJIg7nRw4CB3eizkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478481; c=relaxed/simple;
	bh=bAV413W0oii9dQt3sDWvtF96rCyU8tAPKboiyRTjIcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3huh/hv372Qx4KKaYiU7VsLhmsTjDj00DUDgrUJyv2Is5WrWKoTgx4wQUyNNKMIQosXCNZsUHklc7jZQMOtnVz3q8eyqeFUDHuL+/c1LtNrUS9CJaYHMMe/HgmU61mD4whK4Hqv3Y6aNw47lSNwd6xQbC17PjbO/aqpfYXPlXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyHvQLuo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyHvQLuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789478481; x=1821014481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bAV413W0oii9dQt3sDWvtF96rCyU8tAPKboiyRTjIcY=;
  b=SyHvQLuoGeaFo+IEPuBs3GbcW0+pAuewvxe7DY/7uG8k/p+gTtNAnJmI
   DwhCPkuy1tcL+osMfwx5TIjLKBXv9eVY5RwAOY/zS5riBNHXwtg15eREs
   N+D5vdmI00k4K1TYD5oY6+XsWMFKh6L8KiS4ln+ndIGNzPVgW7rBg5oNy
   rxnwHbYB4xVb5ZdOMm/TXDuXgvY+pMuw+ZIiD1ba/KONr7gQeZHraCNgm
   A5of/bfDzL1AhwOPk71pMbjxcFXOQ61rcWlIlfpSRcMwyKP2erSrqDK4k
   0M11gYDpo88sU8wY+huHys9YVqKrVV3AV0i+lGcxc6v8mnNehT39pL/aQ
   Q==;
X-CSE-ConnectionGUID: ySXi+CdlRO2cBoFJV745iw==
X-CSE-MsgGUID: 9zWqPJWZTrq7ZLgeP3OsEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100164801"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100164801"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 06:21:21 -0700
X-CSE-ConnectionGUID: tO5gH38UQOuIzfyibc7Ggw==
X-CSE-MsgGUID: mimHhMWXTYmyC/Df3JH2pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268726193"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.57])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 06:21:14 -0700
Date: Tue, 15 Sep 2026 16:21:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 13/15] serial: 8250_dw: add Ambarella CV75 quirks
Message-ID: <aqlGSDVrd-k4mRjS@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-13-3297d3fbc9c0@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-cv75-v5-v7-13-3297d3fbc9c0@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 07:15:43PM +0800, Long Zhao via B4 Relay wrote:

> The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
> licensed block. At the register level it is close enough to DW APB UART
> that a full custom UART driver is unnecessary: reuse 8250_dw with a
> small platform quirk.
> 
> Quirks:
> - keep IER ETOI (bit 5) set for RX timeout behaviour
> - skip set_rate; baud clock is managed outside the UART block

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  static const struct of_device_id dw8250_of_match[] = {
> +	{ .compatible = "ambarella,cv75-uart", .data = &dw8250_ambarella_cv75_data },
>  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },

I assume we deliberately keep snps compatible to be the first, so your will be
the second. Update in case it will be v8 of the series.


-- 
With Best Regards,
Andy Shevchenko


