Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43219580A;
	Thu, 31 Oct 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366746; cv=none; b=FWtfEHIl/j0wfZUMh5AE8CGh3ZbSpKhUseTEDew7tw13/25kfQIOG6nK2i65XUo9yO/jFTCPD5RrIjs5DCgwqATYOHlnboEeMNw7dz1rcQYr/PLRldHXc1R8PE3EyZsyflQLPbEsc55HxCVnTy2yETfEE3puPG1BL4KtcRJWfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366746; c=relaxed/simple;
	bh=R9P3BdZPMugAhiXUvDfpQpJdWt09YfI6FBbcP0deauY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tyrhc9Opl2rSCuowbk1k3S00nE1hxfKUI6eknyKuA3M1OfEdS9WTZ83Gs3qL0Qa4WHGs4pM2ES+Col+IkppECjFDerjkCoFlQ9O4Sru9DJTGzPfwl64SuW5rW1QS4O91U3MaQFTsRVMLlxrbMj1hXF8O0b1iUw0OQJw7QK7iobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0BRaxfe8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G0iEi24X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0BRaxfe8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G0iEi24X"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730366742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4XOhA+qbKcOxUwuBV6wIIlJrCI0gaIgvaqmgKGx/kE=;
	b=0BRaxfe8HIoM+0ljJwS/7adDuXuq9rl9de0yDWJxJwSue5d5K6g5HrxPVIfeqeF4wI7y6w
	n9GK10fBMidSxW1W0UsW3g/hRlP3/ZFRkuQ4FsSn2BR+k4kMjeG9Bc/5TosfGKU7httKiD
	3HguzmcMtbA1E/WHWdTfNAMFNdX0kDFqvAeOcfHcr+XVtYF3f5kY3dVnqfh9pc1CLyaiu4
	6oUOCVeHLXEzm74OG7hUqyAQpsLVlnrAmdkRBHDwXGbfQibPTDFtgIMHo/wm0ntVvIluKQ
	dHUJbm9S+m1MiewcFNOHIMUPSxpOyQ4IJTm2e9u/RqxzSIzop9MF/qK1/oXL5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730366742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4XOhA+qbKcOxUwuBV6wIIlJrCI0gaIgvaqmgKGx/kE=;
	b=G0iEi24XT31tI4NdGX5W4gMg1rJdLA/f3QtfC1PUJ49OZLA7TVBHwtDdNtiXuBMenO6Llu
	Nab2V6gtyCtocdDw==
To: Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Uwe =?utf-8?Q?K?=
 =?utf-8?Q?leine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
 Rengarajan S <rengarajan.s@microchip.com>, Peter Collingbourne
 <pcc@google.com>, Serge Semin <fancer.lancer@gmail.com>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 5/6] serial: 8250: Switch to nbcon console
In-Reply-To: <419edf13-3f5e-4d30-90d8-88118f77f704@kernel.org>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-6-john.ogness@linutronix.de>
 <419edf13-3f5e-4d30-90d8-88118f77f704@kernel.org>
Date: Thu, 31 Oct 2024 10:31:41 +0106
Message-ID: <84msiklj3e.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-30, Jiri Slaby <jirislaby@kernel.org> wrote:
>> -static void univ8250_console_write(struct console *co, const char *s,
>> -				   unsigned int count)
>> +static void univ8250_console_write_atomic(struct console *co,
>
> Once 'co'.

>> +static void univ8250_console_write_thread(struct console *co,
>
> Second time co.

>> +static void univ8250_console_device_lock(struct console *con, unsigned long *flags)
>
> And suddenly, it is 'con'.

Sorry. The printk folks like "con". The 8250 folks seem to like "co". I
will switch to "co" for the 8250 changes.

>>   static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
>>   {
>> +	struct uart_8250_port *up = up_to_u8250p(port);
>> +
>>   	serial_port_out(port, UART_TX, ch);
>> +
>> +	if (ch == '\n')
>> +		up->console_line_ended = true;
>> +	else
>> +		up->console_line_ended = false;
>
> So simply:
>     up->console_line_ended = ch == '\n';

OK, although I would also add parenthesis to make the inline boolean
evaluation visually more obvious:

	up->console_line_ended = (ch == '\n');

>>   	/*
>> -	 *	First save the IER then disable the interrupts
>> +	 * First save IER then disable the interrupts. The special variant
>
> When you are at it:
> "First, save the IER, then"

OK.

> (BTW why did you remove the "the"?)

If IER is the name of a register, the "the" is inappropriate. If IER is
just an abbreviation for "interrupt enable register" then the "the" is
correct. In this case, both are correct, so it depends on how you read
it. ;-)

Anyway, I have no problems leaving the "the" in place.

>> +	up->console_line_ended = true;
>> +	up->modem_status_work = IRQ_WORK_INIT(modem_status_handler);
>
> Looks weird ^^^.
>
> Do:
>    init_irq_work(&up->modem_status_work, modem_status_handler)

Right. Thanks.

John
