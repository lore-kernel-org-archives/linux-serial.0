Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726493;
	b=XJHpHohnBf2D7w1SOrxgx4joc5zZdefWt3lFvOgLD+xIta2LaqcB819qXmy5ZlQ/vRba
	 gD75HYAm/H+SsGp81XQQniNFAmQVMi7NRog0gIYOKh3Uqvas+iAItGTQeoooWoBx3PNtf
	 PZvo1CICw9bySH2MYzmJ/O2zr94A6qX2y22Ib+IW0GLqLiICgiz5QEdNgQwbutLTJMudv
	 Y2hv82e5lqAnmCcrKE0T8lGEr2csHazZRyKYRtJUGAZ+He2hTUg6+mD1fzm7cye00sBrK
	 s3jLf0GG2IbkSS/VqgmruR80gYy113aJzQpanXe+VzfddQQ2j4otj2z0BzUv0f0RkSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726493;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jybwex6KEtiVVB5Q7MO/0FLbDCSae5cKl7r/Ekti9JU=;
	b=ItRFqB9OokJBN159ND1OiujwL0DsU784bfoEB9A+L4M1Xeoll1I6wEO2yePAaIkJ19Sy
	 lM3cNBgTw047TKXjMe0VdzCg/56yAXjH4GU4Cavj5x9T0GGkO2Okc/R+0Ln1E3yPlcDVk
	 pATVKn+mmZn6HjhzseQPKz3Cpn9eesrwCb//YB4jt9GXY/6gU5fCMSmhG5JHvASQF+/I7
	 WEszvtqmNH73sqENF/rZP9HnwIOlZ0VEe8b6/KibdSGG25tHuza7t6AvAjzkiCV80ExNJ
	 CcjxJeu3m2AupF4ZJ03MCYgzEuk5V76nkoiKDXYmrBD84I/OVPl18byXDjo+hNXn2zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A5b+VxCN;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8C606A324;
	Tue,  3 Nov 2026 17:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C8C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A5b+VxCN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793726493; x=1825262493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MsQh6jwB+YXfuoggHvsVrFxpE0KnVT/xHsMAp3keNjk=;
  b=A5b+VxCNZfb8XmH14blCsT7Jt5U5Q3Ch19jMODI3W+KRhRdu7/JLNzTX
   /+wLjzKTf1NVqRWlOTEfL4UnpfsLB856vl+kzPHCOn+l/19lhELVsmvrZ
   jVYzCjfuk2si7OfpNkYKPGUzVDMIq7bSqMYO74fBZNamZ0NW6vZFcEvsJ
   67P0HwVI+7ZtgNEb5KxUn8RMfYfdSrwC1FUQKfUZo0S5ROjlPzNf2bjvn
   oT9dQSaCYy492FgmAmtdNDxybz/45Py+NzMItoS2seAtlM0nrxXBO1/Ut
   tCvxPSffgtvTF7W2raZWiO2CB0o/wJizTX+O5MHOyZD5hqXYAAsxRuB15
   g==;
X-CSE-ConnectionGUID: +F0gMht4T+OtaEG0/BQBVg==
X-CSE-MsgGUID: bVqB476nSCemaMP8UEuhkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2369591"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2369591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:21:32 -0800
X-CSE-ConnectionGUID: 04u2Hyb+SN6wX57K1GcXbQ==
X-CSE-MsgGUID: mdIQ21nhR56Tg3Q1sMOFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6331418"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:21:25 -0800
Date: Tue, 3 Nov 2026 19:21:22 +0200
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
Subject: Re: [PATCH v9 6/8] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Message-ID: <auoYEjduLH9GlAFp@ashevche-desk.local>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
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
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 04:14:33PM -0700, James Hilliard wrote:
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

> -	if (!dma->tx_running)
> +	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
>  		return;

> -	if (!dma->tx_running)
> +	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
>  		return;

...

>  	guard(uart_port_lock_irqsave)(&p->port);
>  
> -	if (dma->shutting_down)
> +	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
>  		return;

Try to make these checks consistent. It's always better to choose the order and
be aware of the potential side-effects of the bit-wise operations.

...

> -	if (dma->shutting_down || dma->tx_running)
> +	if (serial8250_tx_dma_blocked(dma) || dma->tx_running)
>  		return 0;
>  	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {

-- 
With Best Regards,
Andy Shevchenko


