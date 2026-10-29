Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283581;
	b=EkN/y8VhDAvz2P8XsvnBHt9PwcNL/edpiG5C291new94ylLrIVZXDav6T5o2CuEGDnav
	 DalMTmA1vDxYNQZaI0CerohKB2QD7pvdpSphSB01tEg/1ihiW+IoYbyaX8E0HS+9Pyqcd
	 JtrS+Xf0ICKvRPTITV46AMZcsT1JpLWooTSOf0TjL7rCm8L/bq8BIk7LrN9wo0NQRYx4x
	 i9Av8viTBBVehwDCfUP4iE/xRbFath0KSuIhPEXgjRAh7ieHMvh26c4j+id7o4EBbAXvf
	 jgJJS6zvzSqFAskuhmwnRWGKUrgYKHRvnJGk3ZNpIL2e/iwY3PMQfnDmF10CrmW8Weg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283581;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0t7g2WC+b9FztvwqiERlUGDT4mF51ROculYuxl9U52o=;
	b=ItLlua0BsikiFOBfkvyevtfNxV8sgTgihV7ObMdeYiE7qnXKGhYbeOovIvKvcTBBAgek
	 8axla55XhugpwDf2UyHpGQZTttQ3guQGa1LUZM/gXlDqKulOepumP8V+rSMBXNAmAKpLr
	 cgxM/38iEFBK8Fstn93cceL0m9YDwClK4+cCt2pElNswXDRz0v4u1zXseLUPvtfbKvNTX
	 3IwfcCcev7jecpSKi6QfMqMTgYzdBGn39fCk1i53LpGvgRoMWVpQfsZT4XZc0CST1Hdb9
	 vJ0l69fMxbqqgUUSErKJLUcqFTR39cY1ssg3PaWg3rBEWrWlbaeXZYi0rI4Pi3HKNMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kWuSS1ku;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44B606B6D4;
	Thu, 29 Oct 2026 14:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF44B606B6D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kWuSS1ku
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793283581; x=1824819581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ks0QnF665NpX8S1B9/P4xaJFMSaRvnc+QpU5Vun1o38=;
  b=kWuSS1kubnfkY9keyowEejRMZp5Xl7hrho2WizUJVGAo/eLJG2MhZzNl
   WTSOP0Hvr9IZAGfe+9xuro8bViWJa3e7jHL9Nu6dInb2G7YkFoYhVD2h+
   K8meJ+9EFEtGart3v66jV6Qk/IHvH8ZzLAP8KxCXvTIFGpFWEYS7oTRKI
   Vn6OOoT6rNFffcOZk+8V7XdJXz6I3DwzCLVYkKM5NrTdeqEZc1E/w4wzw
   1mOsomD7bKbILKSxC06NI/5Og1EALiH2bRjcIn4YFDWVd1LUboydnZuaQ
   EIp8oi8JEZrRNzg1Bz0TWOWW9cDJN1xvAsWg9QwQ/vlEl/RbwxWaAG5Iv
   A==;
X-CSE-ConnectionGUID: bIrVknu2QpOthFcc4CCSmA==
X-CSE-MsgGUID: Ko4ptfLdS7GgKSp+2kZaKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1934262"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1934262"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:19:34 -0700
X-CSE-ConnectionGUID: QyJOQ8qDTY+boqh3NJr+/A==
X-CSE-MsgGUID: 7B3JJIPERS6eyiaI7RVCSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5119312"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:19:28 -0700
Date: Thu, 29 Oct 2026 16:19:25 +0200
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
	Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 4/6] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Message-ID: <auNV7Vco5O3vVwRH@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com>
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
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 01:37:00AM -0600, James Hilliard wrote:
> uart_flush_buffer() resets the transmit kfifo before calling the driver.
> serial8250_tx_dma_flush() terminates DMA asynchronously and clears
> tx_running, allowing a new write to replace tx_size while a detached
> callback has not yet run. That callback can then consume bytes
> from the new transmission. Reusing the reset kfifo can also overwrite the
> source of a transfer that has not stopped yet.
> 
> Reserve the flushed FIFO storage through serial core before returning
> from the flush callback. Keep tx_running set until a worker synchronizes
> the terminated channel, suppressing old callbacks and new submissions
> during that interval. Return the mapping to CPU ownership before releasing
> the reservation and waking writers. Normal transfers continue to use the
> FIFO directly.
> 
> Reuse the locked completion processing after retirement, including OMAP
> delayed register restoration and transmitter-empty handling. Take a runtime
> PM reference around worker UART accesses and drain the worker before
> releasing the channels. Shutdown releases the FIFO reservation after
> stopping DMA and unmapping its source. Serial core keeps writes and wakeups
> gated until startup or resume makes the port ready again.
> 
> Track a flushed FIFO separately from the transfer length. If termination
> fails, retain the reservation until normal completion and account the
> completed bytes without advancing the reset FIFO. After successful
> cancellation, process a zero-length completion once callbacks have drained.
> 
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.
> 
> Retain the tx_running check in both completion callbacks. Releasing the
> reservation relies on the DMA provider draining detached callbacks when
> dmaengine_synchronize() returns; provider callback-lifetime fixes supply
> that guarantee for controllers which previously lacked it.

...

> -	bool			shutting_down;
> +	bool			shutting_down:1;
> +	bool			tx_terminating:1;
> +	bool			tx_flushed:1;

What is the meaning of bool XXX:1? Have you checked with `pahole` the result?

-- 
With Best Regards,
Andy Shevchenko


