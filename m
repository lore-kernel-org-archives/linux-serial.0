Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417C3932D9;
	Thu, 10 Sep 2026 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032443; cv=none; b=DNOh2iJDGJYBfjgdh0wtcIfLepxTi1bAfLSXiBY0Fb/ucB1kO6Drr68Fe9X/nRSq2Ks3TUl0+khwXVb7IIsPzE9oJnB7NmxoDfubU+oWaRJHqjG0GfNaKA3E8KsHSloJtIxDGGlpWTa207q6M0syK9bu2Hvwv9fAnh1RuxaL1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032443; c=relaxed/simple;
	bh=g9Cp6K2YW/0ojAZM+PERC3yWY2MaFiW9F9EZGEa+wq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTMWPMTH6Y8G+fFzW6dotLdIuH47SXKRmCv/GEEmv0GBui4LCFmCmwnHQU0Mgi6kYMZl179tygq5HmO3D1yUpmYkMS7j0hiKOGVehwrjR6Aw09FQGwZkYobLT2rvqRDfwDNe8fHQr3luL7vvlJVOTJzqPDH1MW+QEN084+bHsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/DwY5Iy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/DwY5Iy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789032440; x=1820568440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g9Cp6K2YW/0ojAZM+PERC3yWY2MaFiW9F9EZGEa+wq0=;
  b=X/DwY5Iy/2j8ziFdaKHzSaOBDjDyRNy5y/du+QcwaU+d5m3VIZtMoDsN
   KW6Y7iKgtxh7Wbmv8Em90AjRjYLD76CmY9Z9eZkfjPscQQkUdAwXjsn8I
   ykCLbPDjaInIiSdTVchRfTzqVtQ1NbAJkDcDBcpWPuLXY6LuCicgYJVMd
   RV37g5QOAd6UYPB4bu9SihR3IbNnmQ91zhUboobw3gSUW6Lr+9hFF6D5C
   C3RMkJ+dHNPEiG8YGvoF3Y37ptXSdiE0R5VhRbo2aKTDEhsZT+FVe0axd
   0zz/FrXwBaCF241u7EqzW1ovEzTCwYbQW1jj+6eKXQIfCBBwNZ+dLzCg0
   g==;
X-CSE-ConnectionGUID: gAFrPp3VSOuuHGmX2LlD+Q==
X-CSE-MsgGUID: yrUUlg1CTnin5KczD3M1lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100068155"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="100068155"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:27:09 -0700
X-CSE-ConnectionGUID: 9Lk46I8cT22DEwuQeaU5Rw==
X-CSE-MsgGUID: YmZZHAgjTGqItji2nmnofw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="273537486"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:27:04 -0700
Date: Thu, 10 Sep 2026 12:27:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: zl020895 <zl020895@163.com>
Cc: longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75 quirks
Message-ID: <aqJ35vMBiBZo2iUE@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
 <aqJrSnr0rwv4BOJ3@ashevche-desk.local>
 <122573f8.8232.1a08a9765fc.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122573f8.8232.1a08a9765fc.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 05:12:52PM +0800, zl020895 wrote:

> > Wondering if we should undo this in the port's .shutdown() callback.
> I saw the shutdown path already covers it: dw8250_shutdown() calls
> serial8250_do_shutdown(), which does
> 	up->ier = 0;
> 	serial_port_out(port, UART_IER, 0);
> so both the IER shadow and hardware IER are cleared, including ETOI.

Depending on the answer to Ilpo the enabling may need an updated comment
summarising the above.

> At 2026-09-10 16:33:14, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com> wrote:
> >On Fri, Sep 04, 2026 at 02:38:18PM +0800, Long Zhao via B4 Relay wrote:

...

> >> +	/*
> >> +	 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
> >> +	 * timeout behaviour. Force them into the 8250 IER shadow so later
> >> +	 * generic IER updates do not clear them.
> >> +	 */
> >
> >Wondering if we should undo this in the port's .shutdown() callback.

-- 
With Best Regards,
Andy Shevchenko


