Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA793081D8
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273400; cv=none; b=E040JeJ96iL7pTjP4Z1gVNAZqGpRhimzc7lf6ZgVp6yrWWhwhs08UXykN+Pl4hZFrf90GkCCGvIHx8IJkKI0sSLEr/sr/na0C+nbFml/3ojQ5B0UwkrbzmsiNM5Nnb+VZiv24gwRp8a5ArsOZeCBdD5ANpnZPDUudVqmySJODms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273400; c=relaxed/simple;
	bh=JoU6evbhlIjFrYbt/md+f1YRmcXKeqIewvOvyHEDGLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmaVHRqlLRGhkOqSDn+7J6bYE46V9zJ6KstrUjMGq3/8eBFTZXImgIv6wlDZ2tyK23vGtYqv+BzwJY7WLVzIBY8sSw0X9s3YVSbXDLzt0o2bu/A7j894reQxmEkL5kQPefmN7G9/rFEXCX2fSCPc3c9HM2mlbsb+B6kIPnud1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCVXsX7a; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCVXsX7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764273399; x=1795809399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JoU6evbhlIjFrYbt/md+f1YRmcXKeqIewvOvyHEDGLI=;
  b=VCVXsX7aIUnbUVErrKVSeUS/lp8XaOWMykYFFKF3GtI7uIna3hiX5NZf
   OHPjWgEZxHhVhFBkd1g0NeBn08tNmvknpK7irIMubVs6v2UcH6oPULYWH
   V6jRvMJbmVymHEXWT3wNt166DuxBYL0r3EAVy5AvoXET6I3uq/OMyUIAr
   m1tBdAffAe0in56JlAvzyefcULX5sDUGlj5ObzKcbh3iO16eaZ4UBEvac
   DA8hrzLacg03ZmfvGq0EokZvakl6aggDeotUAJlNaU2QaojRkSYI+SgTK
   3ZXl7mk6X/isYOL9/DsiHuQDU9UVIki1MwjJ8z+fJ+ZJodOFDDDXtTxj/
   g==;
X-CSE-ConnectionGUID: /sD/NbSBRsuyEsNa2FmYKg==
X-CSE-MsgGUID: +yJOP0VMTn+Z2KqIAN/Cpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="70185784"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="70185784"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:56:38 -0800
X-CSE-ConnectionGUID: geQDdOIYTi+2TigS4IqDSg==
X-CSE-MsgGUID: VvExl+xZT525j6lAWQ8w8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="197780756"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:56:38 -0800
Date: Thu, 27 Nov 2025 21:56:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Subject: Re: [PATCH v2 0/2] serial: add KEBA UART driver
Message-ID: <aSis8tuBCfHqJvGY@smile.fi.intel.com>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <aSh21GDLStR3uhnX@black.igk.intel.com>
 <d7f1fbbb-0ec0-47b7-beee-8e9487098c99@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f1fbbb-0ec0-47b7-beee-8e9487098c99@engleder-embedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 08:26:13PM +0100, Gerhard Engleder wrote:
> On 27.11.25 17:05, Andy Shevchenko wrote:
> > On Fri, Oct 17, 2025 at 04:42:07PM +0200, Gerhard Engleder wrote:
> > > First the serial subsystem is prepared to keep rs485 settings from the
> > > driver if no firmware node exists. This enables drivers to configure a
> > > default rs485 mode, which is set by the serial subsystem.
> > > 
> > > Second the driver for the KEBA UART is added. This driver supports
> > > multiple rs485 modes and selects RS485 as default mode. This UART is
> > > found in KEBA PLC devices. The auxiliary devices for this driver are
> > > created by the cp500 driver.
> > 
> > I just realised (thanks, Lukas!) that this is for some kind of FPGA which makes
> > even bigger question here.
> > 
> > First of all, we have the FPGA framework, which handles (re-)configurations of
> > FPGAs. Second, why do you need a new driver when we have already one, i.e.
> > 8250_dfl that follows some kind of standards?
> 
> Yes, there is FPGA framework, which handles FPGA re-configuration.
> There is no FPGA re-configuration in the driver and neither in the
> system. The FPGA does not even support re-configuration. The FPGA is
> just a variant to implement a PCIe target. The FPGA loads its
> configuration on power up once from flash before the BIOS starts. So
> the operating system does not need to know that it is an FPGA. It is
> just a PCIe target.
> 
> Why not 8250_dfl? Because this is a driver for a different IP core.
> The UART is no Altera/Intel or AMD/Xilinx IP core. It is a KEBA
> IP core and the 8250_keba driver only implements feature added by
> KEBA. The rest is 8250 and uses the 8250 infrastructure.
> 
> > Third, the expect approach is to see DT overlay provided along with the FPGA
> > configuration. So, basically your cp500.c should not have been existed to begin
> > with.
> 
> Like first, it is just a PCIe target and this PCIe target is divided
> into auxiliary devices, which was suggested by gregkh. Initially I
> divided it into platform devices, but the suggestion of gregkh is a
> better fit. It is a single PCIe target, which consists of multiple
> logical devices with its own registers and interrupts. This logical
> devices are then separated by auxiliary devices.

This is implementation detail in Linux, but in HW why are those not a proper
PCI endpoints / functions? With that done, the drivers can be just normal
PCI device drivers.

> 3 years ago Intel was not able to deliver enough FPGAs. With just being
> a PCIe target, it was possible to switch the FPGA vendor without
> touching the software in the field. With Linux re-configuring the FPGA
> that would not have been possible. So re-configuring FPGAs during
> runtime is something that should be only used if needed.
> 
> > Can you elaborate on these considerations?
> 
> I hope you get a better impression what this is about. For the drivers
> it is not relevant that the device is FPGA based.

Yes, so it's rather something with a custom FW that is not supposed to be
changed (at least from the device hierarchy / functionality perspective),
or very little from version to version. Is this a correct summary?

-- 
With Best Regards,
Andy Shevchenko


