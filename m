From: Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 8/8] tty/serial: atmel: Prevent a warning on suspend
Date: Wed, 27 Sep 2017 10:35:55 +0200
Message-ID: <20170927083555.16580-9-romain.izard.pro@gmail.com>
References: <20170927083555.16580-1-romain.izard.pro@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170927083555.16580-1-romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Ale
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The atmel serial port driver reported the following warning on suspend:
atmel_usart f8020000.serial: ttyS1: Unable to drain transmitter

As the ATMEL_US_TXEMPTY status bit in ATMEL_US_CSR is always cleared
when the transmitter is disabled, we need to know the transmitter's
state to return the real fifo state. And as ATMEL_US_CR is write-only,
it is necessary to save the state of the transmitter in a local
variable, and update the variable when TXEN and TXDIS is written in
ATMEL_US_CR.

After those changes, atmel_tx_empty can return "empty" on suspend, the
warning in uart_suspend_port disappears, and suspending is 20ms shorter
for each enabled Atmel serial port.

Signed-off-by: Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Tested-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Acked-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/atmel_serial.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 7551cab438ff..ce45b4ada0bf 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -171,6 +171,7 @@ struct atmel_uart_port {
 	bool			has_hw_timer;
 	struct timer_list	uart_timer;
 
+	bool			tx_stopped;
 	bool			suspended;
 	unsigned int		pending;
 	unsigned int		pending_status;
@@ -380,6 +381,10 @@ static int atmel_config_rs485(struct uart_port *port,
  */
 static u_int atmel_tx_empty(struct uart_port *port)
 {
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	if (atmel_port->tx_stopped)
+		return TIOCSER_TEMT;
 	return (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXEMPTY) ?
 		TIOCSER_TEMT :
 		0;
@@ -485,6 +490,7 @@ static void atmel_stop_tx(struct uart_port *port)
 	 * is fully transmitted.
 	 */
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
+	atmel_port->tx_stopped = true;
 
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
@@ -521,6 +527,7 @@ static void atmel_start_tx(struct uart_port *port)
 
 	/* re-enable the transmitter */
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
+	atmel_port->tx_stopped = false;
 }
 
 /*
@@ -1866,6 +1873,7 @@ static int atmel_startup(struct uart_port *port)
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	/* enable xmit & rcvr */
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
+	atmel_port->tx_stopped = false;
 
 	setup_timer(&atmel_port->uart_timer,
 			atmel_uart_timer_callback,
@@ -2122,6 +2130,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* disable receiver and transmitter */
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS | ATMEL_US_RXDIS);
+	atmel_port->tx_stopped = true;
 
 	/* mode */
 	if (port->rs485.flags & SER_RS485_ENABLED) {
@@ -2207,6 +2216,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	atmel_uart_writel(port, ATMEL_US_BRGR, quot);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
+	atmel_port->tx_stopped = false;
 
 	/* restore interrupts */
 	atmel_uart_writel(port, ATMEL_US_IER, imr);
@@ -2450,6 +2460,7 @@ static void atmel_console_write(struct console *co, const char *s, u_int count)
 
 	/* Make sure that tx path is actually able to send characters */
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
+	atmel_port->tx_stopped = false;
 
 	uart_console_write(port, s, count, atmel_console_putchar);
 
@@ -2511,6 +2522,7 @@ static int __init atmel_console_setup(struct console *co, char *options)
 {
 	int ret;
 	struct uart_port *port = &atmel_ports[co->index].uart;
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	int baud = 115200;
 	int bits = 8;
 	int parity = 'n';
@@ -2528,6 +2540,7 @@ static int __init atmel_console_setup(struct console *co, char *options)
 	atmel_uart_writel(port, ATMEL_US_IDR, -1);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
+	atmel_port->tx_stopped = false;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
