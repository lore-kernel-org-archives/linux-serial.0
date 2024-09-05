Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756CDDD2;
	Thu,  5 Sep 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545713; cv=none; b=uDiWjLfvgAFoNOw65ZzFbHU5SLHbfRgrdwaewxxgkSPsb9OooeR+K+zlFtQydwB5jp87yL8yE6dfyfz0scf7CTiZC/5DbLw6wp7WuS+akDV3dlWymnuxHpfOOL1UOzNxeat/+4ua3048OtJOJ39qVPZfKM5E/MGO3209hYUcaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545713; c=relaxed/simple;
	bh=VfkiF78s61HLrfjc1XjUx593xgRMVs66g8YIw198YBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD+mT6J2Ik+Y0Kwl+vZF0jxv4nV4CHv8LH/xRLBlaJQwcZk21SZUZZq1ntV8w53pqFK2Jhut1ZJIEO1+yE/OqQ93H8wX8FygQQnbYd5vYj9JJh89GX+Sto19VN46K2BTtuq4iH5Lj3X2T14YgDT9l5MVh/WXMkbCYNYDJHE/EdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MN03jAJ6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MN03jAJ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725545711; x=1757081711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfkiF78s61HLrfjc1XjUx593xgRMVs66g8YIw198YBU=;
  b=MN03jAJ6sV5cOE6pfjgmSFnzRc3ybdWiTfwMgCz+a0yXMEhhFxcdS0BO
   HN1b+5xzyNts+GhW1qVDA6xtA+8xVcZ3MzfTVg0m2RSj+XKh3lLxhVD4H
   4G7BU0rpdKvgd3g0Fdv6KqMuuru/x0kue4GYfY6DgBlswAwR32P4OcS/9
   4Jj9h8ahlDlUuTE34Y40X6YsFVfdtaBVkIJr4KUc/qfJjJUIeQUlzMseZ
   sNeDSuB4dLHX/vl4mRqjmoZUBoEJNGT2bcCDes4rlOqb3Fu2Qu9Nll851
   toobBIG0mqU/svSIubeYatc38DHuUV3sc/zAxR/h1SAmkehwF8jfYbEw4
   g==;
X-CSE-ConnectionGUID: 8ofElff8Rza2DYAjxj50fQ==
X-CSE-MsgGUID: 8boVKjigRJmn7760x5tXZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35649654"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="35649654"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 07:15:09 -0700
X-CSE-ConnectionGUID: TkcWMN9ZT6S1utG77k8V3g==
X-CSE-MsgGUID: dKVnBy2DQ4ikjBXiO1a9TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70553810"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 07:15:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smDGH-00000005Q26-3ZNs;
	Thu, 05 Sep 2024 17:15:01 +0300
Date: Thu, 5 Sep 2024 17:15:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
Message-ID: <Ztm85Y_mo5-OJveq@smile.fi.intel.com>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <20240905134719.142554-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905134719.142554-2-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 03:53:18PM +0206, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks (write_atomic,
> write_thread, device_lock, device_unlock) and add CON_NBCON to the
> initial flags.
> 
> The legacy code is kept in order to easily switch back to legacy mode
> by defining USE_SERIAL_8250_LEGACY_CONSOLE.

...

>  static struct console univ8250_console = {
>  	.name		= "ttyS",
> +#ifdef USE_SERIAL_8250_LEGACY_CONSOLE

Can it be done at run-time (theoretically or even practically)?
(Note that we have already knob to disable / enable consoles.)

>  	.write		= univ8250_console_write,
> +	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
> +#else
> +	.write_atomic	= univ8250_console_write_atomic,
> +	.write_thread	= univ8250_console_write_thread,
> +	.device_lock	= univ8250_console_device_lock,
> +	.device_unlock	= univ8250_console_device_unlock,
> +	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
> +#endif
>  	.device		= uart_console_device,
>  	.setup		= univ8250_console_setup,
>  	.exit		= univ8250_console_exit,
>  	.match		= univ8250_console_match,
> -	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
>  	.index		= -1,
>  	.data		= &serial8250_reg,
>  };

I would arrange this slightly differently, but not a big deal.

static struct console univ8250_console = {
	.name		= "ttyS",
	.device		= uart_console_device,
#ifndef USE_SERIAL_8250_LEGACY_CONSOLE
	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
	.write_atomic	= univ8250_console_write_atomic,
	.write_thread	= univ8250_console_write_thread,
	.device_lock	= univ8250_console_device_lock,
	.device_unlock	= univ8250_console_device_unlock,
#else
	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
	.write		= univ8250_console_write,
#endif
	.setup		= univ8250_console_setup,
	.exit		= univ8250_console_exit,
	.match		= univ8250_console_match,
	.index		= -1,
	.data		= &serial8250_reg,
};

...

> +	if (nbcon_exit_unsafe(wctxt)) {
> +		int len = READ_ONCE(wctxt->len);

> +		int i;

unsigned ?

> +		/*
> +		 * Write out the message. Toggle unsafe for each byte in order
> +		 * to give another (higher priority) context the opportunity
> +		 * for a friendly takeover. If such a takeover occurs, this
> +		 * must abort writing since wctxt->outbuf and wctxt->len are
> +		 * no longer valid.
> +		 */
> +		for (i = 0; i < len; i++) {
> +			if (!nbcon_enter_unsafe(wctxt))
> +				break;
> +
> +			uart_console_write(port, wctxt->outbuf + i, 1, serial8250_console_putchar);
> +
> +			if (!nbcon_exit_unsafe(wctxt))
> +				break;
> +		}
> +	}

...

> +	/* Finally, wait for transmitter to become empty and restore IER. */
> +	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> +	if (em485) {
> +		mdelay(port->rs485.delay_rts_after_send);
> +		if (em485->tx_stopped)
> +			up->rs485_stop_tx(up);
> +	}
> +	serial_port_out(port, UART_IER, ier);
> +
> +	/*
> +	 * The receive handling will happen properly because the receive ready
> +	 * bit will still be set; it is not cleared on read.  However, modem
> +	 * control will not, we must call it if we have saved something in the
> +	 * saved flags while processing with interrupts off.
> +	 */
> +	if (up->msr_saved_flags)
> +		serial8250_modem_status(up);

(1)

...

> +	/* Atomic console not supported for rs485 mode. */

RS485

...

> +	/*
> +	 * First save IER then disable the interrupts. The special variant to
> +	 * clear IER is used because atomic printing may occur without holding
> +	 * the port lock.
> +	 */
> +	ier = serial_port_in(port, UART_IER);
> +	__serial8250_clear_IER(up);
> +
> +	/* Check scratch reg if port powered off during system sleep. */
> +	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
> +		serial8250_console_restore(up);
> +		up->canary = 0;
> +	}
> +
> +	if (up->console_newline_needed)
> +		uart_console_write(port, "\n", 1, serial8250_console_putchar);
> +	uart_console_write(port, wctxt->outbuf, wctxt->len, serial8250_console_putchar);
> +
> +	/* Finally, wait for transmitter to become empty and restore IER. */
> +	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> +	serial_port_out(port, UART_IER, ier);

(2)

Feels like parts (1) and (2) duplicates existing pieces of code. May it be
refactored to minimize the duplication?

-- 
With Best Regards,
Andy Shevchenko


