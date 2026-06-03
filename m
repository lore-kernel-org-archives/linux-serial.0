Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D722C0F81;
	Wed,  3 Jun 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480431; cv=none; b=ZxlsovS9gPSnp123OZSTJoU0mDm1qn+fCxiuA9pXTdBPo5FOGeEmEybGrino81r/Sz4fjRMrEcipmk9s689jz6mxdWbdobQTeFfO1suD5RwL925zj9FqILePpwYP04zFKdwCQ2XgEVP+U6BaHZ1xkwOzuont0q8wsH8YUZ5ZDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480431; c=relaxed/simple;
	bh=AEqtTbwullUNa0+yeXqNLqYDrhnn7kc/lM55S7ZRcg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLUY9iyGTHH37o259jeqA97tEpbZC4OskoXRmFHM1GcwDFIy8o8ZqZCfmYSsOarbf/XXue8w+/i2XHPJ3Kb46hfGrzOkwa75HLSosC4umhbKcLcQXcDW0/z6AwLvo2T6lJqbkI1vZWRLmZGVbJtDPxRsVmBWrcR+UAM0gLSs/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ea+sJwxJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ea+sJwxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780480431; x=1812016431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AEqtTbwullUNa0+yeXqNLqYDrhnn7kc/lM55S7ZRcg8=;
  b=Ea+sJwxJWa2XQhB/eU+P+5JDTEzyntwAJStNorGNv8FfmeTNdnFzZv6M
   l73fADgJ8MwDrhwWBToe7DhidzVf976S9W5j4uZcX7pzPJ8kDNGvPGO9e
   y/N8yX1fSzqyEGuTgBaOtmGVRzuwnPydvqcyLUta06ASTG6FOTKsiegXR
   hJlwhylniMKxvOcXT6/nigegSvEhfC2OU5ZLi6qmJuiQ/TvlDjIGGRKvT
   ios4h1pYaH4M3LlYWkB99N7+psLaIDpv32nUk1DYe565y1Bd4JS2g6JAW
   pjGnLG/4aJLZQ4N4xXV32w+8TMaQ+07dLREABbSOh5jBE21zx1vrEB1FK
   A==;
X-CSE-ConnectionGUID: V4ly4HXwTAOw9oblY2i25g==
X-CSE-MsgGUID: kPnVFq2BS3ms9XDUS5MsIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85170828"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="85170828"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:53:50 -0700
X-CSE-ConnectionGUID: upiKI8zQQEqexWnPbl7YXA==
X-CSE-MsgGUID: 4DZdYOINTwqfZfvFk7Zn0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="282287599"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:53:48 -0700
Date: Wed, 3 Jun 2026 12:53:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <ah_5qVKOf8LXG1Xo@ashevche-desk.local>
References: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
 <ah87KOm0nfAyvr4c@black.igk.intel.com>
 <ah_DFCQH9e47qBp7@monoceros>
 <ah_Iovpb8N2OTucV@ashevche-desk.local>
 <ah_2rD9UPEYu78mv@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah_2rD9UPEYu78mv@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 11:43:11AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> On Wed, Jun 03, 2026 at 09:24:34AM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 03, 2026 at 08:12:38AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > On Tue, Jun 02, 2026 at 10:20:56PM +0200, Andy Shevchenko wrote:
> > > > This patch broke the build.
> > > > 
> > > > drivers/tty/serial/8250/8250_pci.c:5398:12: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
> > > >  5398 |                 .class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
> > > >       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > include/linux/pci_ids.h:74:45: note: expanded from macro 'PCI_CLASS_COMMUNICATION_MULTISERIAL'
> > > >    74 | #define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
> > > > 
> > > > and so on...
> > > 
> > > Oh, it works fine for me with clang 19.1.7, gcc 11.3.0, gcc 12.4.0, gcc
> > > 13.3.0, gcc 14.2.0 and gcc 15.2.0, but I agree it's a bit obscure
> > > because .class and .class_mask are specified twice; once by PCI_VDEVICE
> > > and once explicitly.
> > 
> > > Which compiler are you using that breaks here? I guess I might have
> > > broken more drivers this way, so it would be great to have a setup to
> > > reproduce your issue.
> > 
> > My make command:
> > 
> > 	make LLVM=-19 W=1 C=1 CF=-D__CHECK_ENDIAN__ ...
> > 
> > The line the above error is from is from your patch.
> 
> OK, I can reproduce with that cmdline, thanks. Expect a patch in a
> moment.

Thanks, will be glad to test ASAP.

-- 
With Best Regards,
Andy Shevchenko


