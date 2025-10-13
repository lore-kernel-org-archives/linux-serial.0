Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527A21ABC1;
	Sat, 18 Oct 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808937; cv=none; b=KXbbzHg/vyu9MOaBmm8c8EthlOyP2B40EDeCKCLhSLy7t96tzNwYq/x/wroGFynbJFGdPEXJnhbCzJGphjPNpWScTNbwA86kxbsWzepPm6W0fzR4+7RMUQps1AU4ZR5i1RuoaXWzPyGtb2q3QuEl3EGJpb49PTg7lbs3gkxRjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808937; c=relaxed/simple;
	bh=eztBdCKaPnPu14BVQLRHDSd1VzhNyTYF0y0q/IugYoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKk7wJPfxD1Mlh5Z+y2FIuWrpPx8Z5Tqu9i4An7iVjHdXeVxqJWUBMxANvLLgmpkDF1rW8vLUKUbK1R35ku/6gAVh9mL1THlVF2VMh+4vVfxy07JwIvCfWg8WE67gynaAHm2E1WI5mW0bTnzz3bRrN3LInSw0p5WT1E5uX91Brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYpJtBKi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYpJtBKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808936; x=1792344936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eztBdCKaPnPu14BVQLRHDSd1VzhNyTYF0y0q/IugYoY=;
  b=JYpJtBKiHm8DbK9wczqF3Zw0bm6PAacw2e6HnYxotKMfQnM4/ayuIooO
   9uxFb6e9zNyIxcbh99+azqT8INBaLRrcatggAunS7Motle6KOkkW07bQx
   diKfbU7zA9scTLm7yr8WgIKsNqnlmxrKEqeabVCVukoo13NX33MRyvn9J
   Hmf7pY58eUQDilxUZ9VfKmomC7UrmJp4pO4awM1LFb/tR4xxPGpgvFRLz
   OBlR9UCYqGfZhYvO2vanYyWV/4ioS7Tg39h69q511vybkfAhHfS0MUfyz
   8nQ/VxBX//xRLcXGyPOxaMsgyO9e1sed9SQHC+d3K9XlT6KBH6BXIGtkP
   A==;
X-CSE-ConnectionGUID: glMxB517QNS7WY952tkKgg==
X-CSE-MsgGUID: q+x9/8ekTYGLRU+ahWc+uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74111588"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="74111588"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:35 -0700
X-CSE-ConnectionGUID: eeE/8mgFRf6hHtlEf9VGow==
X-CSE-MsgGUID: P2+86U1KTWOjHcuRsqbGhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="188288056"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:34 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v8PGw-000000002mf-2YKD;
	Mon, 13 Oct 2025 23:35:58 +0300
Date: Mon, 13 Oct 2025 23:35:58 +0300
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
Message-ID: <aO1irsWEPKFgwQYU@smile.fi.intel.com>
References: <20250930072743.791580-1-fe@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930072743.791580-1-fe@dev.tdt.de>
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


