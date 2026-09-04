Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91164456DE8;
	Fri,  4 Sep 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528605; cv=none; b=kpiA2ung0RdFuAcrEtlh8wPEb8YUw4p+dVBnkDF2Ck8APSXhvXbzliO6pr6/1T27pwJnOAMfXOq+V/XxEzcXXLH1PO3IM2l4aSNCE3GXPa5YAYcsn3qslSPMuQFnUHJV9DGIDm3EgKOwC9Y1puHC4phfiiwP9qslXNfyppp+EIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528605; c=relaxed/simple;
	bh=grhnvhyknET3B7IdJvQibXDzsJ5N/WqEsZ9s8sa9fm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mkp2/kXPvmfvsWY7Ra/Z25eYxJe5bZYl03Y29GU9zPe7nq/DitcvwhfoM4MJGH5cJ6jZMyAdmyAE378RStx3Z0mUqCFqmJyC91+Uupu6CtN4jee0gNEckxyXX2DMxzHzP32E2E1KzxdcY2e0MW4/ePNdmwAR2Whcary0Qr0ZKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHWJqZwJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHWJqZwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788528602; x=1820064602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=grhnvhyknET3B7IdJvQibXDzsJ5N/WqEsZ9s8sa9fm0=;
  b=kHWJqZwJDXzD61UL2IW6AuJ6+0NFT9q/8rZw8HPhT3shMAjdg88QWsrn
   eXj4XV+XVSCMq7PUhAlFkGc90+PDntPvFphFdNx5ZRV6QfIW9aqTtnXYg
   XCY6ayIrV2sgEQGP4sQMyXnczzTUgR8pMCBH1HDDnIMzJCb4kx5bBPJy3
   UWydirTAKwpwlUfQ5pE3plPdPOUIrC1AWPBS85Sz7eTKXj9en0H5Dx0Ik
   YLiY1f17VhjB0bOFuTLexCfe8SqY4EZ4xoOQSWhzZYcN7lmX2r6G8+0yn
   N5Y5YAW5FPBCamZy+dNvzWokBgdos32As5NpVozasntXTaoipOba6giMm
   w==;
X-CSE-ConnectionGUID: oAVj1bSTRjWjjAWcmSImHQ==
X-CSE-MsgGUID: LFhQNmx9TBeMlWNWVTYXlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87966973"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="87966973"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 06:30:00 -0700
X-CSE-ConnectionGUID: cguac88uTRmVD4kZTqMv8g==
X-CSE-MsgGUID: 1Xy87WaxQhialAHJ1iJzyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="275319220"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 06:29:55 -0700
Date: Fri, 4 Sep 2026 16:29:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/13] pinctrl: ambarella: add CV75 pin controller
Message-ID: <aprH0EAx6PlQuoxq@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-10-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-cv75-v5-v6-10-e918514cb3b1@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 02:38:17PM +0800, Long Zhao via B4 Relay wrote:

> Add an Ambarella pinmux-only pinctrl driver with CV75 function/group
> tables. GPIO is handled by the PL061 driver.

...

> +#include <linux/kernel.h>

Absolutely no. Follow IWYU principle in all your patches.

...

> +#define CV75_GROUP(_name)						\
> +	{								\
> +		.name = #_name,						\
> +		.pinmux = cv75_##_name##_pinmux,				\
> +		.num_pins = ARRAY_SIZE(cv75_##_name##_pinmux),		\
> +	}
> +
> +#define CV75_FUNCTION(_name)						\
> +	{								\
> +		.name = #_name,						\
> +		.groups = cv75_##_name##_groups,				\
> +		.num_groups = ARRAY_SIZE(cv75_##_name##_groups),		\
> +	}

Don't we have respective macros in linux/pinctrl/pinctrl.h

...

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitmap.h>
> +#include <linux/io.h>

> +#include <linux/of.h>
> +#include <linux/of_device.h>



> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/seq_file.h>

Make it ordered, group linux/pinctrl/ separately after generic linux/*.h

> +#include "pinconf.h"
> +#include "pinctrl-ambarella.h"

...

> +struct amb_pinctrl_soc_data {
> +	struct device			*dev;
> +	const struct amb_pinctrl_data	*data;
> +	void __iomem			*iomux_base;
> +	struct regmap			*ds_regmap;
> +	struct regmap			*pull_regmap;
> +	unsigned int			npins;
> +	unsigned long			used[BITS_TO_LONGS(AMBA_MAX_PINS)];
> +	raw_spinlock_t lock;
> +
> +	struct pinctrl_dev		*pctl;

> +	const struct ambpin_function	*functions;
> +	unsigned int			nr_functions;
> +	struct ambpin_group		*groups;
> +	unsigned int			nr_groups;

Check what linux/pinctrl/pinctrl.h and drivers/pinctrl/core.h provide.

> +};

...

> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +static void amb_pin_dbg_show(struct pinctrl_dev *pctldev,
> +			     struct seq_file *s, unsigned int pin)
> +{
> +	seq_printf(s, " %s", pinctrl_dev_get_devname(pctldev));
> +}
> +#endif

Does this bring any new information?

...

> +/* check if the selector is a valid pin function selector */
> +static int amb_pinmux_request(struct pinctrl_dev *pctldev, unsigned int pin)
> +{
> +	struct amb_pinctrl_soc_data *soc = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (test_and_set_bit(pin, soc->used))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +/* check if the selector is a valid pin function selector */
> +static int amb_pinmux_free(struct pinctrl_dev *pctldev, unsigned int pin)
> +{
> +	struct amb_pinctrl_soc_data *soc = pinctrl_dev_get_drvdata(pctldev);
> +
> +	clear_bit(pin, soc->used);
> +
> +	return 0;
> +}

Why? Isn't internal pinctrl tracking is not enough?

...

> +static void amb_pinmux_set_altfunc(struct amb_pinctrl_soc_data *soc,
> +				   u32 bank, u32 offset, u32 altfunc)
> +{
> +	u32 i, data;
> +
> +	if (!amb_iomux_accessible(soc))
> +		return;
> +
> +	for (i = 0; i < 3; i++) {

	for (unsigned int i...

> +		data = readl_relaxed(soc->iomux_base + IOMUX_OFFSET(bank, i));
> +		data &= ~BIT(offset);
> +		data |= ((altfunc >> i) & 1U) << offset;
> +		writel_relaxed(data, soc->iomux_base + IOMUX_OFFSET(bank, i));
> +	}
> +}

...

> +static int amb_drive_strength_to_reg(struct amb_pinctrl_soc_data *soc,
> +				     u32 strength)
> +{
> +	if (soc->data->have_ds2) {
> +		switch (strength) {
> +		case 3:
> +			return 0;
> +		case 4:
> +		case 5:
> +			return 1;
> +		case 6:
> +			return 2;
> +		case 7:
> +		case 8:
> +			return 3;
> +		case 9:
> +			return 4;
> +		case 12:
> +			return 5;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	switch (strength) {
> +	case 2:
> +		return 0;
> +	case 4:
> +		return 1;
> +	case 8:
> +		return 2;
> +	case 12:
> +		return 3;
> +	default:
> +		return -EINVAL;
> +	}
> +}

I would look better in three functions

static int amb_drive_strength_to_reg(struct amb_pinctrl_soc_data *soc,
				     u32 strength)
{
	if (soc->data->have_ds2)
		return amb_drive_strength_to_reg_ds2(soc, strength);

	return amb_drive_strength_to_reg_ds1(soc, strength);

}

> +static int amb_reg_to_drive_strength(struct amb_pinctrl_soc_data *soc, u32 ds)
> +{
> +	static const int ds2_ma[] = { 3, 4, 6, 8, 9, 12 };
> +	static const int ds_ma[] = { 2, 4, 8, 12 };

You have switch cases that use the same arrays, use them for both.

> +	if (soc->data->have_ds2) {
> +		if (ds >= ARRAY_SIZE(ds2_ma))
> +			return -EINVAL;
> +
> +		return ds2_ma[ds];
> +	}
> +
> +	if (ds >= ARRAY_SIZE(ds_ma))
> +		return -EINVAL;
> +
> +	return ds_ma[ds];
> +}

...

I stopped here, this driver is quite far from the modern pin control standards,
please look around, you find a lot of new drivers there, that are written in
more-or-less compact ways, using better APIs and approaches.

When creating a driver, use also helper tools, like `pahole`,
scripts/bloat-o-meter, et cetera. Compile with `make W=1 C=1 ...`
using both compilers (GCC and clang).

...

> +static const struct of_device_id amb_pinctrl_dt_match[] = {
> +	{
> +		.compatible = "ambarella,cv75-pinctrl",
> +		.data = &ambarella_cv75_pinctrl_data,
> +	},
> +	{},

No trailing comma for the terminator entry.

> +};

...

> +static struct platform_driver amb_pinctrl_driver = {
> +	.probe	= amb_pinctrl_probe,
> +	.driver	= {
> +		.name	= "ambarella-pinctrl",
> +		.of_match_table = of_match_ptr(amb_pinctrl_dt_match),

Why of_match_ptr()?!

> +	},
> +};

-- 
With Best Regards,
Andy Shevchenko


