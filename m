Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E328175B
	for <linux-serial@vger.kernel.org>; Wed, 18 Sep 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653215; cv=none; b=PgaxVXHnFTWmdS/uhmPeAkn08jNVByr5f6un+o01ef9G7MqpJF8zJegBOXQ8FeQkNsO/SD6PHVGYBzqBpiEL+08/D2pL6yQcBKUMHNMPvS/NQNvtTzsKI5rOT/L4v3DhflNBm7AWmukbNrzP/GPH2UullaNbH1lDLItBMoct0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653215; c=relaxed/simple;
	bh=qX3WYQ6+Vf/oHkvyYC7tQqdcfeK8ooGc7TQuG0J4/8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5yrH0sUbSOF5NTjbhaM577WF2P3GjlMuWHSLhsimG2ZOlBgQCU3XiUKNfvUBv29OceO/aW3LUDN/a0oqfGCtUdViNQIy/kM+3zPPbnv7N1+k66qrl/51JErH7YqtxNftDD7K5qDa7Nh8xyTTL5LqTH5Bay2UA8tkl97a1GkkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UG5uqqPU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UG5uqqPU"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5367ae52a01so5986477e87.3
        for <linux-serial@vger.kernel.org>; Wed, 18 Sep 2024 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726653211; x=1727258011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upynp3eGtaZUvy8FwKmWHNrTSvjQZK+dz1216GoCigI=;
        b=UG5uqqPUAAKks/48aphmRg6pW8eGj0PYXA8UNzrGuQSZDFTEKx/4l+DhAZfUSBHUKN
         l05E2ZqqzDHiS/DPiUqxaFNqHl1cbDUOZ1l7ORZ72Y81Pp0BNsSesEK6ZGCDivu6c6y1
         5hhRNfuobukU9dhjxQayGxDsxycpK9S7/XVXmPv2FeMY9E+XhWCeYD7PXHObeTJ2SknF
         k8zq7TPP5yTdnm+8cSt631YXy6jNppLAJFHenmJhqSMSZmBDXMOc6fE3p7QdVydahug3
         XIntAojmfJA+MXFxWzFlZiYSVqI5vN2jegbPyw9nqE4und4kQLSt++/4XDHOd1PhZXon
         qAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653211; x=1727258011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upynp3eGtaZUvy8FwKmWHNrTSvjQZK+dz1216GoCigI=;
        b=ipXX1O9YySZTzjStAt4PoMr4P25YGSOEv3U80ivO0APK4ALjwT3SjylYmJwX41aFov
         W/dkRqWPwavWhJBMWiCTqFExN75udjse7VHjDSEmTYWOEDuMg6mteoqbKvsOEWpr1Wlv
         2bGtWNBZRXjRjMic+uswqMacna0u2VC1mXmCrDZvfavzcGXDeyXUq4Gbij/niLscux/o
         h9ITYKfMe4joLVh9lcF8MIuHdUDanfeuJ5l7vZgY1OPSrgf/FOZ71sPQURuMZ6m4zBB8
         S6GJaraJ+ShNxme8rLEgPoVB5HQTC0cC6C4lihqFu03OGOGYIEH7S7lMHATlUdiGLVZE
         XwFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8bC/91MsVYZDbDzs8DF9tQYXSuB+DEl9zHKv2rhFu8bi2r9NpO3b33eo6ydcmxog7fl8i6PGNQSHslDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6JruFHR1+i5jxc/LLgx2rO6aLN85Asa3GKfTnQ+3KiLiLo6l
	IdNB1L3cytK6A14sgxIF5fdhBlZQiIa8PcfQ1rtbWy0lrA5dL+eGWKw5XeRx2yAZf9KXdZX8rep
	U
X-Google-Smtp-Source: AGHT+IHpLFVaei2ayXOSJPg4gOV/F1ms9cHgsY6XrAy2tPIaJLJ7WLMBOrHs/jINB0vWDzucU8A1WA==
X-Received: by 2002:a05:6512:6c3:b0:533:4652:983a with SMTP id 2adb3069b0e04-5367fef1846mr10734532e87.35.1726653211318;
        Wed, 18 Sep 2024 02:53:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d19cfsm61744945ad.157.2024.09.18.02.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:53:30 -0700 (PDT)
Date: Wed, 18 Sep 2024 11:53:12 +0200
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>, Udit Kumar <u-kumar1@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH next v2 2/4] serial: 8250: Split out IER from
 rs485_stop_tx()
Message-ID: <ZuqjCN18dSUDEa0d@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140538.221708-3-john.ogness@linutronix.de>

On Fri 2024-09-13 16:11:36, John Ogness wrote:
> Move IER handling out of rs485_stop_tx() callback and into a new
> wrapper serial8250_rs485_stop_tx(). Replace all callback call sites
> with wrapper, except for the console write() callback, where it is
> inappropriate to modify IER.

It would be great to provide more details:

  + why it is done (IER modification requires port lock?)

  + why it is suddenly safe to call serial8250_em485_handle_stop_tx()
    without holding &p->port.lock


> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -558,7 +558,7 @@ static int serial8250_em485_init(struct uart_8250_port *p)
>  
>  deassert_rts:
>  	if (p->em485->tx_stopped)
> -		p->rs485_stop_tx(p);
> +		serial8250_rs485_stop_tx(p);

This would keep the same functionality only when

	p->rs485_stop_tx == serial8250_em485_stop_tx

Is it always the case?
Is it OK when it is not the case?

For example, serial8250_em485_init() is involved in bcm2835aux driver
probe which uses another rs485_stop_tx() callback, see below.

>  
>  	return 0;
>  }
> @@ -1397,16 +1396,29 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
>  	/*
>  	 * Empty the RX FIFO, we are not interested in anything
>  	 * received during the half-duplex transmission.
> -	 * Enable previously disabled RX interrupts.
>  	 */
> -	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> +	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
>  		serial8250_clear_and_reinit_fifos(p);
> +}
> +EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
> +
> +/**
> + * serial8250_rs485_stop_tx() - stop rs485 transmission, restore RX interrupts
> + * @p: uart 8250 port
> + */
> +void serial8250_rs485_stop_tx(struct uart_8250_port *p)
> +{
> +	/* Port locked to synchronize UART_IER access against the console. */
> +	lockdep_assert_held_once(&p->port.lock);
> +
> +	p->rs485_stop_tx(p);
>  
> +	/* Enable previously disabled RX interrupts. */
> +	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
>  		p->ier |= UART_IER_RLSI | UART_IER_RDI;
>  		serial_port_out(&p->port, UART_IER, p->ier);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
>  
>  static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
>  {
> @@ -1418,7 +1430,7 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
>  	serial8250_rpm_get(p);
>  	uart_port_lock_irqsave(&p->port, &flags);
>  	if (em485->active_timer == &em485->stop_tx_timer) {
> -		p->rs485_stop_tx(p);
> +		serial8250_rs485_stop_tx(p);

This causes that UART_IER is manipulated for all p->rs485_stop_tx()
callbacks. Is that correct, please?

For example, it seems serial8250_em485_handle_stop_tx() might be used
also by bcm2835aux driver. It set by:

static int serial8250_em485_init(struct uart_8250_port *p)
{
	[...]
	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
	[...]
}

which is called via

int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
			    struct serial_rs485 *rs485)
{
	[...]
	if (rs485->flags & SER_RS485_ENABLED)
		return serial8250_em485_init(up);
	[...]
}

which is set by:

static int bcm2835aux_serial_probe(struct platform_device *pdev)
{
	[...]
	up.port.rs485_config = serial8250_em485_config;		<--------
	[...]
	up.rs485_stop_tx = bcm2835aux_rs485_stop_tx;
	[...]
}

But this same _probe() call sets

	up.rs485_stop_tx = bcm2835aux_rs485_stop_tx;

which does not manipulate UART_IER.

>  		em485->active_timer = NULL;
>  		em485->tx_stopped = true;
>  	}
> @@ -1450,7 +1462,7 @@ static void __stop_tx_rs485(struct uart_8250_port *p, u64 stop_delay)
>  		em485->active_timer = &em485->stop_tx_timer;
>  		hrtimer_start(&em485->stop_tx_timer, ns_to_ktime(stop_delay), HRTIMER_MODE_REL);
>  	} else {
> -		p->rs485_stop_tx(p);
> +		serial8250_rs485_stop_tx(p);

I can't find easily whether serial8250_em485_stop_tx() is always set
as p->rs485_stop_tx callback here. I would expect that it might be
another callback. It is a callback after all.

Is it always safe?

>  		em485->active_timer = NULL;
>  		em485->tx_stopped = true;
>  	}

Best Regards,
Petr
