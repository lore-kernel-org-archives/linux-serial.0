Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789081;
	b=h1jD3TG3I1Fpf3n52bazLGiELwK0t1a5BnkaDWGYRUjQBPD7gXDUtrr1x8qErzkZb4mn
	 CbMj8niMpSPC3d0wLTheKPUtWhSEuJuBcEB/y2OuZeqPq2JFhF+VjTAaCCGjalcYnCU7+
	 7iBnvGh8iVI7eGnHR18+CnkB+yqW2MUujxn2gYh387BAEKCs6boKk3uKkCyVr11o2UdIO
	 qPa3xv73VeJkUWbDY34I5JKGT2x2PWbfRFDpf/FowyMRw2S6g2+m2PxNHga4/jTdLZ9yW
	 1Z+O4IHn3ef8x/UakPI5t5FbvKO3b6Hlpj4yQFo0xoWqxJp3C6m3GrcgGusMZAwxzJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789081;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=g3rGNVvOS1oWZVgZ9/2cJCzlhYQm99f5FRWSO/pleRc=;
	b=noKln5GGKwOFvQXCDm1sXd26Os3q+AHEtfbmZSziLsogktmqkZUxUv26s2DkajZxFNpM
	 VWdLR194qX5bOtv0KSwUb9qCDhPNrv+6quid8Sscn8xQljthFWwL2yTpuKr7RxT4+wZpX
	 SKshqw1a2bEWVhXU3i80tGCzdYJK4Rtwo3MDiWD9nnE3eEtkSbufH7/uAoJOSWeT5ernA
	 ZSxDQvJ7TricoTziE1ZiUOssNjQqZUqJFKxHKFHNk4bQMZUZz17gT3LGsQNDLA6PlwsBi
	 FlOBdKBiroKSa+0gZzCYOGWu/CooWomtknFPARXtDAI4ELgWCAjJkZtA584exkmYtQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YNG2MirY;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE9606A326;
	Wed,  4 Nov 2026 10:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BEE9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YNG2MirY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793789081; x=1825325081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1s955WMmS+XVS3lgkXpO+uhYMyC1nNQN3ehFdSfyEhg=;
  b=YNG2MirYf7qSh4Hl88ZX0XgRHbvnmVHXJ9eq2npQYZsv3cWJmHYAfXsP
   /5k9SaeOFZEutVkkw5AaPFqcp4Eh2EBft3VVMMwvjEkXNpmcmGr5xMtJU
   ulx+BpdMwNA8xAt5zvZtsiYMyFbqxD+jE7Xqqx48hC0q2Uds4ppY1PkcX
   fVfxgfLkFs9CfVfNGQjb+hyJguuvZDLWKWMEcJwNPZSpjJOZBoxRhTR8Y
   Kp1bvtQRxQfJpIBYVnnjrYpQgo3gkwtm19gJFMR0S9NOJuMZJoqtnJLk3
   mei9AKKwoGETnCm2sQcEg+DK9HM/q+WL7TbOdN1d6uxsgLQC1HnICeLe3
   w==;
X-CSE-ConnectionGUID: JkLHFZ6BQJ+Y/8cDV8OPKg==
X-CSE-MsgGUID: XJCUxH/dSKmGARHQ6+ykoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2424432"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2424432"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:44:41 -0800
X-CSE-ConnectionGUID: M23FiearRYm6Jr0M4io4Ag==
X-CSE-MsgGUID: 4Gl93YrpTUqFiwP2J50+BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6542311"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:44:37 -0800
Date: Wed, 4 Nov 2026 12:44:35 +0200
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
Subject: Re: [PATCH v7 10/12] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
Message-ID: <ausMk21A5PPAaycx@ashevche-desk.local>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-10-c9e248d685c1@gmail.com>
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
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-10-c9e248d685c1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 02:40:03PM -0700, James Hilliard wrote:
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
> Use the shared DesignWare trigger setup to validate the depth and build
> the FIFO-relative threshold table. Invalid depths fail probe before
> registration instead of producing zero or truncated thresholds. The 8250
> core derives the transmit load from the discovered depth.
> 
> Select this setup for the A523 compatible. Like H616, this integration
> has Allwinner-specific debug-divisor and RS485 registers overlapping the
> generic DesignWare feature probes. Use the common sunxi PIO setup,
> BUSY-safe integer divisor programming and software RS485 handling. Keep
> the APB clock gate enabled during termios updates with SKIP_SET_RATE.

...

>  	p->type = PORT_16550A;
>  	p->flags |= UPF_FIXED_TYPE;

+ Blank line in this patch.

> -	p->fifosize = data->pdata->fifo_size;

Perhaps a comment here

	/* Apply given FIFO size or try to autodetect it */

> +	if (data->pdata->fifo_size) {
> +		p->fifosize = data->pdata->fifo_size;
> +	} else {
> +		u32 fcc = dw8250_readl_ext(p, SUNXI_UART_FCC);
> +
> +		p->fifosize = FIELD_GET(SUNXI_UART_FCC_FIFO_DEPTH, fcc);
> +	}

Add a blank line here in the previous patch.

>  	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;

...

Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko


