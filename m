Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD4311C13;
	Wed, 26 Nov 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179103; cv=none; b=CC5wFT47wD8wDF8gltj542Rc70/DyFJgCVsvxXtFCwGrUllLpOfCIm6ZVwhKd5f+9Vuio9bP5EoZ2AL1sQlRHdesu8UJ33ZB2w+3QjDzDobWSYYT9y7RD4cMyA6zeGypX1J+K1DZnRvIu8xvyJrzrvhwsjcZUpdjDSfQ9zs2f/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179103; c=relaxed/simple;
	bh=XshqHQH3pSF5duVhgj/bYmKn1aZMpZPCrVvLmnPAGCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMmxS5LCh0gzVLcqiayVOfTf+esbngaLlQ5iuvwI+LZZQyzMoTLmtLE31xXXn9rr/BkeZbIyHYKIxBBJJYQQOgz2moC7m/nGRvmy5iUODrvI2jW1o3ofEjPCab9Mg9/CsWc4sPRulgopIQ+NK7whC2+Zc1aylc0KC9FaiJ3dp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVyWZ/kC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVyWZ/kC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764179102; x=1795715102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XshqHQH3pSF5duVhgj/bYmKn1aZMpZPCrVvLmnPAGCI=;
  b=hVyWZ/kCTFfzXkOBI1hQLjbGhkZmiwVItm0KIVNCNvsxjihqc+kziDTw
   cr9dnsA4aCCMwD4V9NIdWyOKiW2DyymgD51pmkn94iFgeVWdjWxSnH1ce
   jKKj3U43F2SZw8fxjsCDE+8FKNwklnB9YtNp2tEROLsUjxHBPjTE3n/rC
   Ob36Kfr552w96pjSxt97evE6CrSajxAHs81jTp9x4XHKGRh7VHhOE9bmP
   h+yTcwWKCnmz3nZgzSvBX3Lc97jbSLSPTxhCHZOLHMrz1gNkf6IEmHx+n
   uCIHJ6+bSz5Btx3TjH45u8biJEagaaYsU8AfYNYQoQgISGD9WAQ09HoK8
   g==;
X-CSE-ConnectionGUID: V689233KSb2XqheUlmhVjg==
X-CSE-MsgGUID: pF+U0IinS+apdqHsreOtpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70085208"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="70085208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 09:45:01 -0800
X-CSE-ConnectionGUID: yn3PHeUBQpuF5dO61RfoIQ==
X-CSE-MsgGUID: 7cBIqvr1RPu/s9UgevihGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="197492981"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 09:44:58 -0800
Date: Wed, 26 Nov 2025 19:44:55 +0200
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
Message-ID: <aSc8l-1kQoa9RK-k@smile.fi.intel.com>
References: <20251126090759.4042709-1-flavra@baylibre.com>
 <aSbikmpzkADKkna6@smile.fi.intel.com>
 <562c2b30820d083ff0b5e04ac176ed66c0064363.camel@baylibre.com>
 <aScp6mooEKUkBkA6@smile.fi.intel.com>
 <97d8026590edd4911eb03d775b10f14ecc60ba6e.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97d8026590edd4911eb03d775b10f14ecc60ba6e.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 05:45:25PM +0100, Francesco Lavra wrote:
> On Wed, 2025-11-26 at 18:25 +0200, Andy Shevchenko wrote:
> > On Wed, Nov 26, 2025 at 01:08:23PM +0100, Francesco Lavra wrote:
> > > On Wed, 2025-11-26 at 13:20 +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 26, 2025 at 10:07:59AM +0100, Francesco Lavra wrote:

...

> > > > >         help
> > > > >           Support for the on-chip UARTs on the NVIDIA Tegra series
> > > > > SOCs
> > > > >           providing /dev/ttyTHS0, 1, 2, 3 and 4 (note, some
> > > > > machines
> > > > > may not
> > > > >           provide all of these ports, depending on how the serial
> > > > > port
> > > > > -         are enabled). This driver uses the APB DMA to achieve
> > > > > higher
> > > > > baudrate
> > > > > -         and better performance.
> > > > > +         are enabled).
> > > > 
> > > > I think this removes a good piece of information. Perhaps rephrase?
> > > > 
> > > >           This driver may use the APB DMA when available to achieve
> > > >           higher baudrate and better performance.
> > > 
> > > I think this sentence would make it sound like the driver performs
> > > better
> > > if the APB DMA controller is available, but in reality the driver just
> > > uses
> > > the generic DMA API like most serial drivers, and there is nothing APB-
> > > specific in it. If another DMA controller (e.g. GPC on Tegra234) is
> > > available instead of the APB one, the serial peripheral will be just as
> > > fast.
> > 
> > OK. But this is not the case for Tegra234? Or is it and it uses DMA for
> > UART?
> 
> Yes, that is the case, Tegra234 has just a different DMA controller
> (TEGRA186_GPC_DMA), which is used by the UART driver as long as the
> relevant device tree node properties are in place.

Okay, with this it means that some generic statement like

           This driver may use the DMA when available to achieve
           higher baudrate and better performance.

is too generic to be added. That said, I agree that you dropped
the original one completely.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko


