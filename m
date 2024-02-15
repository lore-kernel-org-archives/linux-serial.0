Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF391369B1;
	Thu, 15 Feb 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024917; cv=none; b=DS0plx/EG+ckRRhJgOUZAY+ZZPrKdKaGdm6KtjlFfhlIUwZRljgyhnt82GEaTEBr/56pgGVBo091wRvCPFOVLoH4y5mMO2bu4E+rpYbUvYznnC6oSUkwaZHz37iUoD1bO7vIBBGlZQ1Qajo768NY4IId0sxDel/n9/9/nobtN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024917; c=relaxed/simple;
	bh=pi6oafJtMPxBMp6PVSY+x5ezA3F1flzUWJNhVutl05c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhtGDcDNJTDi47cpl5EGnm15fHkspIRBumHTV8GS0MeicSvluXeTHMWIdJa9f7a+C107ta5qzjykcaqWrQNIudatSDVTgqzFZaKZteFE1u3SpenlJDySvD1ztISIR7gUtkasrMoP6QrcixkTb/YGGNPzbxFG5y+/DCtpTreDXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ja3DCvoe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ja3DCvoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708024916; x=1739560916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pi6oafJtMPxBMp6PVSY+x5ezA3F1flzUWJNhVutl05c=;
  b=Ja3DCvoe6v9pkKH63hmxuTMO4MVxMQgDU1qAB9FUHD9TO503y44b/3Uy
   gNToGfpz8RcB2/pn8E/aWyFxlrq7b3vCSwmlzj+8c93ffL3pXPWt468wu
   TMfYSTX3mmJOltvDaOxh2rmImQTpT5soHsZ/Ov1tTkIjyi/jFRfcxOfg5
   53ylobbxHQdS73kUQ+CuVnm3wxAGh8YUA565hjL2CS9NCnANzAhAnMQL4
   mt2bPAu5BQ1NSrCPMowUaZ/1VYbGupExLc6zKMsiC2k3FhBkIZfp7X3O5
   /FG9l5GlFIcyzIQfCnO5KHGTCaObsjPeQ/EdLHDwnM2HPe5J7RaFIdE+N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2255605"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2255605"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912215539"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912215539"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:21:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rahIs-00000004sAv-1OoV;
	Thu, 15 Feb 2024 21:21:50 +0200
Date: Thu, 15 Feb 2024 21:21:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_bcm7271: Replace custom unit
 definitions
Message-ID: <Zc5kTdkTqXEE6cA3@smile.fi.intel.com>
References: <20240215160234.653305-1-andriy.shevchenko@linux.intel.com>
 <7132d989-533f-47ef-803b-6001de3aff33@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7132d989-533f-47ef-803b-6001de3aff33@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 10:35:11AM -0800, Florian Fainelli wrote:
> On 2/15/24 08:02, Andy Shevchenko wrote:

...

> > -#define KHZ    1000
> > -#define MHZ(x) ((x) * KHZ * KHZ)
> >   static const u32 brcmstb_rate_table[] = {
> > -	MHZ(81),
> > -	MHZ(108),
> > -	MHZ(64),		/* Actually 64285715 for some chips */
> > -	MHZ(48),
> > +	81 * HZ_PER_MHZ,
> > +	108 * HZ_PER_MHZ,
> > +	64 * HZ_PER_MHZ,		/* Actually 64285715 for some chips */
> > +	48 * HZ_PER_MHZ,
> 
> The previous notation was IMHO more readable,

I tend to disagree as we read in plain text "frequency is 64 MHz",
the patch follows natural language.

> can we meet in the middle and do:
> 
> #define MHZ(x)	((x) * HZ_PER_MHZ
> 
> and avoid touching the tables entirely?

I don't like the intermediate layer which hides the implementation of MHZ().
What does it do exactly? You need to look at the internals, with the patch
applied you immediately see that these are just constants.

-- 
With Best Regards,
Andy Shevchenko


