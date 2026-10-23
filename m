Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744224;
	b=2i4jQQA0TF06q6F2T8DFwqHn65VSxOQ3XJD85bIf+sQ8r9IR+GR/Ac/VW/77RUvLXOjK
	 NFqlvjTEAdZLJ/1NzrziGrhFYyHS+a5U7bzujeRIKb0J+xIq4gi+PLvFRlzlHD1mrbj2C
	 qo/nag1i/E6CX3diYUm1VkN5deQDJQ+Y0cKNes2issHcvvZSlm2es4NGU7JXfLgQ1btyu
	 z+HJc6XPl8dqcJt+I1npncnpUyiU7ihoy5uCDxJgXwmZIeCvyI0Z69lWrq9YwglAikPyg
	 KtQkV6H1pwdhnrFhfclrMkF2vJL0O7t/hjCboPe7THRf/nXCpHF1ZfxCb9t9a/+md+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744224;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=z5IPgDqf7jUjjODA6c6LE1gEhhziE2w3Mn5N3wHqzSg=;
	b=LOO1+oy83zNnu7Ac5Hy2pn2F6YLay9bBuu97/GZwo2CQ+Dh9utkhzAAg5Gatx9xgyTF5
	 qlu+axixBrov5r9LgCIx9/ZYWB0joN1Q6bVmr4dfzKy6MS0o2ETW4bv+W8xeG8ZK0fRte
	 eMSzhVXx2wqCs8BRjtkndo0Eq8Nlb8TpImAdbHZGo+GAaePFjgrTZhaFgELxgeFLKFT4G
	 lTf3+R8+GEgKXD+0mJteN4Sv6/Udghx9aVCT2RUOVkubYaMcviv/1FMUYVx/UnBD/iytK
	 eUTWXqew7PsQbn/oa5YxbhlIKCXwyyW62zpyQuxt4tIPVlHmVMSsIPtxVE1VvxdMkQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EI9fFaQJ;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D8606A321;
	Fri, 23 Oct 2026 08:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 174D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EI9fFaQJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792744224; x=1824280224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GVuHiTfC997jKZJNm5aUJ9dMWAWuuozkGSFX9KoaFgI=;
  b=EI9fFaQJHBrxeRufx2WKPRmHrveGdKMRD2W76Mnq/TkjJ/yyoA52swnn
   96csJHGaRWp3jPp0sieVvcfG3osgwIvoMJ06X4KxQRzemjL1zHx/CK0aM
   fyMWWprtAWRUOvOBUb5N+tGv0nxORh6uHBUJSTT0drWmDUzWBA14M6dV2
   O0YzmJSMWt5Reodn24uLd4UbCZZgx7SlWJQw1SO599O1LB6BLj+BCT1xZ
   ZXJyJHrqyxGt7d/JtlwFw5DpEXFSQTtBuxwCPcw1wyRrMC7LVPnUvOTZa
   3ATMFEpr1hzj3Kgk8S47hqIzxcRVfZ532miZdNk3n731tbXB1e/dQcGpd
   w==;
X-CSE-ConnectionGUID: SvdEMz8OTuiWb7GInoe/pw==
X-CSE-MsgGUID: fZUEmXyjR9uc0aUOMntuvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1491785"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1491785"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:30:23 -0700
X-CSE-ConnectionGUID: TLjUhQJ8SHWhx4WJx/pIZw==
X-CSE-MsgGUID: Rx+u4oceTV+XIiFKmYdqTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3650407"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 01:30:21 -0700
Date: Fri, 23 Oct 2026 11:30:18 +0300
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
Subject: Re: [PATCH v2 4/4] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Message-ID: <atsbGvUUeDYHT_md@ashevche-desk.local>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
 <20261022-submit-serial-8250-dma-cancel-v1-v2-4-088ea51e3891@gmail.com>
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
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-4-088ea51e3891@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 06:34:05PM -0600, James Hilliard wrote:
> The RX timeout path pauses a transfer, copies its data and terminates it
> asynchronously. Clearing rx_running at that point lets another receive
> reuse the buffer and cookie while the old callback is still waiting for
> the port lock. Inspecting the new cookie cannot distinguish that callback
> from the completion of a new transfer.
> 
> Reserve the receive buffer until a worker has drained the canceled
> callbacks. Deliver the paused data before allowing the interrupt handler
> to drain the FIFO through PIO. Normal retirement only releases ownership;
> leave subsequent receive handling to the UART interrupt instead of reading
> LSR and restarting DMA from the worker.
> 
> Reject new flush work during shutdown, including late Intel MID DMA
> timeouts. Serialize those timeout callers with the port lock. Stop and
> drain retirement work before freeing the channels and buffer.
> 
> Check pause failures before accessing the buffer. A successful pause is
> the quiescence guarantee, even when a provider still reports IN_PROGRESS.
> On pause, status or termination failure, mask receive interrupts and let
> the worker stop DMA before handing the FIFO to PIO. Preserve stop_rx() and
> shutdown while restoring deferred interrupts, and hold a runtime PM
> reference around worker register accesses. Keep RX on PIO until reopen.
> 
> Abort the DesignWare idle sequence when RX cannot be stopped. Preserve its
> empty-FIFO timeout workaround during PIO recovery. If the provider still
> cannot terminate the channel in process context, retain its buffer and
> leave receive interrupts masked.

...

> struct uart_8250_dma {

>  	bool			shutting_down;
>  	bool			tx_terminating;
>  	bool			tx_flushed;
> +	bool			rx_terminating;
> +	bool			rx_err;

If they are protected by the same lock, we may actually move to bitfields.
Example:

	unsigned int		rx_err:1;

> +	/* Receive interrupt enables deferred during RX DMA recovery. */
> +	u8			rx_ier;
>  };

...

>  static void dma_rx_complete(void *param)
>  {
>  	struct uart_8250_port *p = param;
>  	struct uart_8250_dma *dma = p->dma;
> +	struct dma_tx_state state;
> +	enum dma_status status;
>  	unsigned long flags;
>  
>  	uart_port_lock_irqsave(&p->port, &flags);
> -	if (dma->shutting_down)
> +	if (dma->shutting_down || dma->rx_terminating)
>  		goto out;

Again repeating the same idiom you have in previous patch.

> -	if (dma->rx_running)
> -		__dma_rx_complete(p);
> +	if (dma->rx_running) {
> +		status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +		if (status == DMA_ERROR) {
> +			serial8250_rx_dma_recover(p);
> +			goto out;
> +		}
> +		if (status != DMA_COMPLETE)
> +			goto out;
> +		serial8250_rx_dma_copy(p, &state);
> +		dma->rx_running = 0;
> +	}
>  
>  	/*
> -	 * Cannot be combined with the previous check because __dma_rx_complete()
> -	 * changes dma->rx_running.
> +	 * The completed transfer no longer owns the receive buffer.
>  	 */
> -	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
> +	if (!dma->rx_running && (p->ier & UART_IER_RDI) &&
> +	    (serial_lsr_in(p) & UART_LSR_DR))

This has a side-effect. Earlier we do read LSR_DR, but now only if _RDI is set.
Would it be problematic?

>  		p->dma->rx_dma(p);
>  out:
>  	uart_port_unlock_irqrestore(&p->port, flags);
>  }

...

> +	dma->rx_terminating = false;
> +	dma->rx_running = 0;
> +	if (dma->shutting_down)
> +		return;

> +	if (dma->rx_err) {

Perhaps

	if (!dma->rx_err)
		return;

?

> +		/* PIO may now drain the FIFO; stop_rx() can cancel these enables. */
> +		p->ier |= dma->rx_ier;
> +		dma->rx_ier = 0;
> +		serial_port_out(&p->port, UART_IER, p->ier);
> +		dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
> +	}
> +}

...

> +	/* Some providers still report IN_PROGRESS after a successful pause. */

Yeah, we need to address that. (I used to have some patches locally,
but they were rebased uncountable number of times without looking at
the result of those rebases, so it's probably rotten enough and may
not be used anymore.)

...

> -	 * This problem has only been observed so far when not in DMA mode
> -	 * so we limit the workaround only to non-DMA mode.
> +	 * Only read the FIFO when DMA no longer owns it, including PIO fallback
> +	 * after a DMA error.

> -	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) && !up->dma && rx_timeout) {
> +	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) &&
> +	    (!up->dma || !up->dma->rx_running) && rx_timeout) {
>  		status = serial_lsr_in(up);

This is a good question. We need to have this be tested on the affected
platforms.

...

>  	guard(serial8250_rpm)(up);
>  
> +	if (up->dma)
> +		up->dma->rx_ier = 0;

Now we have a copy of IER in UART port and in DMA structure. Why do we need
both?

>  	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
>  	serial_port_out(port, UART_IER, up->ier);

-- 
With Best Regards,
Andy Shevchenko


