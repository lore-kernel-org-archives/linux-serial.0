Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3C449B23;
	Mon, 20 Jul 2026 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576882; cv=none; b=WqnXGB3i9Tg7G9jM7ZHBL5IJJ6qKyylKgkmAXykvVNR0m5qsF0CX9R/IK7eaKbwsMEx5RTSAeGlHXcAq50X0jaHmkdn5v+DPqjKyln+8HiOlbT3MNUlrbNYKNMDkTZGXzZk6EklGs8BpKKP3+pIsiaGcgJcsQZT2rIoYRTojrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576882; c=relaxed/simple;
	bh=extbjjyHHo55Qa09aTFB02bWNBbfSOTAx8J673Pzsr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqH6+UnBOCO/VflxiTUKxQM30hAx6t4ExC+KGWu+yziHenyoLoZuuni1lw7qkrDF1tVsysWgqaFSvg3K6cAmq0gQYM2LhkwJsNqDR4ktMpBoGSs2kCHY2li1SfjM9OtG8wgMtWXzF1KWnUmEDN/rIayVkYiXL18rE/6Bb8uz5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOuvmi0e; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOuvmi0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784576881; x=1816112881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=extbjjyHHo55Qa09aTFB02bWNBbfSOTAx8J673Pzsr0=;
  b=gOuvmi0e0MQJMslhyTVoYKgWNc6MOh2BgnlcuAddr+800Cr7np1iFW2t
   ePkmAV4WapfBrS+qWzH0OJkvt2Xwc97JLMlVp3D+vL4lbU/QQS16YOsoT
   vrO1YRKI032355lQ7szbLwIKVRpgWxMjDtUwXpqs8qYi9L9fEIhDGoJza
   eqe1+/8ell24w33LJfz/U0pqInrEsMWMuGEd8fhYTMH17YCTHu0ZBizfl
   3fmP8tZVfCHfFiKC59uC9W/ubQmWAOzuUg4fdiDHeejcfgOhuJfk4M7Zo
   b3pBrUPHMcgnQvpX3y2iVU5AEHG3/AnqlPRtiQyJnNnjDi6pAhUeIxW2R
   g==;
X-CSE-ConnectionGUID: rwxkPFrbQm6KwZGZ/zWNIg==
X-CSE-MsgGUID: H+DfJPxRQKK29tcweCZHXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84149377"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84149377"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:47:59 -0700
X-CSE-ConnectionGUID: 9jYHbEhNTb6BEtcfVymaGA==
X-CSE-MsgGUID: uxtAoh6/RbGGNiEJhkCOWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="259544705"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:47:56 -0700
Date: Mon, 20 Jul 2026 22:47:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v7 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <al57amN8TFhN4IOo@ashevche-desk.local>
References: <20260720135407.3925-1-john.ogness@linutronix.de>
 <20260720135407.3925-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720135407.3925-2-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 04:00:03PM +0206, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks:
> 
>   ->write_atomic()
>   ->write_thread()
>   ->device_lock()
>   ->device_unlock()
> 
> and add CON_NBCON to the initial @flags.
> 
> All hardware access in the callbacks is within unsafe sections.
> The ->write_atomic() and ->write_thread() callbacks allow safe
> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks. During suspend/resume the irq_work is not
> used as this has been shown to cause suspend problems for some
> hardware. Upon resume, any pending modem control is performed.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER during console writing (which may not be
> holding the port lock for atomic printing). This allows restoring
> a lockdep check to serial8250_clear_IER() in a follow-up commit.

...

> +	/* irq_work allowed again. Handle MSR now if pending. */
> +	up->avoid_modem_status_work = false;
> +	guard(uart_port_lock_irqsave)(port);

To make guard()() visible, we usually add a blank line before and after
guard()() line. I dunno if scoped_guard() makes more sense here as Petr
proposed, I'm fine with either.

> +	if (uart_console(port) && up->msr_saved_flags)
> +		serial8250_modem_status(up);

...

> +static void serial8250_console_byte_write(struct uart_8250_port *up,
> +					  struct nbcon_write_context *wctxt)
> +{
> +	struct uart_port *port = &up->port;
> +	const char *s = wctxt->outbuf;
> +	const char *end = s + wctxt->len;
> +
> +	/*
> +	 * Write out the message. If a handover or takeover occurs, writing
> +	 * must be aborted since wctxt->outbuf and wctxt->len are no longer
> +	 * valid.
> +	 */
> +	while (s != end) {

Can len == 0? If not, I would write this as do {} while ().

> +		if (!nbcon_enter_unsafe(wctxt))
> +			return;
> +
> +		uart_console_write(port, s++, 1, serial8250_console_wait_putchar);
> +
> +		nbcon_exit_unsafe(wctxt);
> +	}
>  }

...

> +/*
> + * irq_work handler to perform modem control. Only triggered via
> + * ->write_atomic() callback because it may be in a scheduler or
> + * NMI context, unable to wake tasks.
> + */
> +static void modem_status_handler(struct irq_work *iwp)
> +{
> +	struct uart_8250_port *up = container_of(iwp, struct uart_8250_port, modem_status_work);
> +	struct uart_port *port = &up->port;
> +
> +	guard(uart_port_lock)(port);

+ blank line.

> +	serial8250_modem_status(up);
> +}

-- 
With Best Regards,
Andy Shevchenko


