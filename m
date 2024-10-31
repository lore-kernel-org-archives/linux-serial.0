Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452E139D;
	Thu, 31 Oct 2024 04:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730349898; cv=none; b=hRtibC2L1AhqIT/DWkqnchcxtSd1eQV8IwIbGlQz5PnN7+lZ69Qd5Rxwj6nSGxMClWJKfbfJBfr+2FoQNxXMmmjfXKu3mYC0tkaWFkfNpRmPMsqYg05RvHYG/yvmRJHcadaQTbhkm8CM6ix/482of6nttillMDeOTwmQNJDBch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730349898; c=relaxed/simple;
	bh=lY0tDboyg9q99Ypz0IHXvELN2lh2d3IlSJzu+eSslAA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tgZoq/Vs/0FLkM9GP4fbC7YWeV0PBNo7LkhgsOojY1ZxNMP3V4Py9UVSiE+JCGoLjzzz4liy2k5571itkcZYFJwMAygqaNw5pkJbJa4/1CKOsbx4huDGkIzY2CUMQWczrg/J9wk9m9R5qvZu5omI1emb6azGgynEyjm7foPyBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id F202692009C; Thu, 31 Oct 2024 05:44:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EAC4F92009B;
	Thu, 31 Oct 2024 04:44:46 +0000 (GMT)
Date: Thu, 31 Oct 2024 04:44:46 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jiri Slaby <jirislaby@kernel.org>
cc: John Ogness <john.ogness@linutronix.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Petr Mladek <pmladek@suse.com>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
    Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Rengarajan S <rengarajan.s@microchip.com>, 
    Jeff Johnson <quic_jjohnson@quicinc.com>, 
    Serge Semin <fancer.lancer@gmail.com>, 
    Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
    Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
In-Reply-To: <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org>
Message-ID: <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
References: <20241025105728.602310-1-john.ogness@linutronix.de> <20241025105728.602310-2-john.ogness@linutronix.de> <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Oct 2024, Jiri Slaby wrote:

> > @@ -3306,13 +3310,18 @@ static void serial8250_console_restore(struct
> > uart_8250_port *up)
> >   static void serial8250_console_fifo_write(struct uart_8250_port *up,
> >   					  const char *s, unsigned int count)
> >   {
> > -	int i;
> >   	const char *end = s + count;
> >   	unsigned int fifosize = up->tx_loadsz;
> > +	unsigned int tx_count = 0;
> >   	bool cr_sent = false;
> > +	unsigned int i;
> >     	while (s != end) {
> > -		wait_for_lsr(up, UART_LSR_THRE);
> > +		/* Allow timeout for each byte of a possibly full FIFO. */
> > +		for (i = 0; i < fifosize; i++) {
> > +			if (wait_for_lsr(up, UART_LSR_THRE))
> > +				break;
> > +		}
> 
> THRE only signals there is a space for one character.

 Nope[1]:

"In the FIFO mode, THRE is set when the transmit FIFO is empty; it is 
cleared when at least one byte is written to the transmit FIFO."

It seems common enough a misconception that once I actually had to fix the 
bad interpretation of THRE in an unpublished platform driver to get decent 
performance out of it at higher rates such as 230400bps, as it only pushed 
one byte at a time to the FIFO while it had it all available once THRE has 
been set.

> > +	/* Allow timeout for each byte written. */
> > +	for (i = 0; i < tx_count; i++) {
> > +		if (wait_for_lsr(up, UART_LSR_THRE))
> 
> This ensures you sent one character from the FIFO. The FIFO still can contain
> plenty of them. Did you want UART_LSR_TEMT?

 The difference between THRE and TEMT is the state of the shift register 
only[2]:

"In the FIFO mode, TEMT is set when the transmitter FIFO and shift 
register are both empty."

References:

[1] "TL16C550C, TL16C550CI Asynchronous Communications Element with 
    Autoflow Control", Texas Instruments, SLLS177F -- March 1994 -- 
    Revised March 2001, p. 30

[2] same

  Maciej
