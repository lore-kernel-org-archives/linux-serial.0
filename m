Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9223182D;
	Mon,  4 May 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910482; cv=none; b=O13uA3wtIP7vpt0Wg01yzDqKiNjjBBYt2HiXwGqIDA+ZfHU/LV5tj9+i/3tuI0TqFuZtquGoWpTUssiP330Z8tYabUz4x/81vV9SjLodkW+K/ozfGnNkEWwZM9Gy+eX0Kw1dg3ZV66V/MCLVqDeZi71APkc5N5FZQpWUz6jxoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910482; c=relaxed/simple;
	bh=ibT1WZpkFH1cbse+HsKeO2FF0Uq7aYyVvCoIrL6ssaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNAxOD7/0U0ui4vdCTzpVuSH8HKo3FtCFq9MCowtc5HJ6/J0VCnI6RuU78wZD+iIudGaa97fd8aiNkaaiylXHgzIDFKeb/TBi+oikOJH0HUToUOfrCk+FhZXi5NTECFWjuDMN9t6vDtaHul8K+TG+4mMHGiICmGQFmGQC7uIRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfSoT+Ub; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfSoT+Ub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777910482; x=1809446482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ibT1WZpkFH1cbse+HsKeO2FF0Uq7aYyVvCoIrL6ssaE=;
  b=KfSoT+UbuQINzzYJGPnupoFVIJlht2MOFKBFZbz9V84LSi0rfyT4zvTd
   KDi++cfdaL7lmIf4RMCAyNZbCOXIHmlVfZB6V5JtyMh9nSVY89BNUMVpB
   w/6eV2nG5pXXfFH1HWQcgyAcbUi0+9w+L7x0yIHpOH2rlMqkxAPoT+Ph9
   Uc0t1e4zswXomUdrJb1IFlLlXPXR+NplMPr0iVnh4Jlq96/2wtnrXlsr5
   ZNsO834cDCkaFTxJLxhwPGQmdoTZsT8skbdBnq/cAqlIJEOH4dNlT63bd
   uYuxwqkmNcT0UJcTGMVJw/InRoimCrSAP6IIcqqNv1ivUBhDWeOe1JTpy
   Q==;
X-CSE-ConnectionGUID: zqstXOMPSrGIpCB0svfsBA==
X-CSE-MsgGUID: uJBieRSjQoKadlh8DGewvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="101436105"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101436105"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 09:01:21 -0700
X-CSE-ConnectionGUID: tW+z3w4NRrGjJQRLNPi+7w==
X-CSE-MsgGUID: 0wJOJxW9TvS1aOxCNaApQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235421235"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 09:01:19 -0700
Date: Mon, 4 May 2026 19:01:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 08/15] serial: earlycon: use uart_iotype_*() to
 simplify code
Message-ID: <afjCzMxcz3RA3JQx@ashevche-desk.local>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-8-01c1857cf761@dimonoff.com>
 <afNvR59jmKu3-CoF@black.igk.intel.com>
 <20260504114001.a20541e974060c6fe2f26ba1@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504114001.a20541e974060c6fe2f26ba1@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:40:01AM -0400, Hugo Villeneuve wrote:
> On Thu, 30 Apr 2026 17:03:35 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Apr 28, 2026 at 01:53:54PM -0400, Hugo Villeneuve wrote:

...

> > > +	char address[64] = "";
> > 
> > TBH, I prefer two pr_info() calls as that approach
> > - doesn't require temporary buffer
> > - doesn't use heavy s*printf() on top of the existing printing
> > - doesn't limit the flexibility of each of the strings (64 might
> >   become not enough in some cases, however unlikely to happen)
> 
> Note that this approach is already used in uart_report_port().

Yeah, yeah... I noticed that after review.

> Also this patch may be reworked if patch "serial: uniformize serial
> port I/O infos display" is deemed ok...

-- 
With Best Regards,
Andy Shevchenko


