Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355360;
	b=LBaySvlur9zwBJA/w+rHBktvT0w3kqMh0X6Mq5Pjxcib/4TSHoI021F1ppdgNYS2o55M
	 6cvWzUi1eeLB/K/UKrUjegHje2NEfhKdrdn7Zh/YU3IogAtzSHxk3de7HMReJz44c8XGd
	 NNkLxxiFZmq6WqpwvGscfN2rDVU6wZMSpayf9GXdE2HJwwqFy2qqTnpCwUUFaxmF6FP+O
	 w1l3Q0Va+3SCiRZqZ5+PtWVPg7RACcCQxZsJxFGdt5DQjQhqHjE9BvXWqwHKhKRtHy7HG
	 QBMGWeKRMSh98DFPjDo7843PNy4Q17HJtdjs18SUAedDVdYCcjuvOvdT7RjFIZlptdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355360;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=kkuv7O8q4cZvOapU+GF7kcHYvW6qtmGdZ3sS6JlSXTM=;
	b=Ob1c30o4SU6g4e7waSS9Vr5NAwgM3+BSf6knPyhJ9KWgVW3QBZQpynSyD3aRr9wPT0Yc
	 vTxojDzI0lOV7/++S9yqFz7uEpMD4XEwnNha5NhF/ng0u9CQxr7kuoOKhhsIWTsTN0j2P
	 33Q5BzUS0Qdg1sKWKI5W4TM6Vlwqoj99Scu8/71KzEA83D8n/3a0w4P3CijCd75GZLWXF
	 UxZLGZ2k7SPNruZwpdW9CjrO8NSRxB0qkH8uI9a8UUwWP+SA5NappzlD89RLVKCORZyVI
	 BIQn9OrWd1ZMF3RLqQEFGAe0kwrsKtPtKxI6J+n/8CPFjJb+yk4Bw4hzqCXl9RK7Ykg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JNJHQQiO;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E2606A31E;
	Fri, 30 Oct 2026 10:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D19E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JNJHQQiO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793355360; x=1824891360;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R+nXYiYx7BRcU9Txb0qgGufnwiu0QV9je3piyvExs5Y=;
  b=JNJHQQiOJZKhBltWPxUDqpj9Qj1Mb0wkeZZG11/KVY9EhFgMP/fsgZHO
   dqw22CiuFm+m/V5Gb4rgI5ZHfOcF4SSq8t2ZQ/VD8GctH2kheq9Z1tH+C
   prOBdFlqcigAsLCZNd8Ub97LsQT3GjHz7DI47Aq/QlZqgIttWidHHYdEP
   7Mnww578anwx31XzGj7p4CQILCBExdhxWBmNE2tTynxfX1hQjUgsmb4XK
   SClUXvkMrU/yY7lYNB8w64g8xXAfvxTpy3xr6Labnh1Dc7HMyZ0/EW6uK
   Ihmspk+xTzkUH/McNhEFyuC5RGERP+wT4XLIfNdb6shkN95jmCrPCmXX/
   Q==;
X-CSE-ConnectionGUID: smSCnRHWTFi40h5v5Uj9MQ==
X-CSE-MsgGUID: /wfF+frSSxG4IocZWNvnaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2116785"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2116785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 03:15:59 -0700
X-CSE-ConnectionGUID: rt5aEbZaTLaQ3qY9NGwQOQ==
X-CSE-MsgGUID: 9YaRD7l3S2mTmC0XfSnmRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5305192"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 03:15:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 12:15:51 +0200 (EET)
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
Message-ID: <3d7af02e-4196-bb82-9579-467e88879021@linux.intel.com>
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

One additional comment.

What is the reason for this "byte-sized" limit? Is it Allwinner specific 
or perhaps the use of unsigned char in 8250 driver to store them?

In the DW databook the CPR given fifosizes go all the way up to 2k. I'm 
not sure how large actual UARTs make them but applying the FCR formulas 
one could get > U8_MAX thresholds.

If it's just 8250 drivers type limitation, I think the comment should 
make that obvious the type could be changed as needed.

-- 
 i.

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

