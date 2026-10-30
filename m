Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354895;
	b=aFXeeAkUReah1S/I5ng+MwbMtgKWaFxznVf2UCFC5uv59Z5b+i/+J1flWwAXSzoIsQ+l
	 stGTThH+IlWeekYX3WMwp5YJJiJ2I9baRBznNXJyY9kwgmNBWUA26OuOY+QOp0Xgf9kiw
	 uU2v+TaD5zWjgj4IhhfbKqN5d7Y2cSx78VsjMKB+ZXgtNR8NpC7Q5TU+aGhDk+Rh9/dJI
	 K4yjmAN5DpWFAUAbpgXbF/kYJROYVD89LDwLvSvG7u2qIsJiFCz5vESbrcjUGlUR+ifj6
	 2I25gCNlTfzNfNYS7aeV6ueqUlag+eTfSV3993aHc4WEnxqLz/PcKLm8xWLLSpp0nVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354895;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=C0/mwmzFbhrf2oh9K+Po1CByufDjKwjIEZTp3nBdSuk=;
	b=YKFl8FRINoXtWhLbwHdJl/lB7swynykPO3J2wYeGnpvHr+Egc7bu8UcLMI0vQjsFjEwt
	 6jha3fh70HlfqaxQe3QuCY133ZpmF0RlzjkeMqKbHATSbyZ+CARAgTfIztgPC/jTA/jSA
	 YpPnW8ynz6Icz3IZFg7dqQQs0Qk6vY1K3J2WFk3JQyNNVM9RUE0BDdBDqH+I5bzmCT2O5
	 rdBJ43Lx2wm09i6ipNniR7jlIAX0vEHonC0E38UfYWUTAoPEtOqsaI5FQBSkIKluzOUAp
	 lQmdzQiTFbt4aeuAyeTRjBEYCvk4KDIdHX0bBsatyLFD/G91Xwjc2s50idybRObiVdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FTt5mfpN;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468F606A31A;
	Fri, 30 Oct 2026 10:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5468F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FTt5mfpN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793354895; x=1824890895;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zOblnyUyv9NKvrPuHMLJ0x2zFEjfb1OCZnMziEeVx3Y=;
  b=FTt5mfpNahmYKtP54WqqmFsGzaBq5J/AGV82Gc5erynrV8cK3zhv11u7
   7buQcNSlLXgghfH22SaHQOvVaGyQ0BiBsjabF0vI6DrlLX5moUekOmz77
   GBRU1uAHz52PENMn4Pr4kcNs2ovI8BRN2xIhoiKnu+wvG3DvoAkH/gkDt
   401ppQ7VVi5zOelrqyDrFVD0PGT8TSIEKKi0IxZMZl9UtN8f0+YoE8/lZ
   ROIfgMoq5xk6IB7FDlU9gafm8DQbRjsnwMDjVkTMnibSylK9F1mwROL91
   iz9kZFtVTbvWHnQ9zVd7Wvb1T+JsEPQA02DDfc6ugM3l+/UyyQVBcFdNa
   Q==;
X-CSE-ConnectionGUID: ZcTf5pbcS8a4/w6tRBqsyg==
X-CSE-MsgGUID: xUb/PUENRrOQrD8YbX6s8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2217930"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2217930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 03:08:14 -0700
X-CSE-ConnectionGUID: AHNzZJnuTeKLjfxz5wU0HA==
X-CSE-MsgGUID: 9I/0TBI1QOi05253dVUlJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5737947"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 03:08:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 12:08:06 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: James Hilliard <james.hilliard1@gmail.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 4/5] serial: 8250_dw: configure the Allwinner H616
 UART
In-Reply-To: <auHW9nkDqZUXeHNZ@ashevche-desk.local>
Message-ID: <3e73ec0c-2623-d891-7146-dcf1c7a68c41@linux.intel.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com> <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com> <auHW9nkDqZUXeHNZ@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Oct 2026, Andy Shevchenko wrote:

> On Tue, Oct 27, 2026 at 05:05:32PM -0600, James Hilliard wrote:
> > H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> > component parameter register reads as zero. Generic 16550 probing leaves
> > the port using the 16-byte FIFO configuration and its trigger-level table.
> > 
> > Keep PORT_16550A and describe H616's fixed 256-byte FIFO depth in platform
> > data. Use common Allwinner setup helpers to configure the transmit load
> > and receive trigger table from that depth.
> > 
> > Derive the receive thresholds from the documented 1-byte, quarter-full,
> > half-full and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 128
> > and 254 bytes; the normal 16550A half-full FCR setting selects 128 bytes.
> > 
> > Build the threshold table during setup and use the shared 8250 conversion
> > helper to select the nearest lower threshold for sysfs writes.
> > 
> > Serialize trigger changes with termios and hold a runtime PM reference
> > while programming FCR, preserving the FIFO contents. Propagate runtime
> > resume errors before changing either the FCR shadow or the hardware.
> > 
> > Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
> > DesignWare termios path selects hardware CTS handling, so the capability
> > must be present for the corresponding hardware control to be enabled.
> > 
> > Select the fixed configuration through the platform setup callback.
> > H616 has debug-divisor and RS485 control registers at the offsets used to
> > detect DesignWare hardware RS485 and fractional-divisor support. Avoid
> > those probes and retain the BUSY-safe integer divisor hook and software
> > RS485 handling.
> > 
> > Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
> > termios changes. Its clock is a gate on the shared APB2 source, rather than
> > an independent baud-rate generator.
> 
> ...
> 
> > +	unsigned int fifo_size;
> 
> This is should come from DT (based on the property or compatible),
> 
> ...
> 
> >  	u8			no_int_count;
> > +	u8			rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
> 
> Why do you need it here? Can it be provided via driver_data?
> 
> ...
> 
> > +/* The trigger is the masked, unshifted FCR receive trigger field. */
> > +static unsigned int dw8250_sunxi_rxtrig_bytes(struct uart_port *p, unsigned int trigger)
> > +{
> > +	switch (trigger) {
> > +	case UART_FCR_TRIGGER_1:
> > +		return 1;
> > +	case UART_FCR_TRIGGER_4:
> > +		return p->fifosize / 4;
> > +	case UART_FCR_TRIGGER_8:
> > +		return p->fifosize / 2;
> > +	default:
> > +		return p->fifosize - 2;
> > +	}
> > +}
> 
> You don't need this, just provide a set of numbers directly.

That was my first thought as well, but James explained that he wanted to 
reuse this for HW different fifosize which makes sense.

And these formulas are given in DW spec so I suppose we could actually 
infer these for all DW UARTs, not just these ones being added now, using 
the same formulas. (A future work item.)

-- 
 i.

