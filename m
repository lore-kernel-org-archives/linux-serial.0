Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406551D27B5;
	Fri,  6 Sep 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629735; cv=none; b=eOP5DohnyxiBvXqAmx3AtU3h/vWt32+95dvvUQsqyfVm7U1V6pVAgNusxmttZMc0AwWaPfkCvvm9X/ihFpCTnbdvcJtddvjuugAqZ04s2Guy8eGZWnyBFPGBZ09JgKwb96Tbcit0pO9CJR5A3VnQP3r19NS6vmZ4iIxIPgtDDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629735; c=relaxed/simple;
	bh=KT1UWBeJCZyaYe1ARP8SSElfIfCgLk9cDNxklEkXu6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ih8hVtXdQZKYpD8JTsj6X8sh9OBy4ffJnMs/z1FJm+IKZwB9BWeEM/BvyDgjpwr2/HTZlzPaaZbKChejBIn1kHaKm5+VmJaF1IJw2RCLcnmz+2DV13ZSFEs0qiUPUm/KwtSqGtMZ6yB3hlyNip/be2Sok63kslog47E3gFyAhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OpCDsoBo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0H2W7ryt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OpCDsoBo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0H2W7ryt"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725629731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EBQ/CG5T/049lQPrktYqvc/FJ3lMexeBJgDccAp6KNk=;
	b=OpCDsoBo7YYpL+uxCtzQjJQC9fHihaAbASwRudn4yjC4drrzJSf+12yCoIqQJPHva+yArb
	Z/PD2xNatC3LTXohIrWejYsYz7z0rUve7XyTLSu65Ddh4ZZjlb1Cp3Y6lOKNZNGfbFzmRs
	8pc3fmVttwzDoCGypizA257fWnYHEVAuTX48+oiDCQevKxZ+IhBFjEs7+P8CCTC8jVBHDQ
	0VkLB7QIkiXDifTCpDBrjCKSEQuUDS16ZqGENFDjKu55BlntODKgfaA9P0bF0GOMLU0Mj2
	q2V5ns27UCmP9H+VxeGUQuEr8hIWiHdnkr7VqO8/N2QOJDEBq3YBL5GLmO8RuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725629731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EBQ/CG5T/049lQPrktYqvc/FJ3lMexeBJgDccAp6KNk=;
	b=0H2W7rytLzilnNweNYsu8IV9YkKkmobeGnpzXj9d7v6s0RawvIaipIxE3mIQkED1Yv4yZh
	tIkf/FmVyxC/azAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
 Rengarajan S <rengarajan.s@microchip.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
In-Reply-To: <Ztr3f8M2FaT2Rz1c@pathway.suse.cz>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <20240905134719.142554-2-john.ogness@linutronix.de>
 <Ztr3f8M2FaT2Rz1c@pathway.suse.cz>
Date: Fri, 06 Sep 2024 15:41:30 +0206
Message-ID: <87mskkdhwd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-06, Petr Mladek <pmladek@suse.com> wrote:
>> +#ifdef USE_SERIAL_8250_LEGACY_CONSOLE
>
> Just for record. I agree that it is better to simply remove the
> obsolete legacy code.

Agreed. I will be removing it for v2.

>> +#ifndef USE_SERIAL_8250_LEGACY_CONSOLE
>> +	if (uart_console(&p->port)) {
>> +		dev_warn(p->port.dev, "no atomic printing for rs485 consoles\n");
>> +		p->port.cons->write_atomic = NULL;
>> +	}
>
> Wait! This makes the rs485 consoles much less usable for debugging.
> They might have troubles to see the emergency and panic messages.
> Or do I miss anything, please?
>
> Is this acceptable? Why?

It is not acceptable. I am looking into making the atomic part work for
RS485 as well. My main problem is testing since I will need to get my
hands or real RS485 hardware.

>>  	wait_for_xmitr(up, UART_LSR_THRE);
>>  	serial_port_out(port, UART_TX, ch);
>> +
>> +	if (ch == '\n')
>> +		up->console_newline_needed = false;
>> +	else
>> +		up->console_newline_needed = true;
>
> I might be just dumb but this code confused me. I missed that the
> variable was actually set after printing the character. I inverted
> the logic in my head and it did not make sense.
>
> I vote for adding a comment. Or better make the code more
> straightforward by renaming the variable and inverting the logic:
>
> 	if (ch == '\n')
> 		up->console_line_ended = true;
> 	else
> 		up->console_line_ended = false;

OK. I will add a comment, rename the variable, and invert the logic.

>> +void serial8250_console_write_thread(struct uart_8250_port *up,
>> +				     struct nbcon_write_context *wctxt)
>> +{
>> +	struct uart_8250_em485 *em485 = up->em485;
>> +	struct uart_port *port = &up->port;
>> +	unsigned int ier;
>> +
>> +	touch_nmi_watchdog();
>
> This should not be needed in the write_thread() variant because
> it allows to schedule after emitting one record.

Agreed.

Thanks.

John
