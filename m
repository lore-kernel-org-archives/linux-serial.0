From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial/8250: Add support for Exar's XR17V35x family of
 multi-port PCIe UARTs.
Date: Fri, 9 Nov 2012 23:58:00 +0000
Message-ID: <20121109235800.745dcf15@pyramind.ukuu.org.uk>
References: <CAJp1Oe4DuffN_EWP-zVznBX+JqnE6kEAsXS1oHvfvfLC5DVOAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46422 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab2KIXwz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Nov 2012 18:52:55 -0500
In-Reply-To: <CAJp1Oe4DuffN_EWP-zVznBX+JqnE6kEAsXS1oHvfvfLC5DVOAw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>, Theodore Ts'o <tytso@mit.edu>

> @@ -1484,6 +1526,7 @@ EXPORT_SYMBOL_GPL(serial8250_modem_status);
>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  {
>  	unsigned char status;
> +	unsigned char int0, int1, int2, int3;
>  	unsigned long flags;
>  	struct uart_8250_port *up =
>  		container_of(port, struct uart_8250_port, port);
> @@ -1503,6 +1546,19 @@ int serial8250_handle_irq(struct uart_port
> *port, unsigned int iir)
>  	if (status & UART_LSR_THRE)
>  		serial8250_tx_chars(up);
> 
> +	/*
> +	 * These Exar UARTs have an extra interrupt indicator that could
> +	 * fire for a few unimplemented interrupts.  Put this here just
> +	 * to be on the safe side that these interrupts don't go unhandled.
> +	 */
> +
> +	if (up->port.type == PORT_XR17V35X && status == 0) {
> +		int0 = serial_port_in(port, 0x80);
> +		int1 = serial_port_in(port, 0x81);
> +		int2 = serial_port_in(port, 0x82);
> +		int3 = serial_port_in(port, 0x83);
> +	}
> +
>  	spin_unlock_irqrestore(&port->lock, flags);
>  	return 1;

Provide your own handle_irq method rather than adding more special cases
to the default one (you can just wrap the default one and then perform
the extra actions). Just a case of trying to keep the fast paths clean and
maintainable.

Otherwise looks good.

Alan
