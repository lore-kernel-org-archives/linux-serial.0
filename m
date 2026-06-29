Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815A3EF67B;
	Mon, 29 Jun 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745000; cv=none; b=IWb8AF4uP/9x3uhPv2ndCoJjkE8vVNEhasmTt9TLFiwXLutWEBQ4LgwQ8xz5rDxLYcQksnI+yDDz1V2Sk1VGoD3GDl2mnv3KaC0tc/hxf3jLdL7G/xjpFJ4uBumUC7KkEBGoQ5zvBCiXFVgJrg++OXNU3plRJAcp/GqLKu+iFco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745000; c=relaxed/simple;
	bh=DhvShMfkDmzhr54JwFXiy08k/7PFXGfy8mHmxHdzRQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6HfqrH3RzCLd5Iy0BYwTpEZAXONK6bSmJ7b6Kmwbgq7ezc6MPzKQa/RBarBLS5UxYysSIKZWU6J5rpLOV24lTOUGjhPXTssymBG0RWfMegh2E860EpyB8sm4HUzHaUImCMAzliApZQ2fyupgtpkVh4Ivjt0rUfWJmKMf6ClbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OF4slGCo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OF4slGCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782744999; x=1814280999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DhvShMfkDmzhr54JwFXiy08k/7PFXGfy8mHmxHdzRQg=;
  b=OF4slGCokVill0POLRYYpGPArkNezv5KPhIRecLMTvBb0Y+XX3dOryrY
   6b5yH+R+uTQ06K7zKp+HZw9xivH2/1EZjtUJ5nwaDzVtQpEt9KbqeB8ay
   OCkc2r6PrKt9rXywSh1QY5s++ky5dLkHiHhiWNx7m3Pajpt9yAkLPN00+
   9f0Ta7dkuq/AWZyAC2k0pdy6jkGtSE87haq7qFrsJDzsW2/04CyWRj73L
   qALKfgvYmgGp99n2W/ylixeE1MOxbF1BjAhIUAhjTD/A6ZdFjzJbUgCqH
   izS8M+GoRgZilujBLKSIg7nnd4V27flYj2YX59d8ONnr1PYxeDGn/7WpK
   g==;
X-CSE-ConnectionGUID: FHboFNTcSEC/zrRLmNZX+w==
X-CSE-MsgGUID: ZaEnx2a2RzyoA3q+cZqPvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="100870406"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="100870406"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:56:39 -0700
X-CSE-ConnectionGUID: PUPo7NY0SxOnNRseC1Nuag==
X-CSE-MsgGUID: swAMMlsoSvGDyJr6IjR/bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="275208649"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:56:36 -0700
Date: Mon, 29 Jun 2026 17:56:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, geshijian@picoheart.com,
	yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
Message-ID: <akKHoQOr2Vq9CA1Z@ashevche-desk.local>
References: <20260629075510.32854-1-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629075510.32854-1-yang.yicong@picoheart.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 03:55:10PM +0800, Yicong Yang wrote:
> The DW uart could get into the cases where a bogus RX timeout
> interrupt is asserted but no available data. This could be
> workaround by doing a bogus read.
> 
> Currently the driver's using the standard RBR (receive buffer
> register) for this bogus read. However the reading of RBR
> in this case is allowed to raise a hardware error if vendor
> choose to implement in this way (our platform). It's also
> allowed to do the bogus read using SRBR (shadow RBR) for
> workaround which won't raise the hardware error. So change
> to use the SRBR to workaround the issue if it's available.

...

>  /* Offsets for the DesignWare specific registers */
> +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */

Is this a name per DesignWare databook for UART? I mean that _0 part.

-- 
With Best Regards,
Andy Shevchenko


