Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C402B9B9;
	Mon, 30 Dec 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735554141; cv=none; b=Vsmbt/26dKsSjlt7kZn+NBK+4sysfFzGJvk66g3g22zO/4XoBzq9ox+WTvmALek28Im/7AA07g/CchKUI0t0cNWpvIm46yVOlIituDqGmd8sYMQmTfeSpAOJrn1EnHLfZcccA2LpgrSfV5WBTcHK8g9uY9BMkg+7EtBZ3K+Ihik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735554141; c=relaxed/simple;
	bh=866u2PIES4ulASM05e5Wx7HL6Yn3ncnU1epYJQVM+NY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VShF0nQe3yCqyyYvQrKg7+Ri0f5xbcgotYjfgAQDISldDC5bjEplvJhB8tjaADtAGchyCPT0KB51juKxYs+ku/0DE3Mjpezcq7YgX9nw3/7onDWachs6nOQYJYA8VQkpvEv59Euqc9hwLf9H+MNtvdEDtzKprtyJ91oR4kTOyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMD8LoCQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zM8syA30; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMD8LoCQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zM8syA30"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735554138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhOkXiga70qWA9ePfSf91PhvuvMQljlul7M2OQUHm4I=;
	b=SMD8LoCQE/UwUzmiEKNKTwXKNBkJ7JbKzjt5nEJQ23aPM4UfJR7BVRA0Y9AF1PsGSNQyKw
	JHm9mok2G3ZGCgvUVvRjJs26jPNrJZdUmpho5cqg3tSAPE2RVO33YAgYUVJyhyXnZZLCo3
	0dEDhO6/29eXrS3EYdglladfsDioqYSiVlIdp9z1cp4M2ULQ7ibBmBvSIhFqO6lssOuwkL
	JAbaM+ABhL6uzCb33Xs7qIARwoBOu84MxJFNgYWCy++347ZnRWPn/0/dWWtCM7xjaLBgGZ
	Z0fAJD0ZXMjZD1urDn2l9Y0Iaj14TTUqbFvnSi8DQTXs/w33uu2Z0E7y/WMgcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735554138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhOkXiga70qWA9ePfSf91PhvuvMQljlul7M2OQUHm4I=;
	b=zM8syA3095CsBBKY+uS8ZYelAxdK0idB+coUcpQTOLpo3eod+MAvqg1hUKhR+HFEeI91O9
	E4B1WhgocZE59PBw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Turner
 <mattst88@gmail.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann
 <arnd@arndb.de>, Niklas Schnelle <schnelle@linux.ibm.com>, Serge Semin
 <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v4 5/6] serial: 8250: Switch to nbcon console
In-Reply-To: <Z3B3e6ppZc94Pdck@smile.fi.intel.com>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-6-john.ogness@linutronix.de>
 <Z3B3e6ppZc94Pdck@smile.fi.intel.com>
Date: Mon, 30 Dec 2024 11:28:17 +0106
Message-ID: <844j2lqxly.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-12-29, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> -static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
>> +static int fifo_wait_for_lsr(struct uart_8250_port *up,
>> +			      struct nbcon_write_context *wctxt,
>> +			      unsigned int count)
>>  {
>>  	unsigned int i;
>>  
>>  	for (i = 0; i < count; i++) {
>> +		if (!nbcon_can_proceed(wctxt))
>> +			return -EPERM;
>> +
>>  		if (wait_for_lsr(up, UART_LSR_THRE))
>> -			return;
>> +			return 0;
>>  	}
>> +
>> +	return -ETIMEDOUT;
>>  }
>
> ...
>
>>  static void serial8250_console_fifo_write(struct uart_8250_port *up,
>> -					  const char *s, unsigned int count)
>> +					  struct nbcon_write_context *wctxt)
>>  {
>> -	const char *end = s + count;
>>  	unsigned int fifosize = up->tx_loadsz;
>>  	struct uart_port *port = &up->port;
>> +	const char *s = wctxt->outbuf;
>> +	const char *end = s + wctxt->len;
>>  	unsigned int tx_count = 0;
>>  	bool cr_sent = false;
>>  	unsigned int i;
>>  
>>  	while (s != end) {
>>  		/* Allow timeout for each byte of a possibly full FIFO */
>> -		fifo_wait_for_lsr(up, fifosize);
>> +		if (fifo_wait_for_lsr(up, wctxt, fifosize) == -EPERM)
>> +			return;
>
> Perhaps it was already discussed and I forgot about it or hadn't read,
> but I don't get how per-byte check for NBCON permission can help if there
> is something already in the HW FIFO?
>
> I mean in _this_ case wouldn't be enough to check FIFO to drain and only after
> that check the permission?

If we did that and other CPUs had taken over printing, then this CPU
would possibly busy-wait the maximum timeout because the FIFO keeps
getting refilled by the other CPUs. If this CPU knows that it has lost
ownership then it can abort waiting and trying to write ASAP.

The CPU taking over will perform the necessary waiting for the FIFO to
drain what this CPU had wrote into the FIFO.

>
>>  		for (i = 0; i < fifosize && s != end; ++i) {

That being said, this loop is not checking for lost ownership between
bytes. I will add an nbcon_can_proceed() check here as well. If
ownership was lost, this CPU must not continue writing into the FIFO.

	for (i = 0; i < fifosize && s != end && nbcon_can_proceed(wctxt); ++i) {

>>  			if (*s == '\n' && !cr_sent) {
>
>>  	 * Allow timeout for each byte written since the caller will only wait
>>  	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
>>  	 */
>> -	fifo_wait_for_lsr(up, tx_count);
>> +	fifo_wait_for_lsr(up, wctxt, tx_count);
>> +}
>
>
> ...
>
>> +	if (up->msr_saved_flags) {
>> +		/*
>> +		 * For atomic, it must be deferred to irq_work because this
>> +		 * may be a context that does not permit waking up tasks.
>> +		 */
>> +		if (is_atomic)
>> +			irq_work_queue(&up->modem_status_work);
>> +		else
>> +			serial8250_modem_status(up);
>
> Hmm... Shouldn't this be part of _modem_status() for all drivers using this call?

I am not sure I follow what you are saying.

Only NBCON drivers (that have implemented the ->write_atomic() callback)
will print from any context. OTOH legacy console drivers do not print
directly from scheduling or NMI contexts and instead defer to a printk
irq_work.

As we convert more console drivers to NBCON, it might make sense to move
the irq_work into the generic struct uart_port and possibly consolidate
the _modem_status() implementations. They seem to be mostly copy/paste
code.

>> +	bool			console_line_ended;	/* line fully output */
>
> Sorry, I didn't get the comment. Do you meant "line is fully printed out
> [to HW]"?

'\n' was the most recent byte written to the TX register by the console
driver.

Tracking this is necessary during takeovers so that the CPU taking over
can politely add an extra newline for cleaner output.

The wording for this comment was suggested by Petr Mladek. Please
suggest an acceptable alternative if you require something more concise.

John
