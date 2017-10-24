From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] tty/serial: atmel: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 12:54:17 +0200
Message-ID: <1508842457.6041.1.camel@gmail.com>
References: <20171024100003.GA67892@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171024100003.GA67892@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Le mardi 24 octobre 2017 à 03:00 -0700, Kees Cook a écrit :
> In preparation for unconditionally passing the struct timer_list
> pointer to
> all timer callbacks, switch to using the new timer_setup() and
> from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

Thanks !

> ---
>  drivers/tty/serial/atmel_serial.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c
> b/drivers/tty/serial/atmel_serial.c
> index 82d9c8eae04f..68d8685e5a50 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1185,10 +1185,11 @@ static int atmel_prepare_rx_dma(struct
> uart_port *port)
>  	return -EINVAL;
>  }
>  
> -static void atmel_uart_timer_callback(unsigned long data)
> +static void atmel_uart_timer_callback(struct timer_list *t)
>  {
> -	struct uart_port *port = (void *)data;
> -	struct atmel_uart_port *atmel_port =
> to_atmel_uart_port(port);
> +	struct atmel_uart_port *atmel_port = from_timer(atmel_port,
> t,
> +							uart_timer);
> +	struct uart_port *port = &atmel_port->uart;
>  
>  	if (!atomic_read(&atmel_port->tasklet_shutdown)) {
>  		tasklet_schedule(&atmel_port->tasklet_rx);
> @@ -1852,9 +1853,7 @@ static int atmel_startup(struct uart_port
> *port)
>  	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN |
> ATMEL_US_RXEN);
>  	atmel_port->tx_stopped = false;
>  
> -	setup_timer(&atmel_port->uart_timer,
> -			atmel_uart_timer_callback,
> -			(unsigned long)port);
> +	timer_setup(&atmel_port->uart_timer,
> atmel_uart_timer_callback, 0);
>  
>  	if (atmel_use_pdc_rx(port)) {
>  		/* set UART timeout */
> -- 
> 2.7.4
> 
> 
