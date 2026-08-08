Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91994B04AF;
	Sat,  8 Aug 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218370; cv=none; b=RweD5i0j9XAh1ahEpl413vxi0+WVimw3UNTmZDJ3a4mhT0u5vBItSZZJVC6CxwJa/8PtafNU/yFVW3btbD/HOYw1Ema9Fk5F1tx7OmCQmJ9Gb4p45+UxXl2yRlSpm7hz1U6A/gRncfZ9qBYM7LySHABQieNxmJjGvbc/MRm+iqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218370; c=relaxed/simple;
	bh=Py3ynxzgRFWw7QOYBBpF6AqGMSLoCjmxpVivzVfaRSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7KLFGcKXahx9bJJn12DQGYPRxPc0N40IsjU8Zf/lx+r5r4+3DHzPvmlaC02vspKioBKxBph/YwC0sA0az6y4rAQerTRcc3otIMe3qfnOlJgkp/HsgsxJO9jYLBM8l6gL2assnYwhrkIusJYsw1Caplqyt0hzJmUl3jb2BQDaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzfovSth; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzfovSth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786218368; x=1817754368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Py3ynxzgRFWw7QOYBBpF6AqGMSLoCjmxpVivzVfaRSw=;
  b=dzfovSth1dgk2iNUbyL4qWakMwgx+SfMStHG5KmK0v6PueQvbJ/0hTNW
   8rPj08faVLx44XNGI7JFn0GiYyoD0tpi3fg+/AmCUcWQsRW2qKL8bnQyM
   xx40PHPbvGpeyuJHmnq4AGikgI+l/JY9eA69WAxWvfWwMIhgf4fS8scr1
   4QJzeohwhipa0GC7tu1w/XyOC9FmkkZrfH+GDTPCAby5Yvn0dobIjE6ll
   W38aaJqctjMZb8DqeEKGxCtfr/fVswrrN4XBfzp4MtgWBoYV+H0UxzImj
   f3mFZIbJY1WSkidmeLirs6vzqD8tLnZ1YSJipquJVNB+h4BFkTL0l8TA2
   w==;
X-CSE-ConnectionGUID: r3G39UcPT+Gr1DCYV2JrEw==
X-CSE-MsgGUID: CBgnACdLQiu9u5unm1xnLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="87006362"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="87006362"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 12:46:08 -0700
X-CSE-ConnectionGUID: QklgTQwLTTSAZNzCTlTrxw==
X-CSE-MsgGUID: f9nqorTFTeqj+79nwfLRqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="256456715"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 12:46:03 -0700
Date: Sat, 8 Aug 2026 22:46:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250: Add Airoha SoC UART and HSUART
 support
Message-ID: <aneHeSVtezYtQCSa@ashevche-desk.local>
References: <20260724183007.188172-1-ansuelsmth@gmail.com>
 <20260724183007.188172-3-ansuelsmth@gmail.com>
 <anUQhbuHSDRs04bq@ashevche-desk.local>
 <e0704a22-6a21-4f8f-b1a7-ae200bdbcfae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0704a22-6a21-4f8f-b1a7-ae200bdbcfae@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 06:55:11AM +0200, Jiri Slaby wrote:
> On 07. 08. 26, 0:53, Andy Shevchenko wrote:
> > On Fri, Jul 24, 2026 at 08:30:06PM +0200, Christian Marangi wrote:

...

> > > +	for (i = 0 ; i < ARRAY_SIZE(airoha_clk_div_info) ; i++) {
> > > +		clk_div_info = &airoha_clk_div_info[i];
> > > +		xindiv_clk = XINDIV_CLOCK / clk_div_info->div;
> > 
> > 	for (unsigned int i = ARRAY_SIZE(airoha_clk_div_info) - 1; i >= 0; i--) {
> 
> Due to unsignedness, isn't this a lopp for ever?

Oh, true! In the v3 it seems using correct type (signed one).

> > 		xindiv_clk = XINDIV_CLOCK / BIT(i);
> > 
> > Also variant (but may be a little bit confusing)
> 
> But a little bit more correct :).
> 
> > 	for (unsigned int i = ARRAY_SIZE(airoha_clk_div_info); i; i--) {
> > 		xindiv_clk = XINDIV_CLOCK / BIT(i - 1);

-- 
With Best Regards,
Andy Shevchenko


