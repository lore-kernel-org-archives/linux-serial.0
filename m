Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4EAD2C;
	Sun,  5 Jan 2025 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038665; cv=none; b=rkO0jBslZCETT8ePduFHbJPMNzDrFSisx6hv9x1jmKjTryJi/pIxdyjsdsYYQvydvBEJB2gbpRaYP2d0X1QSR+BzZV3mkcFHsHFuRgf9guGnDBlTDJyfl5T4MuHYawexW9xZdfPH1I5XV7Y8bIyaMIYEBVjH3Ayg0e1eK9nOfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038665; c=relaxed/simple;
	bh=5txMjZ0xP/g4W0sGgfnjhLyFL9+V8+1uGWJy9d0GU2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5qpNHo2+fqSM/yhWx6gpqzvQ+3ZXSadnT2PRWKrfg4Dm62rGHlnO8dOL+3wCa2Sq0p8vNAk4NUDirmytGaMgdzuoKUn/JBbEcfOLWnsFqwLz3/JWTH7qw0uxLiP2aKjy0QffOcy31NawIrHIN/sBISdT+YWbi2D12kfz+p8G28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NWrP/maH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rr2KB7e9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWrP/maH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rr2KB7e9"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736038661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ovkgNmQIB052PO01dDZ2wlB/fQ+XYdeyzvXwMQQ9xDs=;
	b=NWrP/maHl1dzVkQ6FBdwbCYTtI55i2BMrfcOCGS7rpsogI07rdvfiqsA+7C91qMFf4dZAu
	nKLQQGlaVqoCxV33QbNgb8ABg9kiRInacbLy/rbx++hLe3zom7vBk7LxroABUcPn6QqdoA
	JZbwDUB8inflxk5KSG0IgM5/gZkmSeSK8THSkiHwjFEECIOIqbYf9e1w9O7MGOXnULg4zl
	UKNplBrbUU0F2aPom2WeMAPp2Z7S/w6L4nD+3ucpoCVGTRDDvtDLxp1/yf3+k+mRescxF7
	6k/2hBTmimoH+yHYOcR6DtvGuuiYSrU8WCoQxowJtzchgUhFaSk/VqD2DJBYew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736038661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ovkgNmQIB052PO01dDZ2wlB/fQ+XYdeyzvXwMQQ9xDs=;
	b=rr2KB7e94Kx6IJ3PKOt8llIi+MzALAtyhcSFiCb2dSa4Scf95mVQTAuf/oSay6nGOrV7Gk
	vG0R0t46w581fQAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Matt Turner
 <mattst88@gmail.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann
 <arnd@arndb.de>, Niklas Schnelle <schnelle@linux.ibm.com>, Serge Semin
 <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v4 5/6] serial: 8250: Switch to nbcon console
In-Reply-To: <Z3gTmicJVLA1tFq5@pathway.suse.cz>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-6-john.ogness@linutronix.de>
 <Z3gTmicJVLA1tFq5@pathway.suse.cz>
Date: Sun, 05 Jan 2025 02:03:41 +0106
Message-ID: <84h66exeka.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-01-03, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -1406,9 +1416,6 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
>>  {
>>  	unsigned char mcr = serial8250_in_MCR(p);
>>  
>> -	/* Port locked to synchronize UART_IER access against the console. */
>> -	lockdep_assert_held_once(&p->port.lock);
>
> We should explain why it is OK to move the assert.
>
> IMHO, most poeple would not understand the port lock is needed only
> for UART_IER manipulation and not for UART_MCR manipulation.
>
> We should probably explain that even the UART_MCR manipulation
> is synchronized either by the port lock or by nbcon context
> ownership. Where the nbcon context owner ship actually provides
> synchronization against the port lock in all situations
> except for the final unsafe flush in panic().

Correct, although the "except for the final unsafe flush in panic()" is
the reason that even an nbcon context ownership assert could not be used
here.

> A comment might be enough.

OK. I will extend the comment at the new lockdep_assert site explaining
why the port lock is only guaranteed to be held for the toggle_ier==true
situation.

>> +static int fifo_wait_for_lsr(struct uart_8250_port *up,
>> +			      struct nbcon_write_context *wctxt,
>> +			      unsigned int count)
>>  {
>>  	unsigned int i;
>>  
>>  	for (i = 0; i < count; i++) {
>
> This would deserve a comment. The following comes to my mind:
>
> 		/*
> 		 * Pass the ownership as quickly as possible to a higher
> 		 * priority context. Otherwise, its attempt to take
> 		 * over the ownership might timeout. The new owner
> 		 * will wait for lsr before reusing the fifo.
> 		 */

OK.

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
>>  
>>  		for (i = 0; i < fifosize && s != end; ++i) {
>>  			if (*s == '\n' && !cr_sent) {
>
> We might want to check nbcon_can_proceed() after each character.
> I think that you have already suggested this in the reply to Andy.

Yes v5 will check per character.

> But maybe, it is not that important because filling the FIFO buffer is
> probably fast.

Surely it could fill the FIFO in less time than the timeout (currently
hard-coded at 2ms). But I do not think we should rely on such timings
since they could change later. Also, since the CPU is busy-waiting
during the full Tx anyway, the check is not wasting any CPU cycles or
slowing the Tx.

>> +	bool			console_line_ended;	/* line fully output */
>
> I wonder if the following is better:
>
> 	bool			console_line_ended;	/* finished writing full line */

I would prefer to make it more technically exact. It would require a
multi-line comment and this header uses 2 different styles for
multi-line field comments.

How about:

	/*
	 * Track when a console line has been fully written to the
	 * hardware, i.e. true when the most recent byte written by
	 * the console to UART_TX was '\n'.
	 */
	bool			console_line_ended;

John
