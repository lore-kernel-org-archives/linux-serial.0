Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C29202963;
	Mon,  4 May 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905030; cv=none; b=TpwbrBj7Qli6wUTaxOcBNhUQfC5Q8ZdnRcxH5MAH6AJOFyXIgrHFwAyJktoDZjhZt7huwVDmvqpSip+2FWElwVdTIlPEeaMU1TlsGqmPgEkSK6fAc073tbNL0ufKOlH224JTLR3FgVF2a/zsQ5gBn2KoWHaTw1mLlSUU7/WXvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905030; c=relaxed/simple;
	bh=F4rZ+uQVyd6JQS5wvPp8JCWnCbWL3daQQ02JJCbu71s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSTMQAIDEpUU2sgZHtBMTQ4OFhOtnjykfhVixamomxEg5dWauNuYTsAdCpdiYrulUMBCwW3S6gSfCzMcEh52R9claEnS9zy9gJRi/thnIpu1zO4IivPeegBuTXqN9HLCPaBGSloPRFHv/AE0iAD+Xu1gbaja6dsw2npgCqaNekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FK//KCr1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FK//KCr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777905029; x=1809441029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4rZ+uQVyd6JQS5wvPp8JCWnCbWL3daQQ02JJCbu71s=;
  b=FK//KCr1qfpbBJx5w8nWBFDKrKFmUgi2CCyjuCr0JL46cKTnHHjQ6rsZ
   YCblw6Q8rZXqqPtKWpHTTf+9JFJkliH6/GmtBdHa1kwRRPQXU9Yme1kLh
   PZzoEa1/8EBCyXdSu0myp+/pmwnadmMTzuQ2w4lGS/6nVA27HESQg9xR4
   sx0ZXfKUrOTEiZZfpLjnGNn+Nv2nrnQla2rsTOj66HaaUqf9HXu6ORaoY
   SOT/s9CQg0S/TbU56evbB9OljZHxzxKHkJH1enzsTxWvaCbBkL2bGvT+z
   oOHzm7gLbB9/38m7/5UzO3d0lDvy3kLVK747nxbRduoiwgv+fpElDNizn
   A==;
X-CSE-ConnectionGUID: gsoZAEvETQ2/LXrLn6+OAw==
X-CSE-MsgGUID: w/G/ZsuUQqaI5AAkamF7Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78466241"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78466241"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:30:28 -0700
X-CSE-ConnectionGUID: sE1Jb56eSfm0oj7HVpS4kQ==
X-CSE-MsgGUID: AXmao/6UQS6v22/4AoWO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="229032080"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:30:26 -0700
Date: Mon, 4 May 2026 17:30:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Hugo Villeneuve <hugo@hugovil.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 02/15] serial: core: add uart_iotype_mmio/legacy_io
 helper functions
Message-ID: <afitf0I1izLup5TR@ashevche-desk.local>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com>
 <afNwaUf8esqaqxUe@black.igk.intel.com>
 <alpine.DEB.2.21.2605030016120.23161@angie.orcam.me.uk>
 <afhdTI_jAQrIsPSZ@ashevche-desk.local>
 <alpine.DEB.2.21.2605041220540.23161@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2605041220540.23161@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 12:44:41PM +0100, Maciej W. Rozycki wrote:
> On Mon, 4 May 2026, Andy Shevchenko wrote:

...

> > > > Why do we use 'legacy'? Still in use in modern CPUs...
> > > 
> > >  Deprecated in PCIe and not available in numerous systems.  Also actually 
> > > called "legacy" in some serial port datasheets aged ~20 years now.  While 
> > > some contemporary CPUs indeed retain the port I/O address space, it's for 
> > > legacy use anyway, you don't want to rely on it in new designs.
> > 
> > For the holder of the new (modern) CPU which supports the IO ports, this is
> > definitely not a legacy interface despite on whatever PCIe or other datasheets
> > call it.
> 
>  I appreciate your point of view, however I disagree that the presence of an
>  interface in a contemporary chip makes the interface modern.

I appreciate a bike shedding.

>  I see the port I/O space so much legacy as say the PC/AT DMA controller 
> (8237 pair), which is similarly present in current x86 chipsets.  If this 
> stuff was not present, such as say the PC/AT interrupt controller (8259A 
> pair), which I believe has been removed from some x86 system designs, then 
> it would be obsolete/removed rather than legacy.
> 
>  It is analogous to PCI/e systems that lack a southbridge and are called 
> "legacy-free", as the whole southbridge stuff, the main consumer of the 
> port I/O space still remaining in use, is legacy nowadays (the other one I 
> know of being the 8255-based PC parallel port, which has been considered a 
> legacy interface as well, even though you can still buy and plug one into 
> a modern PCIe system).
> 
>  NB I have a couple of modern x86 CPUs around too that support the port 
> I/O space, but it doesn't change my view as to the nomenclature.

Is the regular user assumed to go to dig to the mailing list (at best) or drawn
into the search of the documentation for all this? In their perspective they
possess modern CPU with support of that technology. If the same user possesses
the HW uses that ("legacy") technology, it doesn't make so in their eyes.

On top of that the additional word occupies more space in the code, making it
harder to read. It's just a redundant word. I see no value at all of using it.

P.S.
I see no value in this discussion. And I see no point to add a word where it's
not needed at all.

-- 
With Best Regards,
Andy Shevchenko


