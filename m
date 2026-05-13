Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C3134CF;
	Wed, 13 May 2026 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704514; cv=none; b=MrR/k7sWk8+aHuhIRbHHQNp7xdXAL6IcgK5Ifr5SZ23kfcjepxFVe+VZYu5VdE+hC+CPUyJBRUNnF4KH2Tw8nF/CnSiOUUvwyG3G+qf4LL3XwOc6CQeq5rdVrAQIZplkqgV3ahLQv0P5vFvIGbL2/AqGgX96KMQF04yItLdt/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704514; c=relaxed/simple;
	bh=Zmv8bybZ+r2N7J20OQDPpM7WCmziWkp9fjuPEd8hWY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc4rCWQWgnCqGVzW4GIPLmXq6YfeoO79z9t7ZD4E6udCeohFinaS9GgC+jjuK/SxNBqUJ8zZXkeACgcUXvuThpOWMDDJp7HhlPmA4tYDFkwh9zQ9U0iWB/UiFfbUMacW1gaPuLjnJYechA6DTGNG7QhUtHZcL0BC6QqlhptMiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThV4aLcZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThV4aLcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778704513; x=1810240513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zmv8bybZ+r2N7J20OQDPpM7WCmziWkp9fjuPEd8hWY4=;
  b=ThV4aLcZ9u/7SkLIhoaZaS07JHQbttDfPPIJNyxjjA2yMQFEk4OJsvM6
   ThjAzSm5P3oBS6jDJJvbn4ETFbhcC3+YY6fjinVmCnnZjkXF4GyDSz9VM
   Sgn1SEtOIAIEZEHpMkBZhnpXMwjp8lnCG0HOCcJR7U7JWlSeJOVcWfmJk
   sOvHbWrj9UhxlETAenDwLvsNmmD0aYEsd0WCHAriLCqZXud4SCTuBz4Fd
   TE3nWhUs1DhMOvy0DGh60eTTH868TBqZ2kCTIIeBof1Psk7QT34ycTlL/
   pB2UyBQ2uGZds1KzTYBy/4qjA9oI8aBEk8gxLxVD+yOHQma0VCgcTrGNf
   A==;
X-CSE-ConnectionGUID: sCqW3T/KRiK6fTi1TycLfA==
X-CSE-MsgGUID: eIwi2TvrQl+NAyniTp4VqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83254952"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="83254952"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:34:59 -0700
X-CSE-ConnectionGUID: aZbJy1+GTF2KMPWIpT14ZA==
X-CSE-MsgGUID: ZCGqcfXFQ7OMtlRY24F1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="235122007"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:34:57 -0700
Date: Wed, 13 May 2026 23:34:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250-dw: unregister 8250 port if
 clk_notifier_register() fails
Message-ID: <agTgbk24MtHqgkHm@ashevche-desk.local>
References: <20260513150503.11037-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513150503.11037-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 08:05:03PM +0500, Stepan Ionichev wrote:
> dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
> and then, if the device has a clock, registers a clock notifier:
> 
> 	data->data.line = serial8250_register_8250_port(up);
> 	if (data->data.line < 0)
> 		return data->data.line;
> 	...
> 	if (data->clk) {
> 		err = clk_notifier_register(data->clk, &data->clk_notifier);
> 		if (err)
> 			return dev_err_probe(dev, err,
> 					     "Failed to set the clock notifier\n");
> 		...
> 	}
> 
> If clk_notifier_register() fails, probe returns the error but leaves
> the 8250 port registered. The matching serial8250_unregister_port()
> lives in dw8250_remove(), which is not called when probe fails, so
> the port slot in the serial8250 array stays occupied until the
> device is rebound or the system is rebooted. The devm-allocated
> driver data is freed while the port still references it (via the
> saved private_data and serial_in/serial_out callbacks), so any
> access to that port slot before a rebind would be a use-after-free.
> 
> Unregister the port on the clk_notifier_register() error path.

Maybe as a fix for backporting. For the current cycle can you remove that
notifier and all that crap that was brought by Baikal upstreaming which won't
ever be finished (as we actually dropped Baikal code in the kernel)?

Or maybe series of two: this one as backport and the other one as fix / remove
Baikal support entirely from this driver.

-- 
With Best Regards,
Andy Shevchenko


