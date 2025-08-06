Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDE2206B8;
	Wed,  6 Aug 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512907; cv=none; b=Co4Cv8Ws29FkftHt6f2tuC9OoUrrSeBD4nfbdc/vfq0Ea00TDptOCO8kSJ/XxS8uVvsQ/EZeSyRepmMce8bPweChb1H5HLGoqMApicSgffjJzIVBrgnlA6VKNpzDgg8fW+z19H7tuoFzSzrsvlLKRmnAfocIuz2g0crxke8Swxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512907; c=relaxed/simple;
	bh=woXL7shEadn3VCLr9vjOEHMl/1UF9gCkrZxtWYGliSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrMs6ui95ShfERckmORV/Kf9f/O495GJesJJG/YxfZ7BNafQ36kloqc2BvvkLq6wU1T1Np9tpixKpuXVicP90XnbO/sCt8HTYCowIcEZjor7Cde2rf0WKCbSIgK81b/WuuxlLPYJiZTtYcyKuT1kP4JZJPg7J6Y7fA7wBIjj7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REIToI6q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REIToI6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512904; x=1786048904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=woXL7shEadn3VCLr9vjOEHMl/1UF9gCkrZxtWYGliSk=;
  b=REIToI6qiCVntluIviFxO7WU6cDIru5ZnEjBP7DE+JOgb4P07+8QwY1Q
   W12wD+CznGYYzcvjQfgXD/RzJe0/sBtzEhxXjLnbyG3MKO5zOYuPam0bd
   V7kdNfwjkHrp4ZTmVp378XY3U9jD+tQeaR51VgZqGjBndWlq5mTfK+ptT
   xESX+bQhif7om5nGPDHHcM7YvN2U7EyKWMz2+pulmRyR+LqbTSmoWQGtg
   hpyp3LPDPnL2LoXPFOgn7p2YDQ/K/PkbBXKPGPFD+COuzWq2DbKU7y2eD
   KMcS1j2WVVww5jsBtd6lcvLbmPIgvTvq/lPWNJHUMnRcG232CZXskx698
   A==;
X-CSE-ConnectionGUID: yI/lpD5UQ3ap2P1eECaJkw==
X-CSE-MsgGUID: /JA7KjWTT+yVt/qVVGpNYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44434804"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="44434804"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:41:43 -0700
X-CSE-ConnectionGUID: YjINcB5zT62t2U5LuZHN0A==
X-CSE-MsgGUID: 6lnpmVTgRZaJHFDuGBOz6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="202034276"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:41:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujkx8-000000046uF-2sM3;
	Wed, 06 Aug 2025 23:41:38 +0300
Date: Wed, 6 Aug 2025 23:41:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	sunilvl@ventanamicro.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2 1/2] serial: 8250_platform: Reduce stack usage in
 serial8250_probe_acpi()
Message-ID: <aJO-ApXFIs27couW@smile.fi.intel.com>
References: <aJKDp1LBpzswp5lX@smile.fi.intel.com>
 <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
 <20250806201047.754240-2-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806201047.754240-2-abinashsinghlalotra@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 07, 2025 at 01:40:46AM +0530, Abinash Singh wrote:
> The function serial8250_probe_acpi() in 8250_platform.c triggered a
>     frame size warning:
> drivers/tty/serial/8250/8250_platform.c: In function ‘serial8250_probe_acpi’:
> drivers/tty/serial/8250/8250_platform.c:152:1: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This patch reduces the stack usage by dynamically allocating the
> `uart` structure using kzalloc(), rather than placing it on
> the stack. This eliminates the overflow warning and improves kernel
> robustness.

...

>  	struct resource *regs;
>  	int ret, line;
> +	struct uart_8250_port *uart __free(kfree) = kzalloc(sizeof(*uart), GFP_KERNEL);
> +
> +	if (!uart)
> +		return -ENOMEM;

For cleanup (__free() in particular) we allow to mix definitions with the code
and it would be natural to have it a bit different

	struct resource *regs;
	int ret, line;

	struct uart_8250_port *uart __free(kfree) = kzalloc(sizeof(*uart), GFP_KERNEL);
	if (!uart)
		return -ENOMEM;

(In your case just a blank line placement is one line above.)

-- 
With Best Regards,
Andy Shevchenko


