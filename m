Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0DB18A921;
	Mon, 28 Oct 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121759; cv=none; b=NpjWZ8bi83H4jkeWmTSGpw8jgpb4x/lDWHC+CQU657ZH9z2mAbt5804Fn7TlcK2Shs6oavzswOTv2SVPpjh+Ay++dWuX3W+gTJFu6Op7kHeeqdCwqfgLqdun2b4W1lnwd61uEquqvpqwyq+nvVUdHqgdE/u+fS8nutgJvtN0+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121759; c=relaxed/simple;
	bh=roDEL1+bPO2wS+cBM+y0aiHYpgneB1/8mG78KA5yY64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fc0OSroGi8xXczKP+aDiU/w0kNzYsQUZyk5s29iN6wsXM9wq216fD5cr8kAmn1sW2fY1RRnNnb5bvbgqrX9w8DDEWOIED9mzsk5WdHniD7hHigMod+TUiRfI8hmqjEICNgZ+SjltRYS5fAgPPQMD7d6oawc6vI/9Eqs95Q/npx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDFUQwsS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OIZ4ris+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDFUQwsS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OIZ4ris+"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730121756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apY6S+qeU253Dd/TKZK2biKnIZhCt99HbkaZ7kbjDVE=;
	b=LDFUQwsSME0pYe9xdUvkoGlcU7qsslf7g7nlRu5paPljeoREOtOjM6krVD9I+SeYHKjQ6t
	08Lnthd4DiYwVsDTa+7vom92MS+JNwqk4XK6wyUKHYQx5UrUyHVoJOL/ddt9XoYY1TmMl1
	zzdKyoExedY7FBs86UZyFbNF2kUHAewWuVtXsZc8wOkixnKdhZN2/f0FphbmQjmoOpw1ip
	LW+rTccgZoo13JAOYjnrE2lsnJ7fut26CbRA76NNDHvO5vIgJUYamaTeNg/yWGfueGuoHJ
	LgyMHQ4cZaOLX/GHzB5F9hKmminpkVjmDnm5e+OQMMKi70TEsfCW2Koqh6vLvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730121756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apY6S+qeU253Dd/TKZK2biKnIZhCt99HbkaZ7kbjDVE=;
	b=OIZ4ris+cVy5tg+Br/SXpkJX931O3A4q3LdJXlkysQjqZUG6kzAeVpKuyQXAvYuhjii3L+
	aghviZNEtjFUehCw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Tony
 Lindgren
 <tony@atomide.com>, Rengarajan S <rengarajan.s@microchip.com>, Peter
 Collingbourne <pcc@google.com>, Serge Semin <fancer.lancer@gmail.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 5/6] serial: 8250: Switch to nbcon console
In-Reply-To: <ZxupiKSSpZlyKhz-@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-6-john.ogness@linutronix.de>
 <ZxupiKSSpZlyKhz-@smile.fi.intel.com>
Date: Mon, 28 Oct 2024 14:28:35 +0106
Message-ID: <848qu8nyzo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-25, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> +/*
>> + * Only to be used directly by the console write callbacks, which may not
>> + * require the port lock. Use serial8250_clear_IER() instead for all other
>> + * cases.
>> + */
>> +static void __serial8250_clear_IER(struct uart_8250_port *up)
>>  {
>>  	if (up->capabilities & UART_CAP_UUE)
>>  		serial_out(up, UART_IER, UART_IER_UUE);
>
>>  		serial_out(up, UART_IER, 0);
>>  }
>>  
>> +static inline void serial8250_clear_IER(struct uart_8250_port *up)
>> +{
>> +	__serial8250_clear_IER(up);
>
> Shouldn't this have a lockdep annotation to differentiate with the
> above?

Yes, but the follow-up patch adds the annotation as a clean "revert
patch". I can add a line about that in the commit message.

>> +static void serial8250_console_byte_write(struct uart_8250_port *up,
>> +					  struct nbcon_write_context *wctxt)
>> +{
>> +	const char *s = READ_ONCE(wctxt->outbuf);
>> +	const char *end = s + READ_ONCE(wctxt->len);
>
> Is there any possibility that outbuf value be changed before we get
> the len and at the end we get the wrong pointer?

No. I was concerned about compiler optimization, since @outbuf can
become NULL. However, it can only become NULL if ownership was
transferred, and that is properly checked anyway. I will remove the
READ_ONCE() usage for v4.

>>  struct uart_8250_port {
>
>>  	u16			lsr_save_mask;
>>  #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
>>  	unsigned char		msr_saved_flags;
>> +	struct irq_work		modem_status_work;
>> +
>> +	bool			console_line_ended;	/* line fully output */
>>  
>>  	struct uart_8250_dma	*dma;
>>  	const struct uart_8250_ops *ops;
>
> Btw, have you run `pahole` on this? Perhaps there are better places
> for new members?

Indeed there are. Placing it above the MSR_SAVE_FLAGS macro will reduce
an existing 3-byte hole to 2-bytes and avoid creating a new 7-byte
hole.

Thanks.

John
