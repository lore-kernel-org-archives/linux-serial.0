Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5423241C89;
	Mon, 30 Jun 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290246; cv=none; b=BZOu0KEQWlIks/T5CyOMGxWuievZAr3vkqGrQgUt89AfhYEpe4miN23AXKsruT7iQJwzHHmwX9lt2vzZ0nHLSmPHYMgKDnTHIEOPTWDNlVE3j1CFo2tlhohAShkcLmVvdWkJB9os5ppQ+kCbiA/xVlg+eXqo8ZKmBFeM3a6W2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290246; c=relaxed/simple;
	bh=dgzPfkhy+ytF7h2R7fum3/9PiN1OYr4wvmrvLBauyNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYvgzqMn8s0u226Cv4Xgv+wjue+EHyHwnzqCGJWa55BfvtGxEnPBNPVJzD4EbxErjiAkraH6N+6C7w38js5ShmIwkRnN6Ykk/XeU/2Qfevq1DSJXuISYzyNkyqSv5Snpt0NKW86hQam6WBZ5YUN21PiAgsJsSw81XeQzgCixJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKj+4ILL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKj+4ILL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751290245; x=1782826245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dgzPfkhy+ytF7h2R7fum3/9PiN1OYr4wvmrvLBauyNQ=;
  b=LKj+4ILLUbE4e7kPWHVmnwP1qoT6sLbh/kljfnLefT7jv8Q3KV/PMU77
   eLH1iEXWHlrL92zO5PETUlTwBcYP9JTa8J0ewh2GoiHjCa5KqnovBpYeq
   Zgt95fmksdndUDTj5CVy3K0VYpn7zkjwvoWE/lNzcU8VGQvfLPG9Dbw/I
   C/2gfmS4VQNA22/GuMb/gNULnG2FHru0mAsunhmHEW1UsWT1xdJOUMEM7
   ipzhpoJN4+QyUNWoMxJvWOZCxiamWVxjlT1mZuQSwC7Fb0XVXAt155OIN
   SmF1XIczWyyxNifyOQgljIwHZy/ePSF4KiD81ASQo99sq2RypDTpy1h+G
   w==;
X-CSE-ConnectionGUID: 3Pt2xPFfSbe9iZyGo9A8tw==
X-CSE-MsgGUID: UTygQIWFSpqylxvfv0m5iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="70946626"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="70946626"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 06:30:43 -0700
X-CSE-ConnectionGUID: rLrgEnVWQhKA11NnVHMhjg==
X-CSE-MsgGUID: mlwKJsyaSoWUGlYzIly57Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="157735147"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 06:30:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWEak-0000000BJnw-3lNQ;
	Mon, 30 Jun 2025 16:30:38 +0300
Date: Mon, 30 Jun 2025 16:30:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] serial: 8520_ce4100: Reuse mem_serial_in() in
 ce4100_mem_serial_in()
Message-ID: <aGKRfuu0p9krbejj@smile.fi.intel.com>
References: <20250630125427.2266455-1-andriy.shevchenko@linux.intel.com>
 <023bb251-255d-4f0e-8b2a-d6c8bc35d75b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023bb251-255d-4f0e-8b2a-d6c8bc35d75b@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 30, 2025 at 03:02:11PM +0200, Jiri Slaby wrote:
> On 30. 06. 25, 14:54, Andy Shevchenko wrote:
> > In one place in ce4100_mem_serial_in() the code may be replaced with
> > mem_serial_in() call. Do it so and collapse two conditionals into one.

...

> >   	u32 ret, ier, lsr;
> > -	if (offset != UART_IIR)
> > -		return mem_serial_in(p, offset);
> > -
> > -	offset <<= p->regshift;
> > -
> > -	ret = readl(p->membase + offset);
> > -	if (!(ret & UART_IIR_NO_INT))
> > +	ret = mem_serial_in(p, offset);
> > +	if (!(offset == UART_IIR) && (ret & UART_IIR_NO_INT))
> 
> I am in haste, but a misplaced right paren (should be at the end)?

Ah, good catch! It's probably better in the original form, i.e.

	if ((offset != UART_IIR) || !(ret & UART_IIR_NO_INT))

What do you think?

-- 
With Best Regards,
Andy Shevchenko


