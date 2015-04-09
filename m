From: Leilei Zhao <leilei.zhao@atmel.com>
Subject: [PATCH] tty/serial: at91: handle IRQ status more safely
Date: Thu, 9 Apr 2015 10:48:15 +0800
Message-ID: <1428547695-11004-1-git-send-email-leilei.zhao@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Leilei Zhao <leilei.zhao@atmel.com>
List-Id: linux-serial@vger.kernel.org

Handle the changed flag of IRQ status in interruption
instead of handling it in tasklet due to the tasklet
may be scheduled more than once in one interruption.
Otherwise, the changed status may be processed more
than once which will lead to unexpected result. And
seriously, kernel will crash.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d58fe47..d536d31 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -165,6 +165,7 @@ struct atmel_uart_port {
 	struct tasklet_struct	tasklet;
 	unsigned int		irq_status;
 	unsigned int		irq_status_prev;
+	unsigned int		status_change;
 
 	struct circ_buf		rx_ring;
 
@@ -1175,6 +1176,9 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 	if (pending & (ATMEL_US_RIIC | ATMEL_US_DSRIC | ATMEL_US_DCDIC
 				| ATMEL_US_CTSIC)) {
 		atmel_port->irq_status = status;
+		atmel_port->status_change = atmel_port->irq_status ^
+					    atmel_port->irq_status_prev;
+		atmel_port->irq_status_prev = status;
 		tasklet_schedule(&atmel_port->tasklet);
 	}
 }
@@ -1521,17 +1525,14 @@ static void atmel_tasklet_func(unsigned long data)
 {
 	struct uart_port *port = (struct uart_port *)data;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	unsigned int status;
-	unsigned int status_change;
+	unsigned int status = atmel_port->irq_status;
+	unsigned int status_change = atmel_port->status_change;
 
 	/* The interrupt handler does not take the lock */
 	spin_lock(&port->lock);
 
 	atmel_port->schedule_tx(port);
 
-	status = atmel_port->irq_status;
-	status_change = status ^ atmel_port->irq_status_prev;
-
 	if (status_change & (ATMEL_US_RI | ATMEL_US_DSR
 				| ATMEL_US_DCD | ATMEL_US_CTS)) {
 		/* TODO: All reads to CSR will clear these interrupts! */
@@ -1546,7 +1547,7 @@ static void atmel_tasklet_func(unsigned long data)
 
 		wake_up_interruptible(&port->state->port.delta_msr_wait);
 
-		atmel_port->irq_status_prev = status;
+		atmel_port->status_change = 0;
 	}
 
 	atmel_port->schedule_rx(port);
-- 
1.7.9.5
