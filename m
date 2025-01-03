Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B18169397
	for <linux-serial@vger.kernel.org>; Fri,  3 Jan 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922596; cv=none; b=TpgeFPpPWSovQYTq/h5Uhf2wm/xCsgwIDxTXv7WtGK4ithFb1q8D3XOk98uz7EnWI7xfIKRhYoMkh8p8HKAw4pPmv+KRydNOZsn7QMcjhrO7qBxZBDgb4U64NBodVvodudD6Kopbf0XIvPbLKSLSVYANMkSOcWEW7FqbE6D4tRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922596; c=relaxed/simple;
	bh=j+lM82IXc03OTj1pOCxrS271SCC/nTHabCvEwboID6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf8WQSJGswKr0OLegkBGvmyoePBPQfEzMZR+hx7Dny5Mu2exzQq3eWUfPxgAK+mvzCvHyjzGAWfJCc1wGLe20m80em0zVDbkFMkKtGm7tmQJR/EiphHPUFcJ8BTMRV9OxdYeyION9NukpZXG10yW11ocYTihb7FJk1HVU9burnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bmGlIKG2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bmGlIKG2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso123684735e9.0
        for <linux-serial@vger.kernel.org>; Fri, 03 Jan 2025 08:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735922591; x=1736527391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3c6A5/GJxIkPW+XDvsvsQ6BxdSGRZlVd6K6jUfZBLI=;
        b=bmGlIKG2hcYlX/Pwrk8+JoIcfNThK3WQLmTJkq8RsTxOTAWbiqpl1sfwQFpP3Qbs25
         DLFUMjp2Z/WF+3nxZBwWxmwMb94heqKLK5kxbNi+rOeMNAJ3OjSd/oAnCyGHn8kqi0sq
         BX2y/uWF+iN8HUyw4vUsgALoZvzHxQgmaGNqbv5mbremsDIHfZRWamJvwU9OXt1EFYrn
         53g1x7HK2G3kADCT6zyTd0Yc1bi6AimytoOp9oSnd69ao26xAFgP8+KLBRhx0TW+/XrX
         lpGE6eKhnNBTbNZjLmpC8uFn+IhLwnwd/Ziet2OaisbSf8FoAPp5bsOj7bwtA+tfvByH
         bnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735922591; x=1736527391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3c6A5/GJxIkPW+XDvsvsQ6BxdSGRZlVd6K6jUfZBLI=;
        b=UIm5M1yja/q6ZMshkVvjhVVIQphZ2oQAG+8R/NMcWJ1ECLVUhX3EWVG++YALKsNSs+
         XxI0vdYfF2z4gcjL7D+TY2CIucdyMoI2h2qAv63pvnVjy2MYfe3aHNnlPArtSvgrdYtv
         Y4q2muIR7Lc6Nv9Lq2Bg7qI3A4rD2Vob07NFlFMUj4nsxbZJ3iPiM3j2/4aujdNCeMOl
         QrmAJuUsTWzSl1V+MbeE8cSsF/JMkM/ZjF3ez5A7nERGFA9rH8EX9L2q3Sd4RJkHLvbp
         rXEKB6Lp7sCk4IPGMucm/CQmxmhk2S2UDQZoWoY245XLXGwNqzIkKOhnVL7Sbg41jSsM
         EE2A==
X-Forwarded-Encrypted: i=1; AJvYcCUjWAN5yFTqEqzi6R+Pvisx3HW5bzVMRqnw/Xx6743gMgig9J/UOkWVtBkjBnXWblUwDalGfTnBpMcezzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXNk3GIuywQzVPN+drTdOexzoeT803q+lU+rQhay9AT+DNYEsY
	mbaPD9hTYqXBhEXrThDTmKNYxJOHoTC90lT6t/+JPPktK+ZSse0n254lDv7faYo=
X-Gm-Gg: ASbGncsqmA3aCxsS7J0RCQ44w940mNbEo6eZ4lLLhyig431YWBhu250jSAzJy9JuJ09
	zQK6ronb6V4eT9uYyGdJuaRti+UDvtrnHDPRldeXcxj6GP9JAUie6jv3W2zT2jD02tIdDOQGu4k
	td9hJDYJ0RhBpMF4ribnnDrbXojdpWiX+QJ2Sj9/Q+Z0tDM7H+oMUfTBcFJ7UxyMhGUcCFWDtc6
	PaSuTBSiOVsOvJaNn04tmL39G8SVOq+zCfK/yopzMUz7V+SUs1o5XZjmw==
X-Google-Smtp-Source: AGHT+IEWAPlhknN52jFXYVq75FXJcCnoaBI7o3HRY8Zfa1Gl8wULwEHgc4lReKsw2kOsbSb6LwlxGg==
X-Received: by 2002:a05:600c:3150:b0:436:17e4:ad4c with SMTP id 5b1f17b1804b1-4366835ebefmr397074715e9.6.1735922591046;
        Fri, 03 Jan 2025 08:43:11 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm486981455e9.0.2025.01.03.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:43:10 -0800 (PST)
Date: Fri, 3 Jan 2025 17:43:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matt Turner <mattst88@gmail.com>, Tony Lindgren <tony@atomide.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v4 5/6] serial: 8250: Switch to nbcon console
Message-ID: <Z3gTmicJVLA1tFq5@pathway.suse.cz>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227224523.28131-6-john.ogness@linutronix.de>

On Fri 2024-12-27 23:51:21, John Ogness wrote:
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
> All register access in the callbacks are within unsafe sections.
> The ->write_atomic and ->write_therad() callbacks allow safe
> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER. This will allow to restore the lockdep
> check to serial8250_clear_IER() in a follow-up commit.
> 
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1406,9 +1416,6 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
>  {
>  	unsigned char mcr = serial8250_in_MCR(p);
>  
> -	/* Port locked to synchronize UART_IER access against the console. */
> -	lockdep_assert_held_once(&p->port.lock);

We should explain why it is OK to move the assert.

IMHO, most poeple would not understand the port lock is needed only
for UART_IER manipulation and not for UART_MCR manipulation.

We should probably explain that even the UART_MCR manipulation
is synchronized either by the port lock or by nbcon context
ownership. Where the nbcon context owner ship actually provides
synchronization against the port lock in all situations
except for the final unsafe flush in panic().

In the ideal world it would be nice to check the nbcon context
ownership. But it would require passing struct nbcon_write_context
which does not fit well in this low level API.

A comment might be enough.

Or do I miss something?

> -
>  	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
>  		mcr |= UART_MCR_RTS;
>  	else
> @@ -3339,14 +3356,21 @@ static void serial8250_console_restore(struct uart_8250_port *up)
>  	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
>  }
>  
> -static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
> +static int fifo_wait_for_lsr(struct uart_8250_port *up,
> +			      struct nbcon_write_context *wctxt,
> +			      unsigned int count)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < count; i++) {

This would deserve a comment. The following comes to my mind:

		/*
		 * Pass the ownership as quickly as possible to a higher
		 * priority context. Otherwise, its attempt to take
		 * over the ownership might timeout. The new owner
		 * will wait for lsr before reusing the fifo.
		 */

> +		if (!nbcon_can_proceed(wctxt))
> +			return -EPERM;
> +
>  		if (wait_for_lsr(up, UART_LSR_THRE))
> -			return;
> +			return 0;
>  	}
> +
> +	return -ETIMEDOUT;
>  }
>  
>  /*
> @@ -3356,18 +3380,20 @@ static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
>   * to get empty.
>   */
>  static void serial8250_console_fifo_write(struct uart_8250_port *up,
> -					  const char *s, unsigned int count)
> +					  struct nbcon_write_context *wctxt)
>  {
> -	const char *end = s + count;
>  	unsigned int fifosize = up->tx_loadsz;
>  	struct uart_port *port = &up->port;
> +	const char *s = wctxt->outbuf;
> +	const char *end = s + wctxt->len;
>  	unsigned int tx_count = 0;
>  	bool cr_sent = false;
>  	unsigned int i;
>  
>  	while (s != end) {
>  		/* Allow timeout for each byte of a possibly full FIFO */
> -		fifo_wait_for_lsr(up, fifosize);
> +		if (fifo_wait_for_lsr(up, wctxt, fifosize) == -EPERM)
> +			return;
>  
>  		for (i = 0; i < fifosize && s != end; ++i) {
>  			if (*s == '\n' && !cr_sent) {

We might want to check nbcon_can_proceed() after each character.
I think that you have already suggested this in the reply to Andy.

But maybe, it is not that important because filling the FIFO buffer is
probably fast.

> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -150,8 +150,12 @@ struct uart_8250_port {
>  #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
>  	u16			lsr_saved_flags;
>  	u16			lsr_save_mask;
> +
> +	bool			console_line_ended;	/* line fully output */

I agree with Andy that the comment is confusing. I am sorry if it was
my proposal ;-)

I wonder if the following is better:

	bool			console_line_ended;	/* finished writing full line */

> +
>  #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
>  	unsigned char		msr_saved_flags;
> +	struct irq_work		modem_status_work;
>  
>  	struct uart_8250_dma	*dma;
>  	const struct uart_8250_ops *ops;

Otherwise, it looks good. Well, I might want to double check it
on Monday morning.

Best Regards,
Petr
