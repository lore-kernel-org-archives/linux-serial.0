Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C8306765;
	Wed, 22 Jul 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731994; cv=none; b=C71I18QEN8RGgmhyxuyCxHRTFvawDHtjLMgalLkhlU0jnhPZ52LQ5htj3JK+dabMMqC4AGNxqw3o1ZThkyzH6+G4LOhNS71rSCBqXETPBbYEgi6rHVbMU7EErIyzSW+BiNcOWB2bNvJZTmTQz09M6hNIDEA/19noi7LksjX6ezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731994; c=relaxed/simple;
	bh=AwxqI4g75BIDk7juHCtklfRdTK4vTpXMfS8pxpKCUBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cToTfmmfePqy8QmmtYc9DI9hDE4SvhNTHA7ziFSB3XR4SxwDevtmb7y+RoOgK9VoLq3/61ay7dv1/l9/U2Uoooru1frgRCV+RirlVnnGT6WZnxXzK1LKecbUGl2LTmlo/s7SrjYGgo/ohZIVHFKr66aDWtzOq/UBEd5iLC2WPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K8ysAgHy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BSg3jJu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K8ysAgHy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BSg3jJu"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784731990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0Ktd66/sn11WexIYGIWENSkZuXhHEggdoS5qrl7i6M=;
	b=K8ysAgHyN238JVGk88qPJNr4L0O8+IIb8x7nwYBNQg7G8D6ccst+lAC7dXOvUvBYbHW7iT
	0MNqcfYDkTWIX1H1dstbng64ZF2yS/oLJnMosXeSPjqpnb68BNdv/30YmzsPlcQm2iNfn6
	eZPiMu1JnVlm4/laSwGwPYwYqtk1i9ELYstXLKr+WcIiQp1QacWsilKs4/nR2chonVNvDs
	94cBi4eniZgmbhvR7qIEP9A2EMm6uhvyrHzvc6BWGP4Ff36YdtGXtFgXC8/0lL6ae3YD/4
	uLxC9CBNi0imug/i/4bQuIJl8bP7YaMl7aAxRLsz29QKs1riN0qtdTSGdwUuiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784731990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0Ktd66/sn11WexIYGIWENSkZuXhHEggdoS5qrl7i6M=;
	b=2BSg3jJusaNVJzQ51RpPmHkaRqpdf+70FneT8VmtlMY5DbkC5TEcHDLXLQXNGrvxZz0jZ4
	vXreixLoaVEL0MCw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek
 <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Stepan Ionichev <sozdayvek@gmail.com>, Kees
 Cook <kees@kernel.org>, Xin Zhao <jackzxcui1989@163.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v8 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <20260722110925.74387-2-john.ogness@linutronix.de>
References: <20260722110925.74387-1-john.ogness@linutronix.de>
 <20260722110925.74387-2-john.ogness@linutronix.de>
Date: Wed, 22 Jul 2026 16:59:09 +0206
Message-ID: <87v7a7cbze.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-22, Sashiko wrote:
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 8c241ec7f4f29..7726cca00d364 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -3198,11 +3218,22 @@ void serial8250_set_defaults(struct uart_8250_port *up)
>>  }
>>  EXPORT_SYMBOL_GPL(serial8250_set_defaults);
>>  
>> -void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
>> +void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
>> +				       struct nbcon_write_context *wctxt,
>> +				       unsigned int count)
>>  {
>>  	unsigned int i;
>>  
>>  	for (i = 0; i < count; i++) {
>> +		/*
>> +		 * Pass the ownership as quickly as possible to a higher
>> +		 * priority context. Otherwise, its attempt to take over
>> +		 * the ownership might timeout. The new owner will wait
>> +		 * for UART_LSR_THRE before reusing the fifo.
>> +		 */
>> +		if (wctxt && !nbcon_can_proceed(wctxt))
>> +			return;
>> +
>>  		if (wait_for_lsr(up, UART_LSR_THRE))
>>  			return;
>>  	}
>
> Does this leave the hardware state vulnerable to corruption during an
> emergency console takeover?
>
> The serial8250_fifo_wait_for_lsr_thre() function polls the UART_LSR
> register by calling wait_for_lsr() and modifies up->lsr_saved_flags
> non-atomically.  Since reading UART_LSR clears hardware error flags
> (parity, framing, overrun, break), concurrent reads can cause one CPU
> to consume and lose the flags before the other can observe them.
>
> Because serial8250_fifo_wait_for_lsr_thre() is called outside the
> nbcon_enter_unsafe() block, the nbcon system might grant a safe
> takeover to an emergency message (e.g. sysrq, panic, or NMI printk)
> preempting this loop, as it assumes no hardware access is taking
> place. The emergency writer will then access the same hardware
> registers concurrently.

Sashiko is correct. I did not know that the serial_lsr_in() macro (used
by wait_for_lsr()) updates @lsr_saved_flags! I looked at the other
serial_lsr_in() call sites and they are all in nbcon unsafe sections.

The for-loop in serial8250_fifo_wait_for_lsr_thre() should look like
this:

	for (i = 0; i < count; i++) {
		/* ... */
		if (wctxt && !nbcon_enter_unsafe(wctxt))
			return;

		if (wait_for_lsr(up, UART_LSR_THRE))
			return;

		if (wctxt)
			nbcon_exit_unsafe(wctxt);
	}

Note that Sashiko already reported [0] this in v7, but I did not look
deep enough at that comment, thinking Sashiko was misunderstanding nbcon
ownership. Instead it was me who was misunderstanding. :-/

John

[0] https://sashiko.dev/#/patchset/20260720135407.3925-1-john.ogness%40linutronix.de
