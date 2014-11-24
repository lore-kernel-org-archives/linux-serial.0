From: =Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] serial: pxa: hold port.lock when reporting modem line changes
Date: Mon, 24 Nov 2014 23:08:15 +0100
Message-ID: <87389845gw.fsf@free.fr>
References: <1416815313-20891-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:29815 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaKXWIS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 17:08:18 -0500
In-Reply-To: <1416815313-20891-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
	Eremin-Solenikov's message of "Mon, 24 Nov 2014 10:48:33 +0300")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 2f4c329..b59dcb1 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -223,6 +223,7 @@ static void serial_pxa_start_tx(struct uart_port *port)
>  	}
>  }
>  
> +/* should hold up->port.lock */
>  static inline void check_modem_status(struct uart_pxa_port *up)
>  {
>  	int status;
> @@ -258,7 +259,9 @@ static inline irqreturn_t serial_pxa_irq(int irq, void
>  *dev_id)
The spin_lock() should be here I think. As the spinlock price has to be paid,
let's have the whole function under spinlock().

>  	lsr = serial_in(up, UART_LSR);
>  	if (lsr & UART_LSR_DR)
>  		receive_chars(up, &lsr);
> +	spin_lock(&up->port.lock);
>  	check_modem_status(up);
> +	spin_unlock(&up->port.lock);
>  	if (lsr & UART_LSR_THRE)
>  		transmit_chars(up);
The spin_unlock() should be there, after transmission IMO.

Cheers.

-- 
Robert
