From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/5] tty/serial: at91: correct check of buf used in DMA
Date: Thu, 26 Feb 2015 10:29:54 +0100
Message-ID: <54EEE792.9060706@suse.cz>
References: <1424933725-16242-1-git-send-email-leilei.zhao@atmel.com> <1424933725-16242-2-git-send-email-leilei.zhao@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424933725-16242-2-git-send-email-leilei.zhao@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leilei Zhao <leilei.zhao@atmel.com>, nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 02/26/2015, 07:55 AM, Leilei Zhao wrote:
> We only use buf of ring In DMA rx function while using buf of xmit
> in DMA tx function. So here we need definitively to check the buf
> of ring which is corresponding to DMA rx function.
> 
> Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 846552b..460903c 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1027,7 +1027,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	spin_lock_init(&atmel_port->lock_rx);
>  	sg_init_table(&atmel_port->sg_rx, 1);
>  	/* UART circular rx buffer is an aligned page. */
> -	BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
> +	BUG_ON((int)ring->buf & ~PAGE_MASK);

Please use PAGE_ALIGNED. This will also make the bad (int) cast to dismiss.

thanks,
-- 
js
suse labs
