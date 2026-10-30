Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354449;
	b=HzyNbIFvGb8hWq6DIiAB4BIf+7Ajyf6OY8/HzYOxrJrs1VMfCyABFIlIR64FyxTZewg3
	 1QhsEo1ttmQtQPhdXtqRelHQ9Cv99HiKNRr3VLWyUZLnPIWgFenCtdr0UUB4SDIpLY9BZ
	 Gc5OkeFgV+pxir0MZXpDiCQxEU8IdWkEATtiorGTA7T+tuPiOXMjka8nwC81Uo2NZUkJo
	 6UScPfUzt5k6ArDC9ate46oubAYTwGylfG1UmIpC7QnasgIOLO9mNhHCt9SgrfazXTmmd
	 Ei4iJgPJ/GoS6FctlHdqrrl9Go1K/f/4DCbd/zM/Ya2VT7KtrVOMWZx8XHSwlTYjEWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354449;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=vbB1PXZ8iofBpMV+/vOpPqAHgjVf96svSHPsdRMK9m8=;
	b=ZveSlnuWe4JYjmWVGXjqIvPwBmvdixF06A+l+dnmtItQbJYHgEW3QQNAfgg724QoHgcY
	 MI9G8bfX9pofPvdV5NfcEAhIePV+9p8VR4D8yE3nDX0vaN+L72qvF44ESIor/UL1tX+lt
	 evZzR5rvq+ZvAmXAnN4wLUhFdQlPkK3las5Hifyy41OE742kg1xnhycnI8w3p8whe2yg5
	 24PubqodDnpJjcwcPkINDGfhXmGTyslO/U+b7ghs8fZ2HRjAHh2BoYltfjgiIA8JqgvvD
	 SZFjZCHnSjAbCLfwmddnHBg4Z+OtmAKqYYNR4b++RcQiF6pj0mWvqG8t3qid4RWbVpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AhqxZhPw;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C4606A321;
	Fri, 30 Oct 2026 10:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E84C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AhqxZhPw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793354449; x=1824890449;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HaKzP3810qJc116puiQADiUuz5O1FIDoNR4g6mlq8v8=;
  b=AhqxZhPwolvonocZIXvww7LXaymX+LfzDQFSZqFcXR1k13fCsW8j/FxL
   zCXXqrtQDYtQFftrpEWhPHn78JpbBJXxZyeN6NZDy+itvIBjitsx8GT15
   MhYDhIQIYU739YSvLdNS1BFkbJOA87BOewt7FoIydy+KpmEBOKZx+qrQv
   WZkaqa5Py88z5pz2MO5SJEfkfqijpl9wLj1/+ssTXDFNi8YK1J8mJqXMy
   jCS5EQWY7oX9NPToOQMkwE8z8IumUzCYl0HJK3ejEoEmmTRCWwV97x3J4
   de+m0A+JIeA3C7Rr4rSgi6vE7B/0L1dFKQ1d7EUXlea2FU5Fe90Uhcl5x
   A==;
X-CSE-ConnectionGUID: WD1rfvyDR52E7pr7vNqFnA==
X-CSE-MsgGUID: VaCGPhGgQCOYfyhN1r4F/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2001669"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2001669"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 03:00:48 -0700
X-CSE-ConnectionGUID: 9X1qCIjjSt+PfUy51gRjaw==
X-CSE-MsgGUID: FummiFHNSVWXyiswHYi6ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5521270"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 03:00:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 12:00:41 +0200 (EET)
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
Subject: Re: [PATCH v5 7/8] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-7-53b433aebbf8@gmail.com>
Message-ID: <6499d93e-c6e3-7bfe-b717-a2e032137e1a@linux.intel.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com> <20261029-submit-h616-uart-fifo-v1-v5-7-53b433aebbf8@gmail.com>
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
> zero or truncated thresholds.
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
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 3bc6735fc253..2ab91f479fc6 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -17,6 +17,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/limits.h>
>  #include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -45,6 +46,10 @@
>  #define RZN1_UART_xDMACR_8_WORD_BURST	(2 << 1)
>  #define RZN1_UART_xDMACR_BLK_SZ(x)	((x) << 3)
>  
> +/* Allwinner FIFO Clock Control register */
> +#define SUNXI_UART_FCC			0xf0
> +#define SUNXI_UART_FCC_FIFO_DEPTH		GENMASK(31, 8)
> +
>  /* Quirks */
>  #define DW_UART_QUIRK_OCTEON		BIT(0)
>  #define DW_UART_QUIRK_ARMADA_38X	BIT(1)
> @@ -64,6 +69,7 @@
>  struct dw8250_platform_data {
>  	u8 usr_reg;
>  	u32 cpr_value;
> +	/* Fixed sunxi FIFO depth; zero selects discovery through FCC */

Please generalize the wording by removing sunxi, it might true today but 
as more drivers start to use it, then the comment gets obsoleted by the 
code additions.

>  	unsigned int fifo_size;
>  	unsigned int quirks;
>  	int (*setup)(struct uart_port *p);
> @@ -729,6 +735,16 @@ static int dw8250_sunxi_setup(struct uart_port *p)
>  	p->type = PORT_16550A;
>  	p->flags |= UPF_FIXED_TYPE;
>  	p->fifosize = data->pdata->fifo_size;
> +	if (!p->fifosize) {
> +		u32 fcc = dw8250_readl_ext(p, SUNXI_UART_FCC);
> +
> +		p->fifosize = FIELD_GET(SUNXI_UART_FCC_FIFO_DEPTH, fcc);
> +	}
> +	/* The RX trigger table must contain positive, byte-sized thresholds */
> +	if (p->fifosize < 4 || p->fifosize - 2 > U8_MAX)

As is, these checks are hard to understand / connect to why.

It would make this more obvious if you'd name those literals so they'd 
connect to the FCR side code (naming should be done already in the FCR 
patch, obviously).

> +		return dev_err_probe(p->dev, -EINVAL,
> +				     "invalid FIFO size %u\n", p->fifosize);
> +
>  	up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_AFE;
>  
>  	dw8250_sunxi_setup_rxtrig(p);
> @@ -972,6 +988,12 @@ static const struct dw8250_platform_data dw8250_h616_data = {
>  	.setup = dw8250_sunxi_setup,
>  };
>  
> +static const struct dw8250_platform_data dw8250_a523_data = {
> +	.usr_reg = DW_UART_USR,
> +	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> +	.setup = dw8250_sunxi_setup,
> +};
> +
>  static const struct dw8250_platform_data dw8250_octeon_3860_data = {
>  	.usr_reg = OCTEON_UART_USR,
>  	.quirks = DW_UART_QUIRK_OCTEON,
> @@ -1024,6 +1046,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
>  static const struct of_device_id dw8250_of_match[] = {
>  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>  	{ .compatible = "allwinner,sun50i-h616-uart", .data = &dw8250_h616_data },
> +	{ .compatible = "allwinner,sun55i-a523-uart", .data = &dw8250_a523_data },
>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> 
> 

-- 
 i.
