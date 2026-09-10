Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07E3909BF;
	Thu, 10 Sep 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029204; cv=none; b=oACMIu50wxXefSMGTRXMopuX84IyDkMM+eKO9xgwyWvyf+Gvx8tbiKplSghTfoPbIcTeBJg8A+xUV50hyPoPvzfqocPImqmT99MtslWjodGM21xxIH7dRsEoA3O9wimg2bVo0qiOzvAXngAWVSayj1hxyqQwt0v/zWdzumMN80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029204; c=relaxed/simple;
	bh=crIMr6lHdYoc1yLpuiNmToTTcqtQKMa63bcOTy3RX10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVd3sMBBK9Ux5+HIwgigXnChwdHyiN1xNeyd6mub5FTZWA5d7TQxV04xC/eTiI82cH50H62deyrY7aADzoxmuPAiR9oQ2pAfZ+I3yH7njQ2qPFhxecC3DqHo1ROuBbpNFdAfd/4Byk5Kk6U+hxWR1pCJUboHpCRF3cbsD49MuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRCJgTm6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRCJgTm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789029203; x=1820565203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crIMr6lHdYoc1yLpuiNmToTTcqtQKMa63bcOTy3RX10=;
  b=aRCJgTm67CKlIkl0u5PqJMuc5YAQRGmMNTNtvPP5M4RgSLh8ZQeK0HC5
   1C+CdqXKxjEbXoo3c3z3QIYTUoIAJgtVeJfCDEt4ZqDDGQjacCx7nUl/4
   HfVg1mXq7p8e4GM7SKCA7JCo4cyL88wmdoy8q7lXvb09EvRTxj5cfJW6K
   dy505MOBBakF67oViF1P0njWJOJpitRaHN2liFtWsgxjKJn0hO6SKo/lU
   eSKKrHfLFOaTf2TT4coTUqmnbQ285E7BGGXHnvEKHvHo5EH1FpXsUJ1bP
   5YcdlBODGv+wMHevkgDtA7zIcRRW35+sSL+Jl83ZVesZSMF+LydGq0zFY
   Q==;
X-CSE-ConnectionGUID: 9+0mWm1DRL6Q0+6t7w2ifg==
X-CSE-MsgGUID: FVhS285rTJOIG3u39eHNbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106987301"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="106987301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 01:33:21 -0700
X-CSE-ConnectionGUID: fl6KbBSZRvekShUjRPDzhw==
X-CSE-MsgGUID: xoSe0ZbyT8KlKM8Xu0u95g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="267873193"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 01:33:16 -0700
Date: Thu, 10 Sep 2026 11:33:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
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
Subject: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75 quirks
Message-ID: <aqJrSnr0rwv4BOJ3@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 02:38:18PM +0800, Long Zhao via B4 Relay wrote:

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

> +static int dw8250_ier_mask_startup(struct uart_port *p)
> +{
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +	int ret;
> +
> +	ret = serial8250_do_startup(p);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
> +	 * timeout behaviour. Force them into the 8250 IER shadow so later
> +	 * generic IER updates do not clear them.
> +	 */

Wondering if we should undo this in the port's .shutdown() callback.

> +	up->ier |= d->pdata->ier_mask;
> +	serial_port_out(p, UART_IER, up->ier);
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


