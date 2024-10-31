Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F08F5C;
	Thu, 31 Oct 2024 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364603; cv=none; b=SrRv34F1Ekr4KF7PhGUU0oE6G8h8QTZreaDPCEXa5H2MWAk1ya1mnxwnig6bfnIsj5GXxTlcpTenz8AsCpYqIfpUi3B5Q1TZgCXmJDeeHIYIXWSmXi6KR8spTtqd/GuP9ra9XAUhnABI/teweShQgnZRL1pQM6QpFc0bA/+mPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364603; c=relaxed/simple;
	bh=qPNZfpWGmQ4SZQhBy1CM/jUxXNqfNcI4vpm/jDmtCFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jiuELfet/niMgK6jUWkW1AOjUenQdD2ihHVUlBesWZK5KNU7DLJLAj1TQAC74SFp9JvtkKGAhq4dE0PM2jLA2jYwZgQ2/WyNt76YufNWiWfYiPfsPkQcwGcqfMGCnkZY4wxquppcbGbH8cELpRrRPQ2zpOE0kovPFC/n1b9Jpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JfEsqwDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXxf7UR0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JfEsqwDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXxf7UR0"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730364599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DpxwBF9Vc6S9Oo/ZnENALOc4p6XbTTIle427JY74bWU=;
	b=JfEsqwDT+jNaAVqy+m4ihk4P0USAe7j2pEbujSRC6OieWFmEWsG4HSqPdNYdfZelSKKbYm
	uqXIeSv+IByGjz3DVRsz/bTExQdUC5n5G/41rS7p8q6Q3k0nj1a3IcoGqSXRNZScLD6Bsz
	Be/90XnsWlsvfLUOb4rWF44NkTENHVPPdPT4G6h+3KC0osryRxXDqg+LyX6EqfO0FIg1Q+
	YTtQTQJJIWLyue+l6N+py7kiAEc7mK64GpGAiF4sPN77cyqbmx7aWc4OZXAckh+29BRQxB
	rbhIZzJmD8MudJ5P4f1LeioqWKTM8zyD4DK4zforyKPodrTvzAmPEaeEusq/Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730364599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DpxwBF9Vc6S9Oo/ZnENALOc4p6XbTTIle427JY74bWU=;
	b=LXxf7UR0fjXUlAbe1R+P9MNVLarVlcPR8h6a1QB0dT6fj5dr9GY7fV04iUaadGe4qXw2Fb
	0E00vW1fLGM7RNCA==
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Esben
 Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rengarajan S
 <rengarajan.s@microchip.com>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Serge Semin <fancer.lancer@gmail.com>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
In-Reply-To: <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
 <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org>
 <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
Date: Thu, 31 Oct 2024 09:55:58 +0106
Message-ID: <84sesclkqx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Maciej,

Thanks for jumping in with some ref-manual quotes. Some more comments
from me below...

On 2024-10-31, "Maciej W. Rozycki" <macro@orcam.me.uk> wrote:
> On Wed, 30 Oct 2024, Jiri Slaby wrote:
>> > @@ -3306,13 +3310,18 @@ static void serial8250_console_restore(struct
>> > uart_8250_port *up)
>> >   static void serial8250_console_fifo_write(struct uart_8250_port *up,
>> >   					  const char *s, unsigned int count)
>> >   {
>> > -	int i;
>> >   	const char *end = s + count;
>> >   	unsigned int fifosize = up->tx_loadsz;
>> > +	unsigned int tx_count = 0;
>> >   	bool cr_sent = false;
>> > +	unsigned int i;
>> >     	while (s != end) {
>> > -		wait_for_lsr(up, UART_LSR_THRE);
>> > +		/* Allow timeout for each byte of a possibly full FIFO. */
>> > +		for (i = 0; i < fifosize; i++) {
>> > +			if (wait_for_lsr(up, UART_LSR_THRE))
>> > +				break;
>> > +		}
>> 
>> THRE only signals there is a space for one character.
>
>  Nope[1]:
>
> "In the FIFO mode, THRE is set when the transmit FIFO is empty; it is 
> cleared when at least one byte is written to the transmit FIFO."
>
> It seems common enough a misconception that once I actually had to fix the 
> bad interpretation of THRE in an unpublished platform driver to get decent 
> performance out of it at higher rates such as 230400bps, as it only pushed 
> one byte at a time to the FIFO while it had it all available once THRE has 
> been set.

I do not know if this is true for all 8250-variants. If there is some
variant where it functions as Jiri expected, then it would mean
significant text loss during longer messages. But that would already be
a problem in the current mainline driver.

>> > +	/* Allow timeout for each byte written. */
>> > +	for (i = 0; i < tx_count; i++) {
>> > +		if (wait_for_lsr(up, UART_LSR_THRE))
>> 
>> This ensures you sent one character from the FIFO. The FIFO still can contain
>> plenty of them. Did you want UART_LSR_TEMT?
>
>  The difference between THRE and TEMT is the state of the shift register 
> only[2]:
>
> "In the FIFO mode, TEMT is set when the transmitter FIFO and shift 
> register are both empty."

If we wait for TEMT, we lose significant advantages of having the FIFO.

>> But what's the purpose of spinning _here_? The kernel can run and FIFO
>> too. Without the kernel waiting for the FIFO.

When serial8250_console_fifo_write() exits, the caller just does a
single wait_for_xmitr() ... with a 10ms timeout. In the FIFO case, for
<=56k baudrates, it can easily hit the timeout and thus continue before
the FIFO has been emptied.

By waiting on UART_LSR_THRE after filling the FIFO,
serial8250_console_fifo_write() waits until the hardware has had a
chance to shift out all the data. Then the final wait_for_xmitr() in the
caller only waits for the final byte to go out on the line.

Please keep in mind that none of these timeouts should trigger during
normal operation.

For v4 I am doing some refactoring (as suggested by Andy) so that the
wait-code looks a bit cleaner.

John

> References:
>
> [1] "TL16C550C, TL16C550CI Asynchronous Communications Element with 
>     Autoflow Control", Texas Instruments, SLLS177F -- March 1994 -- 
>     Revised March 2001, p. 30
>
> [2] same
