Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B82339B32;
	Wed, 26 Nov 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174323; cv=none; b=bqNbGyZ6LIYBhc00aGPTWqxzMrkn6oTvFx6p5XrPXRswOecCzmTw1+DpdEPfFhLZN8+nZSg8qV9sk5GqyjEH89zbDp9MS5WBnpYfe6Nq170vUrAYQR1OZwY3yey39+60L7PrNr2RORyDZjHkddCtNXB9FD0V5UNKgmCYFKd0z4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174323; c=relaxed/simple;
	bh=Fcx1CP9IMmKSMpf71o/x6Us865ifJQNnwlfcnQ6Vqlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuzWOU9vRjTkpbzrK08q4yIFGr2ebq0m/wMVm2rkNyq2yPYFc2JftBzAc6chRZtSLapEMXij/oxUE5bwszz6Evh/jD3/MrfUG0T1nIiA78nnkdS090L/mTvDNUZ84GZPSlwKGdff3ABIiZzl1NblkSE9PLAtompuet7GXZdkNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+w/MpA1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+w/MpA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764174321; x=1795710321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Fcx1CP9IMmKSMpf71o/x6Us865ifJQNnwlfcnQ6Vqlc=;
  b=H+w/MpA1eZegupJQMHCJ9bGT+uFEvM3cnYqsM5OpP3mhB4jKgj3Ax7L/
   Hshw7EfkkcDtU8Ot6+wLJmhs/ZnQwvWHlh0MRflUo1EiRtRYVsysiXH4n
   ks86ngowDCrefVf9TMmS9MJAzpaOfHx36wLENBt3CWs0XcSk5YRauki37
   5kUQYNi52HgTeQNFpDKThnc4FaKx3ovhufzLjLLS5BbDrmOnRmUIVdaDI
   YB0oSLIl6NvktDlEbIJzWflFloG/xQtMyIIdQSWL5PU37w64ngaYg6clY
   N7vgvpsbNGn4OUkjLHkcUFeQGeUQTZAKj/FDzZvf8nTuvVFRqDWgfcwRq
   Q==;
X-CSE-ConnectionGUID: tkPc7ZysRdqUBLYhwf8QZQ==
X-CSE-MsgGUID: 9TVSdw+OTeS1hyBWMW8fOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="76541101"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="76541101"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 08:25:20 -0800
X-CSE-ConnectionGUID: X1zkrU61SX66pRRHMB56EA==
X-CSE-MsgGUID: a6qLZ5/mT0astUno1wiUzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192782333"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 08:25:17 -0800
Date: Wed, 26 Nov 2025 18:25:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kartik Rajput <kkartik@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: remove Kconfig dependency on APB DMA
 controller
Message-ID: <aScp6mooEKUkBkA6@smile.fi.intel.com>
References: <20251126090759.4042709-1-flavra@baylibre.com>
 <aSbikmpzkADKkna6@smile.fi.intel.com>
 <562c2b30820d083ff0b5e04ac176ed66c0064363.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <562c2b30820d083ff0b5e04ac176ed66c0064363.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 01:08:23PM +0100, Francesco Lavra wrote:
> On Wed, 2025-11-26 at 13:20 +0200, Andy Shevchenko wrote:
> > On Wed, Nov 26, 2025 at 10:07:59AM +0100, Francesco Lavra wrote:

...

> > >         help
> > >           Support for the on-chip UARTs on the NVIDIA Tegra series SOCs
> > >           providing /dev/ttyTHS0, 1, 2, 3 and 4 (note, some machines
> > > may not
> > >           provide all of these ports, depending on how the serial port
> > > -         are enabled). This driver uses the APB DMA to achieve higher
> > > baudrate
> > > -         and better performance.
> > > +         are enabled).
> > 
> > I think this removes a good piece of information. Perhaps rephrase?
> > 
> >           This driver may use the APB DMA when available to achieve
> >           higher baudrate and better performance.
> 
> I think this sentence would make it sound like the driver performs better
> if the APB DMA controller is available, but in reality the driver just uses
> the generic DMA API like most serial drivers, and there is nothing APB-
> specific in it. If another DMA controller (e.g. GPC on Tegra234) is
> available instead of the APB one, the serial peripheral will be just as
> fast.

OK. But this is not the case for Tegra234? Or is it and it uses DMA for UART?

-- 
With Best Regards,
Andy Shevchenko


