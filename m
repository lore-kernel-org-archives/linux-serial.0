From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 1/2] tty/serial: atmel: Add is_half_duplex helper
Date: Mon, 18 Mar 2019 14:41:35 +0100
Message-ID: <c8ee3b11-e674-4992-c24f-b0434887a21e@sorico.fr>
References: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
 <20190315092334.13246-2-razvan.stefanescu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315092334.13246-2-razvan.stefanescu@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Razvan Stefanescu <razvan.stefanescu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Gil Weber <webergil@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[ adding Gil Weber in Cc: ]

Le 15/03/2019 à 10:23, Razvan Stefanescu a écrit :
> Use a helper function to check that a port needs to use half duplex
> communication, replacing several occurrences of multi-line bit checking.
> 
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 05147fe24343..a6577b1c4461 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -231,6 +231,13 @@ static inline void atmel_uart_write_char(struct uart_port *port, u8 value)
>  	__raw_writeb(value, port->membase + ATMEL_US_THR);
>  }
>  
> +static inline int atmel_uart_is_half_duplex(struct uart_port *port)
> +{
> +	return ((port->rs485.flags & SER_RS485_ENABLED) &&
> +		!(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> +		(port->iso7816.flags & SER_ISO7816_ENABLED);
> +}
> +
>  #ifdef CONFIG_SERIAL_ATMEL_PDC
>  static bool atmel_use_pdc_rx(struct uart_port *port)
>  {
> @@ -608,10 +615,10 @@ static void atmel_stop_tx(struct uart_port *port)
>  	/* Disable interrupts */
>  	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
>  
> -	if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -	    port->iso7816.flags & SER_ISO7816_ENABLED)
> -		atmel_start_rx(port);
> +	if (atmel_uart_is_half_duplex(port))
> +		if (!atomic_read(&atmel_port->tasklet_shutdown))
This check wasn't there before.
If it's really needed, please insert it in another patch and explain why
it's needed.

> +			atmel_start_rx(port);
> +
>  }
>  
>  /*
> @@ -628,9 +635,7 @@ static void atmel_start_tx(struct uart_port *port)
>  		return;
>  
>  	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
> -		if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -		    port->iso7816.flags & SER_ISO7816_ENABLED)
> +		if (atmel_uart_is_half_duplex(port))
>  			atmel_stop_rx(port);
>  
>  	if (atmel_use_pdc_tx(port))
> @@ -928,9 +933,7 @@ static void atmel_complete_tx_dma(void *arg)
>  	 */
>  	if (!uart_circ_empty(xmit))
>  		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
> -	else if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -		  !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -		 port->iso7816.flags & SER_ISO7816_ENABLED) {
> +	else if (atmel_uart_is_half_duplex(port)) {
>  		/* DMA done, stop TX, start RX for RS485 */
>  		atmel_start_rx(port);
>  	}
> @@ -1508,9 +1511,7 @@ static void atmel_tx_pdc(struct uart_port *port)
>  		atmel_uart_writel(port, ATMEL_US_IER,
>  				  atmel_port->tx_done_mask);
>  	} else {
> -		if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -		    port->iso7816.flags & SER_ISO7816_ENABLED) {
> +		if (atmel_uart_is_half_duplex(port)) {
>  			/* DMA done, stop TX, start RX for RS485 */
>  			atmel_start_rx(port);
>  		}
> 
