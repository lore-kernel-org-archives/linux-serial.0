Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176761;
	b=MkKD+YEuCPWltfPueucHCuC/GVUfJ6FPGgcRssY34LOph9ogfk4KHtt0gH1+66Fk2GNT
	 ZTO4boJ1I6uiU9p0bZuHDM0lIzSrRxPUenRPwJc/Cm2ev3oX4sJKMVr0u35rqfpQxJ3N1
	 tO9PGxq0ZakZ2IGkuAsdO1ACAlNxfyyiI2OzVF4QsqM46R0z7/fsj27Z3Q26TDXkOF6u+
	 OS9bE6k2VKtmuYG+6oDNzMNXoTzm1j3JHg/5X6GvBMhTA8wt0yc6bc1NhtLyNKKkGOIt3
	 uKsEu3wF7PUVLwaFEppp+A0FNAosQ6S5Fngs7soElrnJSv9kKINvePgiep16DLgj2Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176761;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=k+/0Etqtd3IAC5WSaWUuCODMHTr63RxsQxyEkapcIZ4=;
	b=qGUCWYVqLfnurfNB5awjsoFodYlnabViWEOeXIOowDu40V7sdWHeqeXHG4Rvz1c4aiMK
	 fxYhcG6/ecK2240M5Z8A7E6j5Io5QQ/8qIFR5HXIO30nYUEIvI+HoWnYdB9iEVpN/uGvI
	 rzvktfMWbiEMdxjT0rQjBpAmDfMEhb6nHhKsMKBFU1SIgb70cIiMa5DZKkeCH2Rd3/2VQ
	 icM4gHGUyPJ8InYy0JVf3JOMYFgZCZiyv5kzAzXskKYzYfl+EmwPHVHvbhG09ZGX+TWep
	 mEJKGESxpAj7+Miqqt4hL/cwetJF6XCPXSViFotjFBa9WCC31/ESMR3pBOG8qJhE15A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fjPI6AZb;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126E606A31A;
	Wed, 28 Oct 2026 08:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B126E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fjPI6AZb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793176760; x=1824712760;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uTaRlxLCqbcv6Xj6m6xjniKklWGvpcYIMWydvvWrEAg=;
  b=fjPI6AZbdKAEbTKthYkTDQ1yc1cIeCmUM7GBBmcLsg/5AMEDE2YwF5Nd
   h6EaTwXxvDyzdXBic+Baxv39cBOrWmsA4shJ0IILyQUbWnMnGNPZMBXRu
   Xa1d/Zz8UfRCnqnpU7Pn0Ba5r/T6Hqg4lXx1S82JGsk4isIgwtg2wkkSe
   qgwA/oL+2Wbo8wr8F06P8v5yZhNAqMY7qYDYQjRXWSlZaVbV61PXuRxIN
   2hVLqRAOBqgP5yQyNs7RgyKJWgqN9HX9GdzI3/8bB3YFdEzF+NicjWYrq
   vJxy7B46suKv0fZrTrr0bp5hJnwkwP2hhagnaVoMV/v91Ls0F9VdUCnmX
   w==;
X-CSE-ConnectionGUID: Yr9/2BPOQ0SrDpbmlqFFGg==
X-CSE-MsgGUID: hYKFcv8SQmqJ+H3hmbqbkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1891349"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1891349"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:39:20 -0700
X-CSE-ConnectionGUID: 1qHJ4GAZQ/2D7Rw5/ucZYQ==
X-CSE-MsgGUID: DGDOUWwPT7WiCRd3U5NEvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4712710"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:39:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Oct 2026 10:39:10 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 4/5] serial: 8250_dw: configure the Allwinner H616
 UART
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com>
Message-ID: <c8668925-efec-da4c-193c-5e85c5bbcf15@linux.intel.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com> <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com>
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

On Tue, 27 Oct 2026, James Hilliard wrote:

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

You do that, I can see from the patch, but I came to read this changelog 
to understand "why"?? You provide zero reasoning for this design decision.

Since you fifosize is constant as well, so what benefit building it on the 
fly servers?

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
>  drivers/tty/serial/8250/8250_dw.c | 94 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 1351523f0c47..2f156c01c5a1 100644
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
>  	void (*setup)(struct uart_port *p);
>  };
> @@ -81,6 +83,7 @@ struct dw8250_data {
>  	unsigned int		in_idle:1;
>  
>  	u8			no_int_count;
> +	u8			rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
>  };
>  
>  static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
> @@ -657,6 +660,89 @@ static void dw8250_octeon_setup(struct uart_port *p)
>  	dw8250_setup_dma(p);
>  }
>  
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
> +	/* Changing the trigger alone preserves the FIFO contents. */
> +	serial_port_out(p, UART_FCR, up->fcr);
> +
> +	return 0;
> +}
> +
> +static void dw8250_sunxi_setup_rxtrig(struct uart_port *p)
> +{
> +	struct dw8250_data *data = to_dw8250_data(p->private_data);
> +
> +	/* Allwinner RX thresholds differ from the standard 16550A table. */
> +	for (unsigned int i = 0; i < ARRAY_SIZE(data->rxtrig_bytes); i++)
> +		data->rxtrig_bytes[i] = dw8250_sunxi_rxtrig_bytes(p, i << UART_FCR_R_TRIG_SHIFT);

FIELD_PREP(UART_FCR_TRIGGER_MASK, i)

For clarity, it might be useful to split it into two lines using an 
intermediate variable.

> +	p->get_rxtrig = dw8250_sunxi_get_rxtrig;
> +	p->set_rxtrig = dw8250_sunxi_set_rxtrig;
> +}
> +
> +static void dw8250_sunxi_setup(struct uart_port *p)
> +{
> +	struct dw8250_data *data = to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +
> +	p->type = PORT_16550A;
> +	p->flags |= UPF_FIXED_TYPE;
> +	p->fifosize = data->pdata->fifo_size;
> +	up->tx_loadsz = p->fifosize;
> +	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
> +
> +	dw8250_sunxi_setup_rxtrig(p);
> +
> +	/* Use software RS485 with the Allwinner register layout. */
> +	p->rs485_config = serial8250_em485_config;
> +	p->rs485_supported = serial8250_em485_supported;
> +	up->rs485_start_tx = serial8250_em485_start_tx;
> +	up->rs485_stop_tx = serial8250_em485_stop_tx;
> +}
> +
>  static int dw8250_probe(struct platform_device *pdev)
>  {
>  	struct uart_8250_port uart = {}, *up = &uart;
> @@ -878,6 +964,13 @@ static const struct dw8250_platform_data dw8250_dw_apb = {
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
> @@ -929,6 +1022,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
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

