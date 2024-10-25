Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09842212177;
	Fri, 25 Oct 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863911; cv=none; b=IL/hOagUXVgUKdG8KRxzMXIF45dofB8MxQkl6bIZI1V4xVl5mYMBWtciDM+05VJB03p16h7L9RjUxLmm+jVvXyNxD9dWJYcjCHBCjEUOKgOaHsuauT1dABAD2HYrB0F/q/8CGpYjPsplB7o3wL5/73S8C8bmZ5/iqvQcCCctqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863911; c=relaxed/simple;
	bh=ELyLqafkWIdrlLlQ8YIqBwYFc0TeAp0pM4iGwvzkzsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXpIFi2btcGpd8QO4I+aeoPXA4i31UGQtOGaOILCKUB6gOgU37XKTTgh20IGRde5XYeHWMY1k6hlxU0B8RObVD3l3WqqBtQR3pg4ixAeggh70c/wBFC/G0XHbpS1IfHsX+tuGlRnod9HOpEAnCcnlp/hGStBlVR1ncWmIn/AeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAItzX1P; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAItzX1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729863910; x=1761399910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ELyLqafkWIdrlLlQ8YIqBwYFc0TeAp0pM4iGwvzkzsE=;
  b=kAItzX1PdybvmWaYFOlpu9N7IjGpLfCXfzq2vBoWG3oZUDi+qS74jT7m
   5xa+ffCLE7AH+8zhFN8dO5TtiyRe6NjCqgaThr5J1ICglGVpu9n/bGvHx
   CLJSfak8+ycuZ3RcboSY0JyS+i2VoE6jVYTYCqXoMx2C30Oy6uZCQMdUl
   BXqzCSzRgTXV7yBI+y5GBaQ36gBZijzOnzMWR/kyYBkdnTvVnAhxnfCQt
   aUXTOYdDzxYBmDzRBTNLPxEhqeJHQ3du0gqpV89lG2Zvkvwiqdz3AonRB
   0/q8hebEi2XgbuOC2gp7xxoe/OMvNmIdn7VX+xVM59dW3B/F/8P9IxwBn
   w==;
X-CSE-ConnectionGUID: sO3IMkyCTjiAaQmVMqCpdA==
X-CSE-MsgGUID: IQiT35UARTWdswGmoL6CSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29310730"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29310730"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:45:09 -0700
X-CSE-ConnectionGUID: nN09eVAJS4CN6rMUw9+LGQ==
X-CSE-MsgGUID: Da6of3eSQTiIx3gO/YT4oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80517919"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:45:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4Kcg-00000006vfl-32tB;
	Fri, 25 Oct 2024 16:45:02 +0300
Date: Fri, 25 Oct 2024 16:45:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rengarajan S <rengarajan.s@microchip.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
Message-ID: <Zxug3qF9KUOn4VaM@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-2-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 01:03:23PM +0206, John Ogness wrote:
> After a console has fed a line into TX, it uses wait_for_xmitr()
> to wait until the data has been sent out before returning to the
> printk code. However, wait_for_xmitr() will timeout after 10ms,

printk here is a function reference or module?
For the latter I would use the filename to be sure it's clear,
like printk.c. For the former (and it seems you know that)
we may use printk().

> regardless if the data has been transmitted or not.
> 
> For single bytes, this timeout is sufficient even at very slow
> baud rates, such as 1200bps. However, when FIFO mode is used,
> there may be 64 bytes pushed into the FIFO at once. At a baud
> rate of 115200bps, the 10ms timeout is still sufficient.
> However, when using lower baud rates (such as 57600bps), the
> timeout is _not_ sufficient. This causes longer lines to be cut
> off, resulting in lost and horribly misformatted output on the
> console.
> 
> When using FIFO mode, take the number of bytes into account to
> determine an appropriate max timeout. Increasing the timeout

maximum
(in order not to mix with max() function)

> does not affect performance since ideally the timeout never
> occurs.

...

>  /*
>   *	Wait for transmitter & holding register to empty
> + *	with timeout

Can you fix the style while at it?

>   */

 /* Wait for transmitter & holding register to empty with timeout */

...

>  static void serial8250_console_fifo_write(struct uart_8250_port *up,
>  					  const char *s, unsigned int count)
>  {
> -	int i;
>  	const char *end = s + count;
>  	unsigned int fifosize = up->tx_loadsz;
> +	unsigned int tx_count = 0;
>  	bool cr_sent = false;
> +	unsigned int i;
>  
>  	while (s != end) {
> -		wait_for_lsr(up, UART_LSR_THRE);
> +		/* Allow timeout for each byte of a possibly full FIFO. */

Does the one-line comment style in this file use periods? If not, drop,
otherwise apply it to the above proposal.

> +		for (i = 0; i < fifosize; i++) {
> +			if (wait_for_lsr(up, UART_LSR_THRE))
> +				break;
> +		}

> +	}
> +
> +	/* Allow timeout for each byte written. */
> +	for (i = 0; i < tx_count; i++) {
> +		if (wait_for_lsr(up, UART_LSR_THRE))
> +			break;

This effectively repeats the above. Even for the fix case I would still add
a new helper to deduplicate.

>  	}
>  }

-- 
With Best Regards,
Andy Shevchenko


