Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041491E9B22;
	Thu, 27 Nov 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234317; cv=none; b=WKDpdy47qUN+5862siCjcfjiXqt6Lqca2eVwlzNx25WXPMzUfh8Ii1eQ4txciwfqyOC0Cf4FCd3MtOq5sNcPON+cfgnEBelrd6X7XA34iomi6roYr0Lj4Iu2Bt8c9hltFABd3+mImE9CkJ7vHuuT0bn01PxfB1H1t/VA1SDm+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234317; c=relaxed/simple;
	bh=uzezHOgdfjxeuuqh9PuAC2SBUnz1PWD2xz4Zeeitw4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GahQiGFoxjoUcl5zYHbBHIULnoU0WWzw8rQRWuE9uwxbPurdt9i8liLQzKpOk4Rlw9ezul05KPKmqtX1uEGb65vrPZS1paFbiP82A+tCTZoOu4Jn53FuNxhlvXiRLX270eUV7VbE3p1cl0sJkNmHvn+y0As13AB2Q4Jq/TzXi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFt1Jt85; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFt1Jt85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764234316; x=1795770316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uzezHOgdfjxeuuqh9PuAC2SBUnz1PWD2xz4Zeeitw4I=;
  b=cFt1Jt85HcxMIZJo8a7pLNlH8QHskcDqDxa14vUOrZ+1zB3nfRXBmLq8
   ue0UylM7G9HCfXLuPF5ujz6sPptow2Wbo7419zZad1hWIoBnxWtaSkvDE
   ZnU0oJCIL6LM7SvYpQcdWePpx9gDt33xSYmqVcWmt67pzVQk1BehTL83/
   x43zxLYFRETHPbmxVis9CmXekPCuicNrQv1gI0xUAddyK+iJQQqIZDNZv
   P2laN7+1JoZjEwMtwU3eAteegG4bxvyah8RcFHCrWVDTHj3Vsy2LTpMOY
   Koa5P8EvMjXeiLH/R0WUw8jr5byMAO+zd6kmYctVwk7+5Ce8lm3r0gB7P
   g==;
X-CSE-ConnectionGUID: JxO/zr6sTyeOlAtahO/xPg==
X-CSE-MsgGUID: w+vXYidgQbWMGGTDsnfSDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66439348"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66439348"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:05:12 -0800
X-CSE-ConnectionGUID: 5j94vtkzQD667j0HMuR3qg==
X-CSE-MsgGUID: gMiMBeKxQW+WzGiRQgGI2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193081676"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:05:08 -0800
Date: Thu, 27 Nov 2025 11:05:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: wenhua lin <wenhua.lin1994@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
	Zhaochen Su <Zhaochen.Su@unisoc.com>,
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is
 not ready
Message-ID: <aSgUQvExNY2lCpYT@smile.fi.intel.com>
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
 <aSb5Q0Giq8p43n_o@black.igk.intel.com>
 <CAB9BWhfkkssUK7inD1gQA7DJ0YFuXKzboYFQjvZgT9jKSmyZFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB9BWhfkkssUK7inD1gQA7DJ0YFuXKzboYFQjvZgT9jKSmyZFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 04:44:08PM +0800, wenhua lin wrote:
> On Wed, Nov 26, 2025 at 8:57 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Oct 22, 2025 at 11:08:40AM +0800, Wenhua Lin wrote:

...

> > >       clk_uart = devm_clk_get(uport->dev, "uart");
> > >       if (IS_ERR(clk_uart)) {
> > > +             if (PTR_ERR(clk_uart) == -EPROBE_DEFER)
> > > +                     return -EPROBE_DEFER;
> > > +
> > >               dev_warn(uport->dev, "uart%d can't get uart clock\n",
> > >                        uport->line);
> > >               clk_uart = NULL;
> >
> > AFAICS this still ignores other issues, what should be done here is to
> > replace devm_clk_get() by devm_clk_get_optional() and drop this NULL
> > assignment.

>    The main reason for this change is that the UART driver is
> built-in, while the CLK driver is loaded as a module (ko).
>    There may be a situation where the UART driver is loaded first. If
> an EPROBE_DEFER error occurs, the driver will return directly
>    and continue waiting for the CLK driver to complete loading.
>    If this interface is changed to devm_clk_get_optional, in scenarios
> where dependent components are not yet loaded,
>    it will no longer return EPROBE_DEFER but instead return null. This
> behavior may not align with the desired outcome.

No, the _optional does exactly what your code does with the better approach
that may return other errors _in addition to_ the current state of affairs.

So, please switch to _optional variant and drop all that unneeded dances.

	clk_uart = devm_clk_get_optional(uport->dev, "uart");
	if (IS_ERR(clk_uart)) {
		return dev_err_probe(uport->dev, PTR_ERR(clk_uart),
				     "uart%d can't get uart clock\n", uport->line);

this will return an error when clock is present, but can't be retrieved.
When there is no clock provided at all, it will return NULL.

> > >       clk_parent = devm_clk_get(uport->dev, "source");
> > >       if (IS_ERR(clk_parent)) {
> > > +             if (PTR_ERR(clk_parent) == -EPROBE_DEFER)
> > > +                     return -EPROBE_DEFER;
> > > +
> > >               dev_warn(uport->dev, "uart%d can't get source clock\n",
> > >                        uport->line);
> > >               clk_parent = NULL;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


