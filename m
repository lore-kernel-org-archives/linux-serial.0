Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D444E046;
	Fri,  2 Oct 2026 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932968; cv=none; b=Q1D6pylWjhg+nFwRJ4mozC88oUm6TZxUeCd2LEGckR6vDHQA9vWqgPUMPBykyTfIUu2aF8XXF23Y8SJBOi1fROEYQYvGdWdRMSb151tCG0WMB1Zaq3lvYOMel7ASP6uBUF1YuqgbJ/CKDJjg7qPHgdbQ+MB4dfUNJ1q/qxCxqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932968; c=relaxed/simple;
	bh=fjiLNweLxwmozP439aS0ZNu1H6FrPKQa3Ai1bKR9ZlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd8+el5hr9uv6aN8fOCiSNZbxr9anIp0Nz7DsyI8JJjCjr8LtbS6nRKmWZ/ZZyzN8IpDDh9//KCUxKrR4SUYGPRAnnfahURqM6NAztt2d2d5Z5ssdI3t8TxXQAA8hRhs83NROmqHCmlm0PxO6qRBxM7wxZZO5STuuPgHT1pPdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdRYyhbw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdRYyhbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790932965; x=1822468965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fjiLNweLxwmozP439aS0ZNu1H6FrPKQa3Ai1bKR9ZlE=;
  b=LdRYyhbwjtEqAllMZnnUdIlQLD4P7oRusht+jqt4IF06wNlxK4NsMfwF
   STPirGH1aRRLaY79CNcDoRuY2RgLLznJlPzctExPIzCjXsERQCuJKrbPu
   Z0UD39/QDvqlZGb7UYX+yWmt5tBn/7om+U3G0q7sAROZ0OucrP4NQEona
   ZWLMYJJ8NKV2WaFK61cuV5tTyy7AK8nJZv5gV7rxbmXvBweHIhDeDTiCJ
   JdSfs/Zt7OZjuCSWiHBsyRY5CXaahEKu8MNBBSmTBijX84z4o9lxbZXkc
   Hpe1lsNFGUHkpkaiV6o3Z4Duuw1E90kwfCtMP8+dZm6wVSnzXYMdKq+cv
   g==;
X-CSE-ConnectionGUID: 291CZu/KTnGiZNtKKGwSmg==
X-CSE-MsgGUID: Fq/fZPLJRIWgR9C8P3Zlyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90728986"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90728986"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:22:43 -0700
X-CSE-ConnectionGUID: eNU2YW10T22FBc3/h+ZAhw==
X-CSE-MsgGUID: y1/IruAGQNa1bH81g2tJsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="302464580"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:22:37 -0700
Date: Fri, 2 Oct 2026 12:22:34 +0300
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
Subject: Re: [PATCH v9 09/15] gpio: pl061: use IRQ_TYPE_LEVEL_MASK and
 IRQ_TYPE_EDGE_BOTH
Message-ID: <ar932rg30_MnbRhf@ashevche-desk.local>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-9-486cc289a4b8@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-cv75-v5-v9-9-486cc289a4b8@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 08:40:58PM +0800, Long Zhao via B4 Relay wrote:

> Use the standard IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH helpers
> instead of open-coded edge and level comparisons.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


