Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246E3CB578;
	Wed, 19 Aug 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124476; cv=none; b=Qe1xUSQnrJCJpW2mpdlfOoO49993TL/E2RcUEhD9644SY6wfNy01TuuuD3vk0zSyOLxWe/Ud1ZyipUbn3bqhhESJSM64mikaKupNBIt+QMN0h7TmbnSmPMCeiwaHQix4oR5MkhR8YDsv+9zdit+v6TaI2KFDjwefsXowsL1Az9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124476; c=relaxed/simple;
	bh=G2kptcnbxzc2RLrx4I654mJLzlzkb8PupIu+d8FB6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVlNbOFKpn15pMy8f6r3mWLrAtk8FSwt0RdwVFWo1iYDXrEfysj99+IqNj+OUN91/ahzyNDzANSEr0yKRiW43Ju0DHO88gHghUexyUOo6R5V0o+WBG8W2PuQbPmqmYw8NcpMe+6anb8kwDu5iYnaj1K0m2kE02dTcsZf+m1mzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lA6nfB+p; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lA6nfB+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787124474; x=1818660474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G2kptcnbxzc2RLrx4I654mJLzlzkb8PupIu+d8FB6VQ=;
  b=lA6nfB+pjp9A+FEgVMMP+fRUaCaVKtq6b/8L2ymp3e/adUb13WzPITNX
   g14wjvRa+bW52WI5yIC6YZjC8wxggCvmVurI7J2Uqbd5cUJHGoHzPsQFK
   Veukm5aCqqOVT42DFGuB8SQ5pqcHepCqPLIe1PZEqv78w1aBAu4OFILYF
   43qMDW5p5FxSG3/knXoBxu2X6zffM0D6wuB8B5q4MzMDBGm4Fy9fyO82G
   pMXKtAlwt9hm/DU9j5dnmMEUzIybe5eOjlFMkFrXvQ7hiVOiwcgj5CLAx
   yV5fZatcEm1O7Rd61KeRroDVXNp85saO7vbzuuUvYiUL999M6EiWo2MFO
   w==;
X-CSE-ConnectionGUID: ynYkFdLRS2OlPIgHBAHERA==
X-CSE-MsgGUID: verLcMFZSCWsNGJbaH7NiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87646172"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87646172"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:27:52 -0700
X-CSE-ConnectionGUID: J+3m20rtSdqiMKQ+W6sX2Q==
X-CSE-MsgGUID: i+ywqdASR2ib4M2LXoSg4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="269303976"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:27:46 -0700
Date: Wed, 19 Aug 2026 10:27:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: zl020895 <zl020895@163.com>
Cc: longzhao <longzhao@ambarella.com>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc <soc@lists.linux.dev>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>,
	linux-gpio <linux-gpio@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Brian Masney <bmasney@redhat.com>, Lee Jones <lee@kernel.org>,
	mfd <mfd@lists.linux.dev>
Subject: Re: Re: [PATCH v5 08/12] gpio: pl061: add Ambarella CV75 register
 layout variant
Message-ID: <aoVa74E4l4fy5Por@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-8-7bbb12f0360f@ambarella.com>
 <aoRoBYE_Ns0lu75-@ashevche-desk.local>
 <79f6dc8c.2c42c.1a018dadd29.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f6dc8c.2c42c.1a018dadd29.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 03:09:51PM +0800, zl020895 wrote:
> 
> I followed Linus' guidance on the v2 pinctrl patch to reuse gpio-pl061 with a
> per-variant register layout, because the Ambarella banks share the PL061
> interrupt register model (IS/IBE/IEV/IE/RIS/MIS/IC). gpio-mmio/gpio-regmap
> cover the DATA/DIR side well, but they seem not provide that IRQ controller,
> so moving there would need a separate irqchip and would risk duplicating the
> PL061 IRQ logic Linus asked us not to fork.
> 
> 
> Would you prefer we keep the PL061 variant for that reason, or is there a
> gpio-mmio/gpio-regmap approach that also covers this interrupt model cleanly?
> We can rework either way once that is clear.

I haven't told we should duplicate. My suggestion is:
- convert current gpio-pl061 to use gpio-mmio / gpio-regmap (and I vote for the latter)
- add new regmap configuration and necessary layout for your case.

> ---- Replied Message ----
> | From | Andy Shevchenko<andriy.shevchenko@linux.intel.com> |
> | Date | 08/18/2026 22:11 |
> On Tue, Aug 18, 2026 at 06:31:22PM +0800, Long Zhao via B4 Relay wrote:
> 
> > Extend gpio-pl061 with a per-variant register layout so the Ambarella
> > CV75 GPIO banks can reuse the PL061 driver instead of a duplicate.
> 
> This is reinvention of gpio-mmio.c (as a library). It has necessary facilities.
> Also gpio-regmap may be considered. So, switch this driver to use one of the
> above and the patch for the new device will be much simpler and elegant.

-- 
With Best Regards,
Andy Shevchenko


