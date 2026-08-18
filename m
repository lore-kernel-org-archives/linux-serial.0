Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A04477E4B;
	Tue, 18 Aug 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062287; cv=none; b=oG/HvjirbpxdRfdHv4NEM+dEB0+E7rBPJKupTbcCcKtK7aPM4AO79Yhg5ef603NvIwhtUyU0CO0b2JLVh0W8PhnvCAJGjMdO/P0/49bGkq28Cl79y9yrZLjDpAKJ/ZV53IwSS7dC8088c8OKdAVh91iDa28E5sn+aNcv2hu4RPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062287; c=relaxed/simple;
	bh=WPuMZj2OAQE9HDFZOAAcnqeB5GxLS7XAo+0fZhNpzmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS8ahagw19UFJcCYzNsKsN2Mq38nyhjYqXWoQUWSV5IZ0IgIITzLhmMghYidQaT7TwaR+huyTkId0teN+jg8CTQ8rsxHgtBWOnW64BH4a7sh2Rz3Ya7Zcir2aeZmCrJqV3pMJOTwfXWH0PSowxOP15GFzjFXiqC3wEqaefz6Sp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8SyjFoD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8SyjFoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787062285; x=1818598285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WPuMZj2OAQE9HDFZOAAcnqeB5GxLS7XAo+0fZhNpzmU=;
  b=l8SyjFoDqtsuVsBbrZwcvxJTQNtKSQXBCAcYExC5elQZSalOB7ddBHEt
   qOauC2Mf/DnlMbEYpXwYO09lHZMKxx58IXDwA/E+FNDVyO0ayHg9MY44V
   p4fovBwN4gqFnJD00WC7h1dtLiEyI1+dCp7+a5WeXCk8aYzjPtJ0t4JnW
   R2pFdoL6FqQsKcOTy54jS5xqqNFc2I0xue63jtg52LsUWZp+3YA8u9pAn
   hx3KQ2QcYSPWT/SnoTb1U5sbntgUqAKWnWhyZ0LVeLsFUezLu4XFJry0h
   lVlFnVfBWUCD3UiUyk6KtHEyQbbgt+kzuuAdcImEv4lVvPOjLiIj2AUrn
   A==;
X-CSE-ConnectionGUID: f+hbq4coRDK8g86m2YUIQw==
X-CSE-MsgGUID: YuFAzbtrSIOIIEZ+/ggH8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="75084878"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="75084878"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:11:24 -0700
X-CSE-ConnectionGUID: zdq+TYqBQmyZpF9Eko9Gkw==
X-CSE-MsgGUID: 5nZDuB5zQVyBEKQ6mP3nNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261488781"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:11:19 -0700
Date: Tue, 18 Aug 2026 17:11:17 +0300
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>, Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev, Long Zhao <zl020895@163.com>
Subject: Re: [PATCH v5 08/12] gpio: pl061: add Ambarella CV75 register layout
 variant
Message-ID: <aoRoBYE_Ns0lu75-@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-8-7bbb12f0360f@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-cv75-v5-v5-8-7bbb12f0360f@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 06:31:22PM +0800, Long Zhao via B4 Relay wrote:

> Extend gpio-pl061 with a per-variant register layout so the Ambarella
> CV75 GPIO banks can reuse the PL061 driver instead of a duplicate.

This is reinvention of gpio-mmio.c (as a library). It has necessary facilities.
Also gpio-regmap may be considered. So, switch this driver to use one of the
above and the patch for the new device will be much simpler and elegant.

-- 
With Best Regards,
Andy Shevchenko


