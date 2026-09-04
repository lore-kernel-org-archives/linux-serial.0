Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E33CF952
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507881; cv=none; b=iKJOsQsfJVW6rCe2Nhp4JVyK6KXga+L8IJlvAC347km2ofP1UxwOLdfRxjsvroL5lZmlx/H+d78b+c/+avbm6/a7QyLiuNpLVIx+7plGpoiDjULGBTMi7ozQs7lTmxmBXFbClvNTOHZ/Q3hrLJ1Udmvp1ypD5h8ccdfOvJ5utvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507881; c=relaxed/simple;
	bh=SxixLoJpvWUpuYUtzMHD+zbfVEWQKfv8O8wWXfnoV6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GeSZjG/p4mXqeW+aHgsILckGl16uh1GBiIeC9rLjWoAHQ0H5yfo/pjFguKNPTQTkcxIM1YT6dk4gr6jlf0lqMiuYc96LwvpWzLY6T3vSvEpjTtshidZwY5gJoJDORIA9zPGAK21Lr127Tre2FoV1Z4Wnb6aOBWS9sTga9GBrB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=IFYtzgP4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="IFYtzgP4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso7825365e9.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788507876; x=1789112676; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mn4IHvl7GoSJtXJxPkH6IqdGI00c13eMeep4WJbgeXM=;
        b=IFYtzgP4INXs2MNoA1FybG8NHCSY8V5lkzuFohxasp1iFIPSB9Zdfxov6AxiW9f2Oz
         nxAI2StF6FxjDg64zPzlfXTLqN4hjPMpPx2MjhaY4dwmitKeKvMAGWUuP6EonX+JP+0R
         Ji76CzJX3dAQ2ZwMkMl6AYVc3ssyswxPPBWIlFxXstVzIV3stsodxQw1eVaAXpx0qrV6
         lzJ927pJJI09rCfulgg80Owo/ne2qu1VxDtZJvb5JX561CnQaBAew2PAW6yqhu8ZSBkS
         3PUsl9xwOC7PV5OZTUWleggwguATzAGEenVWwTIqAyj5bVH2EeyYImh/Y5VoJ2cMu6vl
         Vfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507876; x=1789112676;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mn4IHvl7GoSJtXJxPkH6IqdGI00c13eMeep4WJbgeXM=;
        b=Zld9oAqRexoIXX+WAUIrLHMJQEOwTD81ivvUH8HiH7qFxB2uZ+eZnPnoeLovFwSa2o
         CGz/mvAn19uuVgBtzWkIm1SSa/LZO8a/caI3yw54KiknYyEbx5eCr0wJqmkNzGKb+2/B
         NGvP8vmz0z5x1ketqjxB3WLFYmbUw2+L513nBhM6CpooY273g2QmsXMDnbK5EwzntYaC
         OV1KAViLoSYXbk50f/o5/giywLJhEMy5muFYkr+s3HRm5uwQZCCL2wGubunJzEtjKDRQ
         FJG2QIWII2pmviHklEpCQJv5Dw0ERUo46pa9mF/QjQOZd1UD19+OeCCtM66kOyGJ22wy
         gMsA==
X-Forwarded-Encrypted: i=1; AKwUvBzkjvErnR4g4SLchlvpA7/bfXuDNHNuROMrUy/JUpRRWv/a8nHNNIK/iv2V2J02eBPQXhd92W4N18ctKe0=@vger.kernel.org
X-Gm-Message-State: AFuF++nlZprKxWAqFIxFb/YfYOK3zEJfxQY6yl6udRM/KfWEW3MKr3Ii
	DNw123I8CGjg0dryHFLYoQe8j3FFuVBl1egXWHHGKsR9DING19Cfks/TjYDXGDKaELs=
X-Gm-Gg: AYBFou17jWMMHUPMGEjvaJzzJu/Xy8ppsvw/dXQTNFx4QxlgGaKYIwWN/7qXjsCJwiV
	qihPGoEGUDAx/Vj8TrhLTcxE+vj/gdBCjUEgK8LE/sVuTnC5wFpFvuBFWdcPurcxPh7CN/JSw8M
	Yr+V7R0qZhxz1sBHuXIUybzxvEcwhSNHU5bLr5O1EY8ijIndkPs/I6SeFlR1W/G/tgiGK8OrY4u
	V5nGNAeseHkRQ8rLnez9diWL7uRE30DixrIrNEpoyJuPLxLfBFcrEe9fp5SGi8+6P8QorIWixi5
	yIrm+Tb7I8dkysFQii88X+Rt/3ixU2CS+LGciwyxGx/QNmE4piNr2TCKu/SJyMYQTpkLZqvEf8V
	rYMjrN3Fw9L7aJSpYn07BGkg8vSxU7HlAwUW2b8/R7EVdyGgd7PJByVCzFAlLQK7MhvNsrAXIow
	RI5kkNE551AFpxC+ZFx73OUSo8XkSCfhib4nvP6uZEhN50tIRm15BIMybAmHrvEwMbNH39nPO3S
	K0frpA=
X-Received: by 2002:a05:600c:8b88:b0:49c:db20:da13 with SMTP id 5b1f17b1804b1-49cf822a707mr50344025e9.5.1788507876122;
        Fri, 04 Sep 2026 00:44:36 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858791bddasm4826929f8f.0.2026.09.04.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:44:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvi?=
 =?utf-8?Q?nen?=
 <ilpo.jarvinen@linux.intel.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao
 <zl020895@163.com>, Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/13] clk: ambarella: add CV75 CCU driver
In-Reply-To: <20260904-cv75-v5-v6-7-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-7-e918514cb3b1@ambarella.com>
Date: Fri, 04 Sep 2026 09:44:33 +0200
Message-ID: <1jse3plau6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ven. 04 sept. 2026 at 14:38, Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Add the Ambarella CV75 clock driver covering the core PLL and the
> UART0 / AHB / APB clocks needed for early console bring-up.
>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  drivers/clk/Kconfig                 |   1 +
>  drivers/clk/Makefile                |   1 +
>  drivers/clk/ambarella/Kconfig       |  13 ++
>  drivers/clk/ambarella/Makefile      |   6 +
>  drivers/clk/ambarella/ccu-cv75.c    | 296 +++++++++++++++++++++++++
>  drivers/clk/ambarella/ccu_common.c  |  60 +++++
>  drivers/clk/ambarella/ccu_common.h  |  25 +++
>  drivers/clk/ambarella/ccu_mux_div.c | 234 ++++++++++++++++++++
>  drivers/clk/ambarella/ccu_mux_div.h |  35 +++
>  drivers/clk/ambarella/ccu_pll.c     | 421 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/ambarella/ccu_pll.h     |  70 ++++++
>  11 files changed, 1162 insertions(+)

Again seems like this could be split. AFAICT, you are adding 2 clock
driver and a controller

>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 1717ce75a907..fbbf4963716c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -506,6 +506,7 @@ config COMMON_CLK_RPMI
>  	  the RISC-V platform management interface (RPMI) specification.
>  
>  source "drivers/clk/actions/Kconfig"
> +source "drivers/clk/ambarella/Kconfig"
>  source "drivers/clk/analogbits/Kconfig"
>  source "drivers/clk/aspeed/Kconfig"
>  source "drivers/clk/bcm/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index cc108a75a900..30d823ee606f 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -112,6 +112,7 @@ obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
>  
>  # please keep this section sorted lexicographically by directory path name
>  obj-y					+= actions/
> +obj-y					+= ambarella/
>  obj-y					+= analogbits/
>  obj-y					+= aspeed/
>  obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
> diff --git a/drivers/clk/ambarella/Kconfig b/drivers/clk/ambarella/Kconfig
> new file mode 100644
> index 000000000000..d79bb4bd6df5
> --- /dev/null
> +++ b/drivers/clk/ambarella/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config CLK_AMBARELLA_CV75
> +	bool "Ambarella CV75 RCT clock controller"
> +	depends on ARCH_AMBARELLA || COMPILE_TEST
> +	select CLK_AMBARELLA_CCU
> +	default ARCH_AMBARELLA
> +	help
> +	  Say Y to enable the Ambarella CV75 RCT clock controller.
> +
> +config CLK_AMBARELLA_CCU
> +	bool
> +	select REGMAP_MMIO
> diff --git a/drivers/clk/ambarella/Makefile b/drivers/clk/ambarella/Makefile
> new file mode 100644
> index 000000000000..36e96326ea97
> --- /dev/null
> +++ b/drivers/clk/ambarella/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for ambarella specific clk
> +#
> +
> +obj-$(CONFIG_CLK_AMBARELLA_CCU) += ccu_common.o ccu_mux_div.o ccu_pll.o
> +obj-$(CONFIG_CLK_AMBARELLA_CV75) += ccu-cv75.o
> diff --git a/drivers/clk/ambarella/ccu-cv75.c b/drivers/clk/ambarella/ccu-cv75.c
> new file mode 100644
> index 000000000000..c4828be598be
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu-cv75.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Ambarella, Inc.
> + *
> + * CV75 RCT clock controller for boot clocks.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/ambarella,cv75-rct.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_mux_div.h"
> +#include "ccu_pll.h"
> +
> +enum amb_cv75_clk_type {
> +	AMB_CV75_CLK_FIXED_RATE,
> +	AMB_CV75_CLK_FIXED_FACTOR,
> +	AMB_CV75_CLK_PLL,
> +	AMB_CV75_CLK_DIV,
> +	AMB_CV75_CLK_MUX_DIV,
> +};
> +
> +enum amb_cv75_clk_ref {
> +	AMB_CV75_CLK_REF_OSC = -1,
> +	AMB_CV75_CLK_REF_DUMMY = -2,

This is fishy, needs a comment at least

> +};
> +
> +/* PLL version for CV75 (ambarella,clkpll-v1 in vendor DTS) */
> +static const struct amb_pll_soc_data cv75_pll_soc_data = {
> +	.pll_version	= 1,
> +	.fsout_mask	= CTRL2_FSOUT_DIV2,
> +	.fsout_val	= CTRL2_FSOUT_DIV2,
> +	.fsdiv_mask	= CTRL2_FSDIV_DIV2,
> +	.fsdiv_val	= CTRL2_FSDIV_DIV2,
> +	.vcodiv_mask	= CTRL2_VCODIV_DIV2,
> +	.vcodiv_val	= CTRL2_VCODIV_DIV2,
> +	.vco_max_mhz	= 2600UL,
> +	.vco_min_mhz	= 850UL,
> +	.vco_range	= { 1800UL, 1400UL, 1100UL, 0UL },
> +};
> +
> +struct amb_cv75_clk_desc {
> +	int id;
> +	enum amb_cv75_clk_type type;
> +	const char *name;
> +	int parent;
> +
> +	union {
> +		struct {
> +			unsigned long rate;
> +		} fixed_rate;
> +		struct {
> +			unsigned long flags;
> +			unsigned int mult;
> +			unsigned int div;
> +		} fixed_factor;
> +		struct {
> +			u32 reg_offset[REG_NUM];
> +			const struct amb_pll_soc_data *soc_data;
> +		} pll;
> +		struct {
> +			u32 reg;
> +			u32 shift;
> +			u32 width;
> +			u32 flags;
> +			u32 fix_divider;
> +		} div;
> +		struct amb_mux_div_desc mux_div;
> +	};
> +};
> +
> +static const struct amb_cv75_clk_desc cv75_clks[] = {
> +	{
> +		.id = AMB_CV75_CLK_REF_DUMMY,
> +		.type = AMB_CV75_CLK_FIXED_RATE,
> +		.name = "dummy",
> +		.fixed_rate.rate = 0,
> +	},

A clock that comes out of nowhere with a rate 0 is not OK.

> +	{
> +		.id = CV75_GCLK_CORE,
> +		.type = AMB_CV75_CLK_PLL,
> +		.name = "core",
> +		.parent = AMB_CV75_CLK_REF_OSC,
> +		.pll = {
> +			.reg_offset = {
> +				0x000, 0x004, 0x100,
> +				0x104, 0x000, 0x000,
> +			},
> +			.soc_data = &cv75_pll_soc_data,
> +		},
> +	},
> +	{
> +		.id = CV75_GCLK_AHB,
> +		.type = AMB_CV75_CLK_FIXED_FACTOR,
> +		.name = "ahb",
> +		.parent = CV75_GCLK_CORE,
> +		.fixed_factor = {
> +			.flags = 0,
> +			.mult = 1,
> +			.div = 2,
> +		},
> +	},
> +	{
> +		.id = CV75_GCLK_APB,
> +		.type = AMB_CV75_CLK_FIXED_FACTOR,
> +		.name = "apb",
> +		.parent = CV75_GCLK_CORE,
> +		.fixed_factor = {
> +			.flags = 0,
> +			.mult = 1,
> +			.div = 4,
> +		},
> +	},
> +	{
> +		.id = CV75_GCLK_UART0,
> +		.type = AMB_CV75_CLK_MUX_DIV,
> +		.name = "uart0",
> +		.mux_div = {
> +			.name = "uart0",
> +			.parents = (const int[]) {
> +				AMB_CV75_CLK_REF_OSC, CV75_GCLK_CORE,
> +				AMB_CV75_CLK_REF_DUMMY, AMB_CV75_CLK_REF_DUMMY,
> +			},
> +			.num_parents = 4,
> +			.mux_reg = 0x1c8,
> +			.mux_shift = 0,
> +			.mux_mask = 0x3,
> +			.div_reg = 0x038,
> +			.div_shift = 0,
> +			.div_width = 24,
> +			.div_flags = CLK_DIVIDER_ONE_BASED,
> +			.fix_divider = 1,
> +		},
> +	},
> +};
> +
> +static struct clk_hw *amb_cv75_get_parent(struct amb_ccu *ccu,
> +					  struct clk_hw *osc,
> +					  struct clk_hw *dummy,
> +					  int parent)
> +{
> +	if (parent == AMB_CV75_CLK_REF_OSC)
> +		return osc;
> +	if (parent == AMB_CV75_CLK_REF_DUMMY)
> +		return dummy;
> +
> +	if (parent < 0 || parent >= ccu->data->num)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ccu->data->hws[parent])
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return ccu->data->hws[parent];
> +}
> +
> +static struct clk_hw *amb_cv75_register_mux_div(struct device *dev,
> +						struct amb_ccu *ccu,
> +						const struct amb_cv75_clk_desc *desc,
> +						struct clk_hw *osc,
> +						struct clk_hw *dummy)
> +{
> +	const struct amb_mux_div_desc *md = &desc->mux_div;
> +	struct clk_parent_data *pdata;
> +	struct clk_hw *parent;
> +	u8 i;
> +
> +	pdata = devm_kcalloc(dev, md->num_parents, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < md->num_parents; i++) {
> +		if (md->parents[i] == AMB_CV75_CLK_REF_OSC) {
> +			pdata[i].fw_name = "osc";
> +			continue;
> +		}
> +
> +		parent = amb_cv75_get_parent(ccu, osc, dummy, md->parents[i]);
> +		if (IS_ERR(parent))
> +			return parent;
> +
> +		pdata[i].hw = parent;
> +	}
> +
> +	return amb_mux_div_register(dev, ccu->map, md, pdata);
> +}
> +
> +static struct clk_hw *amb_cv75_register_clk(struct device *dev,
> +					    struct amb_ccu *ccu,
> +					    const struct amb_cv75_clk_desc *desc,
> +					    struct clk_hw *osc,
> +					    struct clk_hw *dummy)
> +{
> +	struct amb_pll_desc pll_desc;
> +	struct clk_hw *parent;
> +
> +	switch (desc->type) {
> +	case AMB_CV75_CLK_FIXED_RATE:
> +		return devm_clk_hw_register_fixed_rate(dev, desc->name, NULL, 0,
> +						       desc->fixed_rate.rate);
> +	case AMB_CV75_CLK_FIXED_FACTOR:
> +		parent = amb_cv75_get_parent(ccu, osc, dummy, desc->parent);
> +		if (IS_ERR(parent))
> +			return parent;
> +
> +		return devm_clk_hw_register_fixed_factor_parent_hw(dev,
> +				desc->name, parent,
> +				desc->fixed_factor.flags,
> +				desc->fixed_factor.mult,
> +				desc->fixed_factor.div);
> +	case AMB_CV75_CLK_PLL:
> +		parent = amb_cv75_get_parent(ccu, osc, dummy, desc->parent);
> +		if (IS_ERR(parent))
> +			return parent;
> +
> +		pll_desc.name = desc->name;
> +		pll_desc.parent = parent;
> +		memcpy(pll_desc.reg_offset, desc->pll.reg_offset,
> +		       sizeof(pll_desc.reg_offset));
> +		pll_desc.soc_data = desc->pll.soc_data;
> +		pll_desc.frac_mode = false;
> +
> +		return amb_pll_register(dev, ccu->map, &pll_desc);
> +	case AMB_CV75_CLK_DIV:
> +		parent = amb_cv75_get_parent(ccu, osc, dummy, desc->parent);
> +		if (IS_ERR(parent))
> +			return parent;
> +
> +		return amb_div_register(dev, ccu->map, desc->name, parent,
> +					desc->div.reg, desc->div.shift,
> +					desc->div.width, desc->div.flags,
> +					desc->div.fix_divider);
> +	case AMB_CV75_CLK_MUX_DIV:
> +		return amb_cv75_register_mux_div(dev, ccu, desc, osc, dummy);
> +	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +}
> +
> +static int amb_cv75_rct_probe(struct platform_device *pdev)
> +{
> +	struct amb_ccu *ccu;
> +	struct clk *osc_clk;
> +	struct clk_hw *osc, *dummy = NULL, *hw;
> +	int i;
> +
> +	ccu = amb_ccu_init(pdev, ARRAY_SIZE(cv75_clks));
> +	if (IS_ERR(ccu))
> +		return PTR_ERR(ccu);
> +
> +	osc_clk = devm_clk_get(&pdev->dev, "osc");
> +	if (IS_ERR(osc_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(osc_clk),
> +				     "missing osc clock\n");
> +	osc = __clk_get_hw(osc_clk);

If you properly declare your parent_data, you will not have to do this.
just use fw_name in the parent data.

> +
> +	for (i = 0; i < ARRAY_SIZE(cv75_clks); i++) {
> +		hw = amb_cv75_register_clk(&pdev->dev, ccu, &cv75_clks[i],
> +					   osc, dummy);
> +		if (IS_ERR(hw))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(hw),
> +					     "failed to register %s\n",
> +					     cv75_clks[i].name);
> +
> +		if (cv75_clks[i].id == AMB_CV75_CLK_REF_DUMMY)
> +			dummy = hw;
> +		else
> +			ccu->data->hws[cv75_clks[i].id] = hw;
> +	}
> +
> +	return amb_ccu_register(ccu);
> +}

Overall, the controller seems a bit overcomplicated to register 4 clocks.

> +
> +static const struct of_device_id amb_cv75_rct_match[] = {
> +	{ .compatible = "ambarella,cv75-rct" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, amb_cv75_rct_match);
> +
> +static struct platform_driver amb_cv75_rct_driver = {
> +	.probe	= amb_cv75_rct_probe,
> +	.driver = {
> +		.name = "ambarella-cv75-rct",
> +		.of_match_table = amb_cv75_rct_match,
> +	},
> +};
> +module_platform_driver(amb_cv75_rct_driver);
> +
> +MODULE_AUTHOR("Ambarella Inc.");
> +MODULE_DESCRIPTION("Ambarella CV75 RCT clock controller");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/ambarella/ccu_common.c b/drivers/clk/ambarella/ccu_common.c
> new file mode 100644
> index 000000000000..78587c5f2ce1
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu_common.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Ambarella, Inc.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "ccu_common.h"
> +
> +static const struct regmap_config amb_rct_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = AMB_RCT_REG_SIZE - 4,
> +};
> +
> +struct amb_ccu *amb_ccu_init(struct platform_device *pdev,
> +			     unsigned int num_clks)
> +{
> +	struct amb_ccu *ccu;
> +	void __iomem *base;
> +
> +	if (!num_clks)
> +		return ERR_PTR(-EINVAL);
> +
> +	ccu = devm_kzalloc(&pdev->dev, sizeof(*ccu), GFP_KERNEL);
> +	if (!ccu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ccu->dev = &pdev->dev;
> +
> +	ccu->data = devm_kzalloc(&pdev->dev,
> +				 struct_size(ccu->data, hws, num_clks),
> +				 GFP_KERNEL);
> +	if (!ccu->data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ccu->data->num = num_clks;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return ERR_CAST(base);
> +
> +	ccu->map = devm_regmap_init_mmio(&pdev->dev, base,
> +					 &amb_rct_regmap_config);
> +	if (IS_ERR(ccu->map))
> +		return ERR_CAST(ccu->map);
> +
> +	return ccu;
> +}
> +
> +int amb_ccu_register(struct amb_ccu *ccu)
> +{
> +	return devm_of_clk_add_hw_provider(ccu->dev, of_clk_hw_onecell_get,
> +					   ccu->data);
> +}
> diff --git a/drivers/clk/ambarella/ccu_common.h b/drivers/clk/ambarella/ccu_common.h
> new file mode 100644
> index 000000000000..f2bf9d1f06d7
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu_common.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 Ambarella, Inc.
> + */
> +
> +#ifndef __CCU_COMMON_H
> +#define __CCU_COMMON_H
> +
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +
> +#define AMB_RCT_REG_SIZE	0x1000
> +
> +struct amb_ccu {
> +	struct device *dev;
> +	struct regmap *map;
> +	struct clk_hw_onecell_data *data;
> +};
> +
> +struct amb_ccu *amb_ccu_init(struct platform_device *pdev,
> +			     unsigned int num_clks);
> +int amb_ccu_register(struct amb_ccu *ccu);
> +
> +#endif
> diff --git a/drivers/clk/ambarella/ccu_mux_div.c b/drivers/clk/ambarella/ccu_mux_div.c
> new file mode 100644
> index 000000000000..d5259bc347e4
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu_mux_div.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Ambarella, Inc.
> + *
> + * Regmap-backed mux + divider, derived from the vendor composite-clock driver.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/math64.h>
> +#include <linux/regmap.h>
> +
> +#include "ccu_mux_div.h"
> +
> +struct amb_mux {
> +	struct clk_hw hw;
> +	struct regmap *map;
> +	u32 offset;
> +	u32 mask;
> +	u32 shift;
> +};
> +
> +struct amb_div {
> +	struct clk_hw hw;
> +	struct regmap *map;
> +	u32 offset;
> +	u32 shift;
> +	u32 width;
> +	u32 flags;
> +	u32 fix_divider;
> +};

Looks like these a really independent entities, so they don't really
need to be mixed.

> +
> +#define to_amb_mux(_hw)	container_of(_hw, struct amb_mux, hw)
> +#define to_amb_div(_hw)	container_of(_hw, struct amb_div, hw)
> +
> +static u8 amb_mux_get_parent(struct clk_hw *hw)
> +{
> +	struct amb_mux *mux = to_amb_mux(hw);
> +	u32 val;
> +
> +	regmap_read(mux->map, mux->offset, &val);
> +	val >>= mux->shift;
> +	val &= mux->mask;
> +
> +	return val;
> +}
> +
> +static int amb_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct amb_mux *mux = to_amb_mux(hw);
> +
> +	return regmap_update_bits(mux->map, mux->offset,
> +				  mux->mask << mux->shift,
> +				  index << mux->shift);
> +}
> +
> +static const struct clk_ops amb_mux_ops = {
> +	.get_parent = amb_mux_get_parent,
> +	.set_parent = amb_mux_set_parent,
> +};
> +
> +static unsigned long amb_div_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	struct amb_div *div = to_amb_div(hw);
> +	unsigned long rate;
> +	u32 val;
> +
> +	regmap_read(div->map, div->offset, &val);
> +
> +	/* Divider reset/disable bit sits above the field at shift+width. */
> +	if (val & (BIT(div->width) << div->shift))

field_get() ?

> +		return 0;

AFAIU, this divider gates at 0. You need to implement the enable/disable
ops. returning 0 rate on a gated clock is wrong. You'll probably need to
cache the divider value when the clock is gated.

> +
> +	val >>= div->shift;
> +	val &= clk_div_mask(div->width);
> +
> +	rate = divider_recalc_rate(hw, parent_rate, val, NULL,
> +				   div->flags, div->width);
> +	if (div->fix_divider)
> +		rate = div_u64(rate, div->fix_divider);
> +
> +	return rate;
> +}
> +
> +static int amb_div_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
> +{
> +	struct amb_div *div = to_amb_div(hw);
> +	struct clk_rate_request scaled = *req;
> +	int ret;
> +
> +	if (!req->rate && (div->flags & CLK_DIVIDER_ONE_BASED))

You did not check that flag before ? do you need it or not ?

> +		return 0;

this is wrong

> +
> +	if (div->fix_divider) {
> +		scaled.rate = min(req->rate,
> +				  ULONG_MAX / div->fix_divider) *
> +			      div->fix_divider;
> +		scaled.min_rate = min(req->min_rate,
> +				      ULONG_MAX / div->fix_divider) *
> +				  div->fix_divider;
> +		scaled.max_rate = min(req->max_rate,
> +				      ULONG_MAX / div->fix_divider) *
> +				  div->fix_divider;
> +	}

What is this ?

> +
> +	ret = divider_determine_rate(hw, &scaled, NULL, div->width,
> +				     div->flags);
> +	if (ret)
> +		return ret;
> +
> +	req->rate = scaled.rate;
> +	req->best_parent_rate = scaled.best_parent_rate;
> +	req->best_parent_hw = scaled.best_parent_hw;
> +	if (div->fix_divider)
> +		req->rate = div_u64(req->rate, div->fix_divider);
> +

?

> +	return 0;
> +}
> +
> +static int amb_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct amb_div *div = to_amb_div(hw);
> +	int val, mask;
> +
> +	if (div->fix_divider)
> +		rate *= div->fix_divider;
> +

Your controller register with fix_divider = 1 ... I don't really get the
point ?

> +	if (!rate) {
> +		/* Assert the reset/disable bit above the divider field. */
> +		val = BIT(div->width);
> +		mask = clk_div_mask(div->width + 1);

Hijacking set_rate() to gate.

> +	} else {
> +		val = divider_get_val(rate, parent_rate, NULL,
> +				      div->width, div->flags);
> +		if (val < 0)
> +			return val;
> +
> +		/*
> +		 * Include the disable bit in the mask so a later non-zero
> +		 * set_rate clears a previous rate==0 disable assert.
> +		 */
> +		mask = clk_div_mask(div->width + 1);
> +	}
> +
> +	regmap_update_bits(div->map, div->offset, mask << div->shift,
> +			   val << div->shift);
> +
> +	/*
> +	 * Non-ONE_BASED dividers use bit 0 as a write-enable strobe. Skip the
> +	 * pulse when shift == 0 so we do not corrupt the divider field itself.
> +	 */
> +	if (!(div->flags & CLK_DIVIDER_ONE_BASED) && div->shift) {
> +		regmap_update_bits(div->map, div->offset, BIT(0), BIT(0));
> +		regmap_update_bits(div->map, div->offset, BIT(0), 0);
> +	}

Looks like you could simplify this A LOT by just have a regular gate on
this bit and splitting it out on its own clk_hw rather than mixing it
with the rest

> +
> +	return 0;
> +}
> +
> +static const struct clk_ops amb_div_ops = {
> +	.recalc_rate = amb_div_recalc_rate,
> +	.determine_rate = amb_div_determine_rate,
> +	.set_rate = amb_div_set_rate,
> +};
> +
> +struct clk_hw *amb_div_register(struct device *dev, struct regmap *map,
> +				const char *name, const struct clk_hw *parent,
> +				u32 div_reg, u32 div_shift, u32 div_width,
> +				u32 div_flags, u32 fix_divider)
> +{
> +	struct amb_div *div;
> +	struct clk_init_data init = {};
> +	int ret;
> +
> +	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +	if (!div)
> +		return ERR_PTR(-ENOMEM);
> +
> +	div->map = map;
> +	div->offset = div_reg;
> +	div->shift = div_shift;
> +	div->width = div_width;
> +	div->flags = div_flags;
> +	div->fix_divider = fix_divider;
> +
> +	init.name = name;
> +	init.ops = &amb_div_ops;
> +	init.parent_hws = &parent;
> +	init.num_parents = 1;
> +
> +	div->hw.init = &init;
> +
> +	ret = devm_clk_hw_register(dev, &div->hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return &div->hw;
> +}
> +
> +struct clk_hw *amb_mux_div_register(struct device *dev, struct regmap *map,
> +				    const struct amb_mux_div_desc *desc,
> +				    const struct clk_parent_data *parent_data)
> +{
> +	struct amb_mux *mux;
> +	struct amb_div *div;
> +
> +	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +	if (!mux || !div)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mux->map = map;
> +	mux->offset = desc->mux_reg;
> +	mux->shift = desc->mux_shift;
> +	mux->mask = desc->mux_mask;
> +
> +	div->map = map;
> +	div->offset = desc->div_reg;
> +	div->shift = desc->div_shift;
> +	div->width = desc->div_width;
> +	div->flags = desc->div_flags;
> +	div->fix_divider = desc->fix_divider;
> +
> +	return devm_clk_hw_register_composite_pdata(dev, desc->name,
> +						    parent_data,
> +						    desc->num_parents,
> +						    &mux->hw, &amb_mux_ops,
> +						    &div->hw, &amb_div_ops,
> +						    NULL, NULL,
> +						    CLK_SET_RATE_NO_REPARENT);

So none of your mux will ever reparent ? really ? Looks like a rather
specific mux driver. That is likely a flag your controller should pass
on when appropriate

> +}
> diff --git a/drivers/clk/ambarella/ccu_mux_div.h b/drivers/clk/ambarella/ccu_mux_div.h
> new file mode 100644
> index 000000000000..abaefff1201a
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu_mux_div.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 Ambarella, Inc.
> + */
> +
> +#ifndef __CCU_MUX_DIV_H
> +#define __CCU_MUX_DIV_H
> +
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +
> +struct amb_mux_div_desc {
> +	const char *name;
> +	const int *parents;
> +	u8 num_parents;
> +	u32 mux_reg;
> +	u32 mux_shift;
> +	u32 mux_mask;
> +	u32 div_reg;
> +	u32 div_shift;
> +	u32 div_width;
> +	u32 div_flags;
> +	u32 fix_divider;
> +};
> +
> +struct clk_hw *amb_mux_div_register(struct device *dev, struct regmap *map,
> +				    const struct amb_mux_div_desc *desc,
> +				    const struct clk_parent_data *parent_data);
> +
> +struct clk_hw *amb_div_register(struct device *dev, struct regmap *map,
> +				const char *name, const struct clk_hw *parent,
> +				u32 div_reg, u32 div_shift, u32 div_width,
> +				u32 div_flags, u32 fix_divider);
> +
> +#endif
> diff --git a/drivers/clk/ambarella/ccu_pll.c b/drivers/clk/ambarella/ccu_pll.c
> new file mode 100644
> index 000000000000..76452003bb0d
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu_pll.c
> @@ -0,0 +1,421 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Ambarella, Inc.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/math64.h>
> +#include <linux/rational.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include "ccu_pll.h"
> +
> +#define AMB_PLL_MAX_SOUT	16UL
> +#define AMB_PLL_MAX_SDIV	16UL
> +
> +struct amb_pll {
> +	struct clk_hw hw;
> +	struct regmap *map;
> +	u32 reg_offset[REG_NUM];
> +	const struct amb_pll_soc_data *soc_data;
> +	u32 fix_divider;
> +	bool frac_mode;
> +};
> +
> +#define to_amb_pll(_hw) container_of(_hw, struct amb_pll, hw)
> +
> +static void amb_pll_write_enable(struct regmap *map, u32 offset, u32 val)
> +{
> +	regmap_write(map, offset, val);
> +	regmap_write(map, offset, val | CTRL_WRITE_ENABLE);
> +	regmap_write(map, offset, val);
> +}
> +
> +static unsigned long amb_pll_calc_vco(struct amb_pll *pll,
> +				      unsigned long parent_rate)
> +{
> +	const struct amb_pll_soc_data *soc_data = pll->soc_data;
> +	u32 *reg = pll->reg_offset;
> +	u32 pre_scaler = 1;
> +	u32 ctrl_val, ctrl2_val = 0, frac_val;
> +	u32 intp, sdiv, vcodiv, fsdiv;
> +	u64 frac = 0, vco;
> +
> +	if (reg[PRES_OFFSET]) {
> +		regmap_read(pll->map, reg[PRES_OFFSET], &pre_scaler);
> +		pre_scaler = (pre_scaler >> 4) + 1;
> +	}
> +
> +	regmap_read(pll->map, reg[CTRL_OFFSET], &ctrl_val);
> +	intp = ((ctrl_val >> 24) & 0x7f) + 1;
> +	sdiv = ((ctrl_val >> 12) & 0xf) + 1;

Magic numbers ?

> +
> +	if (soc_data->pll_version >= 2) {
> +		vcodiv = (ctrl_val & soc_data->vcodiv_mask) ==
> +			 soc_data->vcodiv_val ? 2 : 1;
> +		fsdiv = (ctrl_val & soc_data->fsdiv_mask) ==
> +			soc_data->fsdiv_val ? 2 : 1;
> +	} else {
> +		regmap_read(pll->map, reg[CTRL2_OFFSET], &ctrl2_val);
> +		vcodiv = (ctrl2_val & soc_data->vcodiv_mask) ==
> +			 soc_data->vcodiv_val ? 2 : 1;
> +		fsdiv = (ctrl2_val & soc_data->fsdiv_mask) ==
> +			soc_data->fsdiv_val ? 2 : 1;
> +	}

Looks like a copy of a vendor driver. Please clean it up. You do not
even have this version 2 ATM. This whole table thing seems rather
overcomplicated for what it does. Just define the field you need along
with their offsets. You won't have to have if clause like that then

> +
> +	vco = (u64)parent_rate * vcodiv * fsdiv * intp * sdiv;
> +	vco = div_u64(vco, pre_scaler);
> +
> +	if (ctrl_val & CTRL_FRAC_MODE) {
> +		regmap_read(pll->map, reg[FRAC_OFFSET], &frac_val);
> +		frac = (u64)parent_rate * vcodiv * fsdiv * sdiv * frac_val;
> +		frac = div_u64(frac, pre_scaler) >> 32;
> +	}
> +
> +	return vco + frac;
> +}
> +
> +static unsigned long amb_pll_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	struct amb_pll *pll = to_amb_pll(hw);
> +	const struct amb_pll_soc_data *soc_data = pll->soc_data;
> +	u32 *reg = pll->reg_offset;
> +	u32 pre_scaler = 1, post_scaler = 1;
> +	u32 ctrl_val, ctrl2_val = 0;
> +	u32 vcodiv, fsout, sout;
> +	u64 rate;
> +
> +	regmap_read(pll->map, reg[CTRL_OFFSET], &ctrl_val);
> +	if (ctrl_val & (CTRL_POWER_DOWN | CTRL_HALT_VCO | CTRL_FORCE_RESET))
> +		return 0;
> +
> +	if (reg[PRES_OFFSET]) {
> +		regmap_read(pll->map, reg[PRES_OFFSET], &pre_scaler);
> +		pre_scaler = (pre_scaler >> 4) + 1;
> +	}
> +
> +	if (reg[POST_OFFSET]) {
> +		regmap_read(pll->map, reg[POST_OFFSET], &post_scaler);
> +		post_scaler = (post_scaler >> 4) + 1;
> +	}
> +
> +	if (ctrl_val & CTRL_BYPASS)
> +		return parent_rate / pre_scaler / post_scaler;
> +
> +	if (soc_data->pll_version >= 2) {
> +		vcodiv = (ctrl_val & soc_data->vcodiv_mask) ==
> +			 soc_data->vcodiv_val ? 2 : 1;
> +		fsout = (ctrl_val & soc_data->fsout_mask) ==
> +			soc_data->fsout_val ? 2 : 1;
> +	} else {
> +		regmap_read(pll->map, reg[CTRL2_OFFSET], &ctrl2_val);
> +		vcodiv = (ctrl2_val & soc_data->vcodiv_mask) ==
> +			 soc_data->vcodiv_val ? 2 : 1;
> +		fsout = (ctrl2_val & soc_data->fsout_mask) ==
> +			soc_data->fsout_val ? 2 : 1;
> +	}
> +
> +	sout = ((ctrl_val >> 16) & 0xf) + 1;
> +	rate = amb_pll_calc_vco(pll, parent_rate);
> +
> +	if (soc_data->pll_version >= 2) {
> +		if (!(ctrl_val & CTRL_BYPASS_HSDIV))
> +			rate = div_u64(rate, vcodiv * fsout * sout);
> +	} else {
> +		if (!(ctrl2_val & CTRL2_BYPASS_HSDIV))
> +			rate = div_u64(rate, vcodiv * fsout * sout);
> +	}
> +
> +	rate = div_u64(rate, pll->fix_divider * post_scaler);
> +
> +	return rate;
> +}
> +
> +static int amb_pll_calc_params(struct amb_pll *pll, unsigned long rate,
> +			       unsigned long parent_rate, u32 ctrl2_val,
> +			       u32 *intp, u32 *sdiv, u32 *sout,
> +			       u32 *vcodiv, u32 *fsdiv, u32 *fsout)
> +{
> +	const struct amb_pll_soc_data *soc_data = pll->soc_data;
> +	unsigned long max_numerator, max_denominator;
> +	unsigned long intp_ul, sout_ul, rate_tmp, parent_scaled;
> +	u32 ctrl_val;
> +
> +	if (!parent_rate)
> +		return -EINVAL;
> +
> +	*sdiv = 1;
> +
> +	if (soc_data->pll_version >= 2) {
> +		ctrl_val = 0;
> +		*vcodiv = (ctrl_val & soc_data->vcodiv_mask) ==
> +			  soc_data->vcodiv_val ? 2 : 1;
> +		*fsdiv = (ctrl_val & soc_data->fsdiv_mask) ==
> +			 soc_data->fsdiv_val ? 2 : 1;
> +		*fsout = (ctrl_val & soc_data->fsout_mask) ==
> +			 soc_data->fsout_val ? 2 : 1;
> +	} else {
> +		*vcodiv = (ctrl2_val & soc_data->vcodiv_mask) ==
> +			  soc_data->vcodiv_val ? 2 : 1;
> +		*fsdiv = (ctrl2_val & soc_data->fsdiv_mask) ==
> +			 soc_data->fsdiv_val ? 2 : 1;
> +		*fsout = (ctrl2_val & soc_data->fsout_mask) ==
> +			 soc_data->fsout_val ? 2 : 1;
> +	}
> +
> +	if (rate < parent_rate)
> +		return -EINVAL;
> +
> +	max_numerator = soc_data->vco_max_mhz;
> +	max_numerator = div_u64(max_numerator * 1000000ULL, parent_rate);
> +	max_numerator = div_u64(max_numerator, *vcodiv * *fsdiv);
> +	max_numerator = min(128UL, max_numerator);
> +	if (!max_numerator)
> +		return -EINVAL;
> +
> +	/*
> +	 * Approximate intp/sout against the fsdiv/fsout-scaled parent so the
> +	 * initial guess matches the hardware frequency equation.
> +	 */
> +	max_denominator = AMB_PLL_MAX_SOUT;
> +	parent_scaled = parent_rate * *fsdiv / *fsout;
> +	if (!parent_scaled)
> +		return -EINVAL;
> +	rate_tmp = rate;
> +	rational_best_approximation(rate_tmp, parent_scaled, max_numerator,
> +				    max_denominator, &intp_ul, &sout_ul);
> +
> +	while (parent_rate * *fsdiv * intp_ul * *sdiv / *fsout / sout_ul >
> +	       rate) {
> +		unsigned long resolution = parent_scaled / AMB_PLL_MAX_SOUT;
> +
> +		/* Avoid an infinite loop when parent_rate < AMB_PLL_MAX_SOUT. */
> +		if (!resolution)
> +			resolution = 1;
> +
> +		if (rate_tmp <= resolution)
> +			return -EINVAL;
> +
> +		rate_tmp -= resolution;
> +		rational_best_approximation(rate_tmp, parent_scaled,
> +					    max_numerator, max_denominator,
> +					    &intp_ul, &sout_ul);
> +	}
> +
> +	while (parent_rate / 1000000 * *vcodiv * *fsdiv * intp_ul * *sdiv <
> +	       soc_data->vco_min_mhz) {
> +		if (sout_ul > 8 || intp_ul > 64)
> +			break;
> +
> +		intp_ul *= 2;
> +		sout_ul *= 2;
> +	}
> +
> +	if (intp_ul > max_numerator || sout_ul > max_denominator ||
> +	    *sdiv > AMB_PLL_MAX_SDIV)
> +		return -EINVAL;
> +
> +	*intp = intp_ul;
> +	*sout = sout_ul;
> +
> +	return 0;
> +}
> +
> +static int amb_pll_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
> +{
> +	struct amb_pll *pll = to_amb_pll(hw);
> +	const struct amb_pll_soc_data *soc_data = pll->soc_data;
> +	u32 ctrl2_val = 0;
> +	u32 intp, sdiv, sout, vcodiv, fsdiv, fsout;
> +	unsigned long rate;
> +	u64 rounded;
> +	int ret;
> +
> +	if (!req->best_parent_rate)
> +		return -EINVAL;
> +
> +	if (!req->rate || pll->frac_mode)
> +		return 0;
> +
> +	if (req->rate > ULONG_MAX / pll->fix_divider)
> +		return -ERANGE;
> +
> +	rate = req->rate * pll->fix_divider;
> +	if (soc_data->ctrl2_val)
> +		ctrl2_val = soc_data->ctrl2_val;
> +	else
> +		regmap_read(pll->map, pll->reg_offset[CTRL2_OFFSET],
> +			    &ctrl2_val);
> +
> +	ret = amb_pll_calc_params(pll, rate, req->best_parent_rate,
> +				  ctrl2_val, &intp, &sdiv, &sout, &vcodiv,
> +				  &fsdiv, &fsout);
> +	if (ret)
> +		return ret;
> +
> +	rounded = (u64)req->best_parent_rate * fsdiv * intp * sdiv;
> +	rounded = div64_u64(rounded, (u64)fsout * sout);
> +	rounded = div64_u64(rounded, pll->fix_divider);
> +	if (rounded < req->min_rate || rounded > req->max_rate)
> +		return -EINVAL;
> +
> +	req->rate = rounded;
> +
> +	return 0;
> +}
> +
> +static int amb_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct amb_pll *pll = to_amb_pll(hw);
> +	const struct amb_pll_soc_data *soc_data = pll->soc_data;
> +	u32 *reg = pll->reg_offset;
> +	u32 ctrl_val, ctrl2_val = 0, ctrl3_val, frac_val = 0;
> +	u32 intp, sdiv, sout, vcodiv, fsdiv, fsout;
> +	unsigned long old_rate, new_rate, rate_tmp;
> +	int ret;
> +
> +	if (!rate) {
> +		regmap_read(pll->map, reg[CTRL_OFFSET], &ctrl_val);
> +		ctrl_val |= CTRL_POWER_DOWN | CTRL_HALT_VCO;
> +		amb_pll_write_enable(pll->map, reg[CTRL_OFFSET], ctrl_val);
> +		return 0;
> +	}
> +
> +	if (!parent_rate)
> +		return -EINVAL;
> +
> +	rate *= pll->fix_divider;
> +
> +	if (soc_data->ctrl2_val)
> +		ctrl2_val = soc_data->ctrl2_val;
> +	else
> +		regmap_read(pll->map, reg[CTRL2_OFFSET], &ctrl2_val);
> +
> +	ret = amb_pll_calc_params(pll, rate, parent_rate, ctrl2_val,
> +				  &intp, &sdiv, &sout, &vcodiv, &fsdiv,
> +				  &fsout);
> +	if (ret)
> +		return ret;
> +
> +	if (soc_data->ctrl2_val)
> +		regmap_write(pll->map, reg[CTRL2_OFFSET], soc_data->ctrl2_val);
> +
> +	ctrl_val = ((intp - 1) & 0x7f) << 24;
> +	ctrl_val |= ((sdiv - 1) & 0xf) << 12;
> +	ctrl_val |= ((sout - 1) & 0xf) << 16;
> +	if (soc_data->pll_version >= 2) {
> +		ctrl_val |= vcodiv == 2 ? soc_data->vcodiv_val : 0;
> +		ctrl_val |= fsdiv == 2 ? soc_data->fsdiv_val : 0;
> +		ctrl_val |= fsout == 2 ? soc_data->fsout_val : 0;
> +	}
> +
> +	regmap_write(pll->map, reg[CTRL_OFFSET], ctrl_val);
> +	regmap_write(pll->map, reg[FRAC_OFFSET], 0);
> +
> +	old_rate = amb_pll_recalc_rate(hw, parent_rate) * pll->fix_divider;
> +	rate_tmp = old_rate > rate ? 0 : rate - old_rate;
> +	if (rate_tmp && pll->frac_mode) {
> +		u64 dividend, divider;
> +
> +		dividend = (u64)rate_tmp * sout * fsout;
> +		dividend <<= 32;
> +		divider = (u64)sdiv * fsdiv * parent_rate;
> +		frac_val = DIV64_U64_ROUND_CLOSEST(dividend, divider);
> +		regmap_write(pll->map, reg[FRAC_OFFSET], frac_val);
> +		ctrl_val |= CTRL_FRAC_MODE;
> +	}
> +
> +	if (soc_data->pll_version >= 2) {
> +		ctrl3_val = soc_data->ctrl3_val;
> +		regmap_write(pll->map, reg[CTRL3_OFFSET],
> +			     ctrl3_val | CTRL3_VCO_CLAMP);
> +		regmap_write(pll->map, reg[CTRL_OFFSET],
> +			     ctrl_val | CTRL_FORCE_RESET);
> +		ndelay(100);
> +		regmap_write(pll->map, reg[CTRL_OFFSET],
> +			     ctrl_val & ~CTRL_FORCE_RESET);
> +		ndelay(100);
> +		regmap_write(pll->map, reg[CTRL3_OFFSET],
> +			     ctrl3_val & ~CTRL3_VCO_CLAMP);
> +	} else {
> +		u32 fvco_mhz, range;
> +
> +		fvco_mhz = amb_pll_calc_vco(pll, parent_rate) / 1000000UL;
> +		for (range = 0; range < ARRAY_SIZE(soc_data->vco_range);
> +		     range++) {
> +			if (fvco_mhz > soc_data->vco_range[range])
> +				break;
> +		}
> +		if (range == ARRAY_SIZE(soc_data->vco_range))
> +			range = 0;
> +		else
> +			range = ARRAY_SIZE(soc_data->vco_range) - range - 1;
> +
> +		regmap_read(pll->map, reg[CTRL3_OFFSET], &ctrl3_val);
> +		ctrl3_val &= ~CTRL3_VCO_RANGE_MASK;
> +		ctrl3_val |= range << 1;
> +		regmap_write(pll->map, reg[CTRL3_OFFSET], ctrl3_val);
> +
> +		if (frac_val) {
> +			ctrl_val |= CTRL_FORCE_RESET;
> +			amb_pll_write_enable(pll->map, reg[CTRL_OFFSET],
> +					     ctrl_val);
> +		}
> +
> +		ctrl_val &= ~CTRL_FORCE_RESET;
> +		amb_pll_write_enable(pll->map, reg[CTRL_OFFSET], ctrl_val);
> +	}
> +
> +	new_rate = amb_pll_recalc_rate(hw, parent_rate);
> +	rate_tmp = rate / pll->fix_divider;
> +	if (max(new_rate, rate_tmp) - min(new_rate, rate_tmp) > 10)
> +		pr_warn("%s: requested %lu, got %lu\n", clk_hw_get_name(hw),
> +			rate_tmp, new_rate);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops amb_pll_ops = {
> +	.recalc_rate = amb_pll_recalc_rate,
> +	.determine_rate = amb_pll_determine_rate,
> +	.set_rate = amb_pll_set_rate,
> +};
> +
> +struct clk_hw *amb_pll_register(struct device *dev, struct regmap *map,
> +				const struct amb_pll_desc *desc)
> +{
> +	struct amb_pll *pll;
> +	struct clk_init_data init = {};
> +	const struct clk_hw *parent = desc->parent;
> +	int ret;
> +
> +	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pll->map = map;
> +	memcpy(pll->reg_offset, desc->reg_offset, sizeof(pll->reg_offset));
> +	pll->soc_data = desc->soc_data;
> +	pll->fix_divider = 1;
> +	pll->frac_mode = desc->frac_mode;
> +
> +	init.name = desc->name;
> +	init.ops = &amb_pll_ops;
> +	init.flags = CLK_GET_RATE_NOCACHE | CLK_IS_CRITICAL;
> +	init.parent_hws = &parent;
> +	init.num_parents = 1;
> +
> +	pll->hw.init = &init;
> +
> +	ret = devm_clk_hw_register(dev, &pll->hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return &pll->hw;
> +}
> diff --git a/drivers/clk/ambarella/ccu_pll.h b/drivers/clk/ambarella/ccu_pll.h
> new file mode 100644
> index 000000000000..6d901e88f410
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu_pll.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 Ambarella, Inc.
> + */
> +
> +#ifndef __CCU_PLL_H
> +#define __CCU_PLL_H
> +
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +enum {
> +	CTRL_OFFSET = 0,
> +	FRAC_OFFSET,
> +	CTRL2_OFFSET,
> +	CTRL3_OFFSET,
> +	PRES_OFFSET,
> +	POST_OFFSET,
> +	REG_NUM,
> +};
> +
> +#define CTRL_BYPASS		BIT(2)
> +#define CTRL_WRITE_ENABLE	BIT(0)
> +#define CTRL_FRAC_MODE		BIT(3)
> +#define CTRL_FORCE_RESET	BIT(4)
> +#define CTRL_POWER_DOWN		BIT(5)
> +#define CTRL_HALT_VCO		BIT(6)
> +#define CTRL_VCODIV_DIV2	BIT(8)
> +#define CTRL_FSDIV_DIV2		BIT(9)
> +#define CTRL_FSOUT_DIV2		BIT(10)
> +#define CTRL_BYPASS_HSDIV	BIT(11)
> +
> +#define CTRL2_VCODIV_DIV2	BIT(8)
> +#define CTRL2_FSDIV_DIV2	BIT(9)
> +#define CTRL2_FSOUT_DIV2	BIT(11)
> +#define CTRL2_BYPASS_HSDIV	BIT(12)
> +
> +#define CTRL3_VCO_RANGE_MASK	0x6
> +#define CTRL3_VCO_CLAMP		0x8
> +
> +struct amb_pll_soc_data {
> +	u32 pll_version;
> +	u32 fsout_mask;
> +	u32 fsout_val;
> +	u32 fsdiv_mask;
> +	u32 fsdiv_val;
> +	u32 vcodiv_mask;
> +	u32 vcodiv_val;
> +	u32 vco_max_mhz;
> +	u32 vco_min_mhz;
> +	u32 vco_range[4];
> +	u32 ctrl2_val;
> +	u32 ctrl3_val;
> +};
> +
> +struct amb_pll_desc {
> +	const char *name;
> +	const struct clk_hw *parent;
> +	u32 reg_offset[REG_NUM];
> +	const struct amb_pll_soc_data *soc_data;
> +	bool frac_mode;
> +};
> +
> +struct clk_hw *amb_pll_register(struct device *dev, struct regmap *map,
> +				const struct amb_pll_desc *desc);
> +
> +#endif
>
> -- 
> 2.34.1
>
>

-- 
Jerome
