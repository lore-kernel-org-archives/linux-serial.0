Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448802DCF7C;
	Mon, 20 Oct 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949744; cv=none; b=R+tZL3CQVfYbJC8mAibOlVnz4bGFU23mIscD0iE3JfYCNin7slrgvOOelXFoMEe6VWhKIfhk8nf4mFCs0CVbJVoWIiTqBphSFGaQZb8GDoDa3Vkk4ECxOPVUztVEcFpZQ0kC1ksTZQJ5J73ZrrecOhWrYd4bHs/oD5w8o7cCYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949744; c=relaxed/simple;
	bh=a1hSQoJK8FFb701sH+cRC95PH2MlR9RQOekSrOxAiB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIYpNc0L+GbloFlnqexobB/Ww3LMVYeL4fEdUuQhX86os9HxvA9M84o0Tx+lz5Xadx4V6p5aXsKUoAK8jzQGWeQ3UvfghoA1f4CPEYtAenMMw9IByygw7a1e5dgRv0LB2OciMagm8RItWfIwQ7vfS4W82LzvZcMJNQUhda09348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kejyempy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kejyempy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760949742; x=1792485742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a1hSQoJK8FFb701sH+cRC95PH2MlR9RQOekSrOxAiB4=;
  b=kejyempyYZjzl/uh5OIq11NszFQv2gAxtfEPsnJVWBR7jCKXbg0s5g87
   m0+u7cQ3KMP/g0UDUZVnt/Er6aV8qyq5wVdQCydbRHVDZyN0V/CStWw7a
   way1546VXW6wQdLdZiaIf4Q3r9fQJl5ZzIyBmmez4ngaYC0VfJKfQkG8i
   bz5EPTfM/VeDGRXdUDpJnGpCXZrkPCIfdWjnipHAnlFmWw70JG96M1RnU
   xIl2H24dmOTQYButX6cyhQNU5WZmWU9+sEw4AXEB58oFQGOBc4gjdybYj
   DhU4ahB2ZqZfuvFuztxxrSQRDvPYNEVTlYfejBPUCENDr5/1mIzcEXs3M
   w==;
X-CSE-ConnectionGUID: UfSKHEziTLGQFZClk2D4mA==
X-CSE-MsgGUID: 9nmHy5bpRl6QkbkH1+dlBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62271171"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="62271171"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 01:42:21 -0700
X-CSE-ConnectionGUID: f85Sgmj+RLyIXFj6Co8rLw==
X-CSE-MsgGUID: OiSoDDugTOOCK7QiyF2EaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183690797"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.6])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 01:42:17 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAlT4-00000001EYy-0oIq;
	Mon, 20 Oct 2025 11:42:14 +0300
Date: Mon, 20 Oct 2025 11:42:13 +0300
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
Message-ID: <aPX15a2Zv9b_wM3u@smile.fi.intel.com>
References: <aPPreT00iiTDzJwG@ashevche-desk.local>
 <84ad1b3070a8374ec20f06588fab9f86@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ad1b3070a8374ec20f06588fab9f86@dev.tdt.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 20, 2025 at 08:47:16AM +0200, Florian Eckert wrote:
> On 2025-10-18 21:33, Andy Shevchenko wrote:
> > On Tue, Sep 30, 2025 at 09:27:43AM +0200, Florian Eckert wrote:

...

> > > +	if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {
> > 
> > Dunno if this is included already in Linux Next, but here is room for
> > improvement.
> 
> I followed the code in the 'serial8250_pci_setup_port()' [1] function.
> The same pattern is used there [2].

I see. So if we want to amend that, it should be done separately.

> > The problem with the above code is it (wrongly?) checks for bit and not
> > for the resource type. OTOH I don't remember if 64-bit version requires
> > the IORESOURCE_MEM to be set along with that.
> 
> Do you mean the function 'platform_get_resource()' [3]? This is a platform
> device function?

I mean that the IORESOURCE_MEM and IORESOURCE_MEM_64 are separate bit flags in
struct resource::flags. Checking on one might not imply the other be set,
however brief look at the sources shows that _MEM_64 is supposed to be set on
top of _MEM.

> [1] https://elixir.bootlin.com/linux/v6.18-rc1/source/drivers/tty/serial/8250/8250_pcilib.c#L24
> [2] https://elixir.bootlin.com/linux/v6.18-rc1/source/drivers/tty/serial/8250/8250_pcilib.c#L30
> [3]
> https://elixir.bootlin.com/linux/v6.17.3/source/drivers/base/platform.c#L55

-- 
With Best Regards,
Andy Shevchenko


