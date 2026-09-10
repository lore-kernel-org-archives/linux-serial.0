Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE973C3F50;
	Thu, 10 Sep 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029899; cv=none; b=pPTw3bT+FYOuW1Q0+oNNSBHUDcgkeIPhDI/ra3LH6RnPO9Bs1TLBhya27wUNryQN2lpRq+lpoLPte9BRvZ+nlvqYyKF/t/aAu5ZYf0rACWX2ikJyaXSX144X75zYBV8e1ZZJG2824BWWZWmjfRg8JSKCCrq1pxx9Mj5xVurz1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029899; c=relaxed/simple;
	bh=yHF/t7fo4m7uiGHEup1QALUVhVMyuRlqvqxKVfUDfnU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q0PB/SVp52mMn6LO0Zr3a9HCh/NNyL8kC4RurtwaWyDwvpKuy+8+qrGKm6Qsmi0QFt246AhdjTLHujuUPNDlZmuGgzXOLdmNolYLW3m+A92Lc01yz0NDH33VX+wVWmUk7xkUr6bfB31UOhYU0wwk/tv0kPDR5aWOUULQ5nzasBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgtWHfq7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgtWHfq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789029896; x=1820565896;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yHF/t7fo4m7uiGHEup1QALUVhVMyuRlqvqxKVfUDfnU=;
  b=KgtWHfq7L9Cdr0vwFn8DCWVgZimxtzJmrd7hw7TSEXjQcYfhM1eZoKKA
   W+S5GolaiS2bquIGLrOgVb0RZ7P/jrSi3ScPXHG/wSLUacUizm847qRuh
   IQCRL+FZRQUpwG3XITuzmyDVthKLtR1vmfqMl1+vw873rWFeAP7Uyax7m
   Vbh5Okld6LpWvYwKyxYLSrwG1vTxZBn3UJff4ODXRCXyiW4PDN01R8tHt
   ovEhh9/WuSn0OP+dXCMNK3JW+G4MBWzyqeEVw0yLjKgfkkR/iieHrRQ+c
   MhP9Zca8NaodOB1U+3NfxK6k8GYjj7RO0RNhdLy43T72tKdhWJfaaUABx
   g==;
X-CSE-ConnectionGUID: Oe3PkrMCRDqMpLNvJIXFhw==
X-CSE-MsgGUID: nnxumqzTSK2P1Sx6A2oElw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100134957"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="100134957"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 01:44:54 -0700
X-CSE-ConnectionGUID: 5c0auEYrQJ+J/JRK8/8NQA==
X-CSE-MsgGUID: OIeno0AwRwaIfq4Il33w4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="295059833"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 01:44:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 10 Sep 2026 11:44:35 +0300 (EEST)
To: Long Zhao <longzhao@ambarella.com>
cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
    linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Michael Turquette <mturquette@baylibre.com>, 
    Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
    Bartosz Golaszewski <brgl@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
    mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
    linux-gpio@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75 quirks
In-Reply-To: <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
Message-ID: <07cdbec9-49af-d500-d93d-56bfcef9f490@linux.intel.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com> <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Sep 2026, Long Zhao via B4 Relay wrote:

> From: Long Zhao <longzhao@ambarella.com>
> 
> The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
> licensed block. At the register level it is close enough to DW APB UART
> that a full custom UART driver is unnecessary: reuse 8250_dw with a
> small platform quirk.
> 
> Quirks:
> - keep IER ETOI (bit 5) set for RX timeout behaviour
> - skip set_rate; baud clock is managed outside the UART block
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 5fba913f3301..b15de40d1e2a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -43,6 +43,9 @@
>  #define RZN1_UART_xDMACR_8_WORD_BURST	(2 << 1)
>  #define RZN1_UART_xDMACR_BLK_SZ(x)	((x) << 3)
>  
> +/* Ambarella IER: receive timeout interrupt enable */
> +#define AMBARELLA_UART_IER_ETOI		BIT(5)
> +
>  /* Quirks */
>  #define DW_UART_QUIRK_OCTEON		BIT(0)
>  #define DW_UART_QUIRK_ARMADA_38X	BIT(1)
> @@ -60,6 +63,7 @@
>  
>  struct dw8250_platform_data {
>  	u8 usr_reg;
> +	u8 ier_mask;
>  	u32 cpr_value;
>  	unsigned int quirks;
>  };
> @@ -572,6 +576,27 @@ static void dw8250_prepare_rx_dma(struct uart_8250_port *p)
>  	dw8250_writel_ext(up, RZN1_UART_RDMACR, val);
>  }
>  
> +static int dw8250_ier_mask_startup(struct uart_port *p)
> +{
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +	int ret;
> +
> +	ret = serial8250_do_startup(p);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
> +	 * timeout behaviour. Force them into the 8250 IER shadow so later
> +	 * generic IER updates do not clear them.
> +	 */
> +	up->ier |= d->pdata->ier_mask;
> +	serial_port_out(p, UART_IER, up->ier);

serial8250_do_startup() seems to defer IER update on purpose. Is it fine 
to override that behavior here?

-- 
 i.

> +	return 0;
> +}
> +
>  static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  {
>  	unsigned int quirks = data->pdata->quirks;
> @@ -606,6 +631,8 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  		p->serial_in = dw8250_serial_in32;
>  		data->uart_16550_compatible = true;
>  	}
> +	if (data->pdata->ier_mask)
> +		p->startup = dw8250_ier_mask_startup;
>  }
>  
>  static void dw8250_reset_control_assert(void *data)
> @@ -879,6 +906,12 @@ static const struct dw8250_platform_data dw8250_intc10ee = {
>  	.quirks = DW_UART_QUIRK_IER_KICK,
>  };
>  
> +static const struct dw8250_platform_data dw8250_ambarella_cv75_data = {
> +	.usr_reg = DW_UART_USR,
> +	.ier_mask = AMBARELLA_UART_IER_ETOI,
> +	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> +};
> +
>  static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
>  	.usr_reg = DW_UART_USR,
>  	.cpr_value = FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
> @@ -889,6 +922,7 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
>  };
>  
>  static const struct of_device_id dw8250_of_match[] = {
> +	{ .compatible = "ambarella,cv75-uart", .data = &dw8250_ambarella_cv75_data },
>  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
> 
> 
