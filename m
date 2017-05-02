From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v2] tty/serial: atmel: use offset_in_page() macro
Date: Tue, 2 May 2017 10:47:51 +0200
Message-ID: <54d4b9f3-7aca-ff76-9424-25856e923704@gmail.com>
References: <4467961523eb25226f3dc7b570c98208f31a9750.1493187215.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4467961523eb25226f3dc7b570c98208f31a9750.1493187215.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 29/04/2017 03:39, Geliang Tang wrote:
> Use offset_in_page() macro instead of open-coding.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
> Changes in v2:
>  - include mm.h
> ---
>  drivers/tty/serial/atmel_serial.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index c355ac9..d25f044 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -46,6 +46,7 @@
>  #include <linux/err.h>
>  #include <linux/irq.h>
>  #include <linux/suspend.h>
> +#include <linux/mm.h>
>  
>  #include <asm/io.h>
>  #include <asm/ioctls.h>
> @@ -959,7 +960,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	sg_set_page(&atmel_port->sg_tx,
>  			virt_to_page(port->state->xmit.buf),
>  			UART_XMIT_SIZE,
> -			(unsigned long)port->state->xmit.buf & ~PAGE_MASK);
> +			offset_in_page(port->state->xmit.buf));
>  	nent = dma_map_sg(port->dev,
>  				&atmel_port->sg_tx,
>  				1,
> @@ -1141,7 +1142,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	sg_set_page(&atmel_port->sg_rx,
>  		    virt_to_page(ring->buf),
>  		    sizeof(struct atmel_uart_char) * ATMEL_SERIAL_RINGSIZE,
> -		    (unsigned long)ring->buf & ~PAGE_MASK);
> +		    offset_in_page(ring->buf));
>  	nent = dma_map_sg(port->dev,
>  			  &atmel_port->sg_rx,
>  			  1,
> 

Thanks !
