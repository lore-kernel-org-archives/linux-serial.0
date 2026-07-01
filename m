Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5248BD48;
	Wed,  1 Jul 2026 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909391; cv=none; b=N91lL8YZ9ukpxMHhePO2K65LaQKCnwBlzJtwwn8WnLMyjougSnHqY5iJ7d9JjzSDRuVAx2vnP32fEjANZ6vwJFSsqic/mywgormOP8ISwfJKhEh9N+UlIcSfvrCO0ZSxKvkRp/wic0gtZWFz8xmh2IUFaUelOkMB4kYnJuc12S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909391; c=relaxed/simple;
	bh=3NDvhymVBUW6nmaLDvq3CbpmcjFb6r/Xz+8pPYIlLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zmtbig7A0PTCBLcQAJDEEKooqCgX7j0/5ofmTqNV4zfbwxkrImmeTMTALHWy6d2D5bgD6h9Fly7bd2amnAbaXBWBJQXiXiBL54uI14Qd/WfhfT/Gk3S/I5PJtkMlPZW9qzQ0xZ+G3u2KK6x9jdXDbvlSg4LsIComVrJ74aExLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW0yyrqH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW0yyrqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909390; x=1814445390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3NDvhymVBUW6nmaLDvq3CbpmcjFb6r/Xz+8pPYIlLT0=;
  b=PW0yyrqHLePQrWDHSekIHc6nnuPpdu9wvsPrUh17heVIhAVF1Kf727ob
   BOyhwhBU1Az5Fwl3Jp8k1Zuzbuuv16+WtIifDkE0yQ0td/kl74RLEO6iW
   mNeyN8XXU8VHNCPyh8OGziHjdP9j72Stxx1LhNHSrMdyI9vtYxeMdGuBI
   6YC284ngV9joSIbhD3gaszgRZDQdKazSZODKc1/+y5fY4CrDaJaYLtyxD
   YPcernS2wQ/WuYssfjIz01uwmD3ajE0dZyG6a49nEaftCdJiwj0CUcAL+
   4jN7z2jQ58uSCPlsp4vggdOaWrTQvFO1QQfio07NOg/qtOLdTC8+w5ZbC
   w==;
X-CSE-ConnectionGUID: E2E55kYVQaqpIovvgZqh+Q==
X-CSE-MsgGUID: 3bpBbB+XQCm26FRPA840Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87553860"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="87553860"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:36:29 -0700
X-CSE-ConnectionGUID: EO1PogHjRzaGKjvpMHx5Xg==
X-CSE-MsgGUID: Ff/xRf2BS3+WiZD/tsUzMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="249909046"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:36:27 -0700
Date: Wed, 1 Jul 2026 15:36:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com
Subject: Re: [PATCH v2 08/15] serial: 8250_mxpcie: speed up TX using
 memory-mapped FIFO window
Message-ID: <akUJyfwnYmow45fF@ashevche-desk.local>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
 <20260701034128.218569-9-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701034128.218569-9-crescentcy.hsieh@moxa.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 11:41:21AM +0800, Crescent Hsieh wrote:
> The MUEx50 UART provides a memory-mapped TX FIFO data window along with
> a TX FIFO level counter.
> 
> Fill the TX FIFO in bulk via the MMIO FIFO window based on available
> FIFO space, and use this path from the mxpcie interrupt handler instead
> of the generic serial8250_tx_chars() helper.

...

> +static void mxpcie8250_tx_chars(struct uart_8250_port *up)
> +{
> +	struct uart_port *port = &up->port;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned int i, count, txsize;
> +	unsigned char c;
> +
> +	if (port->x_char) {
> +		uart_xchar_out(port, UART_TX);
> +		return;
> +	}
> +	if (uart_tx_stopped(port) || kfifo_is_empty(&tport->xmit_fifo)) {
> +		port->ops->stop_tx(port);
> +		return;
> +	}
> +	txsize = serial_in(up, MOXA_PUART_TX_FIFO_CNT);
> +	count = min(kfifo_len(&tport->xmit_fifo), port->fifosize - txsize);

> +	for (i = 0; i < count; ++i) {

I haven't checked the whole series, but if the loop iterator is local,
write it as

	for (unsigned int i = 0; i < count; ++i) {

> +		if (!uart_fifo_get(port, &c))
> +			break;
> +
> +		serial_out(up, MOXA_PUART_TX_FIFO_MEM + i, c);
> +	}
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
> +		port->ops->stop_tx(port);
> +}

-- 
With Best Regards,
Andy Shevchenko


