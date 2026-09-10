Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433C37C115;
	Thu, 10 Sep 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032617; cv=none; b=tfDEjmIeA8mAD6jeCq7zJcirMZN3F4xjwEewWnQb0E4z4FGLT8SjQ6A0RDebwFUyMx7N93Ihu5qHHbpOQJWof+RMqQ4y7bKctGVh5R17MoN0YMTFjnUxKXphGWnL5hfAdjQqJteqHX6d5BI+2JuzDiTcoo+U9bxH3yaxofGjU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032617; c=relaxed/simple;
	bh=uRqstXESvREbE7sgABus3VPsikH/WGsWpiYKC8RGfyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5eXaIIiaM21UL3o9nqavoXeCEILBpnV6RORSsE6rreUSNp3KjUE3InKf8NLjcsbA4RPAheEj49nZvkFa81xPqAWR03YJi6F4FpQhw96Aw/kZaDY9k0suXVtXYfxhmAnjz3VHMeUK8XuHEksxxExVFYHI9Smnpqc3vwLzgPUjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m849NaLZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m849NaLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789032616; x=1820568616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uRqstXESvREbE7sgABus3VPsikH/WGsWpiYKC8RGfyc=;
  b=m849NaLZ6sxQ5gBpvzjfBGt2DwyvTsOson0htAtAHUSG5PcjEhEoXv4I
   EgoOrvnOPgNQO2qnZKnjlXffuuVwhNTqR9xWr6fE6I0o2kPq4p/Q+k5xO
   O/2rkGKbNeUTwJ/YfOVl1v3apI/w/ywmaf3D+t2PBZSZYc6b5xynqzqjn
   tOMu03LL7hsavOxwDurtnYNEL1wgkU/urhTBOAiwgkECHchh/2ENGZ5qX
   OQRHYKsQaSd2SepuhThowH8xYm5DqvK/FxxBWCuaxbE6MciO6e+himMXu
   RtGTkAa+kkQ41wmQCyAKk6TFUu6Nu346qgZgapZLLtwfs32M/Es4+wnqd
   g==;
X-CSE-ConnectionGUID: s4To8yddSZOMk9q31zU2Zg==
X-CSE-MsgGUID: 1jlASZOVR+m2PqhFTufz0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89319705"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89319705"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:30:15 -0700
X-CSE-ConnectionGUID: lCnUWz4jQ8CM6GL6fh/4ZA==
X-CSE-MsgGUID: 9Om9URfuRdabHB7tU3BG+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="271089393"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:30:09 -0700
Date: Thu, 10 Sep 2026 12:30:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: zl020895 <zl020895@163.com>
Cc: longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
	Will Deacon <will@kernel.org>, Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH v6 08/13] gpio: regmap: support
 write_data_after_dir and girq
Message-ID: <aqJ4n43eYYochJl4@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
 <apqxwRgi-uVKkOpr@ashevche-desk.local>
 <27a1901.423e.1a07a183bd4.Coremail.zl020895@163.com>
 <ap5BgWtHMAxl28wF@ashevche-desk.local>
 <6ca46138.9970.1a07b6abb25.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ca46138.9970.1a07b6abb25.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 06:29:47PM +0800, zl020895 wrote:

> Thanks for the bxtwc pointer.
> 
> I looked at mapping PL061 onto regmap-irq. Status/mask/ack (MIS/IE/IC)
> could fit, but PL061 still needs the chained demux plus IS/IBE/IEV type
> programming (including EDGE_BOTH) and the existing gpiochip immutable
> helpers. That looks like a poor fit versus idi-48/bxtwc-style chips, and
> switching the long-standing ARM PL061 path from chained to threaded
> regmap-irq seems risky.
> 
> What I plan for the next round (without extending gpio-regmap with girq):
> keep the custom irqchip + chained handler, create the irq_domain in
> gpio-pl061, and pass it via config.irq_domain to gpio-regmap.
> 
> Does that match what you had in mind, or do you still prefer a
> regmap-irq-based approach?

Okay, let's continue with this approach. Just make sure the commit message
covers the choice made (explains why GPIO IRQ chip is customised).

> At 2026-09-07 12:45:53, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com> wrote:
> >On Mon, Sep 07, 2026 at 12:20:03PM +0800, zl020895 wrote:
> >
> >> > Are you going to fix this HW in the next version of the SoC?
> >> No — Ambarella does not use write_data_after_dir. It only preserves the
> >> existing ARM PL061 quirk already documented in gpio-pl061 (data writes
> >> ignored while the pin is still an input). Only pl061_arm sets the flag.
> >
> >Ah, this is a good news!
> >
> >In any case when documenting that flag, please also mention that any new HW
> >should not use it as it's considered buggy (glitches during direction change
> >are guaranteed).
> >
> >> I will also make the first gpio_regmap_set() conditional so the quirk
> >> path writes once after direction_output, not twice.
> >
> >I see that original pl061 actually writes twice. TBH I don't know the best
> >effort here and if it's really required to do so. Probably others have
> >better ideas...
> >
> >> > This needs to be in a separate update. Also we need to understand why
> >> > it is required.
> >> OK, girq will be a separate patch. PL061 keeps a custom chained
> >> irqchip (not regmap-irq); gpio_regmap today only takes irq_domain or
> >> regmap_irq_chip, so we passed girq to keep the usual gpio_irq_chip +
> >> gpiochip_add flow. Open to using a caller-created irq_domain instead if
> >> you prefer.
> >
> >If there is a chained IRQ, look how PMIC drivers usually do similar setups.
> >First what comes to my mind is drivers/mfd/intel_soc_pmic_bxtwc.c.

-- 
With Best Regards,
Andy Shevchenko


