From: Benjamin Krill <ben@codiert.org>
Subject: Re: [PATCH] tty: nwpserial: Pass correct pointer to free_irq()
Date: Tue, 21 May 2013 09:18:10 +0200
Message-ID: <1369120690.1945.9.camel@bne>
References: <1369069650-1742-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.servclub.de ([46.4.228.165]:51557 "EHLO mail.servclub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574Ab3EUHqm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 May 2013 03:46:42 -0400
In-Reply-To: <1369069650-1742-1-git-send-email-lars@metafoo.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Acked-off-by: Benjamin Krill <ben@codiert.org>

On Mon, 2013-05-20 at 19:07 +0200, Lars-Peter Clausen wrote:
> free_irq() expects the same pointer that was passed to request_irq(), otherwise
> the IRQ is not freed.
> 
> The issue was found using the following coccinelle script:
> 
> <smpl>
> @r1@
> type T;
> T devid;
> @@
> request_irq(..., devid)
> 
> @r2@
> type r1.T;
> T devid;
> position p;
> @@
> free_irq@p(..., devid)
> 
> @@
> position p != r2.p;
> @@
> *free_irq@p(...)
> </smpl>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/tty/serial/nwpserial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/nwpserial.c b/drivers/tty/serial/nwpserial.c
> index 77287c5..549c70a 100644
> --- a/drivers/tty/serial/nwpserial.c
> +++ b/drivers/tty/serial/nwpserial.c
> @@ -199,7 +199,7 @@ static void nwpserial_shutdown(struct uart_port *port)
>  	dcr_write(up->dcr_host, UART_IER, up->ier);
>  
>  	/* free irq */
> -	free_irq(up->port.irq, port);
> +	free_irq(up->port.irq, up);
>  }
>  
>  static int nwpserial_verify_port(struct uart_port *port,


