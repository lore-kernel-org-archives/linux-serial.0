From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 4/8] serial: 8250: add RX_DURING_TX capability to RS485 mode
Date: Wed, 16 Nov 2011 17:24:41 +0100
Message-ID: <1321460685-15753-5-git-send-email-w.sang@pengutronix.de>
References: <1321460685-15753-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321460685-15753-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>, Juergen Beisert <jbe@pengutronix.de>, Matthias Fuchs <mfuchs@ma-fu.de>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/tty/serial/8250.c |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index b5d3248..6a2f47f 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1304,6 +1304,26 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	up->port.irq = (irq > 0) ? irq : 0;
 }
 
+static void serial8250_stop_rx(struct uart_port *port)
+{
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
+
+	up->ier &= ~UART_IER_RLSI;
+	up->port.read_status_mask &= ~UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+}
+
+static void serial8250_start_rx(struct uart_port *port)
+{
+	struct uart_8250_port *up =
+		container_of(port, struct uart_8250_port, port);
+
+	up->ier |= UART_IER_RLSI;
+	up->port.read_status_mask |= UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+}
+
 static inline void __stop_tx(struct uart_8250_port *p)
 {
 	if (p->ier & UART_IER_THRI) {
@@ -1326,6 +1346,9 @@ static void serial8250_stop_tx(struct uart_port *port)
 		up->acr |= UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
+
+	if (!(up->rs485_flags & SER_RS485_RX_DURING_TX))
+		serial8250_start_rx(port);
 }
 
 static void transmit_chars(struct uart_8250_port *up);
@@ -1357,16 +1380,9 @@ static void serial8250_start_tx(struct uart_port *port)
 		up->acr &= ~UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
-}
 
-static void serial8250_stop_rx(struct uart_port *port)
-{
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
-
-	up->ier &= ~UART_IER_RLSI;
-	up->port.read_status_mask &= ~UART_LSR_DR;
-	serial_out(up, UART_IER, up->ier);
+	if (!(up->rs485_flags & SER_RS485_RX_DURING_TX))
+		serial8250_stop_rx(port);
 }
 
 static void serial8250_enable_ms(struct uart_port *port)
-- 
1.7.7.1
