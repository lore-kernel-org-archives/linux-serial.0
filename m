Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ACE47209E;
	Tue,  1 Sep 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253279; cv=none; b=aA6je1l9yVmTPjlXwEbmQsHfDJKkwtR6wv+AfI9DjBmSIz0pBpK6P3RmBMSe5CqJJHOzJX6DVYHFDrG3ZSRLzIRFUZgd8JU/+dJgPLLK+9cfeiRZEFlm1lYlYlJecFYgMmk6ZOHt+GQov2DXNVHrGLKwhYrw5Z8hPmmDTqpqjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253279; c=relaxed/simple;
	bh=p+FDewXjFe78Ly5QcGDBrCz+2l8bAumvoYRf7BESYLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkKpJ68dcDKuzIIGct5f5mWB/upQC+hrWFGvj8KGpNez84PBb39HI3LAFXG9JUerHcPfNJU3xF1KrfBiJPHNmKfpnqMGk7cmQ9mT5RA6r0wt6ke9tYzwu7ov0mIRNzy2Vms0bF7EiGF4pUIEVCS6QMlc28xc36T6qVf0Wo1Poj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkEq0NyV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkEq0NyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788253278; x=1819789278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p+FDewXjFe78Ly5QcGDBrCz+2l8bAumvoYRf7BESYLc=;
  b=WkEq0NyVmz+VnMUx7TG9NXDRFU/m01j0nrSEnYYl9EoMgEH//+/pJpY/
   M1i2uM54LY0+bgsQc2CTwZTXrjD3SzWK5pu2PjiTj3l+SdPHE11QLGmig
   6G3QovzYmDfVtLDwZ9Dgb/wutNFRcUKIs+fmHvZ/FFN/C9r0HB7fjoupA
   CRoBbz3/XnuCTQWgiuaILZnHnclW8kq3RnFtmwmkKWaFIS+124xXWG6lV
   9IrfQF/0CpzfVBNOkDHCBGFFcAI2XUCkc5sSO5CdikYwMJu/A/55v1JRY
   xLaepAziMbFb4eKBRhWET4wzeBPF4uGvJrYV/7Y7w5K5yvdO/zY3j0UOE
   A==;
X-CSE-ConnectionGUID: V2Bz8utwRpKVlTc+EwawHg==
X-CSE-MsgGUID: rO1nv5fRTxOP7/JU9n/U3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92543115"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92543115"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:01:17 -0700
X-CSE-ConnectionGUID: gbAMKujNTH29Kn1dxqDthw==
X-CSE-MsgGUID: vwjdUyWsRZyuHt6Et5VUjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="265320216"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:01:14 -0700
Date: Tue, 1 Sep 2026 12:01:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] serial: 8250_mxpcie: probe and console fixes
Message-ID: <apaUVwHNK39wjfF5@ashevche-desk.local>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901041519.114737-1-lilinmao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 01, 2026 at 12:15:16PM +0800, Linmao Li wrote:
> Three fixes for the Moxa PCIe serial driver, found by reading the code
> that was split out of 8250_pci.c and extended during the 7.3 merge
> window.  That code is in mainline now but has not been in a released
> kernel, so the series is against tty-linus.
> 
> Patch 1 fixes a NULL pointer dereference during probe: the serial core
> calls ->rs485_config() from within serial8250_register_8250_port(),
> before pci_set_drvdata() has published the board.  It takes a board
> without RS232 support and SER_RS485_ENABLED still set once
> uart_get_rs485_mode() has run - on Crescent's ACPI machine the firmware
> node clears that flag, which is why it does not crash there.
> 
> Patch 2 makes removal unregister only the ports that were registered.
> v1 failed the probe instead; as Andy pointed out that is a behavioural
> change, and keeping the ports that do work is what pciserial_init_ports()
> in 8250_pci.c does, so v2 keeps it and restores only the missing count.
> 
> Patch 3 stops set_termios() from dereferencing port->state->port.tty,
> which is NULL when the serial core sets the line up for a console or for
> kgdboc.
> 
> I have no Moxa board here.  Crescent Hsieh tested patch 3 with kgdboc on
> a CP-168EL-A, and looked for patch 1's crash on a CP-134EL-A; the rest is
> compile-tested only, W=1 allmodconfig build of drivers/tty/serial/8250/
> and checkpatch --strict, both clean.

LGTM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


