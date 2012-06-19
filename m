From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Questions regarding adding a patch in linux/drivers/char/8250.c
Date: Tue, 19 Jun 2012 10:18:27 +0100
Message-ID: <20120619101827.150d3968@pyramind.ukuu.org.uk>
References: <00a301cd3719$b3faa370$1befea50$@com.tw>
	<20120521102848.7bfb49e0@pyramind.ukuu.org.uk>
	<002101cd4cff$74643c70$5d2cb550$@com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35565 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab2FSJOr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Jun 2012 05:14:47 -0400
In-Reply-To: <002101cd4cff$74643c70$5d2cb550$@com.tw>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Donald <donald@asix.com.tw>
Cc: linux-serial@vger.kernel.org


> +	struct pci_dev *pdev = container_of(port->dev, struct pci_dev, dev);
> +
>  	switch (termios->c_cflag & CSIZE) {
>  	case CS5:
>  		cval = UART_LCR_WLEN5;
> @@ -2351,6 +2354,13 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  	if (up->capabilities & UART_CAP_RTOIE)
>  		up->ier |= UART_IER_RTOIE;
>  
> +	if ((termios->c_cflag & PARENB) && (pdev->vendor == 0x9710)) {
> +		fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
> +		up->ier &= ~UART_IER_RLSI;
> +	} else {
> +		up->ier |= UART_IER_RLSI;
> +	}
> +

It's on my TODO list for the 3.6 merge. Your patch doesn't work (in fact
it crashes in some cases) because it blindly assumes an 8250 port is on
the PCI bus.

However it documents everything I need to know to push an actual fix.

Alan
