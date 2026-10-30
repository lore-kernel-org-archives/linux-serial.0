Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353903;
	b=soF/SD53KdsQGpaa7OLlwM4jzLO6tbdD3rycgyNvdIAaVNe6gQu/oVunEASmPgksnIwr
	 xaCruQWsL/BEtrc/MgYqzCne4aVKXwo3X7slHWSsPV6MLi0RofhZdgt6xLQx0Hg2oImrU
	 ipqcwONa4VuF6BWv3zj6KQ2o3Lpi79P5DPcIf4mNSJMafPO0BZbzWXb5kHhRyZtztrq4M
	 p82iNsyJY9EUfg6fFZW4EPnMy2RNzaz8JLcAAeVXXcVOeaYKFMBYrYQ5Z2ALYHZQ2sK6d
	 CKN+Y7lHoKQ3kMm3wdccG3cC4bfVOmHwsux+tvgaABZa10Wgv0IktTJ1aa9gpKzDVOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353903;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=7TANQUlPJemcIf+d7Vgd+PAva9YTSJD/DfMucJVKdTo=;
	b=akrITTluooH/1KeC4ZhWKSJQw6sy4ec7FXZQFNfdZaR/2ml5gjxoOgoh7M+U08X22RSP
	 bB/nkJL6c62SvPi8NUNNc19Hztzl5qsUyORcody3z0Ij7s3PYCNv4KB3LgWQDSELorBZq
	 1+i1zt6UPTYgPgp7puqikLH20WGP8J9pUkNkuyGJnXO1LTjY54QbN0+cw99gkMfM6iGF/
	 XfIdxM00DamStmm8TXvgo6kcKbu4YkuVXumn/53QflBfgONE3pH4PmuWGTmrmOc5PGWR6
	 +WlkgUiHRIQKCK7UssMva4KYPlUIO43/GvFb51mowH0w1ocFcf+9nF2i21IlS8XV/9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rp6SeMZ7;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1F606A33A;
	Fri, 30 Oct 2026 09:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C1F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rp6SeMZ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793353902; x=1824889902;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rXmmZvQwk7weAWQRbOTp6l9G3HUkrXfcFgXXPPhBVhA=;
  b=Rp6SeMZ7u25QQSV/RotyQsYhMZwz68MekAOpsdZnN3Q7o/E/Q3bV1ibM
   uLfv/ADKkRCWiJA38PVyE9UuqHnbhpILuBXQ06LmYYzM1YbKIxsZ/7c5/
   EERkkf4w1PzA4Q7UB6pKl0RDCpL8ZUNjA4rCZk4lePaSEG3QxawxzUYmI
   7yoTwSEWZJmTU/VyyTQxBPpkUKb5RzEKI3ZeyzoPOtSLJtom2jzKY1TQ/
   bhJlZY6YxxU+GTVdPrK7BWCFBtd0agcbTaH6akdnoVySteAL6UmBPxzIF
   23Cbzqp2S/C50433UKKcMPlNQTT8mQFscr39WtR4HIIVBeov99NB1VWru
   Q==;
X-CSE-ConnectionGUID: oIgdqsktS72wmva5DlxwQQ==
X-CSE-MsgGUID: 2C+wy1EwQY6zgaJDFF8STw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2129639"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2129639"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:51:41 -0700
X-CSE-ConnectionGUID: NiscU6zERACwhqfm6w+v5A==
X-CSE-MsgGUID: yynxe+GeTci66Hb2PFxNzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7187531"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:51:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 11:51:32 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 4/8] serial: 8250_dw: configure the Allwinner H616
 UART
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-4-53b433aebbf8@gmail.com>
Message-ID: <0809accd-0db3-c923-0396-2d45db7b0d82@linux.intel.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com> <20261029-submit-h616-uart-fifo-v1-v5-4-53b433aebbf8@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Oct 2026, James Hilliard wrote:

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
> Allwinner encodes these thresholds as fractions of the FIFO depth rather
> than fixed byte counts.

This feels repetitive wrt. the previous paragraph so I'd instead start 
the previous paragraph with this sentence.

> Building a per-port table from that depth keeps
> the mapping in one place for integrations with different FIFO sizes,
> including those that report their depth through FCC. It also lets the
> shared 8250 conversion helper select the nearest lower threshold for sysfs
> writes using the same table as the read callback.

Instead of this long fragment of text, I'd just say something like this:

Construct the RX trigger threshold array on the fly so that other fifo 
sizes can reuse the same mapping.

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
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 98 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index a546cf2de7b6..3bc6735fc253 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -19,6 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/lockdep.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> @@ -63,6 +64,7 @@
>  struct dw8250_platform_data {
>  	u8 usr_reg;
>  	u32 cpr_value;
> +	unsigned int fifo_size;
>  	unsigned int quirks;
>  	int (*setup)(struct uart_port *p);
>  };
> @@ -81,6 +83,7 @@ struct dw8250_data {
>  	unsigned int		in_idle:1;
>  
>  	u8			no_int_count;
> +	u8			rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
>  };
>  
>  static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
> @@ -652,6 +655,93 @@ static int dw8250_setup(struct uart_port *p)
>  	return dw8250_setup_dma(p);
>  }
>  
> +/* The trigger is the masked FCR receive trigger field, in register position */
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
> +
> +static int dw8250_sunxi_get_rxtrig(struct uart_port *p)
> +{
> +	struct dw8250_data *data = to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +
> +	guard(uart_port_lock_irqsave)(p);
> +
> +	return data->rxtrig_bytes[UART_FCR_R_TRIG_BITS(up->fcr)];
> +}
> +
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
> +
> +	up->fcr &= ~UART_FCR_TRIGGER_MASK;
> +	up->fcr |= fcr;
> +	/* Changing the trigger alone preserves the FIFO contents */
> +	serial_port_out(p, UART_FCR, up->fcr);

Hmm, the current do_serial8250_set_rxtrig() only takes tty port's mutex?
Does it lack something it should be doing (RPM or taking port's lock)?

I was going to suggest putting the actual FCR update into generic 8250 
code and lockdep asserting the required locks are held. But then noticed 
the taken locks seem do differ.

> +	return 0;
> +}
> +
> +static void dw8250_sunxi_setup_rxtrig(struct uart_port *p)
> +{
> +	struct dw8250_data *data = to_dw8250_data(p->private_data);
> +
> +	/* Allwinner RX thresholds differ from the standard 16550A table */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(data->rxtrig_bytes); i++) {

Add include for ARRAY_SIZE()

> +		unsigned int trigger = FIELD_PREP(UART_FCR_TRIGGER_MASK, i);
> +
> +		data->rxtrig_bytes[i] = dw8250_sunxi_rxtrig_bytes(p, trigger);
> +	}
> +	p->get_rxtrig = dw8250_sunxi_get_rxtrig;
> +	p->set_rxtrig = dw8250_sunxi_set_rxtrig;
> +}
> +
> +static int dw8250_sunxi_setup(struct uart_port *p)
> +{
> +	struct dw8250_data *data = to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +
> +	p->type = PORT_16550A;
> +	p->flags |= UPF_FIXED_TYPE;
> +	p->fifosize = data->pdata->fifo_size;
> +	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
> +
> +	dw8250_sunxi_setup_rxtrig(p);
> +
> +	/* Use software RS485 with the Allwinner register layout */
> +	p->rs485_config = serial8250_em485_config;
> +	p->rs485_supported = serial8250_em485_supported;
> +	up->rs485_start_tx = serial8250_em485_start_tx;
> +	up->rs485_stop_tx = serial8250_em485_stop_tx;
> +
> +	return 0;
> +}
> +
>  static int dw8250_probe(struct platform_device *pdev)
>  {
>  	struct uart_8250_port uart = {}, *up = &uart;
> @@ -875,6 +965,13 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
>  	.usr_reg = DW_UART_USR,
>  };
>  
> +static const struct dw8250_platform_data dw8250_h616_data = {
> +	.usr_reg = DW_UART_USR,
> +	.fifo_size = 256,
> +	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> +	.setup = dw8250_sunxi_setup,
> +};
> +
>  static const struct dw8250_platform_data dw8250_octeon_3860_data = {
>  	.usr_reg = OCTEON_UART_USR,
>  	.quirks = DW_UART_QUIRK_OCTEON,
> @@ -926,6 +1023,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
>  
>  static const struct of_device_id dw8250_of_match[] = {
>  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
> +	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> 
> 

-- 
 i.

