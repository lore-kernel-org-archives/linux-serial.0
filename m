Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B01D618C;
	Sat, 18 Oct 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816002; cv=none; b=oV9MBzXV9nVbnh0Php3pSAGGvfTNsZbqhllEiE4gVFbEFVrrm6/PPshUGerx4eiZ5NXieG0hNtAS/KSVbZzzo6nJODYeJ/ZuIJAE1+jEhcK3WCHgAqouww6lbLFJ3v5X/bm1sbFBgk3XdM48JWg9honqyeQc7ln3A4rDqYuL69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816002; c=relaxed/simple;
	bh=eztBdCKaPnPu14BVQLRHDSd1VzhNyTYF0y0q/IugYoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IviDBWcJ0/0+nTAUhUYHjARmgeBQJqtyrQ5GJDsFXWtvG92sz8LDtbPpGTfTwHoK7uYxzcY7QMlchqO3aPcf7Vji4UDdG/Poc0bnGxsE/RKRXId0UKThU6DX+qGPFRDu0mLzolqt+9byn9v5rVaCx42oX0mHNHkAj9qKiKP37xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TridlP09; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TridlP09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760816001; x=1792352001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eztBdCKaPnPu14BVQLRHDSd1VzhNyTYF0y0q/IugYoY=;
  b=TridlP09aBfxvmmNAfXm8D5EThoz4kiKCD33VqOcQmTDlb54w4zeMN0A
   aruX+K/Z2dWFcLETU7yKEhy3cFVmKreXdqgbTXINsuVi3ZHaEUeACtt4y
   o+t8cs/8ZmDwluhSYrdQA1zJ3za5Se7o0GHuwJWeBjS8bK4A2/hy8lv2r
   lOjmOR1YnLMWB2jV2ss5pZg9umcQF0Qi+SCq3wT9WC6Yzrna94m/y/Kja
   rTJkeLLmnPyHwibHzGpVOAqum3C+xlI6yE2HS4sqjXyrIuqaUXJlQ/GDl
   8ijdBhJfLLi86vCLqaXWrHuZNfgaibgHdXZWH0pBEvQvOSaJ/chKVWen2
   g==;
X-CSE-ConnectionGUID: 1JNBhUYqRMSKM+LsAkBT7Q==
X-CSE-MsgGUID: 0JuhUuYKQeedifLqAQH0CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62915078"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62915078"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:33:20 -0700
X-CSE-ConnectionGUID: iQwj7meATiyp74t9Zf7KrA==
X-CSE-MsgGUID: BsUDYKsjRAKI7lGroNLQiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="187009350"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:33:17 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACfx-00000000xar-441f;
	Sat, 18 Oct 2025 22:33:13 +0300
Date: Sat, 18 Oct 2025 22:33:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Eckert <fe@dev.tdt.de>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	kumaravel.thiagarajan@microchip.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pcilib: Replace deprecated PCI functions
Message-ID: <aPPreT00iiTDzJwG@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 30, 2025 at 09:27:43AM +0200, Florian Eckert wrote:
> When the '8250_exar' module is loaded into the kernel, a kernel trace
> with 'WARN_ON(legacy_iomap_table[bar])' is dumped to the console,
> because the old pci table mapping is still used in '8250_pcilib'.
> 
> The old function have been deprecated in commit e354bb84a4c1 ("PCI:
> Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> The remapping already takes or must take place in the driver that calls
> the function 'serial8250_pci_setup_port()'. The remapping should only be
> called once via 'pcim_iomap()'. Therefore the remapping moved to the
> caller of 'serial8250_pci_setup_port()'.
> 
> To replace the outdated/legacy iomap_table processing in '8250_pcilib' the
> function signature of 'serial8250_pci_setup_port()' has been extended with
> an already iomapped address value. So this can be used directly without
> io mapping again.

...

> +	if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {

Dunno if this is included already in Linux Next, but here is room for
improvement.

The problem with the above code is it (wrongly?) checks for bit and not
for the resource type. OTOH I don't remember if 64-bit version requires
the IORESOURCE_MEM to be set along with that.


> +		iomem = pcim_iomap(priv->dev, bar, 0);
> +		if (!iomem)
> +			return -ENOMEM;
> +	}


-- 
With Best Regards,
Andy Shevchenko


