Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC391C8FCF;
	Wed, 18 Sep 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671900; cv=none; b=MC8DSbdCx0X2oiWi9naNF9UoycULgb+fmWo0TYCaOysyzNz4wVIW0+pfNvlkxNw3Z07m86B8e79Ia3ti9BmSc/2K2SsPFRcJmSYkkTjEcG9YOkjbqfTG3nRXUTeO+4vIpJ68b5fGamhj9EdS4fPb7aDwPQcg6yGwl45zfKqQUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671900; c=relaxed/simple;
	bh=KZOHTYrM7sWaaT/k68J7aYWJ6cTtNyx7C5pI5fP7c44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FWtqrAjjn7DUSq5f3FFwhBdJpDZvMn7d1iwVTP0jdfhlD0bXUhZdMMgjPDYArsz4hT63+lcqutmH08M1bRBPfKgX29M37wCIL5LgPyddW1wOL3fbzJS5yqi/xzcwlWwz79yNutagfIp1HQGuIV/mOigFN7dCNwjTH8WqG9EwL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mh8hh09f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3FSGE1TO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mh8hh09f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FSGE1TO"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726671893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgFiqUo4lZd5GY/Ax9STZWtlAUWUSNP7tDTa+zMMzqo=;
	b=Mh8hh09fDZtcsWwOj/nQYB/Xzr+A090SLd3IrTBCAU9+O0BRnt9TTpCQ2UbY8QK92/WWwY
	+fY9B+4M3HhIPLMtPLP+CJS/FK9k5MA26RmayKONhq1HZMxSBWRADvvH7Z+0CaxrNwmtBs
	3jxuAcrpxLLXyhSiS/PQ2WNlSGPP5bxoXU2D4sneLJJ5G7bqNkjc1EtkxJ5mDNrV8fblgz
	AejhKQberpsUEZBc2QF+K6aYYijSwFA1zQeFq8iZL62g8b8/6cqFC8J+THNrtFfLbOds3H
	pIfPtT2UMG9O0CwS1mHzjstLt74OXhW++qi2FZq2fsyfrdHSgRDET+JMH1BKfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726671893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgFiqUo4lZd5GY/Ax9STZWtlAUWUSNP7tDTa+zMMzqo=;
	b=3FSGE1TOJEmidSG47ZA+zrwb0K8BW6QWAnKdIEW8FnPFU07YolG7sdyZWfRxMO9A3mShRc
	qN5PTf/wD/N870Dw==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>, Florian
 Fainelli <f.fainelli@gmail.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Rengarajan S <rengarajan.s@microchip.com>,
 Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH next v2 1/4] serial: 8250: Split out IER from
 rs485_start_tx()
In-Reply-To: <ZumWuketXcGQNw49@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-2-john.ogness@linutronix.de>
 <ZumWuketXcGQNw49@pathway.suse.cz>
Date: Wed, 18 Sep 2024 17:10:53 +0206
Message-ID: <84ldzproiy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-17, Petr Mladek <pmladek@suse.com> wrote:
> Sigh, I am trying to review this patch but I am not familiar with the
> code. Feel free to ignore me when the questions are completely off.

I appreciate you researching where the code came from. I made my changes
based on what I see the code doing now.

>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>>  void serial8250_em485_start_tx(struct uart_8250_port *up)
>>  {
>>  	unsigned char mcr = serial8250_in_MCR(up);
>>  
>> +	/*
>> +	 * Some chips set the UART_LSR_DR bit even when UART_IER_RDI is
>> +	 * disabled, so explicitly mask it.
>> +	 */
>>  	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
>> -		serial8250_stop_rx(&up->port);
>> +		up->port.read_status_mask &= ~UART_LSR_DR;
>
> This change is related to disabling UART_IER_RDI but we do not longer
> disable it in this code path.

Correct. It will be disabled in the new wrapper
serial8250_em485_start_tx(). For the console write() callback, RDI is
already being disabled (IER is cleared). It will not use the wrapper.

> Why do we need to do it here, please?

Because the console write() callback also needs to clear LSR_DR. That
part of the callback needs to stay.

> Why is it needed only in the em485-specific path, please?

Only RS485 deals with controlling TX/RX directions.

> On one hand, the comment talks about UART_LSR_DR and UART_IER_RDI
> so seems to be relater.

I do not know if the LSR_DR modify is strictly necessary. I am just
preserving the existing behavior (and related comment). The disabling of
IER_RDI will still happen (via wrapper or explicitly as in the console
write() callback).

>>  static bool start_tx_rs485(struct uart_port *port)
>>  {
>> @@ -1585,7 +1600,7 @@ static bool start_tx_rs485(struct uart_port *port)
>>  	if (em485->tx_stopped) {
>>  		em485->tx_stopped = false;
>>  
>> -		up->rs485_start_tx(up);
>> +		serial8250_rs485_start_tx(up);
>
> If I get this correctly then this keeps the existing behavior when
>
>     up->rs485_start_tx == serial8250_em485_start_tx

Correct.

> Is this always the case, please?

Yes.

> Can start_tx_rs485() be called for the 8250_bcm2835aux.c driver?

Yes.

> Will it still work as expected?

Yes, but it does perform an extra read. And since someone added a
comment just to mention that, I assume it was important for some use
case.

John
