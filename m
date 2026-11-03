Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707408;
	b=Ge0FtLyPiSV0pBzS87wIIfhmV6LXBahlHwIQNstHBOK960xHvCjtQ0b0UL89tZomhgTz
	 vNI3PAJW4XNyZUxM9IXiZhb5c3uOBpg2A3XePGfWmM8NCLynvt8A9y0NiKAgxthjRW3ak
	 KQ7mNzIFZOGd06+nCaNOc/fhLva8IRb9XGwnHuwme+UOG2AzTxbXuXlQIGvM+Qzp7zyVn
	 Hq54OxAiUflp4oYjRftl+BOVvRev5Q6EFPf14Y/3AycyjsvB84WuleioJcf0J6e/UGUWp
	 ApLiD7nSg6kJVB29RVZWeJtt5YY2Yh0aq4h3y6d/i/pkYvGYX9swD9uc0DNTsh7MO2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707408;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=aFDkJvc0SlO0FoZdt7sy/omFWAvQLp/LHRh9YqnoHDQ=;
	b=qMVNk3Q33n6BYv1OLl6J3njET99wFHHj2+FqtLNRgyBTsqIeP1pwTfgosneGPoWz3ni2
	 eLRoOsBoaYb+5K11HvsVKYlu5as+6pexKD0dOR3ezAatniXKnmw69NlObzkhk7VVoJnjz
	 O+co1RL77fYq3JXKwVKsXCdcvSQjb4SfvNIU0vIqVJh+weC7wSh9KBX+jj86656rIyTS+
	 aqjKE7GboKH3haJV0itI3L9n+ssNhm1YXQC7a1+Gh0hoCbGdRY0gipg4+5rWMaRGuLSl6
	 jl56NeiTkffudhfNrQp3eXlPPsnBA0TyLdvDNdXQsyfpsiPx6d95aquDV8GSzNb7OkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HKJzLVtx;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD3606D820;
	Tue,  3 Nov 2026 12:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDAD3606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HKJzLVtx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793707409; x=1825243409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ms+g3QoZSUyFHUMK9wfol68PI8V8MBi/mm/vsDLdkK8=;
  b=HKJzLVtxnCKrz1kbs/KMp5RNv0G8AoPu37zW05Ha7X8xAq7qMkHKVzOu
   QyY0XY7CpZslVYp+hiwWwZI4oil0XouTcplQWmfuDa0L1Q+cg74AvAIfY
   /S8p7lWEZinvzuGaVVZyPc1ZxSK74MwJJNt5tjhcCTbhCQmD4EmDzI35q
   YmoI49FCeJEyiznEqJ33xpFoHZRDyFumKU5AGGZCSOSeZEPCbXJkj6QQH
   2ik8BbGCIe1fMbwX1nbqQUpGOik1WB4v5uhUwJm5xqGWEureCNZ0r4NOi
   +srPxXIxBTQXvKwNnNJJcm/YupR6SgmROhv+O9kM/wDFo6S0j+4rVKEz0
   w==;
X-CSE-ConnectionGUID: hiLi+IPGQaivNb8egb+K7g==
X-CSE-MsgGUID: 1UN2z4S4TruEczkdvDe0SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2336005"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2336005"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:03:28 -0800
X-CSE-ConnectionGUID: u0dGWKT/S9WdmDpo9aqLlg==
X-CSE-MsgGUID: 772hCfvgTIKLnsT8dX0suA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6737785"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:03:23 -0800
Date: Tue, 3 Nov 2026 14:03:21 +0200
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
Subject: Re: [PATCH v6 4/8] serial: 8250_dw: configure the Allwinner H616 UART
Message-ID: <aunNiQcpKMrc88EK@ashevche-desk.local>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-4-25afcb346b0c@gmail.com>
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
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-4-25afcb346b0c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 12:55:19PM -0700, James Hilliard wrote:
> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
> 
> Keep PORT_16550A and supply H616's fixed FIFO depth through platform data.
> The 8250 core derives the transmit load from that depth.
> 
> Allwinner encodes receive thresholds relative to the FIFO depth: one byte,
> quarter-full, half-full and depth minus two. Construct the RX trigger
> threshold array on the fly so other FIFO sizes can reuse the same mapping.
> For H616 the thresholds are 1, 64, 128 and 254 bytes, with the normal
> half-full FCR setting selecting 128 bytes. Use this array for both RX
> trigger callbacks and the shared bytes-to-FCR conversion.
> 
> Serialize trigger changes with termios through the port mutex. Hold a
> runtime PM reference for the register access and the UART port lock while
> updating the FCR shadow and hardware. Changing only the trigger field
> preserves the FIFO contents; a runtime resume failure leaves both the
> shadow and hardware unchanged.
> 
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE, matching the
> DesignWare termios path's hardware CTS handling.
> 
> Select this configuration through the platform setup callback. H616's
> debug-divisor and RS485 control registers overlap offsets used to detect
> generic DesignWare features. Use the fixed configuration with BUSY-safe
> integer divisor programming and software RS485 handling.
> 
> Keep the UART clock enabled during termios changes with SKIP_SET_RATE.
> Its clock is a gate on the shared APB2 source rather than an independent
> baud-rate generator.

I'm not sure I followed previous discussion, but as far as I get it Ilpo
mentioned the possibility to have that FIFO trigger threshold helper to be
available on 8250_dw level (meaning dwlib). Or was it decided against this?

...

> +static int dw8250_sunxi_set_rxtrig(struct uart_port *p, unsigned char bytes)
> +{
> +	struct dw8250_data *data = to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +	int fcr, ret;
> +
> +	fcr = serial8250_bytes_to_fcr(data->rxtrig_bytes, bytes);
> +	if (fcr < 0)
> +		return fcr;
> +
> +	guard(mutex)(&p->state->port.mutex);
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(p->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(uart_port_lock_irqsave)(p);

> +	up->fcr &= ~UART_FCR_TRIGGER_MASK;
> +	up->fcr |= fcr;

	up->fcr = (up->fcr & ~UART_FCR_TRIGGER_MASK) | fcr;

(as is also okay)?

> +	/* Changing the trigger alone preserves the FIFO contents */
> +	serial_port_out(p, UART_FCR, up->fcr);
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


