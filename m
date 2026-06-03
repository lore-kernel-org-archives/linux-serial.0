Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07137C930;
	Wed,  3 Jun 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483916; cv=none; b=e80OMGKfGx7uxuMzy2E9GO0YxmpD1vSSVR380+chF+QJ7YnZ1OoLbrWPbbzXsmM8eYTzyJoRqeS0ofjI4qsLHeF2znLEl1bWkjwyalfGl6nVhQ3X7ix+n027pWz/4+xKH8caYjdXpnAW6gfi9dZRN3izMTCCP3Ju+BcMAyt8B88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483916; c=relaxed/simple;
	bh=jvDXaLmi9C3Fq91pHkUcbsmwYiHOgg/VtgXlKbXA6v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FakCZXEdxsXNcqU/eBOUbD6HgXCSP3v+0T3THU2PG8I5RKx1aXRhqnwpCdGK4CtzGMvhL2QyFDeX2osxmdfKG8AsBUIaUkHkw1gSzQaGJhlylu+Q2vlQvQxQameC9kgu/Wul+E+B6rvzrZ4Mirb/Ozydw3hq/GQI2b+oUTxIPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5SpMJVm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5SpMJVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780483916; x=1812019916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jvDXaLmi9C3Fq91pHkUcbsmwYiHOgg/VtgXlKbXA6v8=;
  b=n5SpMJVmaZOtk5sYUTFNbM2XU+BF5ww91rSQ5MGIv1A/QFksdXXZWb+S
   veX839A6Xz33txpqcRgJZbCOBztDbBFBnKakz5QiREITdGNozJkTFnvHa
   Nx4FNdj9mGMwn2iQTJ3y3Hd8p3vMySZq5ZCnSx4skE1M5oobAcWUC2QKw
   4S5vEdwu8hBL/KxZagaYPSXZwBN6PtjUHVITCwyIOh6AGMLoCKRIFs/Qv
   dvCrs9DX+KpW3iac+oi7gDilpzsbvMWvP3C9OaOoA5WbBO4SAgJy9wfdw
   M2Zik8t/HlV3IYe445lNJ0OjhJpU30pLVLgnzuikOmTGcB4Q0mSXIPdb6
   w==;
X-CSE-ConnectionGUID: 0NZFC1tXR+qQhyr73ywVAg==
X-CSE-MsgGUID: MePZjKW/TrO2gwkga1cUZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="98852878"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="98852878"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:51:55 -0700
X-CSE-ConnectionGUID: ONEc1imxRTKl3quVi2Ds5Q==
X-CSE-MsgGUID: R9sUZqxrQhCBp/A3eI447Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="246002263"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:51:53 -0700
Date: Wed, 3 Jun 2026 13:51:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Florian Eckert <fe@dev.tdt.de>,
	Martin Roukala =?iso-8859-1?Q?=28n=E9_Peres=29?= <martin.roukala@mupuf.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: Don't specify conflicting values to
 pci_device_id members
Message-ID: <aiAHR3y3RZtl7L_p@ashevche-desk.local>
References: <20260603095616.937968-2-u.kleine-koenig@baylibre.com>
 <aiAFzfU4jsB2iAXi@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiAFzfU4jsB2iAXi@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 01:45:37PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 11:56:16AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > The PCI_VDEVICE macro assigns 0 to .class and .class_mask to allow the
> > next value in the initializer to define the value for .driver_data.
> > 
> > So the construct
> > 
> > 	{
> > 		PCI_VDEVICE(INTASHIELD, 0x0D21),
> > 		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
> > 		.class_mask = 0xffff00,
> > 		.driver_data = pbn_b2_4_115200,
> > 	},
> > 
> > introduced in commit 44e55f1f3088 ("serial: 8250_pci: Consistently
> > define pci_device_ids using named initializers") has conflicting
> > assignments. In only some configurations (i.e. W=1 for me) that makes
> > the compiler unhappy.
> > 
> > So convert the two affected items to PCI_DEVICE which doesn't have that
> > hidden assigment to .class and .class_mask.
> 
> Reported-by? Closes?
> 
> > Fixes: 44e55f1f3088 ("serial: 8250_pci: Consistently define pci_device_ids using named initializers")
> > Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> 
> I will test it right away.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/linux-serial/ah_5qVKOf8LXG1Xo@ashevche-desk.local/T/#ma6eab90ca801b4292639f5c255a89b4033b33d21
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


