Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44FD2BDC0F;
	Thu,  6 Nov 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452884; cv=none; b=i3ZpTM81NgaBAbtRlWaBprAQbZIRcABAiuklRYoruUVZztyvR4tu39WsCEGgikdX3nQquSAe0mwGa0eDZ1LH/jsGyS2NqWo+35wBrGsjjc20R5okg7G3Xpq0wd/gtdOhXusYq70V2au8qawLTzEftoo313McetbZUjfBS9TRlpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452884; c=relaxed/simple;
	bh=TuHLkmP7oc7f1fwGrsHYpTvZNlACxygQSvckAoQGFAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm3ZSOgwl9l/zxS57ttqqTb61pCaAa4jD1cdLyUSN9BZD4Uelpcivpx+RUcDtPJb6vjb53RU5vgNwLMYAF5VU8Lag/IsmDFGbb14dxZizcl3+MgXW0uUWV4iiOGRmytJf4fCshuKEkIWMEzyK7B1pCnQQFopy9HwHhgZOYUjgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiNhbo12; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiNhbo12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762452882; x=1793988882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TuHLkmP7oc7f1fwGrsHYpTvZNlACxygQSvckAoQGFAU=;
  b=UiNhbo12y/w3+0aQdDy7j6E5JUsWd4ne7OHyv7CmuKx6lH7dkqdDqIl9
   hlG9Euot1Gqwce6PS/acT7IbZ6FNXnlUm1HEk3OcQFXKHhYUxS7WhP5cH
   /uprq8cfTu5toOAfk+yy0daRD7kW7oeWBgCQbJPSbxLxpcybdD1oLKM8K
   4dTd0GXQ9xEDtOoHf9JDfwIBG6rsHlbYmfGHSnycQfFPKfgwrfUFSB/CW
   ngluLIT9twGheZ1oE25K+iEoapZqk+puTKwboqMPy2kB4/6DC8UgMo/Rg
   9Jbn+SBlz1zDMTtqB8okrdXBeneeV3ZgTf57jAVLPX7Gw0L6tGNcUjI2O
   Q==;
X-CSE-ConnectionGUID: 1KO+HuPUSJ6P5Lnbee4OVQ==
X-CSE-MsgGUID: fAMSPbduTYWgbwc5gNc5xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68251111"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="68251111"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:14:41 -0800
X-CSE-ConnectionGUID: yrcWH+axQQWKTfc/aTiusg==
X-CSE-MsgGUID: LElf2maNR6+qrVRe5mwBWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="193000886"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:14:38 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vH4VH-00000006DZ2-3ofE;
	Thu, 06 Nov 2025 20:14:35 +0200
Date: Thu, 6 Nov 2025 20:14:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex Davis <alex47794@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Borislav Petkov <bp@alien8.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
Message-ID: <aQzliw1B5DPKcwi5@smile.fi.intel.com>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
 <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
 <aQzJveMYT6O3EHeK@smile.fi.intel.com>
 <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
 <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
 <ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 08:00:36PM +0200, Ilpo Järvinen wrote:
> On Thu, 6 Nov 2025, Ilpo Järvinen wrote:
> > On Thu, 6 Nov 2025, Borislav Petkov wrote:
> > > On Thu, Nov 06, 2025 at 06:15:57PM +0200, Andy Shevchenko wrote:
> > > > > So I'm seeing this with an allmodconfig build too:
> > > 			       ^^^^^^^^^^^^
> > > > > depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > > > > depmod: ERROR: Found 2 modules in dependency cycles!
> > > > 
> > > > I'm surprised it took so long to people to start complaining.
> > > > 
> > > > So, some of those are modules? Can you share the
> > > > 
> > > > 	grep 8250 .config
> > > > 
> > > > part?
> > > 
> > > See above.
> > 
> > https://lore.kernel.org/all/87frc3sd8d.fsf@posteo.net/
> > 
> > I wonder if 8250_rsa.o can be put into 8250_base.o where most of its 
> > callers are anyway?
> 
> This seems to resolve the build issue for me:

I prefer this solution to anything that suggests to merge the 8250_rsa in
another module.

If it fixes for the reporters, feel free to add my
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


