From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 14/24] tty: serial: fsl_lpuart: Introduce lpuart_wait_bit_set()
Date: Mon, 29 Jul 2019 12:52:16 -0700
Message-ID: <20190729195226.8862-15-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Busy polling on a bit in a register is used in multiple places in the
driver. Move it into a shared function.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 42 +++++++++++++++++----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 50a707c88a16..dde5caf724ff 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -548,6 +548,20 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 }
 
+static void lpuart_wait_bit_set(struct uart_port *port, unsigned int offset,
+				u8 bit)
+{
+	while (!(readb(port->membase + offset) & bit))
+		barrier();
+}
+
+static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
+				  u32 bit)
+{
+	while (!(lpuart32_read(port, offset) & bit))
+		barrier();
+}
+
 #if defined(CONFIG_CONSOLE_POLL)
 
 static int lpuart_poll_init(struct uart_port *port)
@@ -591,9 +605,7 @@ static int lpuart_poll_init(struct uart_port *port)
 static void lpuart_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	/* drain */
-	while (!(readb(port->membase + UARTSR1) & UARTSR1_TDRE))
-		barrier();
-
+	lpuart_wait_bit_set(port, UARTSR1, UARTSR1_TDRE);
 	writeb(c, port->membase + UARTDR);
 }
 
@@ -643,9 +655,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 
 static void lpuart32_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	while (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE))
-		barrier();
-
+	lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TDRE);
 	lpuart32_write(port, UARTDATA, c);
 }
 
@@ -1723,8 +1733,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
-	while (!(readb(sport->port.membase + UARTSR1) & UARTSR1_TC))
-		barrier();
+	lpuart_wait_bit_set(&sport->port, UARTSR1, UARTSR1_TC);
 
 	/* disable transmit and receive */
 	writeb(old_cr2 & ~(UARTCR2_TE | UARTCR2_RE),
@@ -1939,8 +1948,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
-	while (!(lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_TC))
-		barrier();
+	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	/* disable transmit and receive */
 	lpuart32_write(&sport->port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
@@ -2055,17 +2063,13 @@ static struct lpuart_port *lpuart_ports[UART_NR];
 #ifdef CONFIG_SERIAL_FSL_LPUART_CONSOLE
 static void lpuart_console_putchar(struct uart_port *port, int ch)
 {
-	while (!(readb(port->membase + UARTSR1) & UARTSR1_TDRE))
-		barrier();
-
+	lpuart_wait_bit_set(port, UARTSR1, UARTSR1_TDRE);
 	writeb(ch, port->membase + UARTDR);
 }
 
 static void lpuart32_console_putchar(struct uart_port *port, int ch)
 {
-	while (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE))
-		barrier();
-
+	lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TDRE);
 	lpuart32_write(port, ch, UARTDATA);
 }
 
@@ -2091,8 +2095,7 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 	uart_console_write(&sport->port, s, count, lpuart_console_putchar);
 
 	/* wait for transmitter finish complete and restore CR2 */
-	while (!(readb(sport->port.membase + UARTSR1) & UARTSR1_TC))
-		barrier();
+	lpuart_wait_bit_set(&sport->port, UARTSR1, UARTSR1_TC);
 
 	writeb(old_cr2, sport->port.membase + UARTCR2);
 
@@ -2122,8 +2125,7 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 	uart_console_write(&sport->port, s, count, lpuart32_console_putchar);
 
 	/* wait for transmitter finish complete and restore CR2 */
-	while (!(lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_TC))
-		barrier();
+	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	lpuart32_write(&sport->port, old_cr, UARTCTRL);
 
-- 
2.21.0
