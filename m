From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [RESEND PATCH 2/4] tty/serial: atmel: split tx and rx paths
Date: Fri, 17 Jun 2016 12:05:47 +0200
Message-ID: <e32adb3b3bc4b03eafe6ecd87bc7e7d67799b26c.1466157015.git.nicolas.ferre@atmel.com>
References: <cover.1466157015.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466157015.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

Split TX and RX paths to not schedule RX tasklet on TX events and vice versa.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 53 +++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 8854ac6f383d..6c1ec7d0d497 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -145,7 +145,8 @@ struct atmel_uart_port {
 	dma_cookie_t			cookie_rx;
 	struct scatterlist		sg_tx;
 	struct scatterlist		sg_rx;
-	struct tasklet_struct	tasklet;
+	struct tasklet_struct	tasklet_rx;
+	struct tasklet_struct	tasklet_tx;
 	unsigned int		irq_status_prev;
 	unsigned int		tx_len;
 
@@ -708,7 +709,7 @@ static void atmel_rx_chars(struct uart_port *port)
 		status = atmel_uart_readl(port, ATMEL_US_CSR);
 	}
 
-	tasklet_schedule(&atmel_port->tasklet);
+	tasklet_schedule(&atmel_port->tasklet_rx);
 }
 
 /*
@@ -779,7 +780,7 @@ static void atmel_complete_tx_dma(void *arg)
 	 * remaining data from the beginning of xmit->buf to xmit->head.
 	 */
 	if (!uart_circ_empty(xmit))
-		tasklet_schedule(&atmel_port->tasklet);
+		tasklet_schedule(&atmel_port->tasklet_tx);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -964,7 +965,7 @@ static void atmel_complete_rx_dma(void *arg)
 	struct uart_port *port = arg;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	tasklet_schedule(&atmel_port->tasklet);
+	tasklet_schedule(&atmel_port->tasklet_rx);
 }
 
 static void atmel_release_rx_dma(struct uart_port *port)
@@ -1004,7 +1005,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 	if (dmastat == DMA_ERROR) {
 		dev_dbg(port->dev, "Get residue error, restart tasklet\n");
 		atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_TIMEOUT);
-		tasklet_schedule(&atmel_port->tasklet);
+		tasklet_schedule(&atmel_port->tasklet_rx);
 		return;
 	}
 
@@ -1158,7 +1159,7 @@ static void atmel_uart_timer_callback(unsigned long data)
 	struct uart_port *port = (void *)data;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	tasklet_schedule(&atmel_port->tasklet);
+	tasklet_schedule(&atmel_port->tasklet_rx);
 	mod_timer(&atmel_port->uart_timer, jiffies + uart_poll_timeout(port));
 }
 
@@ -1181,7 +1182,7 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 		if (pending & (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT)) {
 			atmel_uart_writel(port, ATMEL_US_IDR,
 					  (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT));
-			tasklet_schedule(&atmel_port->tasklet);
+			tasklet_schedule(&atmel_port->tasklet_rx);
 		}
 
 		if (pending & (ATMEL_US_RXBRK | ATMEL_US_OVRE |
@@ -1193,7 +1194,7 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 		if (pending & ATMEL_US_TIMEOUT) {
 			atmel_uart_writel(port, ATMEL_US_IDR,
 					  ATMEL_US_TIMEOUT);
-			tasklet_schedule(&atmel_port->tasklet);
+			tasklet_schedule(&atmel_port->tasklet_rx);
 		}
 	}
 
@@ -1223,7 +1224,7 @@ atmel_handle_transmit(struct uart_port *port, unsigned int pending)
 		/* Either PDC or interrupt transmission */
 		atmel_uart_writel(port, ATMEL_US_IDR,
 				  atmel_port->tx_done_mask);
-		tasklet_schedule(&atmel_port->tasklet);
+		tasklet_schedule(&atmel_port->tasklet_tx);
 	}
 }
 
@@ -1582,18 +1583,25 @@ static int atmel_prepare_rx_pdc(struct uart_port *port)
 /*
  * tasklet handling tty stuff outside the interrupt handler.
  */
-static void atmel_tasklet_func(unsigned long data)
+static void atmel_tasklet_rx_func(unsigned long data)
 {
 	struct uart_port *port = (struct uart_port *)data;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
 	/* The interrupt handler does not take the lock */
 	spin_lock(&port->lock);
-
-	atmel_port->schedule_tx(port);
-
 	atmel_port->schedule_rx(port);
+	spin_unlock(&port->lock);
+}
 
+static void atmel_tasklet_tx_func(unsigned long data)
+{
+	struct uart_port *port = (struct uart_port *)data;
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	/* The interrupt handler does not take the lock */
+	spin_lock(&port->lock);
+	atmel_port->schedule_tx(port);
 	spin_unlock(&port->lock);
 }
 
@@ -1777,7 +1785,8 @@ static int atmel_startup(struct uart_port *port)
 		return retval;
 	}
 
-	tasklet_enable(&atmel_port->tasklet);
+	tasklet_enable(&atmel_port->tasklet_rx);
+	tasklet_enable(&atmel_port->tasklet_tx);
 
 	/*
 	 * Initialize DMA (if necessary)
@@ -1906,8 +1915,10 @@ static void atmel_shutdown(struct uart_port *port)
 	 * Clear out any scheduled tasklets before
 	 * we destroy the buffers
 	 */
-	tasklet_disable(&atmel_port->tasklet);
-	tasklet_kill(&atmel_port->tasklet);
+	tasklet_disable(&atmel_port->tasklet_rx);
+	tasklet_disable(&atmel_port->tasklet_tx);
+	tasklet_kill(&atmel_port->tasklet_rx);
+	tasklet_kill(&atmel_port->tasklet_tx);
 
 	/*
 	 * Ensure everything is stopped and
@@ -2302,9 +2313,12 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	port->irq	= pdev->resource[1].start;
 	port->rs485_config	= atmel_config_rs485;
 
-	tasklet_init(&atmel_port->tasklet, atmel_tasklet_func,
+	tasklet_init(&atmel_port->tasklet_rx, atmel_tasklet_rx_func,
+			(unsigned long)port);
+	tasklet_init(&atmel_port->tasklet_tx, atmel_tasklet_tx_func,
 			(unsigned long)port);
-	tasklet_disable(&atmel_port->tasklet);
+	tasklet_disable(&atmel_port->tasklet_rx);
+	tasklet_disable(&atmel_port->tasklet_tx);
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
@@ -2786,7 +2800,8 @@ static int atmel_serial_remove(struct platform_device *pdev)
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	int ret = 0;
 
-	tasklet_kill(&atmel_port->tasklet);
+	tasklet_kill(&atmel_port->tasklet_rx);
+	tasklet_kill(&atmel_port->tasklet_tx);
 
 	device_init_wakeup(&pdev->dev, 0);
 
-- 
2.9.0
