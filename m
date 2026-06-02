Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A6364EAA;
	Tue,  2 Jun 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431660; cv=none; b=lAQj19U8C8upntwIKNG8M9CMkGP7HvRTyaqobl0zk7be5HhjoZvS7BzOLxFTcUJm7y70m7eLqcIBStI2usRfyKhN1osVfiQD/6G1/L9flHQbTwIK3DS1w1luqAQdrkLmgVEsybJO8QFTAR0DT15wLPZB8f95qFj84yuMmBgR5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431660; c=relaxed/simple;
	bh=CdikHq43MH5fg9/sOKV6gFLArZkeniXGW/8IqrhgMRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWMGSHbpp9eYT90VhcWJiZ2o1CaAnpxYakfoBc1it5P29vTl/qpAJ/0R3eh2NZiO4VVqtibyyPGzyZ9iZUUb7vx9md6Ed59NDRarDA59y6Xh/JIEglWmpXWdvuRcCHB/QvD0+DLos08KYb1D3CNTw5PKRH5IkAX+C0M5yfvqbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lmbata44; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lmbata44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780431660; x=1811967660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CdikHq43MH5fg9/sOKV6gFLArZkeniXGW/8IqrhgMRQ=;
  b=Lmbata44/6xaIWpjQ2FLM+TMHKcp/g4QY+x5uadsMeqQHWTrzFkW6BcC
   nhhoF4w/u+aBXz7fz99UWm0pYJ5WwUpbZtFksIqtkrzjBh76rXHDLEz5l
   /BOZFDq+3usnajzL8VhZMIcbXHtepb/V4KslzRHTuO9/S/npdK03b55f3
   kVct4VESEn+aC7iWfpRuHbum4UxUHYTWN9VTCcPKQNrLXyXwHh0VW3545
   UUvELDEFXCAlhP6VlJ0tqnfOCNGeLiGldpTZP1CB0qYDsmsGZyjHuNtW+
   VJyRZf36zifqTcaNuH+vp2zzShhbVVz2GG1Ddd7QcznXL/Flzg245dIKG
   w==;
X-CSE-ConnectionGUID: /lWEYqY5TZGBlV/GOSpzPg==
X-CSE-MsgGUID: NPBWaqG9TUOPUG+nhWpB8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81089513"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81089513"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:20:59 -0700
X-CSE-ConnectionGUID: 7wAwoq4WR9GfWn1gnsgTXQ==
X-CSE-MsgGUID: tf9IJ+BMTZufuk56wyM69w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="245822834"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 02 Jun 2026 13:20:57 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7D8F295; Tue, 02 Jun 2026 22:20:56 +0200 (CEST)
Date: Tue, 2 Jun 2026 22:20:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <ah87KOm0nfAyvr4c@black.igk.intel.com>
References: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 28, 2026 at 04:40:33PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> ... and PCI device helpers.
> 
> The various struct pci_device_id were defined using a mixture of
> initialization by position and by name. Some use the PCI device helpers
> (like PCI_DEVICE and PCI_DEVICE_SUB) and others don't.
> 
> Consistently use named initializers, drop assignments of 0 by position
> for .class and .class_mask and use the PCI device helpers. Also use
> consistent line-breaks and positioning for opening and closing curly
> braces.
> 
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
> 
> This patch doesn't change the compiled result; this was verified using
> an allmodconfig with several things disabled that make reproducible
> builds harder on x86 and arm64.

This patch broke the build.

drivers/tty/serial/8250/8250_pci.c:5398:12: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
 5398 |                 .class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/pci_ids.h:74:45: note: expanded from macro 'PCI_CLASS_COMMUNICATION_MULTISERIAL'
   74 | #define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702

and so on...

-- 
With Best Regards,
Andy Shevchenko


