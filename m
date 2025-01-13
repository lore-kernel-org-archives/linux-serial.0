Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7329D19;
	Mon, 13 Jan 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782324; cv=none; b=nszwFyfJ94IEptpltTMQjdrcoXnUNNweXzDigGOcdvKZxPBp5AHH4TCUOf33HXpJ+TkhjQaWCve4KiDGs5uxnEPCyMDlBqjfW/IjBejAQODINgHsai9RNEnOBszaORvExCetbh2uy0dhK5a91iTVhFGrzoWryEW79fl1cd2pPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782324; c=relaxed/simple;
	bh=6C3Qc1AAq/Kj1Nh7RPBfeYUF57k9DxJ13kr7mV5ufYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwqYnsvemVEo8apEaN/kga7uhIM1KKWq1vB0J/17ZK9sPbVm4AH26m3DFQtDoWm+NjobXFcyB28gbFKyAseyDeVeieXJI8V6iMkm1vCJ9l3E2R+p1Koxn6BtT1+ntDB2G3SctpnE2sxEESvNFkf+LnkAkYZgP0f7cz/WH+xOywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRjcQ/oD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRjcQ/oD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736782323; x=1768318323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6C3Qc1AAq/Kj1Nh7RPBfeYUF57k9DxJ13kr7mV5ufYs=;
  b=NRjcQ/oDJVME10cIeExZvmgRcq2srWm6rd3fZaq1FTwjJCEWlh+3Nd5e
   ccc77nKhFcb2ZV0eVnbLIygw5dEf5YrnZu8E24rqV/B0/mjsL0Gykmp73
   pZo7Y64DLxgsMPf81Y4ytuhlxSDN6Tyl/y8jZFREL+XK60BM9U3fJJN8+
   lzunykwuSg+D6CBhH35kBXdN0Skmt45Kj1wYwKppoqXGV3YjyITaZNX07
   wsik2QQEx3ISS41d0OVPxis+CigJUkxsy77yGX4H7LPsSbYHKG+l4xDMq
   2nO3+bN46HJoKjKTOGnCZOKm2gz1U93WnIIwP48GvUgvLFvttSSizKt7s
   w==;
X-CSE-ConnectionGUID: 6PaJ3ka2QSuX7qej7Ou3sg==
X-CSE-MsgGUID: KsUlk3wgQ/Cpfk8QVzLNDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48053410"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48053410"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:31:27 -0800
X-CSE-ConnectionGUID: zH0EaHFwTbKQDgDxh4FYYg==
X-CSE-MsgGUID: hB89/Kr3TayUH0g2D/+FvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104467384"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:31:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXMPQ-00000000VjF-0b8O;
	Mon, 13 Jan 2025 17:31:20 +0200
Date: Mon, 13 Jan 2025 17:31:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: WangYuli <wangyuli@uniontech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, pnewman@connecttech.com,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, zhanjun@uniontech.com,
	guanwentao@uniontech.com, Zhuozhen He <hezhuozhen@uniontech.com>,
	Guowei Chen <chenguowei@uniontech.com>
Subject: Re: [PATCH] serial: 8250_it8768e: Create iTE IT8768E specific 8250
 driver
Message-ID: <Z4Uxx-qaNDKtO9Xq@smile.fi.intel.com>
References: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
 <11805e8c-c97b-4297-9c04-462fa1932ce1@app.fastmail.com>
 <Z4TkDgYSSm7nwUhY@smile.fi.intel.com>
 <7dd87e6f-6a86-409f-9e1d-4a2d836e399d@app.fastmail.com>
 <Z4UE995i2OYv-h5E@smile.fi.intel.com>
 <92fa2e1d-2dbb-4d28-a7c5-c0f629f9b05a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fa2e1d-2dbb-4d28-a7c5-c0f629f9b05a@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 13, 2025 at 02:12:01PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 13, 2025, at 13:20, Andy Shevchenko wrote:
> > On Mon, Jan 13, 2025 at 11:36:08AM +0100, Arnd Bergmann wrote:
> >> On Mon, Jan 13, 2025, at 10:59, Andy Shevchenko wrote:
> >> > On Thu, Jan 09, 2025 at 01:40:14PM +0100, Arnd Bergmann wrote:
> >> >> On Thu, Jan 9, 2025, at 13:08, WangYuli wrote:
> >> >> 
> >> >> Can you explain why this isn't done as part of
> >> >> drivers/tty/serial/8250/8250_pnp.c?
> >> >
> >> > I assume you meant 8250_platform.c. PNP is for devices went through legacy PNP
> >> > enumeration, most likely having IOPORT instead of IOMEM.
> >> 
> >> No, I meant the 8250_pnp.c file.
> >
> > I am puzzled then. How should it work? PNP ID != ACPI HID that's provided in
> > this patch commit message. On top of that, PNP driver uses _legacy_ PMP bus
> > and infrastructure.
> 
> I guess I don't understand enough about ACPI then, I always
> assumed these were the same identifiers. I do see that
> CONFIG_ACPI force-enables CONFIG_PNP, and I see the examples in
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/ evice_Configuration.html
> refer to _HID values in the form of "PNP####". 

Check the implementation of the pnp_add_id(), for example.

Besides that PNP device has only 24-bit DMA mask by default,
which is due to legacy DMA controllers.

In any case the differences between PNP IDs and ACPI IDs
are described in the specification.

-- 
With Best Regards,
Andy Shevchenko


