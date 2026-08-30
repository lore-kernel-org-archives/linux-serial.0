Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA2231A3B;
	Sun, 30 Aug 2026 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075771; cv=none; b=Cic9wpvlo2CfEfIxUC8jcdrFXzESZGMhj9mAlm6MKvisMuQMC/O8oLaXQWf0Fs0w8MwtS9ACfWx/LjE5Fkn/YFKuXPv5gSwXwLxNdJWajdn7btbFLG8l3K+0gwhQoGQ81j10yJVkyg0gWw4Kzlb1jYq8AOc8NBx0OFyGI4XJfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075771; c=relaxed/simple;
	bh=1GxxShbqhyWR5JXZGet2lOpYv+Ym/BROEPbMOYsx7J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh9M5jTOf0ZgJ1w7vNNPSkFWfhiTkKa51zUJSWXo8coGAj4aBTnNDRytCTsE2z1AlWjIUhGfesy80/AVj3WeVCYtx+NIhMdzfIFhoW5c1xn66j10YCcwBMdG5ntcZxKB/ZK+Ai5Y3wyH46Oa20qhGfwdn+9IaFi8osvdGD3neHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOakZbd8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOakZbd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788075769; x=1819611769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GxxShbqhyWR5JXZGet2lOpYv+Ym/BROEPbMOYsx7J8=;
  b=OOakZbd8douTOF+V8YSzJPTuOxEFUQy13OW0QPUilZrdW5+3iNt1cKmd
   zZdI+yEy4L/5wnfSc1sQJ6Ba1IEqkpT6okzf03OJOtI6hNjN+kSSuKBVN
   erQk2iptCA27wi2DNP+/uw44QDgddnRImxsK/Dct0CZkgiaXnShXvuCGi
   hWhWC6UlnVjpQPnc6Q+t9+6YZoFcVYdyYP6kUxEh2gS5Dhdfpf21IHIxr
   aOlIbP1ZoIQs4XIwCv2uwoUSwBffRAOnmnTsJlgcnVUg68clOZFMyERCc
   lo/PJpNLr3Mn+1EMtDm7UC5JM+7euRgVCTU5zbmTczrVSgzwIMHnEVJrN
   w==;
X-CSE-ConnectionGUID: L2xdrHIXSyuBPe1crp67jg==
X-CSE-MsgGUID: /g7h99q9SpabKsQxoCpBcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="92381499"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="92381499"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:42:48 -0700
X-CSE-ConnectionGUID: NrKHh4eVRFCvL58bT4Fh/Q==
X-CSE-MsgGUID: IlsWzdGqTimm488ePG15kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="264243276"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:42:44 -0700
Date: Sun, 30 Aug 2026 10:42:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
Message-ID: <apPe8mK8fZPM6NL8@ashevche-desk.local>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
 <20260828160652.TQBsi8oO@linutronix.de>
 <0c2c424f-0372-4626-b14e-7697d98e6b20@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2c424f-0372-4626-b14e-7697d98e6b20@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 06:06:50PM +0100, Jon Hunter wrote:
> On 28/08/2026 17:06, Sebastian Andrzej Siewior wrote:
> > On 2026-08-28 18:04:08 [+0206], John Ogness wrote:
> > > For some platforms it is a problem to queue irq_work when entering
> > > cpuidle states. Since irq_work is used for deferred MSR handling,
> > > any atomic console printing when entering cpuidle states can lead
> > > to the affected hardware hanging. Tegra20 and Tegra30 are examples
> > > of such platforms. Avoiding raising the irq_work IRQ has shown to
> > > circumvent the problem.
> > 
> > I would argue that this is done for the benefit of less interrupts since
> > there no need to handle console_msr_work immediately. With the side
> > effect that it might fix a bug that was not yet reported on Tegra[23]0.
> > 
> > Ideally the Tegra folks should figure out what exactly is broken instead
> > of adding duct tape everywhere else.
> 
> Yes that would be ideal. Unfortunately these are old devices now and very
> much in maintenance mode so getting to the bottom of this now is unlikely.
> You may say then why don't we completely deprecate these, but then you
> could argue the other way and say they have been working fine up until
> now.

This is a trade-off between burden of supporting them vs. developing and move
on on more important things. Personally I consider non-blocking console feature
is *much* more important than a few "working fine up until now" outdated
platforms (side example, recently the whole i486 support was ripped off, while
working fine...).

-- 
With Best Regards,
Andy Shevchenko


