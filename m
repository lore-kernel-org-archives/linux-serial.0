Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE5238C16;
	Wed, 19 Aug 2026 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146291; cv=none; b=auSwcNAWQIDRAOqchtyiAjRdhb+6gwbYFJgmUMj8huoAQJQjtPYrb6gXcGLt4jiIY6XDc68khP2HwETxnZil93y/PlT/+VU0Gno94JThnjs8unqXjkN3yVS3q/gb76s9LENX1O59vVjzkyLVWuMqc82xvvpt2Y0r4X27VsUS1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146291; c=relaxed/simple;
	bh=ScIo51A7f2HXeIZo6CGeC47BIH+wKvrRsYyH1GMktqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK5+ADzukzex6EzzxYmacGFAuzA5d6LAvC9lGO4pN8og/ssffPE057Ghad1oGMLV/JvFZLlw7XEOQzVC0yiuGZ3vSp+BoXDuxzJsDaJm1UIhD4BJEFk18/V1/ZnMOM6Knxm5YXKK6E3o8ioJewP9eaULSSdKouxR/U28Lxas3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWr90j2d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWr90j2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787146286; x=1818682286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ScIo51A7f2HXeIZo6CGeC47BIH+wKvrRsYyH1GMktqY=;
  b=hWr90j2dtWFSi3DjyXOe08H1Ks6R2gbTtIkoNXSkRH7AaWEK20ywJpxZ
   h8N1Y0aIiMZy3GZosBmA2+MwKxW6lnduW+TzHHREDTsTp8xHkwnX5DrcH
   ZtA71TwrQBC0Qt6YC+C1mUSrypQaI+FvCd0+sC38RKQ+MRtSUT27ltMH9
   npS81yQfw5q5N6rBBA+WBTBwHTIsPUzstfDj8CpcKhtIsWwkSQC/Erfm0
   AaNpqQqW1BWCEiVgHiC3+/54B0dPiqcE/ukRYtjH1uPCCVwr9CQ7lQn1J
   wKY74tFjBiRwHuUdjv0MKyDJZ01pisKpBKflvgZk+jrWd+UXASmzs4733
   g==;
X-CSE-ConnectionGUID: sAx5/77vTeKWWWTZWafN5w==
X-CSE-MsgGUID: PQ4zLgCAQ0eZTZfRB9nBrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105043061"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105043061"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:31:23 -0700
X-CSE-ConnectionGUID: YTcs6fY+RbeUOhR2ZZ1Vpg==
X-CSE-MsgGUID: oNOnPIogTJ+b1gvad6Z13w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="290359901"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:31:21 -0700
Date: Wed, 19 Aug 2026 16:31:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_mxpcie: set the driver data before
 registering ports
Message-ID: <aoWwJxrCOPOWtggG@ashevche-desk.local>
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
 <20260818093918.3190686-2-lilinmao@kylinos.cn>
 <aoVyV8x0HgCrCGv2@moxa-KabyLake-H>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoVyV8x0HgCrCGv2@moxa-KabyLake-H>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 05:07:35PM +0800, Crescent Hsieh wrote:
> On Tue, Aug 18, 2026 at 05:39:16PM +0800, Linmao Li wrote:
> > mxpcie8250_rs485_config() looks the board up with dev_get_drvdata() on
> > the PCI device, but pci_set_drvdata() only runs after the registration
> > loop.  Where mxpcie8250_setup_port() presets rs485.flags to
> > SER_RS485_ENABLED, uart_configure_port() calls ->rs485_config() from
> > inside serial8250_register_8250_port(), and the callback dereferences a
> > NULL board pointer.
> > 
> > Publish the driver data before the first port is registered.

> Thanks for pointing this out.
> 
> I tried to reproduce the NULL pointer dereference with a CP-134EL-A on
> an ACPI x86 system, but the callback was not reached during port
> registration.
> 
> The driver initially sets the RS485 flags to 0x201
> (SER_RS485_ENABLED | SER_RS485_MODE_RS422) and directly programs the
> hardware interface for RS422. However, uart_get_rs485_mode() finds an
> ACPI firmware node and changes the flags to 0x202 because the node does
> not provide the linux,rs485-enabled-at-boot-time property.

Either real ACPI node modifications or in lieu of fault injection we should not
rely on the property being absent.

> uart_configure_port() subsequently calls uart_rs485_config(), but the
> latter returns without calling mxpcie8250_rs485_config() because
> SER_RS485_ENABLED is no longer set. Therefore, the NULL driver-data
> pointer is not dereferenced on this system.
> 
> This also leaves the software state inconsistent with the hardware
> after initialization. The hardware is configured for RS422, while
> TIOCGRS485 reports SER_RS485_MODE_RS422 without SER_RS485_ENABLED.
> 
> I also reviewed commit 6974711cf770 ("serial: Keep rs485 settings for
> devices without firmware node") and its review discussion [1]. That
> change preserves driver-provided defaults when no firmware node exists.
> In this case, however, the PCI device has a generic ACPI firmware node
> without any RS485 properties.
> 
> The driver-data ordering change still looks correct to me because
> SER_RS485_ENABLED is preserved on systems without a firmware node,
> allowing mxpcie8250_rs485_config() to be called during port
> registration. The case where an ACPI firmware node exists but provides
> no RS485 properties appears to be a separate issue that also needs to
> be addressed.
> 
> [1]
> https://lore.kernel.org/all/20251023151229.11774-2-gerhard@engleder-embedded.com/

-- 
With Best Regards,
Andy Shevchenko


