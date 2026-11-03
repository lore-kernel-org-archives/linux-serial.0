Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707806;
	b=ObatXslvPKM7D2S95UubOd91WFCIc2+GGtwIqjT5MJVyyRQqVR51MLrxHO4caD8s3JWh
	 H7KkNGdGTKCp7psirSXpmYqwpqpqwhxPRr1no6UjjdERNr6SmMKm0gSFrZnMSHTftvn4r
	 xKo74+pVPgdkz9AcyOKhn61mFq33D7QBwAxcYwEL1/mZFgv+QL6ppMMPMxbta9zMn8uwn
	 HfunxRfoaIb1UDOUkhTTAYFNBkMR9fpOtl2nr0JJKrCJLvsQ7Wq8jiLaEiX7TftZlrCaP
	 WldnngPUgEsEjL1kzSy86XCGW0iVxuIfBpj/CnBEWyBe8o7KN/it79yJzcta2nGPNVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707806;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=lZloWcPDVM4dVpS9WmdN8nPPZc7i9no9wyUqZ5qH2JA=;
	b=1MsZ+kLj3hbrrt9P9XfbBuFm24cqvfzSb3Bhz6NN8wkVycIPs/lHHxF7I8rcCKFri/1f
	 pCDZQJEM1J2m5dLUxotEUaRgKL8N2veGFmuMtFfLCkkXAjGwGxpblsBCL6RFRUcAmR3Lu
	 P656DImofWuZJ0t4NabTCyn9PTo8pdmllFkzKxIw8/xuXFFzSxHHzVR1NohS59PiOf+LZ
	 yt2yF7oTFgQMxkQMQZJwYkMa/bmw+7WqZRsK3zhkdgG8nvm+NK6T9GTjr4POQpio5X+zk
	 XWwfWC9MvxzmFF9l/ZG+0oYwix0bs80Y9DHp+Eq86sVnYuC/tZzxGdT+UssODoJgsQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yxima1mh;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B80606A324;
	Tue,  3 Nov 2026 12:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B80606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yxima1mh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793707806; x=1825243806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HPAWnSLRmzqkl6s9RYyuENxxp9+uYSex0FG9pduGwWo=;
  b=Yxima1mhhhJFWTD6SJx0EVMAxcTojfZzeD9dsfYvryIEFwZYM89QDNw6
   NhicQr7w59Li1oPVae2DkFy5xad36vwL90SD9KVOrTwrAqu2MJYp6r48V
   +HuL9GlToqx2h5l36aXaXXIq6Lpy6f9aCNTB/wn8R7pnrvQOmQ3IpgRE1
   8T4PRtsEirJUrGPaqT6w0tVvG/7jAlzH5suM8sdoOz5n8/SCZRlNqi17L
   8fxrTklvRAQRhj5QHigYx7cyTq26zupat8vhs3OeZr4czyjuz9nvjOsVs
   PbAKgW9rVd3QmO+6wEnU+763Rr9SS+RnuZDfnW2+dK5DaNBP70MDHF0ji
   g==;
X-CSE-ConnectionGUID: 5iwcUJu1SdqjsioYxJLKcA==
X-CSE-MsgGUID: AEox1gj8Rl+82Ax2aukMBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2308614"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2308614"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:10:05 -0800
X-CSE-ConnectionGUID: DLS/RsaYQMKYDRjLO0nS9A==
X-CSE-MsgGUID: c+UbXbirSpmEEJdXix7DlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6944952"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:10:02 -0800
Date: Tue, 3 Nov 2026 14:09:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v6 7/8] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
Message-ID: <aunPFy2TCljGvV2q@ashevche-desk.local>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-7-25afcb346b0c@gmail.com>
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
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-7-25afcb346b0c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 12:55:22PM -0700, James Hilliard wrote:
> The A523 UART integration, also used by A527 and T527, has 64-byte FIFOs
> on UART0 and 128-byte FIFOs on UART1 through UART7. Each controller reports
> its TX/RX FIFO depth in bits 31:8 of the FIFO Clock Control register at
> offset 0xf0. The field holds a byte count, not a logarithmic encoding.
> 
> Read this field in the sunxi setup callback when platform data does not
> provide a fixed FIFO size. A fixed size takes precedence, so H616 retains
> its 256-byte configuration without accessing FCC. The probe has already
> enabled the clocks and deasserted reset before invoking the callback.
> Leave the FIFO clock-control bits untouched.
> 
> Validate the depth before generating the RX trigger table or setting the
> transmit load. The quarter-full threshold must be positive and the
> FIFO-depth-minus-two threshold must fit in the byte-sized table and RX
> trigger API. Report an invalid depth and fail probe instead of generating
> zero or truncated thresholds. This bound follows the current 8250
> table and callback types, not a hardware FIFO-capacity limit; support
> for larger thresholds would require widening that interface.
> 
> Select this setup for the A523 compatible. Derive the transmit load and
> RX threshold table from the discovered depth using the common sunxi
> helpers. This handles the different FIFO sizes with one compatible and
> one receive-trigger mapping.
> 
> Like H616, this integration has Allwinner-specific debug-divisor and
> RS485 registers overlapping the generic DesignWare feature probes. Use
> the common sunxi PIO setup, BUSY-safe integer divisor programming and
> software RS485 handling. Keep the APB clock gate enabled during termios
> updates with SKIP_SET_RATE.

...

>  struct dw8250_platform_data {
>  	u8 usr_reg;
>  	u32 cpr_value;
> +	/* Fixed FIFO depth; zero selects discovery during setup */

But make the code clearer in this sense.

>  	unsigned int fifo_size;
>  	unsigned int quirks;

I'm wondering if we can encode the FIFO size (as power-of-2) into quirks,
but this might be harder to follow in the code.

>  	int (*setup)(struct uart_port *p);

>  	p->fifosize = data->pdata->fifo_size;
> +	if (!p->fifosize) {
> +		u32 fcc = dw8250_readl_ext(p, SUNXI_UART_FCC);
> +
> +		p->fifosize = FIELD_GET(SUNXI_UART_FCC_FIFO_DEPTH, fcc);
> +	}

	if (data->pdata->fifo_size) {
		p->fifosize = data->pdata->fifo_size;
	} else {
		u32 fcc = dw8250_readl_ext(p, SUNXI_UART_FCC);

		p->fifosize = FIELD_GET(SUNXI_UART_FCC_FIFO_DEPTH, fcc);
	}

> +	/*
> +	 * The byte-sized 8250 RX trigger interface requires positive,
> +	 * representable thresholds. Larger thresholds require widening it.
> +	 */
> +	if (p->fifosize < SUNXI_UART_RXTRIG_QUARTER_DIV ||
> +	    p->fifosize - SUNXI_UART_RXTRIG_FULL_MARGIN > U8_MAX)
> +		return dev_err_probe(p->dev, -EINVAL,
> +				     "invalid FIFO size %u\n", p->fifosize);
> +
>  	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;

-- 
With Best Regards,
Andy Shevchenko


