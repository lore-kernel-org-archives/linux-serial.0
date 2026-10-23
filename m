Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741903;
	b=p5onX9gscLd7q6931X823kYqUyFJHH9h1atuGmgDEFry5NlIdOUKKKVFSr7LSWZBczRC
	 Twd3VbNuoywna9wPyrrQZBh5anH9p3iL6oOr7MMxvWlVtMQmsJXpJ3VpQ0EF4RUlbHlRS
	 JjL9rNtSoOqbDWWzAOUeC1hUCZbR8G9MP7wVei+jIn9EK5MpBC8Meq7wi/5rrp5uxJDlo
	 wGxh9GYIMo4DbYJNww7WitRXmGfKm35zqL7nA6J2eQPjHnMLZbCPPo7+55OsXIthhho72
	 2igO3Jn6foyfYcdsWbpec8kXRaBq5m+pPGM6kTVFivtuMv2wIHd64JGsqhgAchrWK6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741903;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VPlI+rlOltoyWLU5NhmPLkDnt8hnrwN6mhJpa/kC7YA=;
	b=dpMtjgsnA0Ra1IB1wUhgwH4+dmD+Fum0hr3znWpI86KoRb5IYCb+00gfv4GQuf++hUwm
	 uXUl/nh2+DFZOxQMC6JuhndWAuBbe7Ml2GUVYLJQUbMhgneWjFCFitKlB9bd3DQX/dYas
	 EYA93DkieqMRmMM5d3II+P3rOEqe6n7p05U4GsvUTbNlOYO8i3wE+mX2Nkxf4Yxp8QffF
	 0g2lZx9hT7oKhqonn2M3s9h+9ry7/+gOpSKfKkymxhlcxB/zdJtdcKr2lU68+8mPd6y5n
	 XhLjyJvgC+x2A7IEMDmEmT8U4XKl5MOxw2106QxlYZUjXqZOELV2VVWHV/oovrHNnqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ELk//9fJ";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE242606A31A;
	Fri, 23 Oct 2026 07:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE242606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ELk//9fJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792741903; x=1824277903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hfu0WxfrC2It6Yrnsq2zHlRa0i4MuU1jso5o8QDV2W0=;
  b=ELk//9fJgX1lufYhde3MzEsrqlafzQStjYNrgS9I+DULfASG16qCeMhG
   CrNS4Kdrlc4Yrdj265WfyWxUPeS+3ywKZO6HN9FGFTq8kF6fn1fxmNQ+M
   0bTVaLWw7sHStqiiKaLewf2cyTm8qx4hvmj+gcV5E9cazxTjJ0OF9k12s
   PGyKqY37eOygGcsW4xTPoj1sSyCLAuEwquofOMJartBVrVX1H3NIq4vT7
   ljfBbotR3LTa+42H5K8/tvMGKQvYqRhzgIGfuqTONhI9Ea9WT+vKl6wEv
   5ufsaR3XlSXi7xDk5L5vBGdr2reuHpnQuWhhsDyXi5b8BzJtCvzYAEkKL
   w==;
X-CSE-ConnectionGUID: EkpoSr5tQcOBERDWWQkeeA==
X-CSE-MsgGUID: 2bBFMZ+kRJ6GrD1mUuH9eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1374778"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1374778"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:51:42 -0700
X-CSE-ConnectionGUID: gFVyw168Q9ytMLPy4tP+7g==
X-CSE-MsgGUID: +mQ/kRaqSaa/Wdwr7tNpaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3615853"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:51:41 -0700
Date: Fri, 23 Oct 2026 10:51:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/4] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Message-ID: <atsSCUDfd4Pk--Ou@ashevche-desk.local>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
 <20261022-submit-serial-8250-dma-cancel-v1-v2-3-088ea51e3891@gmail.com>
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
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-3-088ea51e3891@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 06:34:04PM -0600, James Hilliard wrote:
> uart_flush_buffer() resets the transmit kfifo before calling the driver.
> serial8250_tx_dma_flush() terminates DMA asynchronously and clears
> tx_running, allowing a new write to replace tx_size while the old callback
> is still waiting for the port lock. That callback can then consume bytes
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
> releasing the channels. Shutdown releases the reservation after stopping
> DMA and unmapping its source.
> 
> Track a flushed FIFO separately from the transfer length. If termination
> fails, retain the reservation until normal completion and account the
> completed bytes without advancing the reset FIFO. After successful
> cancellation, process a zero-length completion once callbacks have drained.
> 
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.

...

> -	if (!dma->tx_running)
> +	if (!dma->tx_running || dma->tx_terminating || dma->shutting_down)
>  		return;

...

> +	if (!dma->shutting_down && !dma->tx_terminating)
> +		serial8250_tx_dma_complete(p);

...

> +static void serial8250_tx_dma_flush_work(struct work_struct *work)
> +{
> +	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, tx_flush_work);
> +	struct uart_8250_port *p = dma->port;
> +
> +	/* Neither the channel nor its buffer may be reused before this returns. */
> +	dmaengine_synchronize(dma->txchan);
> +
> +	guard(serial8250_rpm)(p);
> +
> +	guard(uart_port_lock_irqsave)(&p->port);
> +
> +	dma->tx_terminating = false;
> +	dma->tx_size = 0;
> +	if (!dma->shutting_down)

If you write this as

	if (!dma->tx_terminating && !dma->shutting_down)

> +		dma->tx_complete(p);
>  }

...

>  	if (dma->shutting_down)
>  		return 0;
> +	if (dma->tx_terminating)
> +		return 0;

And this

	if (dma->tx_terminating || dma->shutting_down)
		return 0;

...

> -	if (!dma->tx_running)
> +	if (!dma->tx_running || dma->tx_terminating || dma->shutting_down)
>  		return;
>  
>  	/*
>  	 * kfifo_reset() has been called by the serial core, avoid
> -	 * advancing and underflowing in __dma_tx_complete().
> +	 * advancing the reset FIFO when the old transfer completes.
>  	 */

...

> +	dma_sync_single_for_cpu(tx_dev, dma->tx_addr,
> +				UART_XMIT_SIZE, DMA_TO_DEVICE);

Make it a single line.

...

> +free_rx:
> +	dma_free_coherent(rx_dev, dma->rx_size,
> +			  dma->rx_buf, dma->rx_addr);

Ditto.

...

>  	int skip_byte = -1;
>  	int ret;
>  
> -	if (dma->shutting_down || dma->tx_running)
> +	if (dma->shutting_down || dma->tx_terminating || dma->tx_running)
>  		return 0;

>  	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {

So you will have a couple of patterns for the combinations of the flags.
With some static helpers you may optimise that. Also in some cases you even
might consider checking tx_running while it's known it's true (or false)
to reduce amount of variations of the combinations of the flags.

-- 
With Best Regards,
Andy Shevchenko


