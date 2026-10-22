Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677629;
	b=ehj57rBYjncdNIXrgf/eurSwgFDIEUcOyUsdauFJPyoklJERUkzSkcwXXeuJK9y65s0C
	 rPwsI3uA9l60xCIImKCNeB223LDQ/cpyPMRb4Gxj/qOhYei4QKhPDGpI52Mpd7Jqf0be9
	 VVB9OTvfC2xyENBTwWyt96z4mS+KFUT5yKPEy7nmnZiUo0+7XB6Lw0W/V/oYFI0hwVu20
	 HBhc6/pFXu7PyRzz4M+fiWBXmgTGYy/5jquQgtd8SCt8SRmf7/qaTwyg+P4TgF+JEdgfO
	 pITrZiSS7YrgMWscDWfCUj6CGWF9z644ex6dOFFUT1Kd2wofRO0sMMDyvKOcVcHiHCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677629;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VcKX1i1Y/b+vKX5dsNU3fQuC2xICdi7zLkeShlVUpoY=;
	b=3SGJkbPHCFxzYJqGkwUJgRIs9o+xIFxLhHFfoqiWiUl76+bhJ2eoi+hxNTEUJbUNCJjp
	 3FEEybChoaZewrenCyxIOALtJc+OzJm/9O9BK6+O+gl47KLjrSlpSkd9vCx3cydorSLCO
	 /A+ccy6GgwYQ5Lah/IIGmxrvGlJrazENdh5a+VRzwTUkatglfmFYfDLC8JSECc8jBup86
	 qGCY64QRNRwDeH5vYBxxLOshKhMoLE0SUXw/VQfETaUuB2Kz0F4uufZURrtmpdXORMSgY
	 Q+btwPQAXt24jl02RzuWSN1w27zda+daXagRN7ZIB6ymtlNhhTz5qqzCitt6YA+eUtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="LBXF7Mn/";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457CB606A31A;
	Thu, 22 Oct 2026 14:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 457CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LBXF7Mn/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792677628; x=1824213628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TEq2jJ1l0b+qgPo8nG9MmyuMLvPG9vpgXkrCzSyHa0E=;
  b=LBXF7Mn/Ugivq/UurykQ/sxduY+Bul43nABMSZvjm/to1qOVOqByZ2BD
   2pZ+8tg/CiaKTYjHrl/KcocZoFA75/P9T5RX2PaydT3IlhdY6wjbnqBmo
   NepD1eK1kQTG7JjXkm8sSGrILBEEpsvg8Q/T76HDWYyeMmljzRPMaf4A4
   R+2R6SrEg5dYu2R7CfMWuSSMYz71MqN9BbBH6CcULHVlZlLEGctTmnmGe
   WPIpee8nF4qn4X0Ie6EkAJhrjbxWWT4DDllpL2x0w4iLwLwZDGIrtcZI5
   b2/L9Y3O6VKRfRpVEneO7Jbbyt7fURfpfqnj10eAkA6axvsWYB6YsEI8j
   w==;
X-CSE-ConnectionGUID: SHuDQLQBSWOCj2arzim+/A==
X-CSE-MsgGUID: UAVGDnXZRJuzKcgAUoiFfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1305924"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1305924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 07:00:28 -0700
X-CSE-ConnectionGUID: vOBU5w8ZTUqRopPIPV0P1w==
X-CSE-MsgGUID: p+3eJT3+S3ex9FIRgVKwrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3776511"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 07:00:25 -0700
Date: Thu, 22 Oct 2026 17:00:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250: drain canceled TX DMA before reusing
 its buffer
Message-ID: <atoW90cG8hz-h9tc@ashevche-desk.local>
References: <20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com>
 <20261021-submit-serial-8250-dma-cancel-v1-v1-1-efe2b89f2303@gmail.com>
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
In-Reply-To: <20261021-submit-serial-8250-dma-cancel-v1-v1-1-efe2b89f2303@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 04:37:43PM -0600, James Hilliard wrote:
> uart_flush_buffer() resets the transmit kfifo before calling the driver's
> flush callback. serial8250_tx_dma_flush() terminates DMA asynchronously and
> clears tx_running, allowing a new write to replace tx_size before the old
> completion callback has finished. That callback can then consume bytes
> from the new transmission. The serial core can also overwrite the old
> DMA source as soon as it reuses the reset kfifo.
> 
> Give DMA a private transmit buffer, keeping the kfifo offsets used by
> FIFO-window providers. Copy only the queued ranges before handing the
> buffer to the device. Flushing the kfifo can then no longer change an
> in-flight transfer's source.
> 
> Keep tx_running set while a worker synchronizes a successfully terminated
> channel. Suppress callbacks and new submissions during that interval.
> The DesignWare idle helpers must not pause or resume a retiring channel.
> Once synchronization finishes, process the zero-length completion under
> the port lock and start any data queued after the flush. Reuse the normal
> completion processing for OMAP too, including its delayed register
> restore and runtime-PM handling. Drain the worker before releasing DMA
> resources on shutdown.
> 
> Calculate the queued length before calling the platform preparation hook,
> so it sees the length of the transfer being prepared rather than the
> previous transfer's length.
> 
> If termination fails, leave the buffer owned by the transfer and let its
> normal completion release it. Do not submit another transfer before that
> completion. A DMA completion still does not mean that the UART transmitter
> is empty; the existing line-status checks remain in place.
> 
> The race was found by inspecting cancellation and restart while preparing
> H616 UART DMA support.

...

> +static void __dma_tx_complete(void *param)
> +{
> +	struct uart_8250_port *p = param;
> +	struct uart_8250_dma *dma = p->dma;
> +
> +	guard(uart_port_lock_irqsave)(&p->port);

Add a blank line after guard()() everywhere, otherwise it's harder to see it
in the code.

> +	if (!dma->shutting_down && !dma->tx_terminating)
> +		serial8250_tx_dma_complete(p);
>  }

...

> +static void serial8250_tx_dma_flush_work(struct work_struct *work)
> +{
> +	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma,
> +					       tx_flush_work);

Make it a single line.

> +	struct uart_8250_port *p = dma->port;
> +
> +	/* Neither the channel nor its buffer may be reused before this returns. */
> +	dmaengine_synchronize(dma->txchan);
> +
> +	guard(uart_port_lock_irqsave)(&p->port);
> +	dma->tx_terminating = false;
> +	if (!dma->shutting_down)
> +		dma->tx_complete(p);
> +}
> +
> +void serial8250_tx_dma_prepare_buffer(struct uart_8250_port *p,
> +				    struct scatterlist *sgl, unsigned int nents)
> +{
> +	struct uart_8250_dma *dma = p->dma;
> +	struct scatterlist *sg;
> +	unsigned int i;
> +
> +	/* Preserve ring offsets for DMA engines which implement a FIFO window. */
> +	for_each_sg(sgl, sg, nents, i) {
> +		size_t offset = sg_dma_address(sg) - dma->tx_addr;
> +
> +		memcpy(dma->tx_buf + offset,
> +		       p->port.state->port.xmit_buf + offset, sg_dma_len(sg));
> +	}
> +	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
> +				   UART_XMIT_SIZE, DMA_TO_DEVICE);
> +}

This is a bounce buffer, why do we need it? Shouldn't this be rather the
respective DMAengine issue on how to treat the pieces?

...

Overall I have a feeling that we turned somewhere in a wrong direction.
This all activity on 8250 DMA support looks like over engineered approach.

Perhaps we need to reconsider the whole picture?

-- 
With Best Regards,
Andy Shevchenko


