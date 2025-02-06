Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6319F436;
	Thu,  6 Feb 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868119; cv=none; b=g2F8Az/7xe2F/h8rKGjMgjplKFPQUxpMlsbqWlFXLoycTGLvHOzVle/PA6PUkzK8KJYwKUGtfUL9HnG+Q888zoQ0q3D/83MVt0inhhoKhxOgtURUeSjfImbc+iBY2YuAYBuPkcK9G1iQquUsyo+8Qi2BKpvtkh37NIqG9GpsPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868119; c=relaxed/simple;
	bh=FDulyMc4DCvOKU1fXSh1zkUDb8SmMV8MlfmV2AL7ke4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5CGu4N45n/Juaa+QuSBAsso2fgayUye2i/ynhZTwPhfoqob/wnBgamPuuRrrRdl12EcrXsjbmQ7y0vHUcFHVcfY7XKjavKgSORkO0xH7Maa5JdWXMyGAMjBZbeovunezbYeVVePIhkax2Jxek2Hxjm92FYmn6tKjYZlPBXODv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RY/nRYaF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RY/nRYaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738868117; x=1770404117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FDulyMc4DCvOKU1fXSh1zkUDb8SmMV8MlfmV2AL7ke4=;
  b=RY/nRYaFza3h9ty51bL6741um+7hXkHI81ClZSJIg7utV/gWOfuo3tBu
   knRIHlHZwa6UUC18zh7Q4OZVFOzt5ehomCzhx6nSBf5KS9j/mhK8oNk6T
   JYk0m99/m/RXleLbCPKkpqQmQbywlyZc8mXak2YLrmS2tCkbTBL1Lpk8O
   1OuewmU1pWXXP0rVR4kCUPYgwh3RzdaiaXxsQ7acI2VJNJHzKvVvzizlh
   RrpD9YGkPUIAJhWoW12lDqDJU47sYEMcHyehw3Sk4a2Q+ZKJjc+X8glXj
   gjLkHeKv/DrnjgtRB0ILX78DSSGG/7hMLI6AhhGeeLvhPqh+tkLqaBQi9
   A==;
X-CSE-ConnectionGUID: Y4/4/xUJRKmSbVBgZZvwOQ==
X-CSE-MsgGUID: ebDmQEsnSDyQCxKAHdBtDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50476681"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="50476681"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:55:16 -0800
X-CSE-ConnectionGUID: /4dxL3d6QrCZNh4vVdfnGA==
X-CSE-MsgGUID: gzRIt9cRQ+qYEIxJj+zX3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="116326951"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:55:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tg71p-00000008oxX-2XmB;
	Thu, 06 Feb 2025 20:55:09 +0200
Date: Thu, 6 Feb 2025 20:55:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Matt Turner <mattst88@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <ftoth@exalondelft.nl>, Petr Mladek <pmladek@suse.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Fix fifo underflow on flush
Message-ID: <Z6UFjU9SM4laZRyW@smile.fi.intel.com>
References: <20250206155555.85093-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206155555.85093-1-jkeeping@inmusicbrands.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 06, 2025 at 03:55:51PM +0000, John Keeping wrote:
> When flushing the serial port's buffer, uart_flush_buffer() calls
> kfifo_reset() but if there is an outstanding DMA transfer then the
> completion function will consume data from the kfifo via
> uart_xmit_advance(), underflowing and leading to ongoing DMA as the
> driver tries to transmit another 2^32 bytes.
> 
> This is readily reproduced with serial-generic and amidi sending even
> short messages as closing the device on exit will wait for the fifo to
> drain and in the underflow case amidi hangs for 30 seconds on exit in
> tty_wait_until_sent().

Sounds not good user experience...

> A trace of that gives:
> 
>      kworker/1:1-84    [001]    51.769423: bprint:               serial8250_tx_dma: tx_size=3 fifo_len=3
>            amidi-763   [001]    51.769460: bprint:               uart_flush_buffer: resetting fifo
>  irq/21-fe530000-76    [000]    51.769474: bprint:               __dma_tx_complete: tx_size=3
>  irq/21-fe530000-76    [000]    51.769479: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294967293
>  irq/21-fe530000-76    [000]    51.781295: bprint:               __dma_tx_complete: tx_size=4096
>  irq/21-fe530000-76    [000]    51.781301: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294963197
>  irq/21-fe530000-76    [000]    51.793131: bprint:               __dma_tx_complete: tx_size=4096
>  irq/21-fe530000-76    [000]    51.793135: bprint:               serial8250_tx_dma: tx_size=4096 fifo_len=4294959101
>  irq/21-fe530000-76    [000]    51.804949: bprint:               __dma_tx_complete: tx_size=4096
> 
> Since the port lock is held in when the kfifo is reset in
> uart_flush_buffer() and in __dma_tx_complete(), adding a flush_buffer
> hook to adjust the outstanding DMA byte count is sufficient to avoid the
> kfifo underflow.

Shouldn't this have a Fixes tag?

...

> +void serial8250_tx_dma_flush(struct uart_8250_port *p)
> +{
> +	struct uart_8250_dma *dma = p->dma;

> +	if (dma->tx_running) {

	if (!dma->tx_running)
		return;

> +		/*
> +		 * kfifo_reset() has been called by the serial core, avoid
> +		 * advancing and underflowing in __dma_tx_complete().
> +		 */
> +		dma->tx_size = 0;
> +
> +		dmaengine_terminate_async(dma->rxchan);
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


