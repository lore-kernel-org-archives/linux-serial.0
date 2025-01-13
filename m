Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB519259F;
	Mon, 13 Jan 2025 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770817; cv=none; b=OjrVigs8R+rpBvkAWv1qaXLNnfioqRwla5y2A3C3nrFV5p8Okr6TLSDc1GeK16vVlMSrbM4KrqrqRaUZt5EcRne8w85GlXawN4P0wM8g1ScJaZg8S68E32osf579zHps0S4dw+GnYhpyKC/hRJvduAE+cgDx8eUlErSa9XCON+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770817; c=relaxed/simple;
	bh=t986myuyyTck1Yq8XpkreR2DSCSy2gq5w91YEKGzOnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtrLHDw7q4hQhlYfUl/eE1gyGwieKhN02EXRgjbYDL8FcoGj2q4tpy6y0yly93jnRiHf4nh2yHxHTJj7Bz3Q22Ej4dAcRClWcf1WRPtRjkDd9xxavIB6xDkwz1yJYmBVAdyZ2YKK6ZeDvMZDp7fdQh5/9mjQ7rNNxrWXbJ8Spgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNpdRsnv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNpdRsnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736770816; x=1768306816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t986myuyyTck1Yq8XpkreR2DSCSy2gq5w91YEKGzOnw=;
  b=fNpdRsnvvD9zNmNTcJE2QZVx6E12iRhzLrs/6LdSR+TGrc/wlDq5/zKP
   +e+nf5EksgSM89+lHCI/KxQxwmwfK3uU3RgDsm1Fc7cjPY7lwHbjV8Bxs
   4or2AQE5xKXYzG+lKqQcEwdOOieDBQgxws4YfIOLRDMIQHud3o4u2Y5/c
   XJ1B/2N3LYALBDpnDanOwrslBgqUxXDQWZtRe+hgbYoIxiJJZutIvX6OP
   9EAu4gWV6Y4zfNcXdeXvdlaunfqX5OAkLCJmKZROqcYjoxVkJ2h+b7hkG
   SwJe2PNZMDl2QF/VGjxprph8bneCNPVRJ4YV4KdCjxN1um+cPUkeFuXoq
   w==;
X-CSE-ConnectionGUID: resHoeUbQOGe8sTH8qLpMQ==
X-CSE-MsgGUID: pNIZymN6T1mgE3afsi3QHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47606891"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47606891"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:20:15 -0800
X-CSE-ConnectionGUID: U72nlJ2iTR28Q0k6uWQLGw==
X-CSE-MsgGUID: kqMoLNHOQAqqZX6CFulKZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="105030688"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:20:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXJQN-00000000SGP-353v;
	Mon, 13 Jan 2025 14:20:07 +0200
Date: Mon, 13 Jan 2025 14:20:07 +0200
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
Message-ID: <Z4UE995i2OYv-h5E@smile.fi.intel.com>
References: <41B1320691916DE6+20250109120808.559950-1-wangyuli@uniontech.com>
 <11805e8c-c97b-4297-9c04-462fa1932ce1@app.fastmail.com>
 <Z4TkDgYSSm7nwUhY@smile.fi.intel.com>
 <7dd87e6f-6a86-409f-9e1d-4a2d836e399d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd87e6f-6a86-409f-9e1d-4a2d836e399d@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 13, 2025 at 11:36:08AM +0100, Arnd Bergmann wrote:
> On Mon, Jan 13, 2025, at 10:59, Andy Shevchenko wrote:
> > On Thu, Jan 09, 2025 at 01:40:14PM +0100, Arnd Bergmann wrote:
> >> On Thu, Jan 9, 2025, at 13:08, WangYuli wrote:
> >> 
> >> Can you explain why this isn't done as part of
> >> drivers/tty/serial/8250/8250_pnp.c?
> >
> > I assume you meant 8250_platform.c. PNP is for devices went through legacy PNP
> > enumeration, most likely having IOPORT instead of IOMEM.
> 
> No, I meant the 8250_pnp.c file.

I am puzzled then. How should it work? PNP ID != ACPI HID that's provided in
this patch commit message. On top of that, PNP driver uses _legacy_ PMP bus
and infrastructure.

> > Recently 8250_platform.c was expanded to cover ACPI IDs and it seems they have
> > proper ID allocated for their device, so that's where it seems best to fit.
> 
> I don't think we should expand the use of 8250_platform.c
> any more than it is already used for. The ACPI device ID stuff in
> there is really only for one specific platform and should probably
> get moved out as well, the rest is there for hardwired
> "plat_serial8250_port" devices on 25+ year old machines that
> predate any type of firmware (pnpbios, acpibios, of) or hardware
> (ispnp, pci, ...) autodetection for their uarts.

Okay, but I do not see any better fit. Again, PNP is not a fit here or
please elaborate how as I'm lost.

-- 
With Best Regards,
Andy Shevchenko


