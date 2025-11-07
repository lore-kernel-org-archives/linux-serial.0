Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC917C211;
	Fri,  7 Nov 2025 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503487; cv=none; b=sEjExF1NdCzdsNTY40AGjJgyiQFyUvbbWdtpRq2fjYzs0S65fYenkXAWbtzjaI9bTImXPPOQ+b4+olFCbtr2foJ2HwvqBdIhVWNSfvuZGgQoIlHUwMc8sROxtyxEu6JtXbUfxi8UK4xNFFXvk5/YTUk8KbtstXZtFmb5F8GmYQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503487; c=relaxed/simple;
	bh=NsmzHBScL9IZkKex3aWg15Zudgo75lhaEXAr+8Ojhzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVpGXM2CwfcxM4gzjLRzY72t7jX6GX/8ZpC2w0jPY++n7qNRjDxkyKPRCosw6+XyzppPlfdYLatDKTHKSoD32F7bSBnkB8dPZMOjicSQgGskn9z0R1qaIrYsRyDIgfZChhKBKr3etY0CLFem0A8y5d5hRZ1PLdF+3yNupdnQn1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzcwNNpK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzcwNNpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762503482; x=1794039482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NsmzHBScL9IZkKex3aWg15Zudgo75lhaEXAr+8Ojhzo=;
  b=OzcwNNpKtIv+uFfxqrUxFBHlrQ8xhtjLA/3KWTFArh24AYfaAjdP4yX/
   fl+bT2FMGDoEN7d9JvVnaXxIlEi2+ylEHt2Mxo7Udby3iO3CH9zAXnRJ1
   Vdb3R17AfkNsJMwFRmcR49PsguuWem2zObnXW0PLo1ud6fxHm44udZHTm
   A45eQL3qCb5WELsqvSK2dVsYI84oII5grCwtqP9hsl4uF9zecMJiOvKll
   DUsopPyjOY77T7+P3yT5fG8Gx1W8G+KAwfqRArzJO0wz7wo/aSnNbJj5j
   Tr1wjz/jyV9PMS8IpoHQL1alU+wzCn3boMETLANlNdldF/RRAdc3U29FP
   g==;
X-CSE-ConnectionGUID: lrUYWuSTTaWGh3K+/e/7DQ==
X-CSE-MsgGUID: K/B4nXNaSRa5UX6DHGNRoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="82279619"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="82279619"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 00:18:00 -0800
X-CSE-ConnectionGUID: RM0S8d98Q7utS3BUv2MZvw==
X-CSE-MsgGUID: wD11hT3yQvCfWC1xcqp6ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="188702741"
Received: from vpanait-mobl.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.27])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 00:17:58 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vHHfP-00000006P3P-3gdF;
	Fri, 07 Nov 2025 10:17:55 +0200
Date: Fri, 7 Nov 2025 10:17:55 +0200
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
Message-ID: <aQ2rM3KOrCaMqXi6@smile.fi.intel.com>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
 <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
 <aQzJveMYT6O3EHeK@smile.fi.intel.com>
 <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
 <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
 <ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com>
 <aQzliw1B5DPKcwi5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQzliw1B5DPKcwi5@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 08:14:35PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 06, 2025 at 08:00:36PM +0200, Ilpo Järvinen wrote:
> > On Thu, 6 Nov 2025, Ilpo Järvinen wrote:
> > > On Thu, 6 Nov 2025, Borislav Petkov wrote:
> > > > On Thu, Nov 06, 2025 at 06:15:57PM +0200, Andy Shevchenko wrote:
> > > > > > So I'm seeing this with an allmodconfig build too:
> > > > 			       ^^^^^^^^^^^^
> > > > > > depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > > > > > depmod: ERROR: Found 2 modules in dependency cycles!
> > > > > 
> > > > > I'm surprised it took so long to people to start complaining.
> > > > > 
> > > > > So, some of those are modules? Can you share the
> > > > > 
> > > > > 	grep 8250 .config
> > > > > 
> > > > > part?
> > > > 
> > > > See above.
> > > 
> > > https://lore.kernel.org/all/87frc3sd8d.fsf@posteo.net/
> > > 
> > > I wonder if 8250_rsa.o can be put into 8250_base.o where most of its 
> > > callers are anyway?
> > 
> > This seems to resolve the build issue for me:
> 
> I prefer this solution to anything that suggests to merge the 8250_rsa in
> another module.

Oh, I meant "merge the source of the 8250_rsa", and here we are talking about
merging the object file, which is totally fine! Sorry for the confusion it
might made.

> If it fixes for the reporters, feel free to add my
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


