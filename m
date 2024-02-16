Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873644369
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113516; cv=none; b=nbD03PCoGUDMnjjifzuz5PiRg4M7n9hA056gvP1dYMZ9qXErVKb49wh8a3gzlrrnJNcsKzONv19Cgclx6EQmLEv9EUgxIZZt0tJrgA6VeNAhxnL0NwfLcmjaSPEDoOMAqyOGA8Dl8lyvmNgugZG4vP+nPL/s5+GwaMcASgiMNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113516; c=relaxed/simple;
	bh=Y6CA/0eXmsk2eZWqeDuAH9gz/qp6eh4914mbH0EVdkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=ZG9MSBACjnvrYiSo8u0krk4XpcmeKUsfhLiVXw0/13LSezJWPc2HWpzmEs17fGPX3a5+pfLORam28AseXeHY8DDDBlSC6pbsFpmqJ0QGOB3pVfaYKjctquWDuSN43rmCBL2HhHkfmLxaHfQA0atlTiyz3Kgp1leLgtfN5JkgES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/VtZsd1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/VtZsd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708113511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q2M0pDMLhIbJFR8+0n3bXsPc6PTg3nS9JCcltQaK0U=;
	b=f/VtZsd1HywSq2nifyKt92kgjnri5WXurJEQmD93l9eHr7SFqFZlAHrxgD6QEQOL2h8c9U
	gNjRnR8OBK49X2D2v32gxNiqx1I1NyKWJWhlXnG+QPTsiGidXp0hxQ4GbCQuM5B6b6xzwa
	/6U9cBZaCWGHR3eeFrmFewRcYPIjKNA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-xuOq5FevOcaNQ89w7pDmXQ-1; Fri, 16 Feb 2024 14:58:29 -0500
X-MC-Unique: xuOq5FevOcaNQ89w7pDmXQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c140f965e0so1278838b6e.0
        for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 11:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708113508; x=1708718308;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q2M0pDMLhIbJFR8+0n3bXsPc6PTg3nS9JCcltQaK0U=;
        b=v4Bpsw73loA+OX5ktlyhBKgoZH3bryooESbf/MTYTNxocS9G20kYLUHyXGnj6s0ZUo
         zdpKFJ3yhU0yyVS02JNBc8TK48hG1NqCjTkATqbnAIsH21upreUQ5SuAKYWzxplQB0zw
         aaRtj6+wXv/th10tg0TXvURfXuwLQLe4/yqtNGdUQ2XugSl5/DPwMIMhX+skiSEelDDy
         B1dRMkPSrb8/k6pqKMdryO0yHkNnvQ4UbwLNlyI5WrQQM+AIvm/JAY7St5zceeqKUb9G
         OqxvyJFzdtLXcAZ99zTFTMWmiCpe3FWQXAgzFJEg2H6DRmEvcnyGu/e06Z/3toisFKJ2
         FqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQh0xVaMFeuBgp5bLuvpv6N44HT3eTTPgxmA2jtVXJPsHMwAHMrwnz2OsxyTODmwhV3730zUc2nyg5Uw66OWCfOlcTXKS+8EIuMaXD
X-Gm-Message-State: AOJu0YwIrGoCjeGtPbb+btny3fzmWhuIFUXOgbcrzn9mMYgac+UlXvTv
	U6x3xNZ/bUI8r2L6PP2LH2/pz/vBtUTkaivHrMiAQBzcw/YTbdmTOtUWFrCOLWPYeVbxLLFpNRW
	JPV0Oz2dmKBf+0pAag6q4wRLDMoWxL3uBDJ5Vnvfg0UUCmfUSa7/qbvIuis7SKg==
X-Received: by 2002:a05:6808:624d:b0:3c1:3489:f451 with SMTP id dt13-20020a056808624d00b003c13489f451mr5820939oib.54.1708113508496;
        Fri, 16 Feb 2024 11:58:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0gISsbHtKmdg+cmjm/kbPbQhCGSpGQpDeFj7BkHPIY4wbXdxIi1dqz2qkxCbH7bT8x9gavA==
X-Received: by 2002:a05:6808:624d:b0:3c1:3489:f451 with SMTP id dt13-20020a056808624d00b003c13489f451mr5820924oib.54.1708113508191;
        Fri, 16 Feb 2024 11:58:28 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id lq4-20020a0562145b8400b0068f1275b017sm232911qvb.24.2024.02.16.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:58:27 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/4] tty/serial8250: Make use of IRQ_HANDLED_MANY interface
Date: Fri, 16 Feb 2024 16:58:20 -0300
Message-ID: <Zc--XMryevBFYetZ@LeoBras>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <8c080e51-6ae5-0e8a-69f6-ca3666164248@linux.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-6-leobras@redhat.com> <8c080e51-6ae5-0e8a-69f6-ca3666164248@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 16, 2024 at 12:12:44PM +0200, Ilpo Järvinen wrote:
> On Fri, 16 Feb 2024, Leonardo Bras wrote:
> 
> > For every TX byte an IRQ is requested.
> > On threaded IRQs, the handler calls serial8250_tx_chars can send multiple
> > bytes, limited to it's queue size (tx_loadsz).
> 
> Perhaps I'm missing something here but I don't understand what this tries 
> to say.
> 
> - 8250 driver gets TX empty IRQ
> - We write x bytes to FIFO
> - UART blasts those bits to wire, eventually emptying FIFO
> - We get the next TX empty IRQ
> 
> What in this makes "for every TX byte an IRQ is requested" true? There's 
> one IRQ only for every x bytes TX'ed as far as I can tell!?!
> 

Context:
I created a C program for writting data to the serial by opening /dev/ttyS0 
and fprintf() strings of about 100bytes to it. This fprintf() runs alone in 
a for loop. This is compiled with GCC.

I noticed that it will create an IRQ for every char written to ttyS0.
Maybe I missed something, and this is not a rule, but that's what I 
perceived as an average.

My scenario:
- Linux compiled with force_irqthreads = true
- serial8250 used as a serial terminal (emulated by qemu)

For non-irqthreads it works just fine.

But in this (force_irqthreads = true) scenario the IRQ will get triggered a 
lot of times, and the threaded handler runs only sometimes, which makes it 
easy for the IRQs to be handled in batch, which is fine.

The issue: this causes irqs_unhandled to be incremented once every time 
note_interrupt() did not perceive a change in threads_handled. Since the 
threads_handled increments in batches, it means many of those IRQs will be 
considered "unhandled", leading to the serial8250 IRQ to be disabled.

I created a way (patches 2 & 3) to account for how many IRQ requests have 
actually been handled by a handler, if that handler can deal with them in 
batches. 

This patch is about me trying to make serial8250 report how many IRQs it 
handled, by using the (possibly incorrect) information that it will cause 
1 IRQ per tx-byte.

This 1 IRQ/tx-byte info was perceived by tracing the IRQ count and the 
number of bytes sent. It was also reinforced by serial8250_tx_chars() which 
seems to transmit 1 byte at a time, even though it repeats that up to FIFO 
size (up->tx_loadsz) in that function.

If that proves to be not correct, I will need to find a way of tracking 
the number of IRQs handled in that scenario, so the IRQ disabling thing can 
be avoided.

Does it make sense?

Thanks!
Leo

> -- 
>  i.
> 
> > When this happens, the handler return IRQ_HANDLED with reduces the
> > unhandled IRQ counter only by 1, even though many requests have been
> > handled at once.
> > 
> > This causes the unhandled IRQ counter to go up until it reaches the maximum
> > and causes the registered IRQ to be disabled, thus breaking the serial
> > console.
> > 
> > Make use of the newly introduced IRQ_HANDLED_MANY interface to return the
> > number of requests handled, so the unhandled IRQ counter can get decreased
> > accordingly.
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  include/linux/serial_8250.h         |  2 +-
> >  drivers/tty/serial/8250/8250_core.c | 13 ++++++++-----
> >  drivers/tty/serial/8250/8250_port.c | 16 ++++++++++------
> >  3 files changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> > index ec46e3b49ee99..c9d4271b71d70 100644
> > --- a/include/linux/serial_8250.h
> > +++ b/include/linux/serial_8250.h
> > @@ -200,7 +200,7 @@ int fsl8250_handle_irq(struct uart_port *port);
> >  int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
> >  u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
> >  void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
> > -void serial8250_tx_chars(struct uart_8250_port *up);
> > +int serial8250_tx_chars(struct uart_8250_port *up);
> >  unsigned int serial8250_modem_status(struct uart_8250_port *up);
> >  void serial8250_init_port(struct uart_8250_port *up);
> >  void serial8250_set_defaults(struct uart_8250_port *up);
> > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> > index ae637155fe7cd..2fab9102eec45 100644
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -110,7 +110,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
> >  {
> >  	struct irq_info *i = dev_id;
> >  	struct list_head *l, *end = NULL;
> > -	int pass_counter = 0, handled = 0;
> > +	int pass_counter = 0, handled_total = 0;
> >  
> >  	pr_debug("%s(%d): start\n", __func__, irq);
> >  
> > @@ -120,15 +120,18 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
> >  	do {
> >  		struct uart_8250_port *up;
> >  		struct uart_port *port;
> > +		int handled;
> >  
> >  		up = list_entry(l, struct uart_8250_port, list);
> >  		port = &up->port;
> >  
> > -		if (port->handle_irq(port)) {
> > -			handled = 1;
> > +		handled = port->handle_irq(port);
> > +		if (handled) {
> > +			handled_total += handled;
> >  			end = NULL;
> > -		} else if (end == NULL)
> > +		} else if (end == NULL) {
> >  			end = l;
> > +		}
> >  
> >  		l = l->next;
> >  
> > @@ -140,7 +143,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
> >  
> >  	pr_debug("%s(%d): end\n", __func__, irq);
> >  
> > -	return IRQ_RETVAL(handled);
> > +	return IRQ_RETVAL_MANY(handled_total);
> >  }
> >  
> >  /*
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index f799c34f1603c..74d53507a73d4 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1802,7 +1802,7 @@ u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr)
> >  }
> >  EXPORT_SYMBOL_GPL(serial8250_rx_chars);
> >  
> > -void serial8250_tx_chars(struct uart_8250_port *up)
> > +int serial8250_tx_chars(struct uart_8250_port *up)
> >  {
> >  	struct uart_port *port = &up->port;
> >  	struct circ_buf *xmit = &port->state->xmit;
> > @@ -1810,15 +1810,15 @@ void serial8250_tx_chars(struct uart_8250_port *up)
> >  
> >  	if (port->x_char) {
> >  		uart_xchar_out(port, UART_TX);
> > -		return;
> > +		return 0;
> >  	}
> >  	if (uart_tx_stopped(port)) {
> >  		serial8250_stop_tx(port);
> > -		return;
> > +		return 0;
> >  	}
> >  	if (uart_circ_empty(xmit)) {
> >  		__stop_tx(up);
> > -		return;
> > +		return 0;
> >  	}
> >  
> >  	count = up->tx_loadsz;
> > @@ -1858,6 +1858,9 @@ void serial8250_tx_chars(struct uart_8250_port *up)
> >  	 */
> >  	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
> >  		__stop_tx(up);
> > +
> > +	/* Return number of chars sent */
> > +	return up->tx_loadsz - count;
> >  }
> >  EXPORT_SYMBOL_GPL(serial8250_tx_chars);
> >  
> > @@ -1923,6 +1926,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
> >  	bool skip_rx = false;
> >  	unsigned long flags;
> >  	u16 status;
> > +	int handled = 0;
> >  
> >  	if (iir & UART_IIR_NO_INT)
> >  		return 0;
> > @@ -1956,14 +1960,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
> >  	serial8250_modem_status(up);
> >  	if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
> >  		if (!up->dma || up->dma->tx_err)
> > -			serial8250_tx_chars(up);
> > +			handled = serial8250_tx_chars(up);
> >  		else if (!up->dma->tx_running)
> >  			__stop_tx(up);
> >  	}
> >  
> >  	uart_unlock_and_check_sysrq_irqrestore(port, flags);
> >  
> > -	return 1;
> > +	return handled ? : 1;
> >  }
> >  EXPORT_SYMBOL_GPL(serial8250_handle_irq);
> >  
> > 
> 

