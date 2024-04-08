Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A01E532
	for <linux-serial@vger.kernel.org>; Mon,  8 Apr 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594935; cv=none; b=FSBw5ilzRsPfWBNf/8WXM83miZKXDo4EYlXS3ic7XwRa2FPmmEuv2b/6dyVHyKlR/1cVesS6WdVB/krKtXPhpKyZ18xt/Nq58DYwcf7Qy/lJv2n/ICFuIs4WsascXIFxIczx4RlK8CDCgrxwRdIIUG1i2HtyfLB1i5BJKWljUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594935; c=relaxed/simple;
	bh=ClLI2m70yIQ+4roF/mtCyyfdpAsJrZE6AIIbHndfPuc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mDacrrqHgVNpFI9jBHIKqbZx48t58fNYzis++AJHwDmVJammodsnBCxnTmKUDcNnhJRONsr04OwJRbzxO2QpzJBF/SAIcgE42PP0dab2aVjlktMCNybGOJz+ThVy0l2JyGw0ks/ay3DxeA0KSSnHASNuBrhCpIRRs9ev4zebuao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3VJ2XPZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3VJ2XPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594934; x=1744130934;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ClLI2m70yIQ+4roF/mtCyyfdpAsJrZE6AIIbHndfPuc=;
  b=M3VJ2XPZ74/4yHJgo7DYlAFVgVuiZBUomTiZEeyTCigUZbF+AMLap7g0
   JFbU77jsDlvxx026Fu8khuOeCXAZs9526rxNKIRLLSj1lX4pgRHtfTjcy
   RS4cIulevRXDgvfLu6nIjvJTpNdN4G7A2RzP4zP9nyB3jBTVn8wyLlKSg
   MzreZBWqYveTqa/QDV/a/I9b8c/CCMhkc2AS05aXoZS7yyHOgoSY5hwDi
   JJiFOxijWytdSye3DDm+wUhLN2ARrEvDutDQPaK1fR/KVdiOIih5ig44V
   Xa1IWsY+2g+CXaQwjg9lZO35unCcz9YFCEctRjUZm4fDIkRsE7YcQ5I9e
   w==;
X-CSE-ConnectionGUID: RhXLLvbsTGuUn/HHOmU7pQ==
X-CSE-MsgGUID: /RSNLOPdQD+CX/sRGq2dHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8009506"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8009506"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:48:53 -0700
X-CSE-ConnectionGUID: yopttGtbSpqBWVY23PHmIQ==
X-CSE-MsgGUID: J1f5g4WySuuSFH13eZBusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="50943031"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:48:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 19:48:46 +0300 (EEST)
To: Matthew Howell <matthew.howell@sealevel.com>
cc: "5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com" <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>, 
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
    "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
    Darren Beeson <darren.beeson@sealevel.com>, 
    Jeff Baldwin <jeff.baldwin@sealevel.com>, 
    Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
In-Reply-To: <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>
Message-ID: <74b591e8-c8b1-7a9b-e2ea-c375f3d712c2@linux.intel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>  <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com> <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Apr 2024, Matthew Howell wrote:

> On Wed, 2024-02-21 at 16:16 -0500, Matthew Howell wrote:
> > Allows the use of the EN485 hardware pin by preserving the value of
> > FCTR[5] in pci_xr17v35x_setup().
> > 
> > Per the XR17V35X datasheet, the EN485 hardware pin works by setting
> > FCTR[5] when the pin is active. pci_xr17v35x_setup() prevented the use
> > of EN485 because it overwrote the FCTR register.
> > 
> > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > ---
> > V1 -> V2
> > Fixed wordwrap in diff
> > 
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 23366f868..97711606f 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -596,6 +596,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> >  	unsigned int baud = 7812500;
> >  	u8 __iomem *p;
> >  	int ret;
> > +	u8 en485mask;
> >  
> >  	port->port.uartclk = baud * 16;
> >  	port->port.rs485_config = platform->rs485_config;
> > @@ -618,7 +619,8 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> >  	p = port->port.membase;
> >  
> >  	writeb(0x00, p + UART_EXAR_8XMODE);
> > -	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> > +	en485mask = readb(p + UART_EXAR_FCTR) & UART_FCTR_EXAR_485;
> > +	writeb(UART_FCTR_EXAR_TRGD | en485mask, p + UART_EXAR_FCTR);
> >  	writeb(128, p + UART_EXAR_TXTRG);
> >  	writeb(128, p + UART_EXAR_RXTRG);

Why you need to read rs485 state from the register? It should be available 
in ->rs485.flags & SER_RS485_ENABLED.

pci_fastcom335_setup() seems to have the same problem? Path small part 
seems to be common code anyway which should be moved into helper, only the 
trigger threshold seems to differ which can be given in a parameter.

-- 
 i.

> Just wanted to follow-up on this to see if anyone has had a time to
> review the above submission? Please let me know if there are any issues
> / anything I need to do.

