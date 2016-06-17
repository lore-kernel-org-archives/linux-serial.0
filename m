From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [RESEND PATCH 1/4] tty/serial: atmel: re-integrate status check in irq handler
Date: Fri, 17 Jun 2016 12:05:46 +0200
Message-ID: <9d51633c3ea8bd9903731f194903e352e65ee8a3.1466157015.git.nicolas.ferre@atmel.com>
References: <cover.1466157015.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466157015.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

The IRQ status check and related actions was done in the tasklet without
benefit. So, move it back to the IRQ context to simplify IRQ handling and
having the possibility to split the tasklet in two separated ones for
receive and transmit actions.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 43 ++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 954941dd8124..8854ac6f383d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -146,9 +146,7 @@ struct atmel_uart_port {
 	struct scatterlist		sg_tx;
 	struct scatterlist		sg_rx;
 	struct tasklet_struct	tasklet;
-	unsigned int		irq_status;
 	unsigned int		irq_status_prev;
-	unsigned int		status_change;
 	unsigned int		tx_len;
 
 	struct circ_buf		rx_ring;
@@ -1237,14 +1235,27 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 		    unsigned int status)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int status_change;
 
 	if (pending & (ATMEL_US_RIIC | ATMEL_US_DSRIC | ATMEL_US_DCDIC
 				| ATMEL_US_CTSIC)) {
-		atmel_port->irq_status = status;
-		atmel_port->status_change = atmel_port->irq_status ^
-					    atmel_port->irq_status_prev;
+		status_change = status ^ atmel_port->irq_status_prev;
 		atmel_port->irq_status_prev = status;
-		tasklet_schedule(&atmel_port->tasklet);
+
+		if (status_change & (ATMEL_US_RI | ATMEL_US_DSR
+					| ATMEL_US_DCD | ATMEL_US_CTS)) {
+			/* TODO: All reads to CSR will clear these interrupts! */
+			if (status_change & ATMEL_US_RI)
+				port->icount.rng++;
+			if (status_change & ATMEL_US_DSR)
+				port->icount.dsr++;
+			if (status_change & ATMEL_US_DCD)
+				uart_handle_dcd_change(port, !(status & ATMEL_US_DCD));
+			if (status_change & ATMEL_US_CTS)
+				uart_handle_cts_change(port, !(status & ATMEL_US_CTS));
+
+			wake_up_interruptible(&port->state->port.delta_msr_wait);
+		}
 	}
 }
 
@@ -1575,31 +1586,12 @@ static void atmel_tasklet_func(unsigned long data)
 {
 	struct uart_port *port = (struct uart_port *)data;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	unsigned int status = atmel_port->irq_status;
-	unsigned int status_change = atmel_port->status_change;
 
 	/* The interrupt handler does not take the lock */
 	spin_lock(&port->lock);
 
 	atmel_port->schedule_tx(port);
 
-	if (status_change & (ATMEL_US_RI | ATMEL_US_DSR
-				| ATMEL_US_DCD | ATMEL_US_CTS)) {
-		/* TODO: All reads to CSR will clear these interrupts! */
-		if (status_change & ATMEL_US_RI)
-			port->icount.rng++;
-		if (status_change & ATMEL_US_DSR)
-			port->icount.dsr++;
-		if (status_change & ATMEL_US_DCD)
-			uart_handle_dcd_change(port, !(status & ATMEL_US_DCD));
-		if (status_change & ATMEL_US_CTS)
-			uart_handle_cts_change(port, !(status & ATMEL_US_CTS));
-
-		wake_up_interruptible(&port->state->port.delta_msr_wait);
-
-		atmel_port->status_change = 0;
-	}
-
 	atmel_port->schedule_rx(port);
 
 	spin_unlock(&port->lock);
@@ -1833,7 +1825,6 @@ static int atmel_startup(struct uart_port *port)
 
 	/* Save current CSR for comparison in atmel_tasklet_func() */
 	atmel_port->irq_status_prev = atmel_get_lines_status(port);
-	atmel_port->irq_status = atmel_port->irq_status_prev;
 
 	/*
 	 * Finally, enable the serial port
-- 
2.9.0
