Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B21DE3AE
	for <linux-serial@vger.kernel.org>; Mon,  6 Jan 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172036; cv=none; b=l6KQBr/xdetlIUITU0lWBSbwf05FpY/tFHzVqpYEElpyy1HUpVjZX70SG9Bp2M4GLEMqgnddHdw/Xqka0lfeNzwohWC/GzkNQo/ND+EblSIB7acJUoaGZdHK9fZvD+/cz9ADTkJEUtIBg7SwP53Ilghb495KI2m2+hpzeUXL60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172036; c=relaxed/simple;
	bh=1BNqprANFARLX7QiedDZOdix7i0iUCsfKc05vZpKdYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB17hzSGE1caZrSCzKlM7dj5HwQ2L7wM8Sl2H/nLry9ujwB0Ft7mduWrfEJY03jN3ILPgBP3WXlzhqNaVWHnINCj1qZqcb0T/MqDK9Q85Dv8Ohha3rkRxhRQczzX/4Xna7rumeNMPkOUOGkcMaUg6HDwoDJvhgpcdpqXkoddUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U2FyV+A1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U2FyV+A1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43621d27adeso99697115e9.2
        for <linux-serial@vger.kernel.org>; Mon, 06 Jan 2025 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736172032; x=1736776832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4YVUyvlmLs4ShZ5WoAXv9zQ/4rn/hNmmIlIQjqYU1c=;
        b=U2FyV+A1hghsyg7FXeajjfWcvfmuyOXCourdYHvvt5OnxyrQAZQWVUA6/fLabjckDW
         iWUKm4gJSQvNGhLpFVbK4evhbwHPkN7yjd9NO1kCJdeYpBC4dndX9kQ4VHxGRKbW+3ut
         TwVM+A71p7+OtjsFNVEPGPScvpda2fb5P4nu8KlH+Vcege+7IZMRQ6KBKODOtt2Ucfet
         j3oLruni1Zb4XvUIOQmhNv3/yXElvTg5YIZElW08IYGbd8zyOevRuvPH7dRc+TWeAgWo
         kttAPEKOq2ZMeF6n/fYCJdnS6LM8dUEAAtYP+0xRSaH8yK1hK85FDBdJSF/0BcO7hilQ
         dTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736172032; x=1736776832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4YVUyvlmLs4ShZ5WoAXv9zQ/4rn/hNmmIlIQjqYU1c=;
        b=hVzLHeozQzu2WlwEATN84Z5gCby8adkJCV6dz1aT+QfSY/HuejtG0xo8P4CpPanq9c
         FDRLG/l9Fn0JWptUTZMx8stgkWorNSufdNJewl53Du7d1XUjtqkoJa2VDiP4KSos+v/a
         W4G2d6UY8NswTKNR52nvepCEQ4vZR9jqMMms/buZy7Oc8TFlulLd4IF+oXKqH1wNfSNP
         dXElFMduXxJx2D5tepUzyyOdUMyRF7v73t+ThIwp9tIMa+nljy3UgzomovoE4wa1/3VW
         HnTPvXQykQ6AQSkkEr1M8wpABhrf4si6nIcgT3K8kCSpAT9x2UwkiCY0bj71uz1dI0py
         DamA==
X-Forwarded-Encrypted: i=1; AJvYcCXuJcmztD0qjuvQNRRz8jYoF1pF3JMqeeQO38eWaFUGQm3/nWRYWkiXHFSMmJKN9jaoHN3qA6+25lIW07k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEwBEPkfklGybRjJoWaDTE9iFXIxD58sMuJwK2X1PYvHgjxes
	KylCAWl8almEISEQUhbWB/zEUH0AnUA+81T6p+TqpjjV+GFa+Yx8tmbeyx04pws=
X-Gm-Gg: ASbGncvTceJDcbwX8RkS31ldqhoSgxlJblItD/hYt9Bgg6nUEC9ctEX1M4ProkcNq0h
	uUP3i0+LIiwCPuuunQQxd0wq3as3v5xg0zLgRPdzae8rwmvNLrscNC7vfu998YGMvwA4Wt2P63n
	2LWtcAfdzlqBJ5qsmJsnD0nVw6Ii6MU7myuOvKiv3An4FIBbKNazyLTSvPoQDQol4t8qFzgbN3A
	httzGG9OnZ360FxkKe6XJhMityqNP+PgFhE+28hYz7TjKbF5FBZM4ahlw==
X-Google-Smtp-Source: AGHT+IEqaDb8lNaJ2brtbrHX0OiZbuauW9GLm6TzQr7FyD4aBcCJ9xDlwVNH3hoY7B3x4d3Qs9SuiQ==
X-Received: by 2002:a05:6000:1848:b0:385:f220:f798 with SMTP id ffacd0b85a97d-38a221f3001mr38289712f8f.6.1736172031927;
        Mon, 06 Jan 2025 06:00:31 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm565553555e9.24.2025.01.06.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:00:31 -0800 (PST)
Date: Mon, 6 Jan 2025 15:00:28 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Sunil V L <sunilvl@ventanamicro.com>,
	Matt Turner <mattst88@gmail.com>, Stefan Wahren <wahrenst@gmx.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty-next v4 4/6] serial: 8250: Provide flag for IER
 toggling for RS485
Message-ID: <Z3vh_Bi8tgu_dKvH@pathway.suse.cz>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-5-john.ogness@linutronix.de>
 <Z3gCeP_P7VPpcOLA@pathway.suse.cz>
 <84jzbaxg13.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84jzbaxg13.fsf@jogness.linutronix.de>

On Sun 2025-01-05 01:32:00, John Ogness wrote:
> On 2025-01-03, Petr Mladek <pmladek@suse.com> wrote:
> > My understanding is that the nested IER manipulation does not
> > harm.
> 
> This statement implies that it is OK for UART_IER_RLSI|UART_IER_RDI bits
> to be set in UART_IER even though the console will write to UART_TX,
> because the _nesting_ contexts would set those bits rather than
> restoring the original value of 0x0.

This is a misunderstanding. I am sorry I was not clear enough.

To be more clear. By the nested context I meant

	if (em485) {
		if (em485->tx_stopped)
			up->rs485_start_tx(up);

call by serial8250_console_write(). The original code did:

	+ up->rs485_start_tx()
	  + serial8250_em485_start_tx()
	    + serial8250_stop_rx()

, where serial8250_stop_rx() cleared the flags:

static void serial8250_stop_rx(struct uart_port *port)
{
[...]
	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
	serial_port_out(port, UART_IER, up->ier);
[...]
}

But the flags were already cleared by:

	__serial8250_clear_IER(up);

called by serial8250_console_write() _earlier_. Which did:

static void __serial8250_clear_IER(struct uart_8250_port *up)
{
	if (up->capabilities & UART_CAP_UUE)
		serial_out(up, UART_IER, UART_IER_UUE);
	else
		serial_out(up, UART_IER, 0);

}


It means that the nested serial8250_stop_rx() did not change anything.
It was a NOP. The bits were already cleared.

Similar, the counter part. The bits were later set by

	up->rs485_stop_tx(up)

which did:

	+ serial8250_em485_stop_tx

void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
{
[...]
	p->ier |= UART_IER_RLSI | UART_IER_RDI;
	serial_port_out(&p->port, UART_IER, p->ier);
[...]
}

But it was after the writing the message so that it did not affect
the operation.

> I ran some tests and leaving these bits set during Tx does not appear to
> cause an issue, but it is difficult to say because the context
> interrupted by a nesting context will only print at most 1
> character. Also, it is writing under spin_lock_irqsave() so that might
> be masking any effects. Perhaps UART_IER is temporarly cleared because
> of other bits that would cause problems during Tx?
> 
> I would need to create a specific test to investigate this
> further. Regardless, it still is a cosmetic ugliness that bits are not
> being properly restored, even if it turns out these particular bits are
> not problematic during Tx.

I think that you do not need to investigate it further. We should keep
IER cleared when writing the message.


> > All in all, the patch looks good to me.
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Thanks for the review. I interpret it to mean that I do not need to make
> any changes to this patch for v5.

Yup, I am fine with the patch as it is.

Best Regards,
Petr
