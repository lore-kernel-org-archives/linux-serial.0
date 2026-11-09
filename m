Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265624;
	b=rGmqvqI/OvA9pPSScHFw/PXSsNjojLCqwiEP37UJxmCrAhfHDSMRMYfSkI11dsIPpr0z
	 z1XeQiTbsTq9Vs2P5JGwyoH8zRmPtyT8pogQNpEoOGeEWfGvYlzeUsgpKDsau0NOmEH/4
	 8GTrKQR3DGruz6WxCBDmG0ypG/elJusDsNm+YGu861sCZ2FQKBEqsTgqHm/whKgG9Gp76
	 jtwVxXBXfE7179wLNFS411ktqbRRRAAHVxXgCmKktIWz169K9dbt+qDbz85p6rbIQ7/lY
	 DOVFIm0WPMXNqD1xR7bYvbyJAyUvFX5C/frxLBu9pi/cEyXLUoSq/3Vo0MtU5yJ1N2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265624;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cce/9RXAeZ7GCno3/183y+2YRTDy6KkvbogDyDUbNIA=;
	b=bosLGSnYeQwQS9HO7js1b+lynNAc3HiP81Vj9LH+qbhhtkEXkoOcwtqLkb5HNd77BnJw
	 5U9ovRLOPObCpauXlOdibQBRrh8mcAgg1pX63jT03RHsADyvfOtMWgwgA9fasSHnfq5yz
	 2T1deiCwf5lfohFjjoCrUPemn+8efE7ER5uy0yGSvowq88YCt7ZXg6VO58+oZDI+/BryZ
	 EBfniBy7yhHhh3nLgL66/KGkYftsMcs5S9sjYQhLxuSxWsE07t/Y3ZWIjl18xQ/0xhZ9q
	 TQ0wVqaOLqh+5SVmMWqw+j9oh6IiIHw1GSKRKd9+cFdZu9b+gOff4SFIfNIr1IJLJyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Q/llW0h2";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D4606A321;
	Mon,  9 Nov 2026 23:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA7D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q/llW0h2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794265623; x=1825801623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7pmup5JwHroklabp2D5twn2dbPMnGh/ztW33CBS2YQw=;
  b=Q/llW0h2hdc+2u+rt77U2KyqPtvEz9EX9nmwtMthTtQUBQTBVZmaTElU
   hECzRTHKHKOkgAEOwfMPQ41TIQ96wjJGrfzeTrq1rCMYQaJHTS299hqPS
   KH+/u2BfIKYD51IsMhZ7bq5ydDWAPQXJnYQcW/hpmbAULm4cxXUsdHc9V
   odPZSdvefu6bvenoIruqkslKqMSdTOhicSgArk3TouDAXRpLAWvSNlH5a
   am6o/yJ3dopaVexuobtX+eYVZ5KVXXQP2jBPscPa3OF6BRT7CpRvhlPxy
   YWvkh2weX1eAX/6UqkPIYByoqIhrf7JXqMyIaZ1wA0lR0slcaOwQEknWP
   A==;
X-CSE-ConnectionGUID: SSC4ZHgKQRSi+dStAsGEAQ==
X-CSE-MsgGUID: ORion4UzSaCPfYUZYABvpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2998119"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2998119"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:07:02 -0800
X-CSE-ConnectionGUID: YE0vm8kqRGqbaS24Yp0OKw==
X-CSE-MsgGUID: +wxkWmm0Q3CUyhw4YfOevQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8424973"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:06:59 -0800
Date: Tue, 10 Nov 2026 01:06:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v8 01/11] serial: 8250_dw: allow port setup to report
 errors
Message-ID: <avJSEbiZx7cU3ONt@ashevche-desk.local>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-1-14024d2b184b@gmail.com>
 <avJRsij5P7Ch3tqE@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avJRsij5P7Ch3tqE@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 01:05:28AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 05, 2026 at 01:52:02PM -0700, James Hilliard wrote:
> > Return a status from dw8250_setup_port() and propagate failures through
> > the DW and LPSS probe paths before registering the UART. Use the existing
> > LPSS cleanup path to release board resources and IRQ vectors on failure.
> > 
> > Keep the current setup behavior by returning zero on both successful
> > paths. This separates error propagation from the configuration validation
> > that will use it.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> after addressing below piece.

...

> > -	if (!data->skip_autocfg)
> > -		dw8250_setup_port(p);
> > +	if (!data->skip_autocfg) {
> > +		err = dw8250_setup_port(p);
> > +		if (err)
> > +			return err;
> > +	}
> 
> No, don't change it here, the return value will be simply ignored until the
> change that will make use of it.

Alternatively to minimize the churn do it like

	if (!data->skip_autocfg)
		err = dw8250_setup_port(p);
	if (err)
		return err;

-- 
With Best Regards,
Andy Shevchenko


