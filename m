Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94823535E;
	Wed, 21 May 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814273; cv=none; b=Rmv4Upmg2o/Th0NIZxMSWw/OgeuDVbpuW2tueLwn3J5qB7UErhs0ROUv2eZChaXNjf/HBg4JzES5DhlFl8OXONYigGkjFTpGxQKuqTyiJ+/7xpJQ1qAq7rjGOEeTiFHNAJWfSyH7KIEA5zZfdb7Ok7mkcRQ2yRb/JeXZ+Dcd9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814273; c=relaxed/simple;
	bh=IkN/O4TGbrROkbGFdbKNrefNPLwlrHybl144qIJHI1U=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g1iMyyZ681O8AnwBScASQOcMfsLpzyEc5JTEAiW0Ymo6+hTCA4JOQyhB4JceAGQp2246uUnLHvI7TMBegIcdil48n5adGbHjV+9t/vDKZUahzO9O583DZuF150CjdMLaxTFJyHwdaP69J27Po/u42OoEqWe1Ldwz7IH0kchDfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Po5wFrEX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EBFNUbdD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Po5wFrEX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EBFNUbdD"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747814264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zdKNTsArdAs2c1TuTWwCMLwtQeBcXAgqSq0GvPwmk9E=;
	b=Po5wFrEXlEgeg7HOuGajJzCMtJv7DJ5osizJSotIaUDbHtXW7Ke5g4kbSNo/S5YceNXv+8
	cN3+ZrHTEJp7Z/wqOsieYhzE5Uwqyu/q7EQiQV7n0Yp4zpwr2Gnm05zvprJsnRb4/FeJaQ
	eVvymZUf0aJYEbl7VcKHdM61kscCQheDggMdACd5sj7L7QnQLnAZ/rTgYachuiZl5Clfey
	36TEUJOgkud2XV75Eje6bsvkJJwwr6FD4fBDRrQA9UDQ/0fD7S2sKYX32hZ9FLCiJU6aGQ
	3jdVLdrIye7dwvpqYeRKDe+2fHXi7fESWM/Q/GIUtvlTJIqhh6dHfCvwp3CHag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747814264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zdKNTsArdAs2c1TuTWwCMLwtQeBcXAgqSq0GvPwmk9E=;
	b=EBFNUbdDO8eBEXvOQ52dWB0FUTcDW5Z9RK+cMP9n4twiIHeZ69ei35cIr/0GFGegT2gWHB
	n48b6wIuv9lrMFBA==
To: Yunhui Cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
 cuiyunhui@bytedance.com, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 jirislaby@kernel.org, jkeeping@inmusicbrands.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de,
 paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com,
 sunilvl@ventanamicro.com, tim.kryger@linaro.org
Subject: Re: [PATCH v6 2/4] serial: 8250: avoid potential PSLVERR issue
In-Reply-To: <20250513024212.74658-2-cuiyunhui@bytedance.com>
References: <20250513024212.74658-1-cuiyunhui@bytedance.com>
 <20250513024212.74658-2-cuiyunhui@bytedance.com>
Date: Wed, 21 May 2025 10:03:43 +0206
Message-ID: <84y0uq9z0o.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-05-13, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 07fe818dffa34..9a04f24b0c762 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2133,25 +2132,22 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>  static int serial8250_get_poll_char(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> -	int status;
> +	int status = NO_POLL_CHAR;
>  	u16 lsr;
> +	unsigned long flags;
>  
>  	serial8250_rpm_get(up);
>  
> +	uart_port_lock_irqsave(port, &flags);
>  	lsr = serial_port_in(port, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		status = serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);

I realize I previously made a comment saying it was OK to add the spin
locking here. But I have changed my mind. Please remove this spin
locking. It is not necessary because with kgdb all the other CPUs are
quiesced, so there is no need to synchronize with the console. Also, it
will deadlock if kgdb took over while the port was locked.

> @@ -2513,7 +2514,6 @@ void serial8250_do_shutdown(struct uart_port *port)
>  		port->mctrl &= ~TIOCM_OUT2;
>  
>  	serial8250_set_mctrl(port, port->mctrl);
> -	uart_port_unlock_irqrestore(port, flags);
>  
>  	/*
>  	 * Disable break condition and FIFOs
> @@ -2521,6 +2521,14 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	serial_port_out(port, UART_LCR,
>  			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
>  	serial8250_clear_fifos(up);
> +	/*
> +	 * Read data port to reset things, and then unlink from
> +	 * the IRQ chain.
> +	 * Since reading UART_RX clears interrupts, doing so with
> +	 * FIFO disabled won't trigger PSLVERR.
> +	 */
> +	serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  #ifdef CONFIG_SERIAL_8250_RSA
>  	/*
> @@ -2529,11 +2537,6 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	disable_rsa(up);
>  #endif
>  
> -	/*
> -	 * Read data port to reset things, and then unlink from
> -	 * the IRQ chain.
> -	 */
> -	serial_port_in(port, UART_RX);

I am thinking you should keep the read here and instead move the unlock
below the read. This would mean the lock/unlock in disable_rsa() need to
be removed. (The function comments for disable_rsa() aready say that the
caller needs to hold the port lock.)

I am thinking something like the below (untested) diff instead of the
above 2 hunks.

John Ogness

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 22b3f7a193070..51467383aaf5a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -781,8 +781,6 @@ static void disable_rsa(struct uart_8250_port *up)
 
 	if (up->port.type == PORT_RSA &&
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		uart_port_lock_irq(&up->port);
-
 		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
 
@@ -794,7 +792,6 @@ static void disable_rsa(struct uart_8250_port *up)
 
 		if (result)
 			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		uart_port_unlock_irq(&up->port);
 	}
 }
 #endif /* CONFIG_SERIAL_8250_RSA */
@@ -2536,7 +2533,6 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2555,8 +2551,12 @@ void serial8250_do_shutdown(struct uart_port *port)
 	/*
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
+	 *
+	 * Since reading UART_RX clears interrupts, doing so with
+	 * FIFO disabled won't trigger PSLVERR.
 	 */
 	serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
