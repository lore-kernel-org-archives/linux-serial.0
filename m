Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE91A76DE;
	Mon, 20 Oct 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981547; cv=none; b=AXY9fCs6EiU5dLll9VzFHVP3+JdfaikLA/fRwtt3eCMFBgMbHTQjkFqcya3nNcw5HnO6Gg+qaKvj7tLaFTP/U4h8s+We6E8XmoKhZhP5ZRgm4kZ0QxoKxGFPaIRIZYSK3c544oSLuMPbFH6I8iPcyBnyjRB62Qvbpy9Mg6l9szU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981547; c=relaxed/simple;
	bh=yD9NeC1DIeHj+exe4HoGBSo1jJ9DLS0E5wIp8nXAE94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7PyxmXjOEkT/Ps4nOgzfTWXuLC9TbJwqnJSLjXDvk5TUo1UNHvg2DRmxBwRIbLS84NiGK8k2ijnlzN6FJPBegtLIvxXKZHccX8Xmdtc0m6EJEvnV91+oAO0ULuyt2iHpkiDKaUikRlIVbf60km19fnxG7Pov1CqgcD7P/EaEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMDDws0d; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMDDws0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760981545; x=1792517545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yD9NeC1DIeHj+exe4HoGBSo1jJ9DLS0E5wIp8nXAE94=;
  b=SMDDws0dPoUYup8m2EP0IQ+XodEr1MrCsCN4i93E+RrcRE1cgkVGBorb
   S94VwWwYsLa7FGCvBi0FpUW+MuQ3tLQL8Ef1TNsBPv8K4tGN9XDZNRJj+
   tS64ec5NMYPoigjREj/rmguSHc910nXnUThEd6y9rmpyf6cpvQZj2HWU1
   HOML9K83gv6AVmFhbsxPecGAPtv25o01fO78qGAM67UZoWnMXrJl5wlnF
   sUL8J5LZPbNIzRWhSLwzC+ZhDC93dLsvPq9NqGwZE66HE8msnB+smJ8nw
   BJXfbjo8vnq+RZ9O3xaAnlW/fA0GCyPl/BqO3NhwIiLOm/UCifBKz/1rH
   w==;
X-CSE-ConnectionGUID: p5MPvmQOSUSzYVNcFBmNvg==
X-CSE-MsgGUID: HssXx9BFTACPLS8t7L+Dng==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85723342"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="85723342"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:32:24 -0700
X-CSE-ConnectionGUID: ny+37O3HQHmtPj7Zpf12aQ==
X-CSE-MsgGUID: GMVSiQ5XR8KgKGPFlq1v6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="214348038"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.62])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:32:21 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAtk1-00000001LYb-1aez;
	Mon, 20 Oct 2025 20:32:17 +0300
Date: Mon, 20 Oct 2025 20:32:17 +0300
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
Message-ID: <aPZyIdnDVNezI185@smile.fi.intel.com>
References: <aPPreT00iiTDzJwG@ashevche-desk.local>
 <84ad1b3070a8374ec20f06588fab9f86@dev.tdt.de>
 <aPX15a2Zv9b_wM3u@smile.fi.intel.com>
 <e018879d65948462984da19e53cb610a@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e018879d65948462984da19e53cb610a@dev.tdt.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 20, 2025 at 06:18:42PM +0200, Florian Eckert wrote:
> On 2025-10-20 10:42, Andy Shevchenko wrote:
> > On Mon, Oct 20, 2025 at 08:47:16AM +0200, Florian Eckert wrote:
> > > On 2025-10-18 21:33, Andy Shevchenko wrote:
> > > > On Tue, Sep 30, 2025 at 09:27:43AM +0200, Florian Eckert wrote:

...

> > > > > +	if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {
> > > >
> > > > Dunno if this is included already in Linux Next, but here is room for
> > > > improvement.
> > > 
> > > I followed the code in the 'serial8250_pci_setup_port()' [1] function.
> > > The same pattern is used there [2].
> > 
> > I see. So if we want to amend that, it should be done separately.
> 
> If that's the case, then I'm done with this patchset, right?
> I do not have to send a v3?

Yeah, that proposal is not directly related to this change anyway.

> > > > The problem with the above code is it (wrongly?) checks for bit and not
> > > > for the resource type. OTOH I don't remember if 64-bit version requires
> > > > the IORESOURCE_MEM to be set along with that.
> > > 
> > > Do you mean the function 'platform_get_resource()' [3]? This is a
> > > platform
> > > device function?
> > 
> > I mean that the IORESOURCE_MEM and IORESOURCE_MEM_64 are separate bit flags
> > in struct resource::flags. Checking on one might not imply the other be
> > set, however brief look at the sources shows that _MEM_64 is supposed to be
> > set on top of _MEM.
> 
> Okay, I understand.

-- 
With Best Regards,
Andy Shevchenko


