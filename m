Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1542419306;
	Mon, 29 Jun 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749281; cv=none; b=IOiAuawnxVgeXv95likZ76NtTLrw2hDGnQW8HeHTD2+/4BSXmcGiP02rQNbUiuRJYzL4EOBcWlSnO542bmSdIFTn8wiUes08I7aAdrJkbEN4FnLR3+XMnwxdYxJH2CdNCHxNsU+DTFwVA3pb9i+fFAQhjn+fmVXsmJQnkdRfLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749281; c=relaxed/simple;
	bh=vmfSCuYC0OhrvB+YgUsSp8wRKRFL1cmboKIEDMZC70M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4L5e24q4IZo7GAHRFUe2Txd37B8BMZXxXLZdiarAvg0KClAnrbLvAMAnfXKyG4iQQIeo6YIIwf/s4RceVX0bV+K8I1F/eQdWoi6tAG6dLMn1hENxN99DCwmDodU81T8YbWGZtascusbLDox4u2WGs0OP7kM8aX+SSIv1RMjLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhDWTghI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhDWTghI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782749280; x=1814285280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vmfSCuYC0OhrvB+YgUsSp8wRKRFL1cmboKIEDMZC70M=;
  b=JhDWTghIfa/fES96fhED86iXFMtyLlZpy3WzPZ79+yAUP2HTaLrM5ajq
   igM1L9AAtiltCmXhRWZCg6HVnSgn2Ngfoj0M6H9r4VXIzOR4ou0kHJ4fI
   FbUFn2wGjwkAI9uxQ2k5qnYj8cBWakrJtw4f4WM0DpxFAv3s2Y/N5BGAR
   eX+a09/1teFvsp5tjK8AwmUIV+k4q41HgMK+V2K5MN4xSamhK4P7LtmHO
   Fbt2khFG+I/auBk9idccBCZ2ZDjRVACuukzrAPsAIGOWA7gFhEx5u0tgx
   WESEk4c7xV6oguQ09uHRZZltoWX41BrQCnrRMyn9Pte8mAuXbzvfg2l1p
   A==;
X-CSE-ConnectionGUID: 6Bbilxp6TQWfWQjY+uSkTw==
X-CSE-MsgGUID: CzaFNHoURfSLVjm1CjB2nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94938509"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94938509"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:08:00 -0700
X-CSE-ConnectionGUID: WGFevGV1SS+Qgti/D90Vdw==
X-CSE-MsgGUID: 88d8lOobSNqwfpY/K439DQ==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:07:56 -0700
Date: Mon, 29 Jun 2026 19:07:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Yicong Yang <yang.yicong@picoheart.com>,
	linux-serial <linux-serial@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, geshijian@picoheart.com,
	yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
Message-ID: <akKYWjZPHdlgybY8@ashevche-desk.local>
References: <20260629075510.32854-1-yang.yicong@picoheart.com>
 <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 06:56:28PM +0300, Ilpo Järvinen wrote:
> On Mon, 29 Jun 2026, Yicong Yang wrote:

...

> > +			if (d->data.shadow_support)
> > +				serial_port_in(p, DW_UART_SRBR_0);
> > +			else
> > +				serial_port_in(p, UART_RX);
> 
> How about:
> 			serial_port_in(p, d->data.shadow_support ? DW_UART_SRBR_0
> 								 : UART_RX);

I was thinking of even just having the value of the register offset somewhere
in dw8250_data and call this unconditionally.

			serial_port_in(p, d->srbr);

Of course this has to be carefully initialised in time with UART_RX.

...

> >  /* Offsets for the DesignWare specific registers */
> > +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
> >  #define DW_UART_USR	0x1f /* UART Status Register */
> 
> It seems USR and now SRBR_0 are without regshift whereas the reset of 
> the register defines are with it.
> 
> Somewhat unrelated to this patch, I really hate this 
> dw8250_readl/writel_ext() mess even more now... Why are those needed 
> anyway, should the .serial_in/out callbacks handle those byte-order, etc. 
> variations just fine?

Aren't there is a possibility to have the register stride for the first ones as
1 for backward compatibility with 16550, while providing the features like CPR
and UCV that needs a 32-bit accessors? IIRC that was the reason for _ext() IO.

> Are those _ext calls only required for some early things during probe?
> I guess 8250_lpss hasn't setup the callbacks yet before calling 
> dw8250_setup_port() (I'm not even sure where it gets set with it after 
> looking for it for a few minutes)?


-- 
With Best Regards,
Andy Shevchenko


