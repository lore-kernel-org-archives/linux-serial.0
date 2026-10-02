Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CA3D954F;
	Fri,  2 Oct 2026 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928666; cv=none; b=SypEvn+EUZ507xw28REhCuJfXNxCtboNyVLEofe7TMyHnv1RdUFwLCzqmbwnSojgnRxlVzG9rLNuZp38ngYBUng6LB7oyimwj50+pOHYDzDa1UFkkAo6Gq/RgbWc0G6BL06ZDTStx94WS4sL0qnPuk/KJuQU4DO1ftZtYUTh98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928666; c=relaxed/simple;
	bh=jbrobNgLFvEYW+K5702m//jZXUekQEX6EeXtEarN3MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG7CFw/buHXF4E+KIcf4X/ZOrHk+Fs6LXxbz9KDgk/iJQqKch+vhYK+xW1c5cRgxo6IFy/35ZQvsjjY6hJM9gDmsARFF7X8MiI3ApA6eBuseE0qrgrqD76oJ9nPahLDxSS/HfdwcrhFMRgE2uwojZxxDJLRQ8H3O2fuEp9ofR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ia0kYKAi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ia0kYKAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790928663; x=1822464663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jbrobNgLFvEYW+K5702m//jZXUekQEX6EeXtEarN3MI=;
  b=ia0kYKAiSWnVp3MxPr/qS1CY66rm1SkwHNDl+yUybqKvbzb5kyHAJMoG
   BP2vJ178VD2gnOvJhMntaT9LrZiIjNDYCJIXh5w3S0HbJbeKnO1XUYYFs
   oTDUytjCS8HvqEkI8tgNPJNM6IhFlFl0KhimHFSo8XhlsUbtJ1QCkACRf
   mtie2nW22/ipJiznn3OBcWB/cejmPhUVuZDBzdJTdF7LragquZTY5JHfL
   4l7mnS8V9DwzkriZX+57rkeOikdswybiZWDDT+8qpQ5U9pB9Z+YoOQfel
   D5tP8npLinhSC20xp+hviwgEVbPsKUoFXEUy2giQuAaF8Smu1XHwiqRqx
   Q==;
X-CSE-ConnectionGUID: l+io++RYQbqUdxWzNxF9Nw==
X-CSE-MsgGUID: wZeGrd1hS+6ji4HgbDBkzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94406446"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="94406446"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:10:53 -0700
X-CSE-ConnectionGUID: OWKdrr/1QZ+1XoZZBrzcjw==
X-CSE-MsgGUID: wfmyyLdUR1uQ8ZwS3auB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275740714"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:10:47 -0700
Date: Fri, 2 Oct 2026 11:10:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/15] clk: ambarella: add CV75 RCT clock controller
Message-ID: <ar9nBBGJ361IFXn8@ashevche-desk.local>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-6-486cc289a4b8@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-cv75-v5-v9-6-486cc289a4b8@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 08:40:55PM +0800, Long Zhao via B4 Relay wrote:

> Add a table-driven CCF driver for the CV75 root clock tree. Register
> the core PLL, AHB/APB fixed factors and UART0 composite clock, with
> osc supplied via clk_parent_data.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>

> +#include <linux/math.h>
> +#include <linux/math64.h>

The latter one covers the former one.

> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>

...

> +struct cv75_pll_hw {
> +	struct clk_hw hw;

> +	u32 ctrl;
> +	u32 frac;
> +	u32 ctrl2;

This repeats twice in different data structures. Is the semantic the same in
both cases? If so, it might make sense to have a separate data structure for
these three and embed it as required.

> +};

...

> +struct cv75_pll {
> +	const char *name;
> +	struct cv75_pll_hw *hw;
> +	unsigned long flags;

> +	u32 ctrl;
> +	u32 frac;
> +	u32 ctrl2;

^^^ See above.

> +	int id;
> +};

...

> +{
> +	struct clk_parent_data parent_data = { .fw_name = "osc" };
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cv75_plls); i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(cv75_plls); i++) {

Same approach in the below code where similar cases appear.

> +		const struct cv75_pll *desc = &cv75_plls[i];
> +		struct cv75_pll_hw *pll = desc->hw;
> +		struct clk_init_data init = {};
> +		int ret;
> +
> +		pll->ctrl = desc->ctrl;
> +		pll->frac = desc->frac;
> +		pll->ctrl2 = desc->ctrl2;
> +
> +		init.name = desc->name;
> +		init.ops = &cv75_pll_ops;
> +		init.parent_data = &parent_data;
> +		init.num_parents = 1;
> +		init.flags = desc->flags;
> +		pll->hw.init = &init;
> +
> +		ret = devm_clk_hw_register(dev, &pll->hw);
> +		if (ret)
> +			return ret;
> +
> +		if (desc->id >= 0)
> +			data->hws[desc->id] = &pll->hw;
> +	}
> +
> +	return 0;
> +}

...

> +static int cv75_rct_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *data;
> +	struct device *dev = &pdev->dev;
> +	int ret;

> +	spin_lock_init(&cv75_ccu.lock);

Can it be done later, after memory allocation?

> +	cv75_ccu.base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cv75_ccu.base))
> +		return PTR_ERR(cv75_ccu.base);
> +
> +	data = devm_kzalloc(dev, struct_size(data, hws, CV75_NUM_CLKS), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	data->num = CV75_NUM_CLKS;
> +
> +	ret = cv75_register_plls(dev, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register plls\n");
> +
> +	ret = cv75_register_fixed_factors(dev, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register fixed factors\n");
> +
> +	ret = cv75_register_composites(dev, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register composites\n");
> +
> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add clock provider\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


