Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185536;
	b=BcyAnnC9Omj98eyP8H0l1LdVJu8m88RBfpR3bYhKVQ26V5B7DkLwR3z+Abbg4cBb/Z7R
	 HsJuFvYhlBWUb2wWDJ8I7/n+xdvZJPXfwuFbu0ECeLhomnyf3zV/Wz++NUOB8FXsXhdoH
	 rpYC+hhmZrNx49O3w0FIEbHsRPZjfzNjTSpWo5mz0YMc4J7spw8c1sYHv2gKWw8m3IPiX
	 qmbMKpeYbFUPDt8FSiMFC5NHJIDWoEI6iP1mFF8S7GNxKniUZyZJkn6qdw/q2z6ZtBAVU
	 ikmgvXcBpj+5sVXZDuUgmeKnN/X9MT97n08A9nsCQvqghn3bZWNSR0U2+iCH+PjiZRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185536;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SIbHIkb59pVcJng8sKHppF6ubVcQlFLsBLXS2eUuU34=;
	b=otJU0Hebd9hsk5PL55LlPId4jD1xeG0eqeeiDFr+u5zyaLDmmg+JSlr1N+E0FxDj8oba
	 JAL75mEgRY4BFckRr4E6vhvqCHLbJTBI+24T0GChGX9R2tyL+13nK4JyUB7dr+QePunHC
	 QRDCy3t9PbEnw8sGK3z6Y54cjhgHd1a4124EPwlj3J2zwMeoXlt6zj3ZR6RW+Zcr93ssj
	 RkCQxktIMgOveXEfgAJlU0fANUjH//cL4D+aAlGpDa4+RgQkYdjMYx9EwQrN+7LFbYTJh
	 rRa1WbSqSC11u+rFk5GXhnovmvQUsgrnZ3qLsXA7Ag/nPx7Iqin0kv3pBRFkK4B7uHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kNfg2tbk;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06395606A31A;
	Wed, 28 Oct 2026 11:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06395606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kNfg2tbk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793185535; x=1824721535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WX9L8EGH4Oa0aoSnq/yMQj4iV1Wl9LjJdHrn7K6+r08=;
  b=kNfg2tbkeBmEZ3FkWPr8LYjfGqlgWSdB8abutFhf+gdGwx7dS4Im1DV3
   qVsDKEWDIfb+X6A7GcmHtCpVgYM6TlEe6ehpMtuFyi4uzS7RLtyuS0k0b
   2fuC5QlmFig5uJCACucoiqwTtefHOm+XqavGzyiURI/YRA2cZwNAo89WY
   LqJO0r0RT6+culU0YC49iIAwsm0oOcWMo7FM8C6njR3YXjFAqnWuwTXd5
   LSSo8SiXoMA/vg2ZycTjsAGeuNNrLv49v4yL4Fnw8qzwW18qdLYfNPT2d
   vcSiu/K5fUo4WJW/gQbkGNUaYqVqc9GiNzgPSosMjHDTkyFpDw+wtZPpG
   g==;
X-CSE-ConnectionGUID: 927sMKw2Qyy1/ynXMQPydg==
X-CSE-MsgGUID: 0GPVma3nQDGg/3sQwCFygw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1994121"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1994121"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 04:05:34 -0700
X-CSE-ConnectionGUID: 5CMJ/braQgCTYNPfY2aNKw==
X-CSE-MsgGUID: lH3Shlv+T+2rHVEDZRl8rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5184240"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 04:05:30 -0700
Date: Wed, 28 Oct 2026 13:05:26 +0200
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
Subject: Re: [PATCH v4 4/5] serial: 8250_dw: configure the Allwinner H616 UART
Message-ID: <auHW9nkDqZUXeHNZ@ashevche-desk.local>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com>
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
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 05:05:32PM -0600, James Hilliard wrote:
> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
> 
> Keep PORT_16550A and describe H616's fixed 256-byte FIFO depth in platform
> data. Use common Allwinner setup helpers to configure the transmit load
> and receive trigger table from that depth.
> 
> Derive the receive thresholds from the documented 1-byte, quarter-full,
> half-full and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 128
> and 254 bytes; the normal 16550A half-full FCR setting selects 128 bytes.
> 
> Build the threshold table during setup and use the shared 8250 conversion
> helper to select the nearest lower threshold for sysfs writes.
> 
> Serialize trigger changes with termios and hold a runtime PM reference
> while programming FCR, preserving the FIFO contents. Propagate runtime
> resume errors before changing either the FCR shadow or the hardware.
> 
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
> DesignWare termios path selects hardware CTS handling, so the capability
> must be present for the corresponding hardware control to be enabled.
> 
> Select the fixed configuration through the platform setup callback.
> H616 has debug-divisor and RS485 control registers at the offsets used to
> detect DesignWare hardware RS485 and fractional-divisor support. Avoid
> those probes and retain the BUSY-safe integer divisor hook and software
> RS485 handling.
> 
> Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
> termios changes. Its clock is a gate on the shared APB2 source, rather than
> an independent baud-rate generator.

...

> +	unsigned int fifo_size;

This is should come from DT (based on the property or compatible),

...

>  	u8			no_int_count;
> +	u8			rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];

Why do you need it here? Can it be provided via driver_data?

...

> +/* The trigger is the masked, unshifted FCR receive trigger field. */
> +static unsigned int dw8250_sunxi_rxtrig_bytes(struct uart_port *p, unsigned int trigger)
> +{
> +	switch (trigger) {
> +	case UART_FCR_TRIGGER_1:
> +		return 1;
> +	case UART_FCR_TRIGGER_4:
> +		return p->fifosize / 4;
> +	case UART_FCR_TRIGGER_8:
> +		return p->fifosize / 2;
> +	default:
> +		return p->fifosize - 2;
> +	}
> +}

You don't need this, just provide a set of numbers directly.

-- 
With Best Regards,
Andy Shevchenko


