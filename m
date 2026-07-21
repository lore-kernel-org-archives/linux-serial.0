Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E994C900F;
	Tue, 21 Jul 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645620; cv=none; b=mtXPXvjsyhkuatz97V6jev2sYQYS8GIyn5QexEdUBHF8CGiCb5f0iTEfKmcOTjHudQRCwOVV2c0I9zY02nE0gSQQqjoRSh8gKDkadefYK2+NjiW5Dt5GUu53a/QsU/hctBm5Gc5UmjJg4sjrz+Oa4cQ5vPtVhIxByZ7ukuODZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645620; c=relaxed/simple;
	bh=ti0Xi4/ODz42Ys/vabDhPf9PQ35xAOkddWHIqDxt5RI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hIB82QpOHzxfWAdND4UakwUBMGSQRGDXmgUCe5yNlZ89ID8yTGR0sekqg51fGg/tBSYIxMgSyBdtFYD9fleJ75evqpBapnDwZqUsG41WSJiiGmrr/FTIdUq1aRp2sRKSLwAUemj01NA5m8ljCwAEiabrj02O6oKUDlL65V3t29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2QsFclmb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBCjYDbu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2QsFclmb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBCjYDbu"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784645617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwUclzuHFpjtHJN+111DzTjhoZOPgba1eIoD4Dvtsak=;
	b=2QsFclmb/bgICZY5A+pzUSoioixJ4BIuQz2zPSjbK/G0b351z44aB98ma0z55WZc75DqR2
	tzvmnygh7H+C4JGN2v2QN05YnJyuMQtblpc4QiwxkAoBr48S+3dV9yeXiKReCrS388Gjyh
	D6z37v6ty2392DM2sLS/62lDw7FdcsKNWgfz6+3UEAivsvQJgQRtfowA19/b8l3bn2G902
	RymN6e8bcJJeYXrCwLCQ+E0wredhizpm49pRjhokoZyhHJQSFEv0kANPZa59HCL8fEvOpU
	dYJNwpSgdiLWdkQiqKf7vlcAgf+Zj5Xd/bnnAjbZRJvUHtwRfBt0H+kJ6fRfQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784645617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwUclzuHFpjtHJN+111DzTjhoZOPgba1eIoD4Dvtsak=;
	b=qBCjYDbu68uTbD5MVIdNB2qKQx+O51gQzv1ofnM21MDgmRDj10hw4Wie39gTa6jFe7PsyJ
	qfP6+YhnT4hxJLDg==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Petr
 Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J?=
 =?utf-8?Q?=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, Osama Abdelkader <osama.abdelkader@gmail.com>,
 Fushuai Wang <wangfushuai@baidu.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v7 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <al57amN8TFhN4IOo@ashevche-desk.local>
References: <20260720135407.3925-1-john.ogness@linutronix.de>
 <20260720135407.3925-2-john.ogness@linutronix.de>
 <al57amN8TFhN4IOo@ashevche-desk.local>
Date: Tue, 21 Jul 2026 16:59:36 +0206
Message-ID: <871pcw5r7z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-20, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> +	/* irq_work allowed again. Handle MSR now if pending. */
>> +	up->avoid_modem_status_work = false;
>> +	guard(uart_port_lock_irqsave)(port);
>
> To make guard()() visible, we usually add a blank line before and after
> guard()() line. I dunno if scoped_guard() makes more sense here as Petr
> proposed, I'm fine with either.

Ack.

>> +static void serial8250_console_byte_write(struct uart_8250_port *up,
>> +					  struct nbcon_write_context *wctxt)
>> +{
>> +	struct uart_port *port = &up->port;
>> +	const char *s = wctxt->outbuf;
>> +	const char *end = s + wctxt->len;
>> +
>> +	/*
>> +	 * Write out the message. If a handover or takeover occurs, writing
>> +	 * must be aborted since wctxt->outbuf and wctxt->len are no longer
>> +	 * valid.
>> +	 */
>> +	while (s != end) {
>
> Can len == 0? If not, I would write this as do {} while ().

printk should never make such requests (len=0 means it is a skipped
record) but the driver should not rely on that. Also, this pattern is
the same used by serial8250_console_fifo_write()

>> +/*
>> + * irq_work handler to perform modem control. Only triggered via
>> + * ->write_atomic() callback because it may be in a scheduler or
>> + * NMI context, unable to wake tasks.
>> + */
>> +static void modem_status_handler(struct irq_work *iwp)
>> +{
>> +	struct uart_8250_port *up = container_of(iwp, struct uart_8250_port, modem_status_work);
>> +	struct uart_port *port = &up->port;
>> +
>> +	guard(uart_port_lock)(port);
>
> + blank line.

Ack.

John
