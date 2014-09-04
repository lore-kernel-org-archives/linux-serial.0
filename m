From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty/serial: at91: BUG: disable interrupts when !UART_ENABLE_MS()
Date: Thu, 04 Sep 2014 11:47:17 -0400
Message-ID: <54088985.80102@hurleysoftware.com>
References: <1409760567-13186-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:39821 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752840AbaIDPr0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Sep 2014 11:47:26 -0400
In-Reply-To: <1409760567-13186-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/03/2014 12:09 PM, Richard Genoud wrote:
> In set_termios(), interrupts where not disabled if UART_ENABLE_MS() was
> false.
> 
> Tested on at91sam9g35.
> 
> CC: stable@vger.kernel.org # >= 3.16

Awesome, thank you.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 43 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 7b63677475c1..d7d4584549a5 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -527,6 +527,45 @@ static void atmel_enable_ms(struct uart_port *port)
>  }
>  
>  /*
> + * Disable modem status interrupts
> + */
> +static void atmel_disable_ms(struct uart_port *port)
> +{
> +	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	uint32_t idr = 0;
> +
> +	/*
> +	 * Interrupt should not be disabled twice
> +	 */
> +	if (!atmel_port->ms_irq_enabled)
> +		return;
> +
> +	atmel_port->ms_irq_enabled = false;
> +
> +	if (atmel_port->gpio_irq[UART_GPIO_CTS] >= 0)
> +		disable_irq(atmel_port->gpio_irq[UART_GPIO_CTS]);
> +	else
> +		idr |= ATMEL_US_CTSIC;
> +
> +	if (atmel_port->gpio_irq[UART_GPIO_DSR] >= 0)
> +		disable_irq(atmel_port->gpio_irq[UART_GPIO_DSR]);
> +	else
> +		idr |= ATMEL_US_DSRIC;
> +
> +	if (atmel_port->gpio_irq[UART_GPIO_RI] >= 0)
> +		disable_irq(atmel_port->gpio_irq[UART_GPIO_RI]);
> +	else
> +		idr |= ATMEL_US_RIIC;
> +
> +	if (atmel_port->gpio_irq[UART_GPIO_DCD] >= 0)
> +		disable_irq(atmel_port->gpio_irq[UART_GPIO_DCD]);
> +	else
> +		idr |= ATMEL_US_DCDIC;
> +
> +	UART_PUT_IDR(port, idr);
> +}
> +
> +/*
>   * Control the transmission of a break signal
>   */
>  static void atmel_break_ctl(struct uart_port *port, int break_state)
> @@ -1993,7 +2032,9 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  	/* CTS flow-control and modem-status interrupts */
>  	if (UART_ENABLE_MS(port, termios->c_cflag))
> -		port->ops->enable_ms(port);
> +		atmel_enable_ms(port);
> +	else
> +		atmel_disable_ms(port);
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
> 

