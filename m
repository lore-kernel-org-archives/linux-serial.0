Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66B535DC
	for <linux-serial@vger.kernel.org>; Tue, 17 Sep 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584527; cv=none; b=YXcRl0QjX0Re40FDqaUqBTGasmzHvL/SlXjWtcxVt1h/EmWEFcuzVbFIPsuPLwCQrkazEyxJBvRfT8qxALveobM5yTB3B1kueBeeBkHD+XW3rzCFa/t3+L5Me/Oj+giIUqumXszUlM/UPyAunPPoMr5x3gJHXdXSS4DRcSA7EDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584527; c=relaxed/simple;
	bh=4uIK60EGaW6dVjNViNGIwWxFwwNR/9uuqLGHsgbYNc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWKhR60hPvysysYUUJjS93eKZsxCklXM0aqA06+CvVvc2wC1b/fP76/zbfAoxhlE1Tbk3RUm/4CJpYa2d1N8TJZp+JLf5/NcUKgzOvOTumXoesUPpNZShctoMkeMf3yKrqD9kWjWIL6isjOMuS+2jGfgAsZzcRs19JqSZqXK9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U1rc3TZN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U1rc3TZN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374d29ad870so2963888f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 17 Sep 2024 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726584524; x=1727189324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXDqTY064KNEq97yK926UATT+WBft9fL/VhHHBwl5bE=;
        b=U1rc3TZNvJTf9dNFnvMDZehGz9sVj1jOrNeAsOm+vlXkQoRMmJWPt9rb5EjN0wThH7
         FC2dfS/GfTXbEdeXkbV437b9kfP5cUuzkKFrSwaZ0JyqrYepYuUZ8rT2vGUs08Er7AbN
         THbD7lolzR9ysjwldOR2390EIQh4YEFqlZ8KpVh67yvpe4pqSpZ974P+05evVOgsSK1Q
         aSgGO3WVCazBsdwiNCKI3mmnn5yK9zBkFU9HcIy51PCvmnt6djCUqAt5x11ov0uPL9aB
         howf/8itIifIKChpdDqa45r+CYuG5UTMQZMDP3Ya4X+czq2wEEvJJsidiK4pMFtLPm37
         hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726584524; x=1727189324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXDqTY064KNEq97yK926UATT+WBft9fL/VhHHBwl5bE=;
        b=EsswOMVqVMn3Fe5xvGaW+2gysKy1yTLPPf4+cXrgOGW0qFNRjo+N1dBksjuvEX5Puw
         rQUFRjiJsxTfijIDruAsok1sIxr+lwWdS9RYVG/lP4+toqPa0PFnMs5vAORbzoSvncDi
         EdrUgyoDyo8yvLIk6U2lg1bGIevM4zWMic6ZjV3nbUg9U544Kp9ATZSVxL6fezgLHg1K
         B08U5dR4Kf6CHoz0VKHaXQEZu2whLHMVZG0peQqX7rxFUaEur/EYtXX2w1VcwDFhBdrf
         BLhARNUpp/l9i+MQxJd82X0y1MKJuV3wzg0jMFyFEE8WyddjQrj2AbheUanZFelp1oPF
         JDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt0+i9hsX9U9S5+XOCsB5ogJLBcoe8h63IUsx8xvxp0KFtgbzyaFbVm+PeXpnQMCZ6myQi1CqS+9mnDmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxVE9pF5tBnCDf2Mmoe9DU5EgTyk/JIUlGW26J2TbX6Q7kQeU
	ZWkNtGIvHyQYKSpBLdFxUqzCUwNA6xmhgo0sZtsWkFw6LtUYe/ftphcNl9rbL0w=
X-Google-Smtp-Source: AGHT+IGEmOVQE8uhUKC3WlhBdCfEe4ALXQuvED5sUykC8fxO080mg9b5sZyFqp/kwmVWyffuaG5TzA==
X-Received: by 2002:a05:6000:25c:b0:371:8688:1660 with SMTP id ffacd0b85a97d-378d625a53cmr6960061f8f.51.1726584523556;
        Tue, 17 Sep 2024 07:48:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b97544sm5480696b3a.146.2024.09.17.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:48:41 -0700 (PDT)
Date: Tue, 17 Sep 2024 16:48:26 +0200
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
	Sunil V L <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH next v2 1/4] serial: 8250: Split out IER from
 rs485_start_tx()
Message-ID: <ZumWuketXcGQNw49@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140538.221708-2-john.ogness@linutronix.de>

On Fri 2024-09-13 16:11:35, John Ogness wrote:
> Move IER handling out of rs485_start_tx() callback and into a new
> wrapper serial8250_rs485_start_tx(). Replace all callback call sites
> with wrapper, except for the console write() callback, where it is
> inappropriate to modify IER.

Sigh, I am trying to review this patch but I am not familiar with the
code. Feel free to ignore me when the questions are completely off.

> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1370,7 +1370,6 @@ static void serial8250_stop_rx(struct uart_port *port)
>  	serial8250_rpm_get(up);
>  
>  	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
> -	up->port.read_status_mask &= ~UART_LSR_DR;
>  	serial_port_out(port, UART_IER, up->ier);
>  
>  	serial8250_rpm_put(up);
> @@ -1543,16 +1542,20 @@ static inline void __start_tx(struct uart_port *port)
>   *
>   * Generic callback usable by 8250 uart drivers to start rs485 transmission.
>   * Assumes that setting the RTS bit in the MCR register means RTS is high.
> - * (Some chips use inverse semantics.)  Further assumes that reception is
> - * stoppable by disabling the UART_IER_RDI interrupt. (Some chips set the
> - * UART_LSR_DR bit even when UART_IER_RDI is disabled, foiling this approach.)
> + * (Some chips use inverse semantics.)
> + * It does not disable RX interrupts. Use the wrapper function
> + * serial8250_rs485_start_tx() if that is also needed.
>   */
>  void serial8250_em485_start_tx(struct uart_8250_port *up)
>  {
>  	unsigned char mcr = serial8250_in_MCR(up);
>  
> +	/*
> +	 * Some chips set the UART_LSR_DR bit even when UART_IER_RDI is
> +	 * disabled, so explicitly mask it.
> +	 */
>  	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
> -		serial8250_stop_rx(&up->port);
> +		up->port.read_status_mask &= ~UART_LSR_DR;

This change is related to disabling UART_IER_RDI but we do not longer
disable it in this code path.

Why do we need to do it here, please?
Why is it needed only in the em485-specific path, please?


I tried to understand the code and am in doubts:

On one hand, the comment talks about UART_LSR_DR and UART_IER_RDI
so seems to be relater.

But the "Some chips set..." comment has been added by the commit
058bc104f7ca5c83d81 ("serial: 8250: Generalize rs485 software emulation").
And I do not see any explanation why it was added in this code path
even though UART_LSR_DR and UART_IER_RDI were manipulated in
serial8250_stop_rx() which can be called also in other code
paths via uport->ops->stop_rx().

Also the comment suggests that this fixes a bug in some chips but
the line has been added into 1.1.60 back in 2007.

--- a/drivers/char/ChangeLog
+++ b/drivers/char/ChangeLog
@@ -1,3 +1,28 @@
+Sat Oct 29 18:17:34 1994  Theodore Y. Ts'o  (tytso@rt-11)
+
+	* serial.c (rs_ioctl, get_lsr_info): Added patch suggested by Arne
+		Riiber so that user mode programs can tell when the
+		transmitter shift register is empty.
+
+Thu Oct 27 23:14:29 1994  Theodore Y. Ts'o  (tytso@rt-11)
+
+	* tty_ioctl.c (wait_until_sent): Added debugging printk statements
+		(under the #ifdef TTY_DEBUG_WAIT_UNTL_SENT)  
+
+	* serial.c (rs_interrupt, rs_interrupt_single, receive_chars,
+		change_speed, rs_close): rs_close now disables receiver
+		interrupts when closing the serial port.  This allows the
+		serial port to close quickly when Linux and a modem (or a
+		mouse) are engaged in an echo war; when closing the serial
+		port, we now first stop listening to incoming characters,
+		and *then* wait for the transmit buffer to drain.  
+
+		In order to make this change, the info->read_status_mask
+		is now used to control what bits of the line status
+		register are looked at in the interrupt routine in all
+		cases; previously it was only used in receive_chars to
+		select a few of the status bits.
+
--- a/drivers/char/serial.c
+++ b/drivers/char/serial.c
[...]
@@ -1780,6 +1830,15 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 		info->normal_termios = *tty->termios;
 	if (info->flags & ASYNC_CALLOUT_ACTIVE)
 		info->callout_termios = *tty->termios;
+	/*
+	 * At this point we stop accepting input.  To do this, we
+	 * disable the receive line status interrupts, and tell the
+	 * interrut driver to stop checking the data ready bit in the
+	 * line status register.
+	 */
+	info->IER &= ~UART_IER_RLSI;
+	serial_out(info, UART_IER, info->IER);
+	info->read_status_mask &= ~UART_LSR_DR;
 	if (info->flags & ASYNC_INITIALIZED) {
 		wait_until_sent(tty, 3000); /* 30 seconds timeout */
 		/*

    => It looks like it was not a fix for a "buggy chips". It looks
       like it was part of the design.

>  
>  	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
>  		mcr |= UART_MCR_RTS;
> @@ -1562,6 +1565,18 @@ void serial8250_em485_start_tx(struct uart_8250_port *up)
>  }
>  EXPORT_SYMBOL_GPL(serial8250_em485_start_tx);
>  
> +/**
> + * serial8250_rs485_start_tx() - stop rs485 reception, enable transmission
> + * @up: uart 8250 port
> + */
> +void serial8250_rs485_start_tx(struct uart_8250_port *up)
> +{
> +	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
> +		serial8250_stop_rx(&up->port);
> +
> +	up->rs485_start_tx(up);
> +}
> +
>  /* Returns false, if start_tx_timer was setup to defer TX start */
>  static bool start_tx_rs485(struct uart_port *port)
>  {
> @@ -1585,7 +1600,7 @@ static bool start_tx_rs485(struct uart_port *port)
>  	if (em485->tx_stopped) {
>  		em485->tx_stopped = false;
>  
> -		up->rs485_start_tx(up);
> +		serial8250_rs485_start_tx(up);

If I get this correctly then this keeps the existing behavior when

    up->rs485_start_tx == serial8250_em485_start_tx

Is this always the case, please?

The callback has been added by the commit 058bc104f7ca5c83d81
("serial: 8250: Generalize rs485 software emulation") because
8250_bcm2835aux.c driver needed to do something else.

Can start_tx_rs485() be called for the 8250_bcm2835aux.c driver?
Will it still work as expected?

>  
>  		if (up->port.rs485.delay_rts_before_send > 0) {
>  			em485->active_timer = &em485->start_tx_timer;

Best Regards,
Petr
