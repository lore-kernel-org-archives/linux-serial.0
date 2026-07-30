Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8013F4DC3
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421485; cv=none; b=nHs3s4k3lH84EejFaG8UIrFvOdIStoCWMz1pf5TOLlXtcDc9xwvrjatS2ELEh4xLfZ/ywAKgKmnVo48aaY2K66hzOfrMx0ST4Vuet6z4VQR84Vt0tTfXhSptd8bVkyVwQkRobxv221Cg+xEhIHzpfaNiAtLpAV4OmHik94Pgbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421485; c=relaxed/simple;
	bh=gS7M7WaABYQkobBXMOJi/hfH/P6dVhltQu8iIaQydSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFy+W5FNTxJKWX13aO1EKrnEIKdMLXkrvS/c8l1pkflXeGcBzvDHaYcSjKpPubGPUhtXiOohdChMgJJ+2PYaZNXU7DrbadgKtMqwMtmUfw43UHeFbp9y3MowqeNaNoFdHpWG9YuPBYViYC6CZA8rf9WfR3qoueYD+SjrcpqOocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VU9P02dK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VU9P02dK"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1456605f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785421481; x=1786026281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aATaI8dHYxrwOEz3FkheuyLZ9atzLTZfmfFwHyaNgzo=;
        b=VU9P02dKGhZjbaBLwhpy6mTebQLVwlZe7zfKtD+1/bSfIyWbLEjMyLoWfi7LX0ITh3
         qlldvGumUJGYr1aqPnulotllQytNhj/RXCzn6pRpQ8PdWZNywnEuqK/eAc21t3ZarTd1
         nJRxC7WvM5lwJl5JwhnMUVlIRNF5SK4etJsMhKURLd7FpzvsaPTVvHKXXRFdFeaT6QJq
         opIsZe0/fONw1TdmLJ5TAKeJ4lUQSm58PgxrBKxwYht6OYoO7/OyLN1LHgsuBqCE5K3O
         3qC69DxNWPjoO6KzEXMzd43rClYSnhwoYI54IpB8liqqKufw2C5LNhCBIBNUBqj4B002
         oOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785421481; x=1786026281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aATaI8dHYxrwOEz3FkheuyLZ9atzLTZfmfFwHyaNgzo=;
        b=m9E0o10yu1Vx6WDVzTdYiZ9fvF0UbgoawB9CNVAtmcws8UArne797pSaf6yAGoxgIH
         yq6h5vl2QNMwT2frSKhmMZebFO29uke6LobjIm4KJ3303z7Wq4iaZHI7dqMmdmP2TcNw
         yac+qNu2szVdYmpxjCQBgTdtjS/fp11oBd+r/qZi3Pp0NFYc+olouHu9ZM4U4mFVu+pt
         UNSEFLQZBTpDkE9D90wVDAhC/CgGzYsaYNLY6Dzkdnfo7rGFttHIf+/V5Ud/upKkcs1L
         nOvk0L18CxRPoVjU5ualXbuh0Su8c6dIkKQY8o1KdALCq5yLx+5gX3mLoM3aiPJoMIeW
         NK6g==
X-Forwarded-Encrypted: i=1; AHgh+Rp2yJ9Nu/IbRoTh2p/CFA/e1vhOcl8zMR8kKhBUyMF/6IiguK5Ed7aT4+eWTnWYr5hRX8MKSzyuj2QpEdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iAIAQcpN77dQ3sT+aqGe5qN+BxkwSHKvhjPLA7ktjZDkHjie
	4sIL6Tt0KpkiDVt8hRf3QahyrP0hVy38F3JMO7VIIUXRmwoOgC2lZ3cHUq7qr7b9NGU=
X-Gm-Gg: AR+sD10dB9YB9iCxjVtsCh/FWPiy0KknGFGzP8ntTVN6rRCtiC6kkLZm3OJf9gHRM4I
	R0dUkUiaXzMeycA+TBxN2l7IzWlK2GmdNhfkRXXogOJUs2ClO51s1ny4pfjPYox+TSYrQ03qXNV
	SyyJiqUNjaZ45ke5FhHXTEQKQgeRZlqptkXpiEWbUrwBVO4YXKFnsKKhrQW+lIgMJqAtnBi51ku
	aqFwF2xuLewe1ZByW5JQuDESt+5MGIn8ueH/TE8Iq9vD4FZfi8Fmg2x3iLLNGvBenqw8ukTzb0j
	gePD7XT8lCdFLPkRE4YVnFzrfKy8EC/ywcznjXrAi9IGwFE01E9pWK9Il6MlqVDUJZte67lQFcU
	mg3dTUejIrQCLT0wP+OxduJXfgCYEE140O8tgec7pCxoqXFFuOmVFTq9NKSxEis6HGKD1KDpuP5
	soi6YPkkp/PLfXKm0mhd12RYJX5lgI0QVJTsk1n5YDn1CnK5tfLtwDi6pKZSw9ufc=
X-Received: by 2002:a05:6000:4701:b0:47f:77dc:aaa2 with SMTP id ffacd0b85a97d-47fc854ec44mr4227094f8f.45.1785421481046;
        Thu, 30 Jul 2026 07:24:41 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d708bsm7321145f8f.6.2026.07.30.07.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:24:40 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:24:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <amtepien519U578B@pathway.suse.cz>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729120439.281252-2-john.ogness@linutronix.de>

On Wed 2026-07-29 14:10:33, John Ogness wrote:
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
> clearing of UART_IER during console writing (which will not be
> holding the port lock for atomic printing or KDB/KGDB). This
> allows restoring a lockdep check to serial8250_clear_IER() in
> a follow-up commit.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250.h      |   4 +-
>  drivers/tty/serial/8250/8250_core.c |  65 ++++++--
>  drivers/tty/serial/8250/8250_dw.c   |   2 +-
>  drivers/tty/serial/8250/8250_port.c | 242 +++++++++++++++++++++++-----
>  include/linux/serial_8250.h         |  16 +-
>  5 files changed, 274 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index b62f88eec881f..d672b014ade02 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -178,7 +178,9 @@ static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
>  
>  void serial8250_clear_fifos(struct uart_8250_port *p);
>  void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
> -void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count);
> +void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
> +				       struct nbcon_write_context *wctxt,
> +				       unsigned int count);
>  
>  void serial8250_rpm_get(struct uart_8250_port *p);
>  void serial8250_rpm_put(struct uart_8250_port *p);
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index c0e8a4efbdcc8..5042a8e8c6fb1 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -390,12 +390,34 @@ void __init serial8250_register_ports(struct uart_driver *drv, struct device *de
>  
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
>  
> -static void univ8250_console_write(struct console *co, const char *s,
> -				   unsigned int count)
> +static void univ8250_console_write_atomic(struct console *co,
> +					  struct nbcon_write_context *wctxt)
>  {
>  	struct uart_8250_port *up = &serial8250_ports[co->index];
>  
> -	serial8250_console_write(up, s, count);
> +	serial8250_console_write(up, wctxt, true);
> +}
> +
> +static void univ8250_console_write_thread(struct console *co,
> +					  struct nbcon_write_context *wctxt)
> +{
> +	struct uart_8250_port *up = &serial8250_ports[co->index];
> +
> +	serial8250_console_write(up, wctxt, false);
> +}
> +
> +static void univ8250_console_device_lock(struct console *co, unsigned long *flags)
> +{
> +	struct uart_port *up = &serial8250_ports[co->index].port;
> +
> +	__uart_port_lock_irqsave(up, flags);
> +}
> +
> +static void univ8250_console_device_unlock(struct console *co, unsigned long flags)
> +{
> +	struct uart_port *up = &serial8250_ports[co->index].port;
> +
> +	__uart_port_unlock_irqrestore(up, flags);
>  }
>  
>  static int univ8250_console_setup(struct console *co, char *options)
> @@ -496,12 +518,15 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>  
>  static struct console univ8250_console = {
>  	.name		= "ttyS",
> -	.write		= univ8250_console_write,
> +	.write_atomic	= univ8250_console_write_atomic,
> +	.write_thread	= univ8250_console_write_thread,
> +	.device_lock	= univ8250_console_device_lock,
> +	.device_unlock	= univ8250_console_device_unlock,
>  	.device		= uart_console_device,
>  	.setup		= univ8250_console_setup,
>  	.exit		= univ8250_console_exit,
>  	.match		= univ8250_console_match,
> -	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
> +	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
>  	.index		= -1,
>  	.data		= &serial8250_reg,
>  };
> @@ -584,13 +609,19 @@ void serial8250_suspend_port(int line)
>  	struct uart_8250_port *up = &serial8250_ports[line];
>  	struct uart_port *port = &up->port;
>  
> -	if (!console_suspend_enabled && uart_console(port) &&
> -	    port->type != PORT_8250) {
> -		unsigned char canary = 0xa5;
> +	if (uart_console(port)) {
> +		/* No irq_work may be queued when suspending */
> +		scoped_guard(uart_port_lock_irq, port)
> +			up->console_msr_work_allow = false;
> +		irq_work_sync(&up->console_msr_work);
>  
> -		serial_out(up, UART_SCR, canary);
> -		if (serial_in(up, UART_SCR) == canary)
> -			up->canary = canary;
> +		if (!console_suspend_enabled && port->type != PORT_8250) {
> +			unsigned char canary = 0xa5;
> +
> +			serial_out(up, UART_SCR, canary);
> +			if (serial_in(up, UART_SCR) == canary)
> +				up->canary = canary;
> +		}
>  	}
>  
>  	uart_suspend_port(&serial8250_reg, port);
> @@ -620,6 +651,18 @@ void serial8250_resume_port(int line)
>  		port->uartclk = 921600*16;
>  	}
>  	uart_resume_port(&serial8250_reg, port);
> +
> +	if (uart_console(port)) {
> +
> +		guard(uart_port_lock_irq)(port);
> +
> +		/* irq_work allowed again */
> +		up->console_msr_work_allow = true;
> +
> +		/* Handle any pending MSR changes */
> +		if (up->msr_saved_flags)
> +			serial8250_modem_status(up);
> +	}
>  }
>  EXPORT_SYMBOL(serial8250_resume_port);
>  
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 5fba913f33010..51d026f20825a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -156,7 +156,7 @@ static int dw8250_idle_enter(struct uart_port *p)
>  	 *
>  	 * FIXME: frame_time delay is too long with very low baudrates.
>  	 */
> -	serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
> +	serial8250_fifo_wait_for_lsr_thre(up, NULL, p->fifosize);
>  	ndelay(p->frame_time);
>  
>  	serial_port_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 8c241ec7f4f29..b9ea4f898474e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -704,7 +704,12 @@ static void serial8250_clear_interrupts(struct uart_port *port)
>  	serial_port_in(port, UART_MSR);
>  }
>  
> -static void serial8250_clear_IER(struct uart_8250_port *up)
> +/*
> + * Only to be directly used by serial8250_console_write() and
> + * serial8250_put_poll_char(), which do not require the port lock.
> + * Use serial8250_clear_IER() instead for all other cases.
> + */
> +static void __serial8250_clear_IER(struct uart_8250_port *up)
>  {
>  	if (up->capabilities & UART_CAP_UUE)
>  		serial_out(up, UART_IER, UART_IER_UUE);
> @@ -712,6 +717,11 @@ static void serial8250_clear_IER(struct uart_8250_port *up)
>  		serial_out(up, UART_IER, 0);
>  }
>  
> +static inline void serial8250_clear_IER(struct uart_8250_port *up)
> +{
> +	__serial8250_clear_IER(up);
> +}
> +
>  /*
>   * This is a quickie test to see how big the FIFO is.
>   * It doesn't work at all the time, more's the pity.
> @@ -1284,9 +1294,6 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
>  {
>  	unsigned char mcr = serial8250_in_MCR(p);
>  
> -	/* Port locked to synchronize UART_IER access against the console. */
> -	lockdep_assert_held_once(&p->port.lock);
> -
>  	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
>  		mcr |= UART_MCR_RTS;
>  	else
> @@ -1302,6 +1309,16 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
>  		serial8250_clear_and_reinit_fifos(p);
>  
>  		if (toggle_ier) {
> +			/*
> +			 * Port locked to synchronize UART_IER access against
> +			 * the console. The lockdep_assert must be restricted
> +			 * to this condition because only here is it
> +			 * guaranteed that the port lock is held. The other
> +			 * hardware access in this function is synchronized
> +			 * by console ownership.
> +			 */
> +			lockdep_assert_held_once(&p->port.lock);
> +
>  			p->ier |= UART_IER_RLSI | UART_IER_RDI;
>  			serial_port_out(&p->port, UART_IER, p->ier);
>  		}
> @@ -2053,10 +2070,13 @@ static void serial8250_put_poll_char(struct uart_port *port,
>  
>  	guard(serial8250_rpm)(up);
>  	/*
> -	 *	First save the IER then disable the interrupts
> +	 * First, save the IER, then disable the interrupts. The special
> +	 * variant to clear the IER is used because KDB/KGDB printing
> +	 * is synchronized via CPU quiescence without holding the port
> +	 * lock.
>  	 */
>  	ier = serial_port_in(port, UART_IER);
> -	serial8250_clear_IER(up);
> +	__serial8250_clear_IER(up);
>  
>  	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
>  	/*
> @@ -3198,13 +3218,32 @@ void serial8250_set_defaults(struct uart_8250_port *up)
>  }
>  EXPORT_SYMBOL_GPL(serial8250_set_defaults);
>  
> -void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
> +void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
> +				       struct nbcon_write_context *wctxt,
> +				       unsigned int count)
>  {
>  	unsigned int i;
>  
> +	/*
> +	 * For console writing, enter/exit an unsafe section for each byte
> +	 * in order to pass the ownership as quickly as possible if a higher
> +	 * priority context wants ownership. Otherwise, an attempt to take
> +	 * over the ownership might timeout. The new owner will wait for
> +	 * UART_LSR_THRE before reusing the fifo.
> +	 */
>  	for (i = 0; i < count; i++) {
> -		if (wait_for_lsr(up, UART_LSR_THRE))
> +		bool tx_ready;
> +
> +		if (wctxt && !nbcon_enter_unsafe(wctxt))
>  			return;
> +
> +		tx_ready = wait_for_lsr(up, UART_LSR_THRE);
> +
> +		if (wctxt)
> +			nbcon_exit_unsafe(wctxt);
> +
> +		if (tx_ready)
> +			break;
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, "SERIAL_8250");
> @@ -3213,7 +3252,11 @@ EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, "SERIAL_8250");
>  
>  static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
>  {
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +
>  	serial_port_out(port, UART_TX, ch);
> +
> +	up->console_line_ended = (ch == '\n');
>  }
>  
>  static void serial8250_console_wait_putchar(struct uart_port *port, unsigned char ch)
> @@ -3256,8 +3299,9 @@ static void serial8250_console_restore(struct uart_8250_port *up)
>   * It sends fifosize bytes and then waits for the fifo
>   * to get empty.
>   */
> -static void serial8250_console_fifo_write(struct uart_8250_port *up,
> -					  const char *s, unsigned int count)
> +static void __serial8250_console_fifo_write(struct uart_8250_port *up,
> +					    struct nbcon_write_context *wctxt,
> +					    const char *s, unsigned int count)
>  {
>  	const char *end = s + count;
>  	unsigned int fifosize = up->tx_loadsz;
> @@ -3268,9 +3312,16 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
>  
>  	while (s != end) {
>  		/* Allow timeout for each byte of a possibly full FIFO */
> -		serial8250_fifo_wait_for_lsr_thre(up, fifosize);
> +		serial8250_fifo_wait_for_lsr_thre(up, wctxt, fifosize);
>  
> +		/*
> +		 * Fill the FIFO. If a handover or takeover occurs, writing
> +		 * must be aborted since the string data is no longer valid.
> +		 */
>  		for (i = 0; i < fifosize && s != end; ++i) {
> +			if (!nbcon_enter_unsafe(wctxt))
> +				return;
> +
>  			if (*s == '\n' && !cr_sent) {
>  				serial8250_console_putchar(port, '\r');
>  				cr_sent = true;
> @@ -3278,6 +3329,8 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
>  				serial8250_console_putchar(port, *s++);
>  				cr_sent = false;
>  			}
> +
> +			nbcon_exit_unsafe(wctxt);
>  		}
>  		tx_count = i;
>  	}
> @@ -3286,39 +3339,92 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
>  	 * Allow timeout for each byte written since the caller will only wait
>  	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
>  	 */
> -	serial8250_fifo_wait_for_lsr_thre(up, tx_count);
> +	serial8250_fifo_wait_for_lsr_thre(up, wctxt, tx_count);
> +}
> +
> +static void serial8250_console_fifo_write(struct uart_8250_port *up,
> +					  struct nbcon_write_context *wctxt)
> +{
> +	__serial8250_console_fifo_write(up, wctxt, wctxt->outbuf, wctxt->len);
> +}
> +
> +static void __serial8250_console_byte_write(struct uart_8250_port *up,
> +					    struct nbcon_write_context *wctxt,
> +					    const char *s, unsigned int count)
> +{
> +	struct uart_port *port = &up->port;
> +	const char *end = s + count;
> +
> +	/*
> +	 * Write out the message. If a handover or takeover occurs, writing
> +	 * must be aborted since the string data is no longer valid.
> +	 */
> +	while (s != end) {
> +		if (!nbcon_enter_unsafe(wctxt))
> +			return;
> +
> +		uart_console_write(port, s++, 1, serial8250_console_wait_putchar);
> +
> +		nbcon_exit_unsafe(wctxt);
> +	}
> +}
> +
> +static void serial8250_console_byte_write(struct uart_8250_port *up,
> +					  struct nbcon_write_context *wctxt)
> +{
> +	__serial8250_console_byte_write(up, wctxt, wctxt->outbuf, wctxt->len);
> +}
> +
> +/*
> + * Print the console line using the appropriate variant. If ownership is lost
> + * at any time during printing, the printing is aborted.
> + */
> +static void __serial8250_console_write(struct uart_8250_port *up,
> +				       struct nbcon_write_context *wctxt,
> +				       bool use_fifo)
> +{
> +	/*
> +	 * If the console printer did not fully output the previous line, it
> +	 * must have been handed or taken over. Insert a newline in order to
> +	 * maintain clean output.
> +	 */
> +	if (!up->console_line_ended) {
> +		if (use_fifo)
> +			__serial8250_console_fifo_write(up, wctxt, "\n", 1);
> +		else
> +			__serial8250_console_byte_write(up, wctxt, "\n", 1);
> +	}
> +
> +	if (use_fifo)
> +		serial8250_console_fifo_write(up, wctxt);
> +	else
> +		serial8250_console_byte_write(up, wctxt);
>  }
>  
>  /*
> - *	Print a string to the serial port trying not to disturb
> - *	any possible real use of the port...
> - *
> - *	The console_lock must be held when we get here.
> - *
> - *	Doing runtime PM is really a bad idea for the kernel console.
> - *	Thus, we assume the function is called when device is powered up.
> + * Print a string to the serial port trying not to disturb
> + * any possible real use of the port...
>   */
> -void serial8250_console_write(struct uart_8250_port *up, const char *s,
> -			      unsigned int count)
> +void serial8250_console_write(struct uart_8250_port *up,
> +			      struct nbcon_write_context *wctxt,
> +			      bool is_atomic)
>  {
>  	struct uart_8250_em485 *em485 = up->em485;
>  	struct uart_port *port = &up->port;
> -	unsigned long flags;
> -	unsigned int ier, use_fifo;
> -	int locked = 1;
> -
> -	touch_nmi_watchdog();
> +	unsigned int ier;
> +	bool use_fifo;
>  
> -	if (oops_in_progress)
> -		locked = uart_port_trylock_irqsave(port, &flags);
> -	else
> -		uart_port_lock_irqsave(port, &flags);
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
>  
>  	/*
> -	 *	First save the IER then disable the interrupts
> +	 * First, save the IER, then disable the interrupts. The special
> +	 * variant to clear the IER is used because emergency and panic
> +	 * printing is synchronized only by nbcon ownership without
> +	 * holding the port lock.
>  	 */
>  	ier = serial_port_in(port, UART_IER);
> -	serial8250_clear_IER(up);
> +	__serial8250_clear_IER(up);
>  
>  	/* check scratch reg to see if port powered off during system sleep */
>  	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
> @@ -3352,10 +3458,17 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  		 */
>  		!uart_console_hwflow_active(&up->port);
>  
> -	if (likely(use_fifo))
> -		serial8250_console_fifo_write(up, s, count);
> -	else
> -		uart_console_write(port, s, count, serial8250_console_wait_putchar);
> +	nbcon_exit_unsafe(wctxt);
> +
> +	__serial8250_console_write(up, wctxt, use_fifo);
> +
> +	/*
> +	 * Re-enter an unsafe section in order to perform final actions
> +	 * (such as re-enabling interrupts). If ownership was lost, this
> +	 * context must reacquire ownership.
> +	 */
> +	while (!nbcon_enter_unsafe(wctxt))
> +		nbcon_reacquire_nobuf(wctxt);

If we are going to use this on more locations than I would add
a new API, e.g.

/**
 * nbcon_enter_unsafe_reacquire - Enter an unsafe region in the driver,
 *	reacquire when needed.
 * @wctxt:	The write context that was handed to the write function
 *
 *
 * The function is allowed to reacquire the console ownership to make
 * sure that the caller can enter an unsafe region in the driver.
 *
 * Warning: The caller must not longer access the text buffer. It is
 *	lost when the reacquire was needed. The function is intended
 *	for cleanup operations after emitting the message, for example,
 *	re-enabling interrupts on a used serial port.
 */
void nbcon_enter_unsafe_reacquire(struct nbcon_write_context *wctxt)
{
	while (!nbcon_enter_unsafe(wctxt))
		nbcon_reacquire_nobuf(wctxt);
}

>  
>  	/*
>  	 *	Finally, wait for transmitter to become empty
> @@ -3365,10 +3478,21 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  
>  	if (em485) {
>  		mdelay(port->rs485.delay_rts_after_send);
> +
> +		/* Toggle unsafe after possibly long delay */
> +		nbcon_exit_unsafe(wctxt);
> +		while (!nbcon_enter_unsafe(wctxt))
> +			nbcon_reacquire_nobuf(wctxt);

The comment describes what the code does but it does not explain why.

My first idea was that it would allow to takeover the ownership
as soon as possible in an emergency context.

But the motivation seems to be to reduce the race with a possible
unsafe takeover in the final panic flush, see
https://lore.kernel.org/all/87ecgntf01.fsf@jogness.linutronix.de/

It opens some questions:

First, is it really necessary to finish the clean up when
this CPU is supposed to be stopped and the panic CPU
is about to enter the infinite loop?

Second, it is actually safe in the emergency context?
For example, the mdelay() is there for a reason. Maybe,
we should repeat it when the ownership has been lost here?

Third, is it necessary to call the mdelay() in the unsafe context?

OK, if it is safe in emergency then it does not harm in panic.
And it might be safe in emergency. We could assume that
the nested owner did the delay as well.

See below.

>  		if (em485->tx_stopped)
>  			up->rs485_stop_tx(up, false);
>  	}
>  
> +	/* Toggle unsafe after possibly long delay */
> +	nbcon_exit_unsafe(wctxt);
> +	while (!nbcon_enter_unsafe(wctxt))
> +		nbcon_reacquire_nobuf(wctxt);
>  	serial_port_out(port, UART_IER, ier);
>  
>  	/*
> @@ -3378,11 +3502,25 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  	 *	call it if we have saved something in the saved flags
>  	 *	while processing with interrupts off.
>  	 */
> -	if (up->msr_saved_flags)
> -		serial8250_modem_status(up);
> +	if (up->msr_saved_flags) {
> +		if (is_atomic) {
> +			/*
> +			 * For atomic, MSR handling must be deferred to
> +			 * irq_work because this may be a context that does
> +			 * not permit waking up tasks.
> +			 *
> +			 * But no irq_work may be queued when suspending.
> +			 * In that case, the MSR handling will occur during
> +			 * resume in serial8250_resume_port().
> +			 */
> +			if (up->console_msr_work_allow)
> +				irq_work_queue(&up->console_msr_work);
> +		} else {
> +			serial8250_modem_status(up);
> +		}
> +	}
>  
> -	if (locked)
> -		uart_port_unlock_irqrestore(port, flags);
> +	nbcon_exit_unsafe(wctxt);
>  }

I think about entering unsafe only when really needed.
Instead of releasing it and taking again immediately.

Something like:

	/*
	 * Re-enter an unsafe section in order to perform final actions
	 * (such as re-enabling interrupts). If ownership was lost, this
	 * context must reacquire ownership.
	 */
	nbcon_enter_unsafe_reacquire(wctxt);

	/*
	 *	Finally, wait for transmitter to become empty
	 *	and restore the IER
	 */
	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);

	/*
	 * Exit unsafe section after a potentially long wait. It allows
	 * a safe takeover before another potentially long way. Also
	 * it reduces the race window when a possible unsafe takeover
	 * happened unnoticed.
	 */
	nbcon_exit_unsafe()

	if (em485) {
		u32 delay;

		nbcon_enter_unsafe_reacquire(wctxt);
		delay = port->rs485.delay_rts_after_send;
		nbcon_exit_unsafe(wctxt);

		mdelay(port->rs485.delay_rts_after_send);

		nbcon_enter_unsafe_reacquire(wctxt);
		if (em485->tx_stopped)
			up->rs485_stop_tx(up, false);
		nbcon_exit_unsafe(wctxt);
	}

	nbcon_enter_unsafe_reacquire(wctxt);

	serial_port_out(port, UART_IER, ier);

	/*
	 *	The receive handling will happen properly because the
	 *	receive ready bit will still be set; it is not cleared
	 *	on read.  However, modem control will not, we must
	 *	call it if we have saved something in the saved flags
	 *	while processing with interrupts off.
	 */
	if (up->msr_saved_flags) {
		if (is_atomic) {
			/*
			 * For atomic, MSR handling must be deferred to
			 * irq_work because this may be a context that does
			 * not permit waking up tasks.
			 *
			 * But no irq_work may be queued when suspending.
			 * In that case, the MSR handling will occur during
			 * resume in serial8250_resume_port().
			 */
			if (up->console_msr_work_allow)
				irq_work_queue(&up->console_msr_work);
		} else {
			serial8250_modem_status(up);
		}
	}

	nbcon_exit_unsafe(wctxt);
}

But I have to say that both approaches are quite hairy. I am not sure
if it is worth it.

>  static unsigned int probe_baud(struct uart_port *port)

Otherwise, I do not see any real problems in the code.

Best Regards,
Petr
