Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E61428FA
	for <linux-serial@vger.kernel.org>; Thu, 11 Apr 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840767; cv=none; b=bqze9CI4O0/Qxf4giHSD0uRH8SVFr++dm76thNhY9mAnWqwt6f8jSzbhzQR6MPETGBnaBOVDt0dGd/dpNvJPo9EBeMMr9FSd18fvEat04sTkeqELEp89Uqshi0HJOISRxV1XdB+ZFlmi3iB6Oyqvj4fB7TOfULhhYdDysAJPD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840767; c=relaxed/simple;
	bh=pryc/QH+INi/Qsom/WNhFv2C+a3hNEWpvJ2Ll6EXqb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYFrccojIsRRhLCbUuBiCQBIdbigB/No3cqt3lfb4LxpdDZJXmQZCCnnaszxEPwC+c6tILKGW4TFEDaubeDZN1X5NDKKPTlQOdEOn0CJcAsfxZW8V5EvTi+DMp49IizcVymjGXm5qR+WNlRsKlcR5PKG8yT+ppz4ztrySIix7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHhbXa0r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHhbXa0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712840766; x=1744376766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pryc/QH+INi/Qsom/WNhFv2C+a3hNEWpvJ2Ll6EXqb0=;
  b=WHhbXa0rgFkVTkITc3dhynpX/vrZSzVoz9WyuIzDJvVIBT9o0HkJSQym
   tYchdLxaJcUgQRZTo7m0ED2O+JN1h0c3QvTsfZzi9oASG2J35XetPqnAH
   Zl2Wdq+gk85puaoy7pNei1s7XbDzySK70G+8l6CBlDMVGSgeZjiB+GN9G
   UzBM+d/o4/AL4DxfIwKW3VSWvy8K39kmFZalqzpnd08rkMyV08HGT4ZSz
   EPBfbb64RdqlgvEiq49S8zki8RmHVGaYMwC13o7HIrDR2nc3K5SC435HH
   OC9y58tXknCdtyRNqYjSVJRN5uXwzuGR9SOWJ+BdtzefyrTZBtkheNl0g
   A==;
X-CSE-ConnectionGUID: rsvEFPN4SiWXSSwChSYJzg==
X-CSE-MsgGUID: BBQZrdWCTImCIGAy3NzlAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18807045"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18807045"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="915463110"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915463110"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:06:04 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruu7t-00000003M6G-44NO;
	Thu, 11 Apr 2024 16:06:01 +0300
Date: Thu, 11 Apr 2024 16:06:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix missing shutdown and startup for
 serial base port
Message-ID: <ZhfgOU7htReGK3Xt@smile.fi.intel.com>
References: <20240411055848.38190-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411055848.38190-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 08:58:45AM +0300, Tony Lindgren wrote:
> We are seeing start_tx being called after port shutdown as noted by Jiri.
> This happens because we are missing the startup and shutdown related
> functions for the serial base port.
> 
> Let's fix the issue by adding startup and shutdown functions for the
> serial base port to block tx flushing for the serial base port when the
> port is not in use.

I'm going to test this later today, meanwhile some comments below.

...

> +out_base_port_startup:
> +	uport = uart_port_check(state);
> +	if (!uport)
> +		return -EIO;
> +
> +	serial_base_port_startup(uport);

So, we call this even on uninitialised TTY. Is it okay?

> +	return 0;
>  }


...

>  	if (tty)
>  		set_bit(TTY_IO_ERROR, &tty->flags);

> +	if (uport)
> +		serial_base_port_shutdown(uport);

Why not to call it after the below check to be reverse-symmetrical with startup?

>  	if (tty_port_initialized(port)) {
>  		tty_port_set_initialized(port, false);
>  

...

>  	/* Flush any pending TX for the port */
>  	uart_port_lock_irqsave(port, &flags);
> +	if (!port_dev->tx_enabled)
> +		goto unlock;

Can't this be integrated into...

>  	if (__serial_port_busy(port))

...this call?

>  		port->ops->start_tx(port);
> +
> +unlock:
>  	uart_port_unlock_irqrestore(port, flags);
>  

...

>  	uart_port_lock_irqsave(port, &flags);
> +	if (!port_dev->tx_enabled) {
> +		uart_port_unlock_irqrestore(port, flags);
> +		return 0;
> +	}
> +
>  	busy = __serial_port_busy(port);
>  	if (busy)
>  		port->ops->start_tx(port);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


