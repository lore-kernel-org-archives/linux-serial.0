Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560D3783AD;
	Mon,  7 Sep 2026 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756364; cv=none; b=NL+FQ+Dxe0XaUjfDfhMjm1GXnlFPaShNG08qiAc1L1hSlZLKMtMD/1dGt+J8DAK+vSH4Hi5r+ts2eqixBCBs+j2lbd5Xfubipf4qAD6E59fSHrjeqv4RVUrch9dwe5sK8x9CTXrXGfQXLLlI2v7VBfr5OpyA2yHqcsoAT7IJssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756364; c=relaxed/simple;
	bh=MvbHHEL5/a5EqTe+dAnJ+mIvKAY5vNH6ijYKQPM4nCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O26aZYeiZliaELG02UV22tQOlQrwFLVeLep6w1L/VCMePyR8lU1rY3122TGErry/246AgXoT3QhiQd0iqDORgkwzXjQlEiSxFBI0DCAewEyYrrO4h6eTfIhBhnP1lQ8gg+eSzfEDkRO4u8ddd10zwCjgpWI1XdhEDf7xfipgD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqmvuIBL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqmvuIBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788756363; x=1820292363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MvbHHEL5/a5EqTe+dAnJ+mIvKAY5vNH6ijYKQPM4nCI=;
  b=jqmvuIBLomBJA3BWZ3QucWWOslJ3Vf13V/vXmhQAjwlqSfa7dtJgtzbN
   bmyp5z8RkrMa09L3Uslyr5XSo3sdhRSq/+bgziHI68hmfqyxBrm4JHR8s
   zeOEW1kMi5agFlZ9Afx8zR2dPJ1AfPSE0jqBm7q3O4jkD1o2lFg7P0wuC
   hC33WssDXgQ97eNkv7p6m4dpXOQPGo9hrYtBsmLFC6APFX4U/U1noKC5v
   IBsxzAUhdS3p0nAjrn83E5g5ru2dGK4ePGE5TZmuTKoKnfAaPennBIYNZ
   CrQXgKriIRi80pbUOeAaBscIBjHRd2TMZLecfA3VcUGXN8ISdlz5bFPKO
   A==;
X-CSE-ConnectionGUID: WdIXD8VBSdqG9PifLKUoag==
X-CSE-MsgGUID: 2qwucMzAQg2fQoqMFGAyyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="93022620"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="93022620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:46:02 -0700
X-CSE-ConnectionGUID: 6Svu84RsS9W24VILoF1UaQ==
X-CSE-MsgGUID: 7Pmz5ViORtuzSLnZnlMKgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="274406097"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:45:56 -0700
Date: Mon, 7 Sep 2026 07:45:53 +0300
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
Subject: Re: Re: [PATCH v6 08/13] gpio: regmap: support write_data_after_dir
 and girq
Message-ID: <ap5BgWtHMAxl28wF@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
 <apqxwRgi-uVKkOpr@ashevche-desk.local>
 <27a1901.423e.1a07a183bd4.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27a1901.423e.1a07a183bd4.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 12:20:03PM +0800, zl020895 wrote:

> > Are you going to fix this HW in the next version of the SoC?
> No — Ambarella does not use write_data_after_dir. It only preserves the
> existing ARM PL061 quirk already documented in gpio-pl061 (data writes
> ignored while the pin is still an input). Only pl061_arm sets the flag.

Ah, this is a good news!

In any case when documenting that flag, please also mention that any new HW
should not use it as it's considered buggy (glitches during direction change
are guaranteed).

> I will also make the first gpio_regmap_set() conditional so the quirk
> path writes once after direction_output, not twice.

I see that original pl061 actually writes twice. TBH I don't know the best
effort here and if it's really required to do so. Probably others have
better ideas...

> > This needs to be in a separate update. Also we need to understand why
> > it is required.
> OK, girq will be a separate patch. PL061 keeps a custom chained
> irqchip (not regmap-irq); gpio_regmap today only takes irq_domain or
> regmap_irq_chip, so we passed girq to keep the usual gpio_irq_chip +
> gpiochip_add flow. Open to using a caller-created irq_domain instead if
> you prefer.

If there is a chained IRQ, look how PMIC drivers usually do similar setups.
First what comes to my mind is drivers/mfd/intel_soc_pmic_bxtwc.c.

-- 
With Best Regards,
Andy Shevchenko


