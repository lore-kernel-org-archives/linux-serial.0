Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C923C9EF3;
	Tue, 15 Sep 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478855; cv=none; b=EIyC9R7LQ7BJnWNJg3mg7CZHebmiOKPvMjSjFy4ZSZpQilIOmr7pND8BtXjgzX2q5alSrvV3+uYOpmdkXWc/vFG5iJB1KNlM5t0po0ZuuhTKbalYbyGufgm3E4ibwbPV/dRlZJSAViMuwDVfFSas6uqqnH1ZcrB5ezWeuU78xLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478855; c=relaxed/simple;
	bh=LvQZ0lj3BE7qSBpR37PGrtquuI5nJqHwIN8zYY7oDdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mClTwhKDduYgQBpvY2Ny7ojPKPBBpOvvKjnvUtG7C0RjtzAZLmvAWpCmCJtCy7sLyKWuzb6q9zoPUYvnXmmv+ZVXZ/DX6t4fVnRgVWzg4NMnJt01GB1IMmVyLl6HHi5FrRo+beUs9L7R7t+Eyr3KIOkOgzsAgCy9KYFXbvKAhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3XZFW4Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3XZFW4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789478853; x=1821014853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LvQZ0lj3BE7qSBpR37PGrtquuI5nJqHwIN8zYY7oDdM=;
  b=M3XZFW4Y8Ot96Tp8FZ2rM2KmE9djZYK4pogsqrzgLb5s8nsL+6GON9tI
   UMSJpFE5ZhZHu5KkxjqGICbP1JYjJAq7iCo3PgJHQFR5cBHg5B/jQfj25
   w8kC/MRY0ins8AQ4CRA7IEtlj/jT5v00xbXjgZlWH2h1662q078CWdhzU
   /92SS2jctWOoCaji49AnK6CLIM6n5ncN67kn7VSAqOZZj0AzHClNczqpU
   USDfyIWDEC6uQJuLG+9s38T97QGfLX8gbZOn8z6wgMUL9K5Tq2bqttERj
   q6c2L/k8lB0ypfaAWRhlru0L/+/pO+4UneM2c+YsSN+3iLE1U5Xns/RvF
   Q==;
X-CSE-ConnectionGUID: YpaGc43yTW+/pplXs6ujSg==
X-CSE-MsgGUID: lfE6j+XaQ/SwNdzH3AJ9qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107353189"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107353189"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 06:27:32 -0700
X-CSE-ConnectionGUID: ZNMsbKv1RnuiE3ZxRK2M1Q==
X-CSE-MsgGUID: B+6W7utzQDKDtDV+XQ1KUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296513770"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.57])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 06:27:26 -0700
Date: Tue, 15 Sep 2026 16:27:24 +0300
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/15] clk: ambarella: add CV75 RCT clock controller
Message-ID: <aqlHvB2FkpBdlEBT@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-7-3297d3fbc9c0@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-cv75-v5-v7-7-3297d3fbc9c0@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 07:15:37PM +0800, Long Zhao via B4 Relay wrote:

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
> +#include <linux/math64.h>

> +#include <linux/mod_devicetable.h>

No new driver should use this, ID tables are provided by...

> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>

^^^...this one.

> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>

...

> +struct cv75_fixed_factor {
> +	const char *name;
> +	u32 id;

> +	u16 mult;
> +	u16 div;

There is struct u16_fract in math.h. Can you use it instead of these two?

> +};

...

> +static int cv75_rct_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *data;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	spin_lock_init(&cv75_ccu.lock);
> +
> +	cv75_ccu.base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cv75_ccu.base))
> +		return PTR_ERR(cv75_ccu.base);

> +	data = devm_kzalloc(dev, struct_size(data, hws, CV75_NUM_CLKS),
> +			    GFP_KERNEL);

I think it's okay to have this on a single line.

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


