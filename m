Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D8224BBEB;
	Thu,  6 Aug 2026 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786056848; cv=none; b=DM6sAMXtasg7gvL2wsfMOgYU1nXrC35yVlkFtIIh8erdBcCJh2JBkN1kT0gpw5NKouJjg98KY+SGg8qpfqXHUGUuYgrJWaBPtUhe+HVNgYraHRaiYElrtv5+cgTfDZtVo6X1davGuxQ5v9As9A0ItNNpZsqP9m2vLfWxeiDf2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786056848; c=relaxed/simple;
	bh=INJpg97Vjdcs97i99S7lop3sy0oLpvOAASnWJelOOj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLBEPhw+mChg7GWmeZSONX4EFhmYthyq9a41MrX7MxpB9Vi/JQRpFlxO1iFFCrKB5P4lgPWaPZyUlGXUv7piPlgapSEWRLyDM0VBAq/hI6f9gk2xsj72DmnUAP3aOC4Xw3VfrwUYm69yXygIqo7Mhs40xliThXpW2+8X+1UbW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZQ3qRHb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZQ3qRHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786056846; x=1817592846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=INJpg97Vjdcs97i99S7lop3sy0oLpvOAASnWJelOOj8=;
  b=jZQ3qRHbG6etle5Rp81n5aQgy8rBevRUSul5yNgmTEdijy40X5xEAa4W
   VFYBQ1utaiRmQX1Mk4QEsBQy3gCjrzs7Ajoo8gEgkZLIfAvrMCReIcwRB
   oTyqZMtozz+KPPOLk2g0xWPIQMFLYfBhl6Jux2ytnRRRuXmPBEk7yL9an
   N29xCJB/R9LaOECgufjFueolBmbCM2Ze3iJOHsxfSmJVejnI6oZZTMuhr
   hCPKQSJtoofMrGzTz9i1lbZqSD0Msr/TUcdJfAtqEuRkRza2cUUpAA/HD
   Grce5lAKmFPXDbBRfT60smq55StFIkjqvSKszpR2pPYT4/g7+yPI4Ktv3
   A==;
X-CSE-ConnectionGUID: xoKKad50RXGTaUD1/sQC/Q==
X-CSE-MsgGUID: sfd5xSYiRoC3LsGvKYWQ+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97314357"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="97314357"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:54:04 -0700
X-CSE-ConnectionGUID: iZUZ07JeRnCwI7fuIv19kQ==
X-CSE-MsgGUID: sjrwq9tNSayCMc3WOYPdWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="262854063"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:53:59 -0700
Date: Fri, 7 Aug 2026 01:53:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250: Add Airoha SoC UART and HSUART
 support
Message-ID: <anUQhbuHSDRs04bq@ashevche-desk.local>
References: <20260724183007.188172-1-ansuelsmth@gmail.com>
 <20260724183007.188172-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724183007.188172-3-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 24, 2026 at 08:30:06PM +0200, Christian Marangi wrote:
> Add support for Airoha AN7523 UART and AN7581 HSUART.
> 
> These implement a standard 16550 UART with only some custom logic
> for baud rate handling.

I tried not to clash with Ilpo's review (all he said is still applicable here).

...

> +#define XINDIV_CLOCK		20000000


20 * HZ_PER_MHZ

(should include units.h)

...

> +static const struct airoha_8250_clk_div_info airoha_clk_div_info[] = {
> +	{ .div = 10, .mask = BIT(2) },
> +	{ .div = 4, .mask = BIT(1) },
> +	{ .div = 2, .mask = BIT(0) },
> +};

The (reversed) array of integers should suffice.

static const unsigned int airoha_clk_divs[] = { 2, 4, 10 };

See below for more.

...

> +static void airoha_set_divisor(struct uart_port *port, unsigned int baud,
> +			       unsigned int quot, unsigned int quot_frac)
> +{
> +	const struct airoha_8250_clk_div_info *clk_div_info;
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	u32 xindiv_clk;
> +	u64 xyd_x, nom;

> +	int i;

Not used outside of the loop, define it there.

> +	/* Set DLAB to access the baud rate divider registers (BRDH, BRDL) */
> +	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
> +
> +	/* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */
> +	serial_port_out(port, UART_AIROHA_BRDL, UART_BRDL_20M);
> +	serial_port_out(port, UART_AIROHA_BRDH, UART_BRDH_20M);

The above three calls repeat serial8250_do_set_divisor(), don't they?

	/* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */
	serial8250_do_set_divisor(port, baud, 1);

> +	/*
> +	 * Calculate XYD_x and XINCLKDR register by searching
> +	 * through a table of crystal_clock divisors.
> +	 */
> +	nom = baud * XYD_Y;

> +	for (i = 0 ; i < ARRAY_SIZE(airoha_clk_div_info) ; i++) {
> +		clk_div_info = &airoha_clk_div_info[i];
> +		xindiv_clk = XINDIV_CLOCK / clk_div_info->div;

	for (unsigned int i = ARRAY_SIZE(airoha_clk_div_info) - 1; i >= 0; i--) {
		xindiv_clk = XINDIV_CLOCK / BIT(i);

Also variant (but may be a little bit confusing)

	for (unsigned int i = ARRAY_SIZE(airoha_clk_div_info); i; i--) {
		xindiv_clk = XINDIV_CLOCK / BIT(i - 1);

> +		xyd_x = div_u64(nom, xindiv_clk) * 16;
> +
> +		/* For the HSUART xyd_x needs to be scaled by a factor of 2 */
> +		if (port->type == UART_PORT_AIROHA_HS)
> +			xyd_x /= 2;
> +
> +		if (xyd_x < XYD_Y)
> +			break;
> +	}
> +
> +	serial_port_out(port, UART_AIROHA_XINCLKDR, clk_div_info->mask);
> +	serial_port_out(port, UART_AIROHA_XYD,
> +			FIELD_PREP(UART_AIROHA_XYD_X, xyd_x) |
> +			FIELD_PREP(UART_AIROHA_XYD_Y, XYD_Y));

> +	/* Restore normal register access. */
> +	serial_port_out(port, UART_LCR, up->lcr);

Hmm... do you really need this? It doesn't seem required (at least for many
other 8250 compatible devices).

> +}

...

> +static int airoha_8250_probe(struct platform_device *pdev)
> +{
> +	struct uart_8250_port uart = { };
> +	struct device *dev = &pdev->dev;
> +	struct airoha_8250_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return dev_err_probe(dev, -EINVAL, "invalid address\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	uart.port.dev = dev;
> +	if (device_is_compatible(dev, "airoha,an7581-hsuart"))
> +		uart.port.type = UART_PORT_AIROHA_HS;
> +	else
> +		uart.port.type = UART_PORT_AIROHA;

> +	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
> +			  UPF_FIXED_TYPE | UPF_IOREMAP;

> +	uart.port.set_divisor = airoha_set_divisor;
> +	uart.port.get_divisor = airoha_get_divisor;
> +	uart.port.mapbase = res->start;
> +	uart.port.mapsize = resource_size(res);

> +	ret = uart_read_and_validate_port_properties(&uart.port);

I'm not sure about 'validate' as only one or two drivers use it. Just double
check that this is indeed what you want (read the kernel-doc for that function
carefully, it's not that trivial, unfortunately).

> +	if (ret)
> +		return ret;
> +
> +	ret = serial8250_register_8250_port(&uart);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->line = ret;
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}

...

> +static const struct of_device_id airoha_8250_dt_ids[] = {
> +	{ .compatible = "airoha,en7523-uart" },
> +	{ .compatible = "airoha,an7581-hsuart" },
> +	{ },

No comma in the terminator.

> +};

...

> +static struct platform_driver airoha_8250_driver = {
> +	.driver = {
> +		.name = "8250_airoha",
> +		.of_match_table = airoha_8250_dt_ids,
> +	},
> +	.probe = airoha_8250_probe,
> +	.remove = airoha_8250_remove,
> +};

> +

Drop this redundant blank line.

> +module_platform_driver(airoha_8250_driver);

-- 
With Best Regards,
Andy Shevchenko


