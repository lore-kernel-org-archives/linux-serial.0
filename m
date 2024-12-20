Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2499182B4;
	Fri, 20 Dec 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734695435; cv=none; b=qOnlvzcaoaE2w2tVYlueyZaraURBhS5XHDYj8ltct8xm8uZxZz3pznujhB2PeEYDaMrSwfn3wumHKKgOBI3u8/1ogcx1RWToQaw+KqoorsYbHIZFvHal0aLucwuKP6yeRAk/rF6uO4pFTA1mEvKhjseYyQgVJLKQYjZ5JlReWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734695435; c=relaxed/simple;
	bh=V2rgkmiW6f8CPDVhJw7Ctc2+zmfqJOFw92iW7hHRZEI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=g5RFH39SgH9upLtTOCi2sJ0k+t6NcOKznp59WxA1DyBVM7XpMLZyjefPNMy4tG3hdBXc2eL1rDn8HJuCGcuCQ5e3Xwh1xpaJxGCEulpCGuPGSZ9rAARQza5bdUY7diDsdas0wP0+py1rMnDK4xuWfERrM19FotkQ8MAMynvtyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvpTWwkr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NgZifuYk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvpTWwkr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NgZifuYk"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734695431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=lUKRjsJh4wLt12+BSGF0lbVjgOK/cMAK5vePGhQ1SoU=;
	b=BvpTWwkrJddVegr5lhnYhXeYutedR9tiDM6f5dhrefFro+1VgepVMv9nLkFcrF3hloUYaL
	o1zcEJEVlt9ohfqv32YEPQGUP3bwlq+UNttbkSroDoR06eY8/wZUqLYXfqEwqKkQ09tWQR
	dMrHXzpsDV9UBjyMN49iGG4XbSKy8wjtUUnsYRckSTxyMl+mvQPNc6wvOMTC+WFVt6raVb
	MLzv5BxCD5dUlgq98xVy1BcY3ivNIsmDpbeKIg/FrkVzlqY/K6wog6SMvFYimepKtAGLH/
	Z+oYmATuNtEE06W24iMOJ1UpBRq/xpDbHude4W+hdiZNXVzr3IwSA8mBwhOIDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734695431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=lUKRjsJh4wLt12+BSGF0lbVjgOK/cMAK5vePGhQ1SoU=;
	b=NgZifuYkXObzFBKIMavpsmFIMqAKQuw6vzCDyolY/lTQPUaMsJlMcEPXMlfaf1hsBxbMy8
	mAhgVKZCcj/iqjCw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Rengarajan S <rengarajan.s@microchip.com>, Bart Van
 Assche <bvanassche@acm.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Serge Semin <fancer.lancer@gmail.com>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH tty-next v1 1/4] serial: 8250: Use @ier bits to
 determine if Rx is stopped
In-Reply-To: <Z2CQ8NvNhIOpPcBn@smile.fi.intel.com>
Date: Fri, 20 Dec 2024 12:56:31 +0106
Message-ID: <84ed22h8u0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-12-16, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > Use the UART_IER_RLSI and UART_IER_RDI bits in @ier instead, as
>> > this is already common in 8250-variants and drivers.
>> 
>> Hmm... IER is Interrupt Enable Register, so it has been programmed to the value
>> we control, on the opposite the LSR is Line Status Register and defines status
>> on the line at the moment of reading. Can you elaborate how your change is correct
>> substitute?

The change subsitutes @ier usage for @read_status_mask usage. Both are
programmed values that we control. Note that the code being replaced
does _not_ care about the Line Status Register. It is only looking at
the bit in the mask.

Everywhere that UART_LSR_DR is set/cleared in @read_status_mask,
UART_IER_RLSI and UART_IER_RDI are also set/cleared in @ier.

Also, there are plenty of examples where the RLSI and RDI bits of @ier
are used to determine if Rx is enabled. Here are the examples from the
8250 variants...

In fsl8250_handle_irq() we see that the @ier condition is used for
deciding if Rx is enabled:

        /* Process incoming characters first */
        if ((lsr & (UART_LSR_DR | UART_LSR_BI)) &&
            (up->ier & (UART_IER_RLSI | UART_IER_RDI))) {
                lsr = serial8250_rx_chars(up, lsr);
        }

Ditto for brcmuart_hrtimer_func():

        /* re-enable receive unless upper layer has disabled it */
        if ((up->ier & (UART_IER_RLSI | UART_IER_RDI)) ==
            (UART_IER_RLSI | UART_IER_RDI)) {

Ditto for fsl8250_handle_irq():

                if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
                        port->ops->stop_rx(port);

Ditto for omap8250_irq():

                if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
                        port->ops->stop_rx(port);

> Additionally the common IRQ handler may be called at last in the custom ones
> and hence potentially the value of saved IER might be different to what the
> actual register is programmed to.

There is only 1 place where they do not match: serial8250_do_startup()

        /*
         * Set the IER shadow for rx interrupts but defer actual interrupt
         * enable until after the FIFOs are enabled; otherwise, an already-
         * active sender can swamp the interrupt handler with "too much work".
         */
        up->ier = UART_IER_RLSI | UART_IER_RDI;

The IER hardware register contains 0 here.

This comes from commit ee3ad90be5ec ("serial: 8250: Defer interrupt
enable until fifos enabled").

But since IER is 0, there will be no interrupt to land in any handlers
leading to serial8250_handle_irq().

> Besides that I don't remember all of the mysterious ways of DMA. May it affect
> the value of IER and when we swtich from DMA to PIO and vice versa we get an
> incorrect value in the saved variable?

The change being made in this patch is only related to the Rx FIFO
throttling when hardware flow control is enabled. The "feature" was
added by commit f19c3f6c810 ("serial: 8250_port: Don't service RX FIFO
if throttled").

For the omap variant this worked because the omap variant also updates
the @read_status_mask when unthrottling (no other variant does that).

What confuses me is in 8250_omap.c:__dma_rx_complete() where there is:

        __dma_rx_do_complete(p);
        if (!priv->throttled) {
                p->ier |= UART_IER_RLSI | UART_IER_RDI;
                serial_out(p, UART_IER, p->ier);
                if (!(priv->habit & UART_HAS_EFR2))
                        omap_8250_rx_dma(p);
        }

I would expect to see:

        __dma_rx_do_complete(p);
        if (!priv->throttled) {
                p->ier |= UART_IER_RLSI | UART_IER_RDI;
                p->port.read_status_mask |= UART_LSR_DR;
                serial_out(p, UART_IER, p->ier);
        }

But perhaps that is a bug. In fact, it would be exactly the bug that
this patch is fixing because there are many places where
@read_status_mask does not mirror Rx enable/disable status (because that
is not the correct use of @read_status_mask).

John
