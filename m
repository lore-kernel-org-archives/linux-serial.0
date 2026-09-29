Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450635C69D;
	Tue, 29 Sep 2026 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664623; cv=none; b=Oc5IgVaVrvWt9SY2c6klrvpD269rSh/rc1j++73mxZL9dB+6YjTbpLPsk1HlP5s6TgHD2iJfnHnZxj2GAcBmIwxGYEyculdJWghO1Gn6y1xVzFLeYBAb8S8eQLc2a5/+ns4Pcuv3IEf5Hm9ehoRJlq/keDwfF/BQ1lr9JURK8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664623; c=relaxed/simple;
	bh=icXQJlJ2gE2aKfbGJbgwrG3Kq+4XdfW1MP3OKZ1JDlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6yyskgTlVsudXdmbgihnl2mlyNh99ReRKg85jneMBJhetBuIFzu8zYkhfZG1C/JANGy5Z2oEN3ORVEZjFjgGtl+1uY2YzdGyOUlbY45gVJqnXbmkQHbPxDdRjBJcCgEQ4YZjoWng29deRKCxx9yqOEvePzpXs2uQqu+iPy8TxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVVqwSIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVVqwSIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B11F000FF;
	Tue, 29 Sep 2026 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664622;
	bh=3QNnYrmPWFJ3dHPbxUuYCkeu7U1ZSe+QYcoj8h3lGiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVVqwSIWMtVOJ0LtFWfhF6p7M6Y+WOAKiT4/cpSAqbIEkBXNP7tck/ohnsseOtgJC
	 Raul5dacReRH1qcsup5lXIAaVcOgbwdXtqJCTLm0Gze3sFjrBpyfV84TDxnu0/cKtS
	 o4ZyRp3k7E+MlHRLVZOf2yuV7t4PITN6GhOnzjUYyDfjTiIy0WCmQV9u0dJ3AndNW/
	 Y5n8SZqCNBQkwFtZmxmKVetOcjWPPBRfoV0SvhwkmZhEuZr7TiE/uC6OUvmUL6QcZn
	 tBkrUDDutmuDhvod43p02CemQ7X8rSgxmyn0WIxmhh1CgV2Ob5+No2+xvcak1M5AYA
	 Wf/a/NIzvRZbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/20] clk: berlin: add Synaptics SL261X SoC clocks and
 plls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: conor+dt@kernel.org, linux-serial@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, Frank.Li@kernel.org, linux-i3c@lists.infradead.org, mfd@lists.linux.dev, robh@kernel.org, linux-clk@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260929061417.20733-17-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-17-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:50:20 +0000
Message-Id: <20260929065021.5E2B11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] clk: berlin: missing .disable callbacks in sysmgr clock operatio=
ns
- [Low] kbuild: Linker error due to missing Kconfig dependency for SL261X_P=
LL
--

commit 56d97606c2f6bbb88d4a36a5f8b06b807c05523d
Author: Jisheng Zhang <jszhang@kernel.org>

clk: berlin: add Synaptics SL261X SoC clocks and plls

Add support for clocks, plls in Synaptics SL261X SoCs.

> diff --git a/drivers/clk/berlin/Kconfig b/drivers/clk/berlin/Kconfig
> new file mode 100644
> --- /dev/null
> +++ b/drivers/clk/berlin/Kconfig
[ ... ]
> +config SL261X_CLK
> +	tristate "Synaptics SL261X Clock Driver"
> +	depends on ARCH_BERLIN || COMPILE_TEST
> +	select SL_COMMON_CLK
> +	select SL_SYSMGR_CLK
> +	default n

[Severity: Low]
Does this missing dependency lead to a linker error? The SL261X_CLK config
fails to declare a dependency or select on SL261X_PLL, but the clock driver
unconditionally calls sl261x_pll_register() defined in the PLL driver. If
CONFIG_SL261X_CLK=3Dy but CONFIG_SL261X_PLL=3Dn or m, the build will fail w=
ith an
undefined reference.

[ ... ]
> diff --git a/drivers/clk/berlin/sl-sysmgr-clk.c b/drivers/clk/berlin/sl-s=
ysmgr-clk.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/clk/berlin/sl-sysmgr-clk.c
[ ... ]
> +static const struct clk_ops sl_sysmgr_gateclk_ops =3D {
> +	.enable		=3D sl_sysmgr_gateclk_enable,
> +	.is_enabled	=3D sl_sysmgr_gateclk_is_enabled,
> +};

[Severity: Medium]
Will this leave the gate clocks permanently enabled? The ops struct for gate
clocks implements .enable to ungate the clock but omits the .disable callba=
ck.
When a consumer driver calls clk_disable_unprepare(), the common clock
framework will silently skip the hardware operation, leaking power.

[ ... ]
> +static const struct clk_ops sl_sysmgr_clk_ops =3D {
> +	.recalc_rate	=3D sl_sysmgr_clk_recalc_rate,
> +	.enable		=3D sl_sysmgr_clk_enable,
> +	.is_enabled	=3D sl_sysmgr_clk_is_enabled,
> +};

[Severity: Medium]
Does this have the same issue with missing disable operations? The ops stru=
ct
for divider clocks implements .enable but also omits the .disable callback.

[ ... ]
> diff --git a/drivers/clk/berlin/sl261x-clks.c b/drivers/clk/berlin/sl261x=
-clks.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/clk/berlin/sl261x-clks.c
[ ... ]
> +static int sl261x_soc_clk_setup(struct platform_device *pdev)
> +{
[ ... ]
> +	/* sysplls */
> +	ret =3D sl261x_pll_register(dev, base + SYSPLL0_OFFSET,
> +				  clk_names[SYSPLL0_OUT], clk_names[SYSPLL0_OUTF]);

[Severity: Low]
This is the call to sl261x_pll_register() mentioned above that requires
SL261X_PLL to be selected or depended on in Kconfig to avoid linker errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D16
