Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085718;
	b=ghnHrGppFjuHpl6OgGflB1Zrtxya+wlfCxLVQlpN4joD4QvubeNlrZ6T+H0o2A6TvbNv
	 v1MrItEu5Vd8P4vZe8dXwvXwCZh50fEGzN/yd0Wff7KX4kMywdTrEhhKkElryMxXsLO2I
	 7tP9a1IHjL7h85JBK4xA8cuLJOX2RXO3BXI750aRLEX6u4VTJQbRFJG9OjXsRAJe7erUQ
	 98F/nh/wC7TNmhW44eTKLOSDhuhWWZ/LKxQnjYaQCP4biLUJ/d70YqfTrWOfqMGd4aGbq
	 Bt4bAUoqXOZwT8HH8qeqGs5Fjag6V2srb4sZnlxteYozRjXdF1jFLQH5/n4s+fpJgbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085718;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=AVTyXl56KTAD9qthFvNCSvQI53NTnxNb8lASUJ9aXqI=;
	b=lfWgGOwCD8qaqQyO9SxCqIPbd7VPJoqYkjwTFRzqczKJAO9DsOGl9bYEwWtp0bvoVQHT
	 +AHEL4bN9HnMwbyXuCwGwMWkTDM7kiJH3IINmKkfyhEF0gInXUW5ueTfZn64KGddq31IU
	 QQKaSlsbKnCVgZKSZcwozxMcGr8EBhGV5URNEor+Ierh8fxrAjMOTQvoZZ1q2K+KcGw+M
	 LhALv846Suc35BoO49LXjGUEb/R8XVBvzix/2QdcTd2ZmjKwU8X9biE9kcF6dHaLzJxSC
	 +3AzUyOVclJRf36+kx3QwrAXjpV35CHIophXbMw6L2y1xblv34AhCMtVYz23SvnMBrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yw7R9fEF;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD06606A31A;
	Tue, 27 Oct 2026 07:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yw7R9fEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793085718; x=1824621718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTLEDAupRY2oWJwjRjfzsKaWR6SmrpHN+eBe2aIhJOs=;
  b=Yw7R9fEFvAYKvCNJ8i+w8yVv44UPr8QA932xAPKrPbyVbFlvSKjBcvaP
   rd5rzWT/qhvp+aVPOE+oeKeaiehzRavDckxb5+W8yYEslQxElfm5XJRP5
   OU9eu5TNDs0QbWw/q3/u4bqwQIIKVHLKUlX6tSXvduDGnFrqJ36bYF+7c
   OndVrhMmYFZMTsUAmYaQ846vWU8QYtLeqbaFAqDeepf4TY5kXYdqMFHi7
   3/DOvX6riY7JTwzIXV2lglbov9OuJOCsGWb6VJSzleWLzacvswnwUfZPm
   qzD5LL3AX1R0lnTAZe1ThDmVEcuv16E1VF8qK54RAQRWJcEZVlHY55klw
   w==;
X-CSE-ConnectionGUID: YLTvDJtMR8uJXlfsNgbdNQ==
X-CSE-MsgGUID: prf++W+pQz6N3J170LvC7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1670531"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1670531"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:21:58 -0700
X-CSE-ConnectionGUID: QQ7qj2MiSJqvvbsyjg+eug==
X-CSE-MsgGUID: QbVb4ynrSgWUyDG3mhGFww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6317598"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:21:54 -0700
Date: Tue, 27 Oct 2026 09:21:51 +0200
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
Subject: Re: [PATCH v3 3/4] serial: 8250_dw: configure the Allwinner H616 UART
Message-ID: <auBRD7Ny6u_a9X7p@ashevche-desk.local>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-3-286fc1b8c3c1@gmail.com>
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
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-3-286fc1b8c3c1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 02:22:25PM -0600, James Hilliard wrote:
> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
> 
> Keep PORT_16550A and preserve the FIFO size read from firmware by
> uart_read_port_properties(). Use it for the transmit load and derive the
> receive thresholds from the documented 1-byte, quarter-full, half-full
> and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 128 and 254
> bytes; the normal 16550A half-full FCR setting selects 128 bytes.
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

> +static int dw8250_sunxi_set_rxtrig(struct uart_port *p, unsigned char bytes)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +	unsigned int i;
> +	int ret;
> +
> +	/* Use the nearest lower threshold, as the generic 8250 implementation does. */
> +	for (i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++)
> +		if (bytes < dw8250_sunxi_rxtrig_bytes(p, i))
> +			break;

Can we provide an array of the possible values and deduplicate this loop?

drivers/tty/serial/8250/8250.h:

static inline int serial8250_bytes_to_fcr(unsigned char *rxtrig_bytes, unsigned char bytes)
{
	for (unsigned int i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
		if (bytes < rxtrig_bytes[i])
			/* Use the nearest lower value */
			return (--i) << UART_FCR_R_TRIG_SHIFT;
        }

        return UART_FCR_R_TRIG_11;
}

drivers/tty/serial/8250/8250_port.c:

static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
{
        const struct serial8250_config *conf_type = &uart_config[up->port.type];

        if (!conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
                return -EOPNOTSUPP;

	return serial8250_bytes_to_fcr(conf_type->rxtrig_bytes, bytes);
}

(this split should be done in a separate preparatory change).

And here

	u32 fcr;
	...
	fcr = serial8250_bytes_to_fcr(...->rxtrig_bytes, bytes);

> +	guard(mutex)(&p->state->port.mutex);
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(p->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(uart_port_lock_irqsave)(p);
> +
> +	up->fcr &= ~UART_FCR_TRIGGER_MASK;

> +	up->fcr |= (i - 1) << UART_FCR_R_TRIG_SHIFT;

The right side is embedded in the above mentioned helper.

> +	/* Changing the trigger alone preserves the FIFO contents. */
> +	serial_port_out(p, UART_FCR, up->fcr);
> +
> +	return 0;
> +}

...

> +static void dw8250_h616_setup(struct uart_port *p)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +
> +	p->type = PORT_16550A;
> +	p->flags |= UPF_FIXED_TYPE;

> +	up->tx_loadsz = p->fifosize;

So, here you can precalculate the array of possible FIFO thresholds.

> +	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
> +	p->get_rxtrig = dw8250_sunxi_get_rxtrig;
> +	p->set_rxtrig = dw8250_sunxi_set_rxtrig;
> +	p->rs485_config = serial8250_em485_config;
> +	p->rs485_supported = serial8250_em485_supported;
> +	up->rs485_start_tx = serial8250_em485_start_tx;
> +	up->rs485_stop_tx = serial8250_em485_stop_tx;

Please, add more new lines, so we see the groups of different callbacks and add
comments on top of some to explain, like

	/* Custom FIFO trigger thresholds since it differs to standard 16550A */

> +}

-- 
With Best Regards,
Andy Shevchenko


