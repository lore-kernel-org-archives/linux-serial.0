Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC43AEF54;
	Wed, 16 Sep 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572059; cv=none; b=pYI26Z29TnyLLLUniCU+1Y9YAbpQEK75EG6SQ0lC/rBPUned/kjdfeMVpKqmxf7HLgWVd/Ir1Lw+UMv9Q/Mk8lTGXEliVzmbOt2HH+wZF3I7VbliAkQ9+UF5kO7VRr6P13UrYOoWLj0bPTCqC39BMI6LlqAa9CoPrkKwA45XuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572059; c=relaxed/simple;
	bh=ABPqlFY+qgVQVQriZmgkEfnyudsflUMPcXg+FS+S01s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUMmFZverZb+L17NmWhMVvZZiVAQHiPO6Rfh42P6SJgcl7KNcJKKHak95RUmSSVfzaLm7rIek309DodCpxudedt0EcgdgQrmC140KgcedSrewwZpkz5rmLqsYTVAEubguTa4kaZWQ5hSOC1IrJMHGBCPs0adda06jCBXieg/c2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9R1Ie7d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9R1Ie7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789572055; x=1821108055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ABPqlFY+qgVQVQriZmgkEfnyudsflUMPcXg+FS+S01s=;
  b=P9R1Ie7dh/WuZ/gm4VrKfwWkQjGWNtJaDLJPWL1UMlgR2iVm+wKCmRbQ
   fgbMCIzChwCNsdz9CEm8vNgB+RBtxuOwcQ+FuyIJrva8kn72p6jWTSh4t
   zOE3FHoEZ4aD94u9uJf6prRjpm+hgwshy4v8nDzKvEzrnqwfjcrqSocfq
   8aVQ0UQfYh048ni2IirXb58Ol+1xO90YqGZCk0I0nj7DY69bfvEuGt4P6
   8LkYGN0z/EXfOowtasDLApIqrwHieDkmsWteEbx5r/NbbRGClayYzVtxf
   9h5BbOw+ixYyoZSgl1arfiGmHQJru56FDXD57EbbI1HO2JMpMoB+gLqiU
   A==;
X-CSE-ConnectionGUID: AxT9WPvfQcGmdQFfABdgLQ==
X-CSE-MsgGUID: +P4sgKO0Tk+U4oPjYzFuvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93653712"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93653712"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:20:49 -0700
X-CSE-ConnectionGUID: JwexR3oJQzatmu4g5LEWDA==
X-CSE-MsgGUID: vFlYH9tyRkangFMS75Q85w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296853472"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:20:43 -0700
Date: Wed, 16 Sep 2026 18:20:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: zl020895 <zl020895@163.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, soc@lists.linux.dev,
	longzhao@ambarella.com,
	Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Re: [PATCH v7 00/15] Ambarella CV75 SoC minimal bring-up
Message-ID: <aqqzyPR-2JKr-2Me@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <CAMRc=McEOcWq8i3B01AR1PnfBzSQaLEaOzE6Qa+QdVXrvS_YrA@mail.gmail.com>
 <CAD++jLnRL_s9zPNkSj2UnHWPx+QHAXV19DA7dEmGZu0AkxxyaA@mail.gmail.com>
 <aqpuMcqbra9i6UDq@ashevche-desk.local>
 <23d61058.962b.1a0a9e0b355.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23d61058.962b.1a0a9e0b355.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 07:01:10PM +0800, zl020895 wrote:

> ACK: GPIO bits through the GPIO tree, then an IB for the SoC tree.
> I will keep a unified series for now.
> 
> regmap-irq cannot do PL061 type (IS/IBE/IEV, both-edge) plus the
> AMBA chained demux.
> 
> Two options for v8 — Andy, which do you prefer?
>   1) Convert PL061 MMIO to regmap only. Keep the existing gpio_chip
>      and irqchip/girq (double-write stays in the driver). Ambarella
>      layout can be a follow-up on that. No gpio-regmap yet.
> 
>   2) After (1), also move get/set/direction to gpio-regmap. IRQ
>      would stay a custom PL061 irqchip (not regmap-irq). I am not
>      sure we can avoid a way to get the gpio_chip for
>      gpiochip_*_irq() / the chained handler.
> 
> I am leaning to (1) for v8.

I would prefer to see (2) and then we can discuss to roll-back if it looks not
good enough.

Either way your PM runtime support for gpio-regmap is a good change.

> 在 2026-09-16 18:23:45，"Andy Shevchenko" <andriy.shevchenko@linux.intel.com> 写道：
> >On Wed, Sep 16, 2026 at 11:42:56AM +0200, Linus Walleij wrote:
> >> On Wed, Sep 16, 2026 at 11:14 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
> >> > On Tue, 15 Sep 2026 13:15:30 +0200, Long Zhao via B4 Relay
> >> > <devnull+longzhao.ambarella.com@kernel.org> said:
> >> > > This series adds minimal Ambarella CV75 support for early bring-up with
> >> > > a serial console: DT bindings, RCT clocks, pinctrl, PL061 GPIO via
> >> > > gpio-regmap, 8250_dw UART quirks, ARCH_AMBARELLA, CV75 EVK DT, and
> >> > > MAINTAINERS.
> >> > >
> >> > > This is a single unified series. Please apply via the SoC
> >> > > tree; subsystem maintainers are Cc'd for their pieces.
> >> >
> >> > I would prefer to take the GPIO regmap bits through the GPIO tree and provide
> >> > an immutable branch to the SoC tree as it has potential for conflicts that
> >> > early into the cycle.
> >> 
> >> Queue them up and send us the IB if you think they are ready!
> >> 
> >> Long can probably send a PR based on that IB for the rest to the
> >> SoC tree, a bit tricksy but it works.
> >
> >I'm still unsure why we can't use IRQ facility from gpio-regmap.
> >Can you have a look there?
> >
> >With that being said, I'm not sure that the patch that exposing gpio_chip
> >from gpio-regmap is justified.
> >
> >The whole GPIO rework needs a bit more routine work (resplitting, refactoring,
> >et cetera), so later we may see clearer what's going on.

-- 
With Best Regards,
Andy Shevchenko


