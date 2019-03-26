From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v2 1/2] tty/serial: atmel: Add is_half_duplex helper
Date: Tue, 26 Mar 2019 16:10:17 +0100
Message-ID: <fc6d0053-0b87-539b-8733-443494613858@sorico.fr>
References: <20190319132035.18481-1-razvan.stefanescu@microchip.com>
 <20190319132035.18481-2-razvan.stefanescu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319132035.18481-2-razvan.stefanescu@microchip.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Razvan Stefanescu <razvan.stefanescu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Gil Weber <webergil@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Le 19/03/2019 à 14:20, Razvan Stefanescu a écrit :
> Use a helper function to check that a port needs to use half duplex
> communication, replacing several occurrences of multi-line bit checking.
> 
> Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable
> RX after TX is done")
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

NB: backport on kernel older than 4.20 will fail because of the
SER_ISO7816_ENABLED flag.
> ---
> Changelog:
> v2: 
>   - remove extra check
>   - add fix info
> 
>  drivers/tty/serial/atmel_serial.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 05147fe24343..b4b89a16a41b 100644
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
> @@ -608,10 +615,9 @@ static void atmel_stop_tx(struct uart_port *port)
>  	/* Disable interrupts */
>  	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
>  
> -	if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -	    port->iso7816.flags & SER_ISO7816_ENABLED)
> +	if (atmel_uart_is_half_duplex(port))
>  		atmel_start_rx(port);
> +
>  }
>  
>  /*
> @@ -628,9 +634,7 @@ static void atmel_start_tx(struct uart_port *port)
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
> @@ -928,9 +932,7 @@ static void atmel_complete_tx_dma(void *arg)
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
> @@ -1508,9 +1510,7 @@ static void atmel_tx_pdc(struct uart_port *port)
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
