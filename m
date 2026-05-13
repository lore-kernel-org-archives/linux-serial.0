Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB69360EED;
	Wed, 13 May 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704549; cv=none; b=FlYiNzzBnDNAzCGbrWuOo67Vk6Bg6pA4ughXZszVnqIOVcDgYKYA7HG6Athu6KsGwnC06zBBCzECaIUu3MRD1xWGm3jb3YJSw9KvrpTYekmgqQAi0klmXni7sCoMwEXok3klPpf3z2CSwQxgmKsdkRwY5xIHW/dvaf5JnsfnK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704549; c=relaxed/simple;
	bh=aLStSbcwX9KH50pcxt2wBDufCfKmzMqXYeRjp/3UI+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhYq7HJkHJDkwfMJgKY4Erc2XBQ6ubKDYfbxMIu6ARVVswbXZlLtwqlnaQS9W7xxsevnP0smapvnXtBHRhqgX0lbMmKlcYGncN94sOuD/ILaQ1FXwVuhXELhpkp7YHeLM4Q/+ST0Fth4cWOy5iYIGVA/9MTZIkz/gxLSCJzqybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmBXzU1w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmBXzU1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778704548; x=1810240548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aLStSbcwX9KH50pcxt2wBDufCfKmzMqXYeRjp/3UI+E=;
  b=LmBXzU1w1o6fbNnOpYvDvj0IJT15mxAixFcUT1KXw003vmkoU0oq0igH
   BWNOMI0pEzojxgCB9V1fBMyT26SpVgDLBCRd1glaxvtzzoulUnfIBrwrh
   3F3L0au+42Hdd1deC5fS0FFJQVJKchDIrz73NHqiGFPGPjVUFtkVPmi0O
   2C1CPWRjFthRL+3FCcyJqGbl8OCvfOVjjnqw0zF1mUQ/sFval0z5iL6Xa
   FtMyjDPO1/lmTmvkn0CxPQzhJVu0tuEQ/buws+MHQlXXF0BfmVYYCxfFF
   3F+zTQ2S8HZ2cbDWCUrYgdZdAyFCcI37j+nsWo6nQG9YOZlfrrYBiNMU2
   g==;
X-CSE-ConnectionGUID: Usxc5/9tRqKThviXO6VxWg==
X-CSE-MsgGUID: xYsSui2SRG2suBlmLRLJHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="102310837"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="102310837"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:35:47 -0700
X-CSE-ConnectionGUID: ce39DgGkR0i65IIm0u3Xvw==
X-CSE-MsgGUID: mHotHRbbQxuVKxdWenklMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="261938700"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:35:45 -0700
Date: Wed, 13 May 2026 23:35:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250-dw: unregister 8250 port if
 clk_notifier_register() fails
Message-ID: <agTgn0BXFAdSiOkf@ashevche-desk.local>
References: <20260513150503.11037-1-sozdayvek@gmail.com>
 <agTgbk24MtHqgkHm@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agTgbk24MtHqgkHm@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 11:34:58PM +0300, Andy Shevchenko wrote:
> On Wed, May 13, 2026 at 08:05:03PM +0500, Stepan Ionichev wrote:

Also note, the Subject prefix should be "serial: 8250_dw: ...".

> > dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
> > and then, if the device has a clock, registers a clock notifier:
> > 
> > 	data->data.line = serial8250_register_8250_port(up);
> > 	if (data->data.line < 0)
> > 		return data->data.line;
> > 	...
> > 	if (data->clk) {
> > 		err = clk_notifier_register(data->clk, &data->clk_notifier);
> > 		if (err)
> > 			return dev_err_probe(dev, err,
> > 					     "Failed to set the clock notifier\n");
> > 		...
> > 	}
> > 
> > If clk_notifier_register() fails, probe returns the error but leaves
> > the 8250 port registered. The matching serial8250_unregister_port()
> > lives in dw8250_remove(), which is not called when probe fails, so
> > the port slot in the serial8250 array stays occupied until the
> > device is rebound or the system is rebooted. The devm-allocated
> > driver data is freed while the port still references it (via the
> > saved private_data and serial_in/serial_out callbacks), so any
> > access to that port slot before a rebind would be a use-after-free.
> > 
> > Unregister the port on the clk_notifier_register() error path.
> 
> Maybe as a fix for backporting. For the current cycle can you remove that
> notifier and all that crap that was brought by Baikal upstreaming which won't
> ever be finished (as we actually dropped Baikal code in the kernel)?
> 
> Or maybe series of two: this one as backport and the other one as fix / remove
> Baikal support entirely from this driver.

-- 
With Best Regards,
Andy Shevchenko


