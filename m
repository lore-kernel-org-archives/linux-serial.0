From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v1 10/10] tty/serial: atmel: Prevent a warning on suspend
Date: Mon, 11 Sep 2017 11:52:12 +0200
Message-ID: <CAGkQfmOBNYeYTrbzAZBZ6cC5==Pfm6pZnho-9P8ggPjMZXX4nA@mail.gmail.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
 <20170908153604.28383-11-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170908153604.28383-11-romain.izard.pro@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Jonathan Cameron <jic23@kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-serial@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>, linux-clk@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2017-09-08 17:36 GMT+02:00 Romain Izard <romain.izard.pro@gmail.com>:
> The atmel serial port driver reported the following warning on suspend:
> atmel_usart f8020000.serial: ttyS1: Unable to drain transmitter
>
> As the ATMEL_US_TXEMPTY status bit in ATMEL_US_CSR is always cleared
> when the transmitter is disabled, we need to know the transmitter's
> state to return the real fifo state. And as ATMEL_US_CR is write-only,
> it is necessary to save the state of the transmitter in a local
> variable, and update the variable when TXEN and TXDIS is written in
> ATMEL_US_CR.
>
> After those changes, atmel_tx_empty can return "empty" on suspend, the
> warning in uart_suspend_port disappears, and suspending is 20ms shorter
> for each enabled Atmel serial port.
>
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 7551cab438ff..195c0d1b594e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -171,6 +171,7 @@ struct atmel_uart_port {
>         bool                    has_hw_timer;
>         struct timer_list       uart_timer;
>
> +       bool                    tx_stopped;
>         bool                    suspended;
>         unsigned int            pending;
>         unsigned int            pending_status;
> @@ -380,6 +381,10 @@ static int atmel_config_rs485(struct uart_port *port,
>   */
>  static u_int atmel_tx_empty(struct uart_port *port)
>  {
> +       struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +
> +       if (atmel_port->tx_stopped)
> +               return TIOCSER_TEMT;
>         return (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXEMPTY) ?
>                 TIOCSER_TEMT :
>                 0;
> @@ -485,6 +490,7 @@ static void atmel_stop_tx(struct uart_port *port)
>          * is fully transmitted.
>          */
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
> +       atmel_port->tx_stopped = true;
>
>         /* Disable interrupts */
>         atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
> @@ -492,6 +498,7 @@ static void atmel_stop_tx(struct uart_port *port)
>         if ((port->rs485.flags & SER_RS485_ENABLED) &&
>             !(port->rs485.flags & SER_RS485_RX_DURING_TX))
>                 atmel_start_rx(port);
> +
>  }
>
>  /*
> @@ -521,6 +528,7 @@ static void atmel_start_tx(struct uart_port *port)
>
>         /* re-enable the transmitter */
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
> +       atmel_port->tx_stopped = false;
>  }
>
>  /*
> @@ -1866,6 +1874,7 @@ static int atmel_startup(struct uart_port *port)
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>         /* enable xmit & rcvr */
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
> +       atmel_port->tx_stopped = false;
>
>         setup_timer(&atmel_port->uart_timer,
>                         atmel_uart_timer_callback,
> @@ -2122,6 +2131,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>
>         /* disable receiver and transmitter */
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS | ATMEL_US_RXDIS);
> +       atmel_port->tx_stopped = true;
>
>         /* mode */
>         if (port->rs485.flags & SER_RS485_ENABLED) {
> @@ -2207,6 +2217,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>         atmel_uart_writel(port, ATMEL_US_BRGR, quot);
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
> +       atmel_port->tx_stopped = false;
>
>         /* restore interrupts */
>         atmel_uart_writel(port, ATMEL_US_IER, imr);
> @@ -2450,6 +2461,7 @@ static void atmel_console_write(struct console *co, const char *s, u_int count)
>
>         /* Make sure that tx path is actually able to send characters */
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
> +       atmel_port->tx_stopped = false;
>
>         uart_console_write(port, s, count, atmel_console_putchar);
>
> @@ -2528,6 +2540,7 @@ static int __init atmel_console_setup(struct console *co, char *options)
>         atmel_uart_writel(port, ATMEL_US_IDR, -1);
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
> +       atmel_port->tx_stopped = false;
>
>         if (options)
>                 uart_parse_options(options, &baud, &parity, &bits, &flow);
> --
> 2.11.0
>

Unfortunately this patch was broken when I reported it from my branch to
the v4.13, as it does not build because of the missing declaration of
'atmel_port' in 'atmel_console_setup'.

I'll send a corrected version for v2.

-- 
Romain Izard
