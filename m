Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084061;
	b=XjGPnu0RRhi8s29vm8P9ChE2idta3tap9SDoAUFsRZIrMeiMr670G6NqMcIfIvmURJ92
	 CjW4N3GnMPMcwTH5H7jGgkSNDM1pMRQLT3Tjtuw3X8LXsWY4PDrr6u4/gLWWQKzOdnpSW
	 un9e+HcJBNtGzfQshA8DZ0zWaLDOWdL9C6ume9Yr0ZI/jJX5g84Y3ZkfhUJlHVkP8diuF
	 fAXulZHqeMuiHoZPOFL+L+wX6krAgIzIgnru3ZAwCr+Y+Dj5nRMIpxX9veLoRBqQsLgta
	 AnImk0+17JSPNlZVcc88Q9S4VTE0tPag+KDXdX0TYHHQN7deunAj3cyiSlgCk3R6PZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084061;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kV4jEv5sJ1fhwruuECh2r7bZz8ZxIRz2IHxBzvIfK/w=;
	b=iavm6LXtlN/iKssUTHhNurIYMLIdL1Gvl/dJkaSjIYSfmmLBQHeXRBxcv3Ux0TxpCt5r
	 9jjPjHwGGIfHBtJMP8tlDlFWM+MEynMfT4lv0Tjmmcuvpm0z/CWHBB7oAgV8qLtWX6VPc
	 NVGOvNqhCx2zUQYXcjjRbha6QYUefLPVNBzKpY3Ux4t09emjj+10HM6Qk+lidB0loYW6i
	 c6fOalbTI1nFg7gVOsB775ufajurMM2Hu6aMCjo6DcauumX8DtLnxbd0j5/iQj1pVjva5
	 71PjnchBC+4pvMBxXsN5184cmE+mriJpRz1d5P3/mZ35BLedRSCHojB4D+ypG+CL2HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJvjNvX2;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47862606A321;
	Tue, 27 Oct 2026 06:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47862606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJvjNvX2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793084060; x=1824620060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E54gxf4saca+RBeymUGcrO5/xiigxNpKbUqIJy908ig=;
  b=KJvjNvX2cw/ulcmwTLoCVqh3MGvfwbS3O5dXGeEhXyAPQLFCMK80z51s
   +6DfRmjmylEeb1f19P97j7GVMMjIyUCfekFxDvIeBwXIPPf7lTjdmnqSl
   U0xwcsDE6nFl6Yd3TBIvbb1WZWD4Q1HCYd2+eMHYRQLLND0QTwM6Y9DRB
   JFco9JWAuPxJpmUg7dhn5IOhBaJ4HbuSvq/BrFH/pQQEsx4SN00NdrpXh
   pagPx89EYUv8e+OQnd6wk3SN3Et1gxkk62qa672545epEkJN9XHplFqVD
   J1ipYA97n6g+ylVfQH2+Ke/x5Jc9DOmjXna+KX5Jexa2mnTrxpiTtQMCe
   g==;
X-CSE-ConnectionGUID: A3DD1MdwRKiuC8r42Dk5Zw==
X-CSE-MsgGUID: FLUP9v8HSZqg5gCDK27Uhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1798035"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1798035"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 23:54:19 -0700
X-CSE-ConnectionGUID: cEV2pnl5QWexlm2/6h19Ug==
X-CSE-MsgGUID: gXby9iudRf2Fmsjfa53UKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4865007"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 23:54:17 -0700
Date: Tue, 27 Oct 2026 08:54:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 1/4] serial: 8250_dw: select port setup through
 platform data
Message-ID: <auBKlohJi7TV9uq3@ashevche-desk.local>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-1-286fc1b8c3c1@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-1-286fc1b8c3c1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 02:22:23PM -0600, James Hilliard wrote:
> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered.
> 
> Replace skip_autocfg with the Octeon setup selection. On 64-bit builds,
> Octeon continues to skip optional-register probing while retaining its DMA
> setup; on 32-bit builds it retains the generic setup. Keep generic setup
> for devices without matched platform data as well.

...

> +static void dw8250_setup_dma(struct uart_port *p)
> +{
> +	struct dw8250_data *data = to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up = up_to_u8250p(p);

> +	/* If we have a valid fifosize, try hooking up DMA */
> +	if (p->fifosize) {

This can be written now as

	/* We can't setup DMA when there is no FIFO defined */
	if (!p->fifosize)
		return;

> +		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
> +		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
> +		up->dma = &data->data.dma;
> +	}
> +}

...

> +	if (data->pdata) {
> +		if (data->pdata->setup)
> +			data->pdata->setup(p);

Do we have users for this case, when pdata is defined and no setup is provided?
What I see, we may default it to dw8250_setup() and drop a lot of assignments
below.  Otherwise those special cases can add an empty stubs, which in my opinion
will be cleaner solution.

> +	} else {
> +		dw8250_setup(p);
>  	}

...

>  static const struct dw8250_platform_data dw8250_octeon_3860_data = {
>  	.usr_reg = OCTEON_UART_USR,
>  	.quirks = DW_UART_QUIRK_OCTEON,
> +#ifdef CONFIG_64BIT
> +	.setup = dw8250_setup_dma,
> +#else
> +	.setup = dw8250_setup,
> +#endif

I'm wondering if we can do something at runtime with these ugly ifdef:s
(yes, it's a preexisted inconvenience).

>  };

-- 
With Best Regards,
Andy Shevchenko


