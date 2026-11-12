Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500039;
	b=1mwhqrcbLU5BdEFtdo+3JLWv/9lgg9ohRCLNDJtiVj4ymj2X0lLNagu3VJiZfTA5NzW4
	 u04QytcJzxQZO8imQEfmduLwr4v/FAQD5Qo7V5jqqYn8wTaXW/7Nf02KXDL/N6kXNn7uq
	 eYHEg+NEaXMVGaY/ZGfwyzJP2O1t/lRVfgw/R3YlufaeP9/9csSqTFu2M8NADulis34yB
	 sJSMYwvG+6u+S9SYEJmPJUW0lLbg3gBCeYIsbrAEzad2XMcVXJ/np6mz++t7iV3sMEgmZ
	 VmTZiv0v1rXlZslULcPfpgnujgR7FbcaCuZPbLB0I8MDbaA0huvTwpFDmFgTfr5MRNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500039;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=c4OknN5YfqROvQIcmXbW+MOiSND7LTxhC21JuzqOEYM=;
	b=cBaBsxuFF0W2RRH66LBuytV0AiVo8Ea0aCK3fxwArX9O6Exr0osqeaqHDbszyHPRSIzB
	 aaZCBDSbo1LXOL7IBVQL99BDLF9r2MhPOo8weTCOfnOV5xQhLYHZH0Wt8UbqhuWu51y0k
	 0/nQbj0/fQXbv406r54HJXI9+AqXiOQi9uIY/MoXqgBlp0/gUv+1gA3rV71n64zhIGUeb
	 1dkA2ACAoXL4tYZ5at1IL9zSM/utYcKPzIJ/PasfyKXt+KKvx3HtZE1l5eXhnVLpTmLMK
	 yYHIbVWSMPqTIK0soeyQTjFtzprC8YnHDhzeMm7L5uCa8tmUKo8oRaTqqPgUEwA+XSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BBJqyU5j;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686E606A32A;
	Thu, 12 Nov 2026 16:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8686E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BBJqyU5j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794500039; x=1826036039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P3eY0n6vlSPXz45ttiFWukVb0XOFJGYuxSNON9DZg6w=;
  b=BBJqyU5jLzrqm3uwjT8AVddpzs6xLM8oFHeV/3JM0OWnv6lEME/tTfZJ
   Xn6400iOKCX88MED6MoPk3FYQ0zdrkDZGxsUjNtG0e25R54yH/O3a2E46
   GAuAs6bHW0R+2xXOi/St9t3Eg+qiWIj2HoA6rtdryL2OB1PQdRIaez/hv
   a8tosv6hDYtU52S3dIqto5b2vh0xk/EEyegzTx8CZxXbJMaf1V2CNqTQl
   AkQ/o2rhOJHqOH+F7ic/RRiYUpyfT9VjlG4vX9bDxAnkCZM/h+wu8v9nM
   iBzBihdV3WW0Qa/rv1Uwg4lhB/3piVvncgup9e/HEUSwjKG+CWQjA+Dnq
   A==;
X-CSE-ConnectionGUID: enQjiMIpRJWEae4mN7CqDQ==
X-CSE-MsgGUID: o7d23q4JThKh0PPbaBJNUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3210554"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3210554"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:13:58 -0800
X-CSE-ConnectionGUID: YpTlbcAPQJGxf1iKlOYuBw==
X-CSE-MsgGUID: 7vG+U6ikQHSqNIVXrFRQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8519157"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:13:51 -0800
Date: Thu, 12 Nov 2026 18:13:49 +0200
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
Subject: Re: [PATCH v12 5/8] serial: core: allow drivers to reserve flushed
 transmit storage
Message-ID: <avXlve7ROG9jb6AH@ashevche-desk.local>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-5-9e3456bc2555@gmail.com>
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
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-5-9e3456bc2555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 03:16:30PM -0700, James Hilliard wrote:
> uart_flush_buffer() resets the transmit FIFO before calling the driver's
> flush callback. An asynchronous DMA transfer can still access that storage
> after the callback returns, while a new write can immediately reuse it.
> 
> Add uart_xmit_block() and uart_xmit_unblock() so a driver can reserve the
> flushed storage until its transfer and completion callbacks have retired.
> Serialize the reservation with FIFO producers using the port lock.
> 
> While the storage is reserved, write_room() reports no space and write()
> and put_char() accept no data. Defer write-ready notifications until the
> reservation is released, preserving one-shot TTY wakeups. Keep the flush's
> write-ready notification under the port lock so it cannot race another
> reservation.
> 
> Wake tty->write_wait after flushing even when writes remain blocked.
> tty_wait_until_sent() waits for the logical FIFO to empty, independently
> of whether its storage can be reused. Notify these drain waiters without
> invoking the line discipline's write_wakeup() callback, so a reservation
> does not prevent a completed logical flush from waking a drain waiter or
> consume a one-shot write-ready notification prematurely.
> 
> Suppress ordinary TX starts while the FIFO storage is blocked. Preserve
> high-priority flow-control characters, which use separate storage.
> Releasing the reservation wakes writers through the existing TTY wakeup
> path. This preserves immediate logical flushing while applying write
> backpressure until the storage is reusable.
> 
> Track port readiness separately from DMA ownership. Retirement releases the
> reservation even during startup or shutdown, while writes and wakeups stay
> gated until successful startup or resume. Reopening or restarting a port
> wakes deferred writers with either a new or retained FIFO. Restart queued
> output when reusing a FIFO after suspension. Keep its write-ready
> notification pending until the retained output drains below the normal
> wakeup threshold. Share that threshold check with generic 8250 and OMAP
> TX DMA completion through uart_write_wakeup_if_needed().
> 
> Publish resume readiness under the same port lock as the TX restart,
> without clearing any reservation. A concurrent flush can then reserve a
> new transfer without resume releasing its storage prematurely.
> 
> Assert the port-lock requirement at uart_write_wakeup(), alongside the
> reservation helpers, so callers cannot inspect readiness or release a
> one-shot notification concurrently with a reservation change.

...

>  void uart_write_wakeup(struct uart_port *port);

> +void uart_xmit_block(struct uart_port *port);
> +void uart_xmit_unblock(struct uart_port *port);

These are not used in the below helper, so, move them after it, with that
the uart_xmit_*() and uart_write_*() will be grouped.

> +/**
> + * uart_write_wakeup_if_needed - notify writers when queued output is low
> + * @port: port to be processed
> + *
> + * Keep one-shot write-wakeup notifications pending until fewer than
> + * %WAKEUP_CHARS remain in the transmit FIFO. This also applies to output
> + * retained across suspend and resume.
> + *
> + * Context: @port->lock held.
> + */
> +static inline void uart_write_wakeup_if_needed(struct uart_port *port)
> +{
> +	if (kfifo_len(&port->state->port.xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +}

-- 
With Best Regards,
Andy Shevchenko


