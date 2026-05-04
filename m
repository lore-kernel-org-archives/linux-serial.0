Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6B34C826;
	Mon,  4 May 2026 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884502; cv=none; b=tW3IE1Ivfok6sC389WczgCmq8ZUTPB3n0GvU/yvWf2mg3hUYmTjRH8d0RSbOEW7mBlVbAo9vqgmf2Ptzmjr9XMayinx2F6i+HQy144VEEwV5wEIJ2Y001VqsBhWDp20tkO6VZ/tRZSjB5QCI+yqcI0NNSS4x0McbG1xd/84kvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884502; c=relaxed/simple;
	bh=VhjIRh1fvqhJwGuBgBtRh0hmITofmGczb7njAOFRQsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQzkqKAuHOtNJF2amIzXoypGsxq5H0SS8lrhpPd73zelvfjmpvYC3sa0h6Vf9nwz6DlxjcrDtuBegmnmrDeGgzeJ5ZM58ElAE9vRxnYyo0lZjdB/bIr6kLnDLpxCQpNOU9Cz4X0W8ur8y5p7qmUy2ONfbTd7nlNU6WIa0Ay+oFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcdX8nlY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcdX8nlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777884501; x=1809420501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VhjIRh1fvqhJwGuBgBtRh0hmITofmGczb7njAOFRQsY=;
  b=YcdX8nlYJZXUvVzULwPxqW3RwCqm6wNTBBXPgckIfggdi6Xi7QUX2yU3
   tjCudN5AkcmBrG4TXjDOms/QjGnQWkRQ8ZA919JbF4BZi6pUMhROOOGWc
   xYBUXoXwedUA8f+Uka45Y+luzi3EaBU+mLY3kAcdKqvfMs2VEXHW1NFBz
   Jzz0inNrUQjZ6Mk690U9gS1OSmFRT/jBZVMD4tbNQ0CTo1Ft8yTBzARqc
   o+VRAfhZOxNVt1udqPBTbQZvYZoKY95kin7YS5IO0Ag3xgOt1nrVU8xfi
   1v8PE+MXEXHoPvTTvwtbnGus6L9Cw44vRdT5y0mVO4EpvurjZ0yRoagsD
   A==;
X-CSE-ConnectionGUID: UuUC6l/FT6+6fE/5EiJZQg==
X-CSE-MsgGUID: g9Ipir6GT++DcayviF1LvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="66269768"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="66269768"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:48:20 -0700
X-CSE-ConnectionGUID: 23XgBpF2Q8GbP1W8FAvmVQ==
X-CSE-MsgGUID: TWzm6+YuT0eTRSygQAhPiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273571012"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:48:15 -0700
Date: Mon, 4 May 2026 11:48:12 +0300
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
Message-ID: <afhdTI_jAQrIsPSZ@ashevche-desk.local>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com>
 <afNwaUf8esqaqxUe@black.igk.intel.com>
 <alpine.DEB.2.21.2605030016120.23161@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2605030016120.23161@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 03, 2026 at 12:25:24AM +0100, Maciej W. Rozycki wrote:
> On Thu, 30 Apr 2026, Andy Shevchenko wrote:
> 
> > > +bool uart_iotype_legacy_io(enum uart_iotype iotype)
> > 
> > Why do we use 'legacy'? Still in use in modern CPUs...
> 
>  Deprecated in PCIe and not available in numerous systems.  Also actually 
> called "legacy" in some serial port datasheets aged ~20 years now.  While 
> some contemporary CPUs indeed retain the port I/O address space, it's for 
> legacy use anyway, you don't want to rely on it in new designs.

For the holder of the new (modern) CPU which supports the IO ports, this is
definitely not a legacy interface despite on whatever PCIe or other datasheets
call it.

-- 
With Best Regards,
Andy Shevchenko


