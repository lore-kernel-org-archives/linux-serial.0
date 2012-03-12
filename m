From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial: PL011: clear pending interrupts
Date: Mon, 12 Mar 2012 08:32:22 +0000
Message-ID: <20120312083221.GW17370@n2100.arm.linux.org.uk>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49382 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab2CLIci (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 04:32:38 -0400
Content-Disposition: inline
In-Reply-To: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Jong-Sung Kim <neidhard.kim@lge.com>, Linus Walleij <linus.walleij@linaro.org>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Mon, Mar 12, 2012 at 09:25:50AM +0100, Linus Walleij wrote:
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 6800f5f..ff3fed0 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -224,6 +224,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
>  		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
>  	}
>  

What if we really do end up receiving some characters here?

> +	/* RXIS but RXFE? Just clear the interrupt */
> +	if(unlikely(fifotaken == 0))
> +		writew(UART011_RTIS | UART011_RXIS,
> +		       uap->port.membase + UART011_ICR);
