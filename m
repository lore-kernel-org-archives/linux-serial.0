Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB94CA77D;
	Wed, 16 Sep 2026 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554241; cv=none; b=VrVxW1/5U8Z7n8dkb+Xw2yhFkvmVbO4PkLaPLr1tL8UOa/luQ728kM6h1YIo1EtJTGEOPhTAxYkfH64007+7xVCUBSC82p4j+C6JQTQuweYTVQMIDYn86Zw3HCRQOhokjdViRJpy8j5bsZ75xXQA4SzhM52XX8brbRE56/7qILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554241; c=relaxed/simple;
	bh=PeVfyJvNsLA4HGK44/YoeVENKrqs3ZCDtZ1Sly+fN/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDmxmpZtJxFShK6UkTjFx1QU4uAKovXS5bAhVCRzef2s6lwMgAPVoAYoiAKhEZ0xJoBF5eo8+QPt13gPsGgeKwBKkFDvuNbrlpBwatM1nq4QTTKk5aflzNCFbu3BhWj1w2fTfyc94CavdGreqPFJHTpPioB+B+iqcUDLvnmTw4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fj9zoMMd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fj9zoMMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789554239; x=1821090239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PeVfyJvNsLA4HGK44/YoeVENKrqs3ZCDtZ1Sly+fN/8=;
  b=Fj9zoMMdt5ussF0KzS6nC6Q4a8nJDG3jKtQI1P32gVm0MklvO2Zs4wvk
   YiPl2I0FEzabybjWdxsMhtTI6Q1DtQbDDTr7B6q2EL9sQAUyLoXPr7/mC
   X3zAcZ0uYMT5btOk4n1N0hwhuXsFxmeOqJ8gUUw2VfgwdNOoooeSjHEkK
   T32+i7Dw6GkqroKTOOe6KzJa+k+WpIgYqWuQ/FIFpqfbus8tNZky6nDZa
   6L8hXxLudV9FcXyE8tHa+gZKqiH7VGfim4XXnTMkKFZZLqJ8C1hfP9Ojx
   2loFuwc+x59E5LFOpbht9Vmxe2ixrerLHluKHkoFvmTaF+2IPAZJCG46Y
   w==;
X-CSE-ConnectionGUID: J0khVd5RQwuhVEidff6kAw==
X-CSE-MsgGUID: oIDTHnrZTxinrenKwLYopA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93798672"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93798672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:23:54 -0700
X-CSE-ConnectionGUID: zZTsqc9USHyL5sqH2UfPDg==
X-CSE-MsgGUID: 8JRWbhnbR4S5o23MCxAirA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="311581967"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:23:48 -0700
Date: Wed, 16 Sep 2026 13:23:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, soc@lists.linux.dev,
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
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 00/15] Ambarella CV75 SoC minimal bring-up
Message-ID: <aqpuMcqbra9i6UDq@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <CAMRc=McEOcWq8i3B01AR1PnfBzSQaLEaOzE6Qa+QdVXrvS_YrA@mail.gmail.com>
 <CAD++jLnRL_s9zPNkSj2UnHWPx+QHAXV19DA7dEmGZu0AkxxyaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnRL_s9zPNkSj2UnHWPx+QHAXV19DA7dEmGZu0AkxxyaA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 11:42:56AM +0200, Linus Walleij wrote:
> On Wed, Sep 16, 2026 at 11:14 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
> > On Tue, 15 Sep 2026 13:15:30 +0200, Long Zhao via B4 Relay
> > <devnull+longzhao.ambarella.com@kernel.org> said:
> > > This series adds minimal Ambarella CV75 support for early bring-up with
> > > a serial console: DT bindings, RCT clocks, pinctrl, PL061 GPIO via
> > > gpio-regmap, 8250_dw UART quirks, ARCH_AMBARELLA, CV75 EVK DT, and
> > > MAINTAINERS.
> > >
> > > This is a single unified series. Please apply via the SoC
> > > tree; subsystem maintainers are Cc'd for their pieces.
> >
> > I would prefer to take the GPIO regmap bits through the GPIO tree and provide
> > an immutable branch to the SoC tree as it has potential for conflicts that
> > early into the cycle.
> 
> Queue them up and send us the IB if you think they are ready!
> 
> Long can probably send a PR based on that IB for the rest to the
> SoC tree, a bit tricksy but it works.

I'm still unsure why we can't use IRQ facility from gpio-regmap.
Can you have a look there?

With that being said, I'm not sure that the patch that exposing gpio_chip
from gpio-regmap is justified.

The whole GPIO rework needs a bit more routine work (resplitting, refactoring,
et cetera), so later we may see clearer what's going on.

-- 
With Best Regards,
Andy Shevchenko


