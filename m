From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250: Add cpufreq support
Date: Wed, 13 Jan 2010 13:44:45 +0000
Message-ID: <20100113134445.010d4f1c@lxorguk.ukuu.org.uk>
References: <1263386121-6644-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43784 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754965Ab0AMNle (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Jan 2010 08:41:34 -0500
In-Reply-To: <1263386121-6644-1-git-send-email-chaithrika@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, khilman@deeprootsystems.com, akpm@linux-foundation.org, Chaithrika U S <chaithrika@ti.com>

> +static int serial8250_cpufreq_transition(struct notifier_block *nb,
> +					     unsigned long val, void *data)
> +{
> +	struct uart_8250_port *p;
> +	struct uart_port *uport;
> +
> +	p = container_of(nb, struct uart_8250_port, freq_transition);
> +	uport = &p->port;
> +
> +	if (IS_ERR(p->clk))
> +		goto cpu_freq_exit;
> +
> +	if (p->port.uartclk == clk_get_rate(p->clk))
> +		goto cpu_freq_exit;
> +
> +	p->port.uartclk = clk_get_rate(p->clk);
> +	if (val == CPUFREQ_POSTCHANGE) {
> +		struct ktermios *termios;
> +		struct tty_struct *tty;
> +		if (uport->state == NULL)
> +			goto cpu_freq_exit;
> +
> +		tty = uport->state->port.tty;

Need locking on port->tty.

> +		if (tty == NULL)
> +			goto cpu_freq_exit;
> +

Need locking on tty->termios

I'd say this is also probably at the wrong level - why not do it at the
uart_port level instead (ie move the code you have into serial_core using
uart_port) - you've made it all nicely generic already.

Alan
