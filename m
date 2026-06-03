Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463A34CFD6;
	Wed,  3 Jun 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495272; cv=none; b=uzSUi2Iph1S4FvScSI7Riusi311yA8RbnZ8hZ5HcvPrdTM4QFlpMiC97XIbqjyBFMR4WwUUhlBCpd+eFr0mm/6A7t40GKNhhT/aXPW4v2hIu6OrawY5xweG8SJw9MQ5vSSf/AegqyU/vgjfscsYXywb1aJzy3fkYATWT8lfKLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495272; c=relaxed/simple;
	bh=gXzk52FsXVPcnLFxjHW0ebA7XY1+chpuI+OLCyxp9U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNDH3jdeKqbgVKRIIhI1IXohkBpej5L7N1r0j1JR6wt0SQXaC6CYu8WFYR1SNpTPow2XQhZenTTUjOtajhBXXF/LZ7YxHBJ/ntAzOLWBkAP7I2JyJ/5nI8isGp8ckTmt3972qniq/OoAKkUFGQ6zj22JIYUIUpI6lxTlHhvc4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6GTZ4C/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6GTZ4C/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780495265; x=1812031265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gXzk52FsXVPcnLFxjHW0ebA7XY1+chpuI+OLCyxp9U4=;
  b=i6GTZ4C/5qTpicUW0Y3FFk4bZMu4R6l7BloYSx/E4p6uFlkobc+Q1xEO
   f5FzGiUvy69RGC8Cs1qS1tHSgy1NFt+PheQD8tWw/klIVT0srjbAuach8
   gOJZqSdIrna0gtCRNQrl/ZmrNMZ0Bg1zWuKuweu4Y32TJXtROcJ0Tj2p+
   HzqnJ8KVGDqaJl4nJCIDXkNqtOYnzysqqvh3t1kswS4QJWJjNzF0X5VCh
   kiaq48UwUMg/K1O42H5n655zBxubTOs1K/v5OKHiclsM3FWcMdqWGuRfR
   rPtewZHCSfw1AGPmGeDPtBf4tNnOmwQkwYYjbUVk6+vzkgP58ArwmldpO
   A==;
X-CSE-ConnectionGUID: m0RG+h+ZTWG/TJbEBRzkvw==
X-CSE-MsgGUID: 8aJMpCJvQs+R0pTD6qxQsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81486821"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81486821"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:01:04 -0700
X-CSE-ConnectionGUID: IZpyVRJ4RqqFqVkyyziasw==
X-CSE-MsgGUID: ufD3+im5SGaI1avt8Ip90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="244095749"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.250])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:01:02 -0700
Date: Wed, 3 Jun 2026 17:00:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <aiAzm-DNwlIXA_ta@ashevche-desk.local>
References: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
 <ah87KOm0nfAyvr4c@black.igk.intel.com>
 <ah_DFCQH9e47qBp7@monoceros>
 <ah_Iovpb8N2OTucV@ashevche-desk.local>
 <ah_2rD9UPEYu78mv@monoceros>
 <aiANetMk3rkR0SyW@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiANetMk3rkR0SyW@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 01:21:40PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> On Wed, Jun 03, 2026 at 11:43:14AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > On Wed, Jun 03, 2026 at 09:24:34AM +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 03, 2026 at 08:12:38AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > > On Tue, Jun 02, 2026 at 10:20:56PM +0200, Andy Shevchenko wrote:
> > > > > This patch broke the build.
> > > > > 
> > > > > drivers/tty/serial/8250/8250_pci.c:5398:12: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
> > > > >  5398 |                 .class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
> > > > >       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > include/linux/pci_ids.h:74:45: note: expanded from macro 'PCI_CLASS_COMMUNICATION_MULTISERIAL'
> > > > >    74 | #define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
> > > > > 
> > > > > and so on...
> > > > 
> > > > Oh, it works fine for me with clang 19.1.7, gcc 11.3.0, gcc 12.4.0, gcc
> > > > 13.3.0, gcc 14.2.0 and gcc 15.2.0, but I agree it's a bit obscure
> > > > because .class and .class_mask are specified twice; once by PCI_VDEVICE
> > > > and once explicitly.
> > > 
> > > > Which compiler are you using that breaks here? I guess I might have
> > > > broken more drivers this way, so it would be great to have a setup to
> > > > reproduce your issue.
> > > 
> > > My make command:
> > > 
> > > 	make LLVM=-19 W=1 C=1 CF=-D__CHECK_ENDIAN__ ...
> > > 
> > > The line the above error is from is from your patch.
> > 
> > OK, I can reproduce with that cmdline, thanks. Expect a patch in a
> > moment.
> 
> The pity is that an x86 allmodconfig fails to build for different
> reasons with W=1, so I cannot easily use that to check for other drivers
> that got that same clash between PCI_VDEVICE + explicit .class assignment :-\
> 
> I'll experiment a bit about how to identify those, maybe I'll have grep
> over all my patches ...

You don't need to build the whole kernel for that, build subsystem by subsystem
where gigantic patches from you were applied.

Example:
$ make LLVM=-19 W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64 CONFIG_COMPILE_TEST=y allmodconfig -- drivers/tty/serial/8250/


-- 
With Best Regards,
Andy Shevchenko


