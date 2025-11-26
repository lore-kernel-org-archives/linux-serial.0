Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FF32861A;
	Wed, 26 Nov 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161865; cv=none; b=Tq/MKAfSMGWJE96YoZ3zk/VTgYgvbyAqs+p1wR+sMEYkmq+DGuBD5MHUEMTo7yd6alvujg3GBlUklijcY065hHesj4n90d3g8agqMQ6Ndh2hTH8OowkyjMxSo6pFDymFF1ECtw+3zUX2i76TOz1r7BTawjA/cOVEk75kxqQ9vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161865; c=relaxed/simple;
	bh=c2HeNL3nBLVfMslHAUVQ8RTYzUmxy4gJxxzOaYqihVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5TbmUf1et9cURxnwKfGwNQ+10Rc1WiRJv+g4FrJyzAbYGWhRYQL5RSXQVWHjRlPZaCJHZVKhFjI7IYh7LNg3CDjc/oo2YNlmeLOZo5+NhFV2tNk21H1d0K5xw/19I7iwfGwpvKeM+qTYno1n2fJWw31paF+HW/jSxixdkzeEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDYdvEUg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDYdvEUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764161865; x=1795697865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2HeNL3nBLVfMslHAUVQ8RTYzUmxy4gJxxzOaYqihVA=;
  b=NDYdvEUgPf2Fjzj8ucE61w+1u46EA7YCnbETCujUDttxgFYwRE16FObW
   y8WuWrtyTbN/Q6TYT37Etb2T5PdU3B6R+2ExZar3BwhKAEAtb/q0mCFvI
   V/iFJ/xVUgOWoRkXqGUuxgb50t6fOOBiR4nz+egRFUO1lDUGtJ1wbTO5U
   V4u8xx72dYCdiL7GydtFzRVHIOjOVBig0KvHr3Wa0V/Qfil30QsdAVsA5
   0M2bmynSsiLD3BbmDr2MLrYJXzZPigA6pHfMR73E7hOs4vDYeyRDAcY7D
   xD95A6OPbzG/MfIk8/+54ZdoVXZ5NfdFYAsOcrOaNYFaNBPmUgyE/BG4A
   w==;
X-CSE-ConnectionGUID: V3pI7KcFSq+aWY5b3d+OSQ==
X-CSE-MsgGUID: +SL6EchqR6iBcDzSifzsjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66229719"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66229719"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 04:57:44 -0800
X-CSE-ConnectionGUID: psku0azPSieuHmmmsJw9Mg==
X-CSE-MsgGUID: uiBLhpQLSV65Wz536S3xVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="223654102"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 26 Nov 2025 04:57:40 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 24CDCA0; Wed, 26 Nov 2025 13:57:39 +0100 (CET)
Date: Wed, 26 Nov 2025 13:57:39 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>,
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
	Zhaochen Su <Zhaochen.Su@unisoc.com>,
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is
 not ready
Message-ID: <aSb5Q0Giq8p43n_o@black.igk.intel.com>
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 22, 2025 at 11:08:40AM +0800, Wenhua Lin wrote:
> In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> for either uart or source clock, we should propagate the
> error instead of just warning and continuing with NULL clocks.
> 
> Currently the driver only emits a warning when clock acquisition
> fails and proceeds with NULL clock pointers. This can lead to
> issues later when the clocks are actually needed. More importantly,
> when the clock provider is not ready yet and returns -EPROBE_DEFER,
> we should return this error to allow deferred probing.
> 
> This change adds explicit checks for -EPROBE_DEFER after both:
> 1. devm_clk_get(uport->dev, uart)
> 2. devm_clk_get(uport->dev, source)
> 
> When -EPROBE_DEFER is encountered, the function now returns
> -EPROBE_DEFER to let the driver framework retry probing
> later when the clock dependencies are resolved.

...

>  	clk_uart = devm_clk_get(uport->dev, "uart");
>  	if (IS_ERR(clk_uart)) {
> +		if (PTR_ERR(clk_uart) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
>  		dev_warn(uport->dev, "uart%d can't get uart clock\n",
>  			 uport->line);
>  		clk_uart = NULL;

AFAICS this still ignores other issues, what should be done here is to
replace devm_clk_get() by devm_clk_get_optional() and drop this NULL
assignment.

...

>  	clk_parent = devm_clk_get(uport->dev, "source");
>  	if (IS_ERR(clk_parent)) {
> +		if (PTR_ERR(clk_parent) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
>  		dev_warn(uport->dev, "uart%d can't get source clock\n",
>  			 uport->line);
>  		clk_parent = NULL;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


