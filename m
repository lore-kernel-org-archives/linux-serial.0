Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A13921DD;
	Wed,  3 Jun 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467881; cv=none; b=aYTMnyyBns7IsdOTay2vnRi/quhYn6IsXFneNOqVErVxsW2ldOv1S4+ibb9GvIKCX6uR3QieeWs70LqUA/cSkYndQ9RXNOyAJKMO8pO1c93G+Qea/PILD1l8s7LskhXy+LfdBN6wFJgyMUAjKiXy9zWAdg68A5aDnBCVlZ91Xyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467881; c=relaxed/simple;
	bh=aPkrQ6JmSv7uAfTQzyp9VFLHcfsD5sqSUD5F6ZTWZLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj9uKeqx2Fpv3pUVGFfjmY98GNAlIe4brH8qbOeRMXJsaejrlS1aOxxozMr5lY2Knzs7T73n0rip/wirpwJ4l3x9A8mLJOzHzbyI9rwPVQPN6IPzPmap0NVPDIYouMl865aoZP5/yfVSd6Fxo8zmfMUzjsEsiiLlNyaoZvQ72Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS0rVZce; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS0rVZce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780467879; x=1812003879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aPkrQ6JmSv7uAfTQzyp9VFLHcfsD5sqSUD5F6ZTWZLA=;
  b=kS0rVZceNngkYwMkzlplR5nBWfqjozYpadDBBIx50wEO+LQ3TGZVay6/
   LIXG3pokJPv+5WkU1CLHPpbk0wdpLuChOZonBcv1i5TGgs0Kp8RZWJkJc
   l7nhTHZAy62CRt+hf7QeFupRFrPbUl4Q2GHOr0Dds8jdP6oKKdLDmRbbx
   bODhFYojBPIeOcKjfpGKTiIlQ1jxxqVKI77nHhCti7pCdn0WSEeTjBwtd
   x/JYz5Tt+A/tHBmiayYF7JuZBFJVB2/X6c/1ic2aC0sJ1VhtmABXvwr4c
   511JxZZL+5IRYaNQ1NRXWjNarU6eIVdGEvtg3/pebPmY0NSNnuMEJKzFY
   Q==;
X-CSE-ConnectionGUID: BzsLlC23SYSlrnDlTjnnYQ==
X-CSE-MsgGUID: T1G378lUREeiIKkhM/cR8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81122750"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81122750"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:24:38 -0700
X-CSE-ConnectionGUID: h/fLTFIYT9yOcqp1Jn/LZg==
X-CSE-MsgGUID: S7il6SwSQrOlfC1LdqVJ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="248443716"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:24:37 -0700
Date: Wed, 3 Jun 2026 09:24:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <ah_Iovpb8N2OTucV@ashevche-desk.local>
References: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
 <ah87KOm0nfAyvr4c@black.igk.intel.com>
 <ah_DFCQH9e47qBp7@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah_DFCQH9e47qBp7@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 08:12:38AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> On Tue, Jun 02, 2026 at 10:20:56PM +0200, Andy Shevchenko wrote:
> > On Tue, Apr 28, 2026 at 04:40:33PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > ... and PCI device helpers.
> > > 
> > > The various struct pci_device_id were defined using a mixture of
> > > initialization by position and by name. Some use the PCI device helpers
> > > (like PCI_DEVICE and PCI_DEVICE_SUB) and others don't.
> > > 
> > > Consistently use named initializers, drop assignments of 0 by position
> > > for .class and .class_mask and use the PCI device helpers. Also use
> > > consistent line-breaks and positioning for opening and closing curly
> > > braces.
> > > 
> > > The secret plan is to make struct pci_device_id::driver_data an
> > > anonymous union (similar to
> > > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> > > and that requires named initializers. But it's also a nice cleanup on
> > > its own.
> > > 
> > > This patch doesn't change the compiled result; this was verified using
> > > an allmodconfig with several things disabled that make reproducible
> > > builds harder on x86 and arm64.
> > 
> > This patch broke the build.
> > 
> > drivers/tty/serial/8250/8250_pci.c:5398:12: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
> >  5398 |                 .class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
> >       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/linux/pci_ids.h:74:45: note: expanded from macro 'PCI_CLASS_COMMUNICATION_MULTISERIAL'
> >    74 | #define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
> > 
> > and so on...
> 
> Oh, it works fine for me with clang 19.1.7, gcc 11.3.0, gcc 12.4.0, gcc
> 13.3.0, gcc 14.2.0 and gcc 15.2.0, but I agree it's a bit obscure
> because .class and .class_mask are specified twice; once by PCI_VDEVICE
> and once explicitly.

> Which compiler are you using that breaks here? I guess I might have
> broken more drivers this way, so it would be great to have a setup to
> reproduce your issue.

My make command:

	make LLVM=-19 W=1 C=1 CF=-D__CHECK_ENDIAN__ ...

The line the above error is from is from your patch.

> Once all the initializer are converted to named initialisation, we
> should definitively drop the assignment to .class and .class_mask in
> PCI_VDEVICE, but that doesn't work yet.

Please, address the build issue first. I'm surprised the LKP hadn't complained
on that (yet?). Note, that all redefinitions like this are broken and need to
be addressed.

-- 
With Best Regards,
Andy Shevchenko


