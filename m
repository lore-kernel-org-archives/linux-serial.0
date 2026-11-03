Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725611;
	b=FSyw4Rbbjo9g92IL1pz1iBsQmP0bKB/m8swyxaXZjh/xDGx9FLESVpduILCs+csq5Xas
	 wY5i4bX2BMNLdxIczptrOrg+1j6RK5MpS3gVqkccuNw/Ug4wPda9J+9/NllkxevPCv4C4
	 sDql4LFncGFxh5v4ndrfLZLEXZP3mYlk1oFwJ7rEELjbLa0uTUSYUTtJHzGfibUC8a4f1
	 Ze3YTo46czEfQdDFXzOV3BvEFcK+E3GnRi1r+oaRe2ZprMDKXMeY3xsnbF+1Rwdx48g0z
	 yDEvfWEl7BbsTIV7LsTf5yP7eJwM3hP9coCTJ7l1aURKJMnbjZPXS+kq5Iz9ka4Tpww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725611;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=LnJRPskf8tuWyC8euiLr2zfBkW5TahKoa5RK+g4sahI=;
	b=vEOujfoPgwwh65pctjUaSAhUdzQrASd7tXTDD4WBGhbxM2FNviHG88T71bCTAOP9ETJs
	 tL5/rIt38GNfQu8jnWwMdqpwUlI1yTAUiuOyR94PcEOWgiEYTaypw3pzzGNdL2ifhJGfg
	 i+Kem9LvM25rWVbcvz4qQnAZnNOKRQzF7a5485EZ69U3Pb/gq6Jk2UDXo6QNvEDQz8++k
	 781D2A5LTBalcW1+pGe/uxUTOhONvQ/KKJxLxSOx6wyymlPcr9onAP7AT622jznOGe+8V
	 HBfDRHNAJsmLMcdKnl5WMqie2kdsyNue+Oq0g2zg9dq3YZ6YvAwh76u5lbC56YAUgkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jkqS6a3D;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF442606A324;
	Tue,  3 Nov 2026 17:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF442606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jkqS6a3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793725611; x=1825261611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/Ods/jKC1tVnIO8altZ+B3XsQ3TaPxecZLysqqf6EE=;
  b=jkqS6a3Dgsoq3H7AIroOF/KOnpEEalq77/OQ71ouNjcU8NqOVUMosO2H
   mbxD9IFMtREpCd721sDkhQxr96ed0Y0IMrHJfe3oNsRtEbldzY6RdXSxG
   frQgk0ifywBRrvWGcgCeTIMAAI8HCAHywWhrHuKugnXR2c1Rb2Pg//dmP
   7JwUoCMdgsz11bhBqSPUSinDeeFi6m62frGFLov64CifswcUmX95Au+vu
   vK7CxcP8fr5acCVIkY+xf6mNMtn1PRxO/gj8sMtd6CJfK/CY/p8Z6n+mH
   LN9D3IoKeXTDRbzO8w7D0dcl2U3JY+sFVnLNWwboBp/vgVq0cBTUp8Gut
   Q==;
X-CSE-ConnectionGUID: 4lBJ9DWERXaDg/jnEv2AOA==
X-CSE-MsgGUID: Kk3V0KaAR5GSgLmT3iCa4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2339829"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2339829"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:06:39 -0800
X-CSE-ConnectionGUID: iT3AJUmwR0ufFtQwiH5x+A==
X-CSE-MsgGUID: xQuXNDHgRLmpSPA7hG/IKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6490320"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:06:32 -0800
Date: Tue, 3 Nov 2026 19:06:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 2/8] serial: serialize asynchronous write wakeups with
 the port lock
Message-ID: <auoUlkzXsl9WJG8B@ashevche-desk.local>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com>
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
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 04:14:29PM -0700, James Hilliard wrote:
> uart_write_wakeup() expects the UART port lock to be held. Several worker,
> DMA completion and interrupt paths call it without that lock, including
> indirect calls from uart_handle_cts_change() and the transmit helpers.
> 
> Take the port lock around these notifications or their transmit helper.
> Keep sleeping SPI and regmap accesses outside the locked region, and keep
> the FSL LPUART completion lock held through its wakeup. Acquire the port
> lock after releasing private channel locks to preserve the ordering used
> by UART callbacks. In the MUX timer, publish available FIFO space under
> the port lock and keep the hardware FIFO-drain wait outside it.
> 
> Use plain port locking in hard-IRQ handlers and in helpers whose callers
> already mask interrupts. Atmel status handling is also called during
> resume, where lock_suspended is acquired with interrupts disabled; JSM
> interrupt processing holds its IRQ-saving board lock. Keep IRQ-saving
> locking in workers, tasklets and other mixed-context paths.
> 
> Take the port lock after requesting the ST ASC interrupt and hold it
> through startup's transmit servicing and RX interrupt enable. The transmit
> helper can notify writers even when the FIFO is empty, and serial core
> calls startup without holding the port spinlock.
> 
> Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
> path, since their interrupt handlers now acquire the same port lock.
> Preserve the caller's interrupt state when releasing those locks.
> 
> On SB1250, lock modem-state updates after reading and filtering the change
> status, and wake modem-status waiters after unlocking. Take the TX lock
> inside its service routine so RX-only interrupts need no acquisition.
> Keep that lock across x_char handling, FIFO consumption and the decision
> to mask TX interrupts: a writer must not enqueue data and enable TX between
> the empty-FIFO check and the interrupt-mask write. Each TX invocation sends
> at most one character.
> 
> Serialize CLPS711x TX servicing and its interrupt-enable state with the
> port lock. Disable TX interrupts without waiting in stop_tx(), since a
> threaded handler may need that same lock. Have an already queued handler
> leave stopped output untouched, and drain it outside the lock during
> shutdown before the transmit FIFO can be released.
> 
> SCCNXP handles interrupts under a controller lock which its UART callbacks
> acquire with the port lock already held. Collect the ports needing wakeups
> in an unsigned long bitmap while servicing the controller, then release
> that lock before visiting the set bits, taking each port lock and
> rechecking the wakeup threshold. Removal drains the IRQ or timer before
> unregistering the ports.
> 
> This serializes write notifications with port-locked serial-core state
> changes, allowing readiness and transmit-storage reservations to gate the
> notification without a check-versus-shutdown race.
> 
> Cover DZ TX servicing and JSM Classic modem notifications as well. On
> DECstation ZS, acquire the port lock before the SCC lock and notify writers
> after releasing the SCC lock. Defer normal TX restart after console output
> to a worker, since console output can already run under the port lock.
> Check transmitter readiness before consuming another character and drain
> the restart worker during shutdown and removal. Release Lantiq's hardware
> lock through the transmit helper's completion hook before notifying the
> line discipline.

...

> +++ b/drivers/tty/serial/sccnxp.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/find.h>

Try to understand what AI is trying to achieve and why it compiles.
The above is wrong.

>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/console.h>

...

> +static unsigned long sccnxp_handle_events(struct sccnxp_port *s)
>  {

> -	int i;
> +	unsigned int i;

This change seems unrelated to the patch. Again, slow down and READ what AI
produces before sending, please!

>  	u8 isr;

-- 
With Best Regards,
Andy Shevchenko


