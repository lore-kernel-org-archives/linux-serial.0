Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3127442;
	Tue, 17 Sep 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726581523; cv=none; b=NF73c/EOKy1+m6DPGp0LdQ8bs4ALMDAotqFXYQxCcksoHkz0OJiYtHXPzFBxqdWWjLZpX8HAh480aUZNNHI4sz1JwhTOdwfNTWZ+O2IbZqIOci3Uu7wUgUeywV0zX4+FP40jRNCCcwNpcq16FjBd+aRol/tE+1UflhTtoCVFvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726581523; c=relaxed/simple;
	bh=ZXeO3cCGpQp8km56A8jsnfTWizOI32RKsbTpSpPVZrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZCeeLZ1U50V6MaBgfo98JYEeTz3Tz4BJSgEUqcdMalBD8U6VEW3VZ3BUnfNLioNH66Go3JY750fAvkRuckv0kTZ11h5V+Av4wU2AE0if7IcC1rh0Qrpw5kqXGKJbalu00Ygvj/VTK0g0hLyAJfkDuW+QN7ZfYhxg2vVDcYTCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8hfm7Sh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8hfm7Sh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726581522; x=1758117522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZXeO3cCGpQp8km56A8jsnfTWizOI32RKsbTpSpPVZrM=;
  b=R8hfm7Shu6Ljm6DAPZ1w28kyBuHWeDcMac43GudnbDDH6u8GOA+WUgT1
   +gnf3UWTq0oEfAKob4AHtLCM879fbiydvALkEzgf5c6uRtXSEQ5CRxQQg
   8HXEZkDi0iJ8RkeT5NWQH03x1UmhXqROkTbAWUYPydTSqmZvG0fvPpFou
   kJqYgkbYZs//2gvWD+dh/WVwb/hnerLDsnxCRWXYlH0uTGl8ujZwyp6tE
   F4lV3IbM/aemYSuYc9kJJPtOnGQyzDmha7YzKR4teDa26sus2kp7HUP+b
   dVh6XmgKvmKWSunHnYZqI7UGDBAxan/lYGQqF4FapinpPL6R/MAUdIcN2
   Q==;
X-CSE-ConnectionGUID: oORtztbiTcy7u2kxEzWo4g==
X-CSE-MsgGUID: 8/HOxCK/RPuYxAyW4chHNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25538897"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25538897"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 06:58:41 -0700
X-CSE-ConnectionGUID: DrsjfDWiQXS1CygqQkRpgQ==
X-CSE-MsgGUID: +42bj6NxTM6E86iNmlIkXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="100036764"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 06:58:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqYix-00000009q6z-1l1f;
	Tue, 17 Sep 2024 16:58:35 +0300
Date: Tue, 17 Sep 2024 16:58:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
	andrei.warkentin@intel.com, apatel@ventanamicro.com,
	ajones@ventanamicro.com, dfustini@tenstorrent.com
Subject: Re: [PATCH] serial: 8250_platform: Enable generic 16550A platform
 devices
Message-ID: <ZumLC9I1Jf82Y8T-@smile.fi.intel.com>
References: <20240730051218.767580-1-sunilvl@ventanamicro.com>
 <mhng-d52ac6ff-2221-4613-9fce-f73467495389@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-d52ac6ff-2221-4613-9fce-f73467495389@palmer-ri-x1c9>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 17, 2024 at 06:10:25AM -0700, Palmer Dabbelt wrote:
> On Mon, 29 Jul 2024 22:12:18 PDT (-0700), Sunil V L wrote:
> > Currently, 8250_platform driver is used only for devices with fixed
> > serial ports (plat_serial8250_port). Extend this driver for any generic
> > 16550A platform devices which can be probed using standard hardware
> > discovery mechanisms like ACPI.
> >
> > This is required in particular for RISC-V which has non-PNP generic
> > 16550A compatible UART that needs to be enumerated as ACPI platform
> > device.

> It seems a bit awkward that we need something RISC-V specific here.  I 
> guess the idea is that we don't want to depend on PNP because we'd end 
> up with a bunch of PCI dependencies as well?  That seems like kind of an 
> odd way to do things, but I'm frequently suprised by ACPI stuff so

We have the same for HSUART on Intel (see 8250_dw.c). The ACPI devices use
different approach than PNP. PNP has the exact requirements for compatibility
with the legacy UARTs (to some extend). It puts some limitations. I believe
having specifics for RISC-V is fine. But I haven't checked the real IP used
in the SoC. If it's one that we have the existing driver for (like again
mentioned 8250_dw.c), then it should be added there.

TL;DR: so, what is the IP is in hardware for UART? Custom?

-- 
With Best Regards,
Andy Shevchenko


