Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839280;
	b=1vWTJnmKpzTPBoC+XEUQa72DyaWoxfOaAHbmIFEKDfYLg7wC/wxi34nBPGQ/FZhDW+zQ
	 7wla+NGmkJXVUA42t0SgB8sXZv0HFkrLkxu2GqJrxtallizh8TdMTJtn8OTAl756KrDEd
	 DO5/gJRm2zuci5O68VNL8D8Oq6T3QqpoJidtqLJVgwYDJvB8YJYj5oREso5XiAibKIUNs
	 jvOxbGnEDTFC2WNTSD4qhqTst9rNC5A18im4zTKr/8cNhzDo/Uw5MAZIz94lgTk07SFRn
	 GmWhl3+7k2Ho16z2QC4fheX1KoIdIOpS2qUOK6BXDJ8ZOBUwFXaM+qXavFxBItZ7LRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=PImphhu3wIi9qvd60NuK0r09MdROw2ZiyCj8HwZ8s3U=;
	b=p+AFsenHoXo+j8Cn9T8bLrNo1/UNB+FR2zngrJqxhx606vNNnJAfY2cwUIiPtCQAy9n5
	 KxMqkVnQIdXFmZqgsH+w3dfQyst+uz7Es7EDTl2j+En2yvubXCCHwf/wU9mxjpATx8e0Y
	 YAqEqITXjp6qmAa1IOXm6lwElSwXDzI5r3PW3IFGbw1D022XvxdSdEHLxwuOATkfUDAl/
	 nrIV/qoOLyJSpN/FwOUNG5869nPc1yleSX+UqHGI3b7G+i91T5WBy4P9KGMMk0gKYwNo/
	 4sl65nwRsZDmPrTmCFZSI58rFzuiUbKKjg+KCrepSkSP8HyTYRGY2ohccGxXuEKpHwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED63E606A31A;
	Sat, 24 Oct 2026 10:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED63E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792839275; x=1824375275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xz5PQv0ox+JrG5g9K0fQpO/jVvuTlGpeFFcNwDdTuSA=;
  b=lTvkfwR4btj1IsIhLcBgJBOlmlYMgXIZvgoGr7GaawDJ3Vrxh9ZLXmyA
   V6he6YNpd7HnbvB5zFhlrashPjMjeGwdzZSiJDidkPFKP9XJbc8h5NtGJ
   uk55/9kkxgidH5x3kqT1LX5CTWpcp1ypYSSaIeeNg+qoCom9tbvdWkmdq
   Gj3LHy1446UTW+s2rFYaHCvY6UBJJ4rXkh9fMs+C18AtNw9Irdcxp5TUo
   VUml7ZSXMC+kJtGhtNMiXg0HdHI8cvHbe39eFn+OVsglw1m0OGO5Sk7TR
   f2wo9HStm+HkDhDTaJqlfUqngetloZ3wqNlPMb+DPYB10rChXpKM82/VC
   A==;
X-CSE-ConnectionGUID: 21HRsTWCTJmYAef200FhZQ==
X-CSE-MsgGUID: OuGQTj6cQTG64FzwxL/yZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1588583"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1588583"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:54:35 -0700
X-CSE-ConnectionGUID: IE+gK7i/SBCiQ1gyGE/l2Q==
X-CSE-MsgGUID: hTBVR/MXRzmLcXOjYpwx3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4194078"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:54:32 -0700
Date: Sat, 24 Oct 2026 13:54:29 +0300
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
Subject: Re: [PATCH v2 2/3] serial: 8250_dw: configure the Allwinner H616 UART
Message-ID: <atyOZcmdRMnpF078@ashevche-desk.local>
References: <20261023-submit-h616-uart-fifo-v1-v2-0-af0593504635@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v2-2-af0593504635@gmail.com>
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
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v2-2-af0593504635@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 03:19:28PM -0600, James Hilliard wrote:
> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
> DMA attachment also depends on a FIFO size being available during probe,
> so these ports do not reach the existing 8250 DMA path.
> 
> Keep PORT_16550A and supply the FIFO size, transmit load and capabilities
> when matching the H616 platform data. Provide receive-trigger callbacks
> for the documented thresholds of 1, 64, 128 and 254 bytes. The normal
> 16550A half-full trigger selects 128 bytes on this integration. Serialize
> trigger changes with termios and hold a runtime PM reference while
> programming FCR, preserving the FIFO contents.
> 
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
> DesignWare termios path selects hardware CTS handling, so the capability
> must be present for the corresponding hardware control to be enabled.
> 
> Skip optional-register probing for this fixed configuration. H616 has
> debug-divisor and RS485 control registers at the offsets used to detect
> DesignWare hardware RS485 and fractional-divisor support. Probing these
> offsets writes unrelated registers and can select incompatible callbacks.
> Keep the BUSY-safe integer divisor hook and software RS485 handling.
> 
> Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
> termios changes. Its clock is a gate on the shared APB2 source, rather than
> an independent baud-rate generator.
> 
> Attach DMA from the fixed configuration before registering the port.
> Configure single-byte RX and TX bursts because the peripheral request can
> correspond to just one character. The existing startup path requests the
> firmware-described channels and falls back to PIO when they are unavailable
> or the port is a kernel console.

...

> +static int dw8250_h616_set_rxtrig(struct uart_port *p, unsigned char bytes)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +	int i, ret;

Why is 'i' signed?

> +	/* Use the nearest lower threshold, as the generic 8250 implementation does. */
> +	for (i = 1; i < ARRAY_SIZE(dw8250_h616_rxtrig_bytes); i++)
> +		if (bytes < dw8250_h616_rxtrig_bytes[i])
> +			break;
> +
> +	guard(mutex)(&p->state->port.mutex);
> +
> +	ret = pm_runtime_resume_and_get(p->dev);
> +	if (ret < 0)
> +		return ret;

Don't we have a guard()() for this?

> +	scoped_guard(uart_port_lock_irqsave, p) {
> +		up->fcr &= ~UART_FCR_TRIGGER_MASK;
> +		up->fcr |= (i - 1) << UART_FCR_R_TRIG_SHIFT;
> +		/* Changing the trigger alone preserves the FIFO contents. */
> +		serial_port_out(p, UART_FCR, up->fcr);
> +	}
> +	pm_runtime_put(p->dev);
> +
> +	return 0;
> +}

...

> static int dw8250_probe(struct platform_device *pdev)

> -	if (!data->skip_autocfg)
> -		dw8250_setup_port(p);
> -
> -	/* If we have a valid fifosize, try hooking up DMA */
> -	if (p->fifosize) {
> -		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
> -		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
> -		up->dma = &data->data.dma;
> +	if (data->pdata == &dw8250_h616_data) {
> +		dw8250_h616_setup(up, data);
> +	} else {
> +		if (!data->skip_autocfg)
> +			dw8250_setup_port(p);
> +
> +		/* If we have a valid fifosize, try hooking up DMA */
> +		if (p->fifosize) {
> +			data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
> +			data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
> +			up->dma = &data->data.dma;
> +		}
>  	}

This looks unscalable and too much churn. What you should do is to add
a .setup() callback member to struct dw8250_platform_data and assign that
to dw8250_setup_port(), and change the

	if (!data->skip_autocfg)
		dw8250_setup_port(p);

to

	if (data->pdata->setup)
		data->pdata->setup(...);

which effectively kills that skip_autocfg. This is done in a separate patch.
Then in your patch you won't need this churn.

-- 
With Best Regards,
Andy Shevchenko


