Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968193B2D24;
	Wed,  3 Jun 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483539; cv=none; b=Hc11Hm7AUbSsmWJoFJ3DmP+b7Hxpa4G+H05ue8nlzQ/vdjhOSo3IZu/VdtkS02QWs2+S+uY2OddVCaxy/j7q+ltEc1TITEMD++g50qfTrUPc6Q50zvq8bp2yRs04jxsJt97w34K7Ow6GNDBSlTNVahIIrHT8qkARLfyH9VLBb6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483539; c=relaxed/simple;
	bh=it1b2HztzA9FWX261qX9GkmMoX3GQqEAEh2pUPf7GhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxVmEO96B6qAZxBOby90Wq/qT+ajt/cCU6lXwom9IMQpOXGsCTIoN8y0gjDEY1efktcktgWGe55FdQJF29+8V3Lf+KpmNAMridQFhDBGVuRqJIse+T6nGIYatD9hr9WbWRa6xnSvGKQmm4zwTPQ73JrixcbE7P315U2cP4mG/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkZpbsUa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkZpbsUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780483539; x=1812019539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=it1b2HztzA9FWX261qX9GkmMoX3GQqEAEh2pUPf7GhI=;
  b=LkZpbsUabnppLiNja9kE2uMNHkcAu3NwfyZkzgklfebr1VRKHFnpGgZq
   wGqyFtzp4FOtDUm3mOeYWxtd1A78zxA9+EUazRxv5EiWpjNUAI01yRvFr
   w94idRUIaEKG/9tDZgg3fWrSllqGjewIQkQwJy3yZJFDuC5Mv/zJiLi5k
   XrPHpWJP9xhOPaU9HgafikIFg2KYhUfg+udyvI0ZrUR1mR86pGOBfRBCl
   SiUDFyahm+6XpEBboTh8ImL2e6HHkjV0P3vLtOTOaT6dH72DbRR48VUNc
   5Ol6k1SVHvDyhe7f/Rhw8pLaI7uolV63SZDVOoBFj2vG055b3Qvi44LEy
   w==;
X-CSE-ConnectionGUID: e0xeymzqSf+Xw6CtgnzGJg==
X-CSE-MsgGUID: +zCGhna5RsaBdC2m6tF4zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81468055"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81468055"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:45:38 -0700
X-CSE-ConnectionGUID: gC0QZc6oRhmCXeXF9plhJw==
X-CSE-MsgGUID: W6bb8KmJSjaAIkKZdxp5ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="239729299"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:45:35 -0700
Date: Wed, 3 Jun 2026 13:45:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Florian Eckert <fe@dev.tdt.de>,
	Martin Roukala =?iso-8859-1?Q?=28n=E9_Peres=29?= <martin.roukala@mupuf.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: Don't specify conflicting values to
 pci_device_id members
Message-ID: <aiAFzfU4jsB2iAXi@ashevche-desk.local>
References: <20260603095616.937968-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603095616.937968-2-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 11:56:16AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The PCI_VDEVICE macro assigns 0 to .class and .class_mask to allow the
> next value in the initializer to define the value for .driver_data.
> 
> So the construct
> 
> 	{
> 		PCI_VDEVICE(INTASHIELD, 0x0D21),
> 		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
> 		.class_mask = 0xffff00,
> 		.driver_data = pbn_b2_4_115200,
> 	},
> 
> introduced in commit 44e55f1f3088 ("serial: 8250_pci: Consistently
> define pci_device_ids using named initializers") has conflicting
> assignments. In only some configurations (i.e. W=1 for me) that makes
> the compiler unhappy.
> 
> So convert the two affected items to PCI_DEVICE which doesn't have that
> hidden assigment to .class and .class_mask.

Reported-by? Closes?

> Fixes: 44e55f1f3088 ("serial: 8250_pci: Consistently define pci_device_ids using named initializers")
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

I will test it right away.

-- 
With Best Regards,
Andy Shevchenko


