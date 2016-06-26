From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH v2] tty/serial: atmel: enforce tasklet init and termination sequences
Date: Sun, 26 Jun 2016 09:44:49 +0200
Message-ID: <20160626074449.14523-1-nicolas.ferre@atmel.com>
References: <20160625203959.GA22761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160625203959.GA22761@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

As some race conditions are identified in the termination process of tasklets,
enforce the atmel_shutdown() sequence. This way we make sure that no new
tasklets or software timer are scheduled during shutdown process.

An atomic flag is positioned to give this information throughout the code.

We also remove tasklet_disable() calls that were leading to deadlocks while
stopping the driver. A simpler init/kill sequence is used.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
- v2: fix build. Error in the struct name called in atmel_serial_probe()

Greg,

Sorry for the noise. My porting of this patch had an issue and was breaking the
build, indeed.
So, here is the v2 on top of your tty-testing branch which already contains the
rest of the series that you integrated yesterday.

Thanks, bye.


 drivers/tty/serial/atmel_serial.c | 61 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index f887c1df23e6..2eaa18ddef61 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -153,6 +153,7 @@ struct atmel_uart_port {
 	struct scatterlist		sg_rx;
 	struct tasklet_struct	tasklet_rx;
 	struct tasklet_struct	tasklet_tx;
+	atomic_t		tasklet_shutdown;
 	unsigned int		irq_status_prev;
 	unsigned int		tx_len;
 
@@ -286,6 +287,13 @@ static bool atmel_use_fifo(struct uart_port *port)
 	return atmel_port->fifo_size;
 }
 
+static void atmel_tasklet_schedule(struct atmel_uart_port *atmel_port,
+				   struct tasklet_struct *t)
+{
+	if (!atomic_read(&atmel_port->tasklet_shutdown))
+		tasklet_schedule(t);
+}
+
 static unsigned int atmel_get_lines_status(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
@@ -717,7 +725,7 @@ static void atmel_rx_chars(struct uart_port *port)
 		status = atmel_uart_readl(port, ATMEL_US_CSR);
 	}
 
-	tasklet_schedule(&atmel_port->tasklet_rx);
+	atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_rx);
 }
 
 /*
@@ -788,7 +796,7 @@ static void atmel_complete_tx_dma(void *arg)
 	 * remaining data from the beginning of xmit->buf to xmit->head.
 	 */
 	if (!uart_circ_empty(xmit))
-		tasklet_schedule(&atmel_port->tasklet_tx);
+		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -973,7 +981,7 @@ static void atmel_complete_rx_dma(void *arg)
 	struct uart_port *port = arg;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	tasklet_schedule(&atmel_port->tasklet_rx);
+	atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_rx);
 }
 
 static void atmel_release_rx_dma(struct uart_port *port)
@@ -1013,7 +1021,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 	if (dmastat == DMA_ERROR) {
 		dev_dbg(port->dev, "Get residue error, restart tasklet\n");
 		atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_TIMEOUT);
-		tasklet_schedule(&atmel_port->tasklet_rx);
+		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_rx);
 		return;
 	}
 
@@ -1167,8 +1175,11 @@ static void atmel_uart_timer_callback(unsigned long data)
 	struct uart_port *port = (void *)data;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	tasklet_schedule(&atmel_port->tasklet_rx);
-	mod_timer(&atmel_port->uart_timer, jiffies + uart_poll_timeout(port));
+	if (!atomic_read(&atmel_port->tasklet_shutdown)) {
+		tasklet_schedule(&atmel_port->tasklet_rx);
+		mod_timer(&atmel_port->uart_timer,
+			  jiffies + uart_poll_timeout(port));
+	}
 }
 
 /*
@@ -1190,7 +1201,8 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 		if (pending & (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT)) {
 			atmel_uart_writel(port, ATMEL_US_IDR,
 					  (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT));
-			tasklet_schedule(&atmel_port->tasklet_rx);
+			atmel_tasklet_schedule(atmel_port,
+					       &atmel_port->tasklet_rx);
 		}
 
 		if (pending & (ATMEL_US_RXBRK | ATMEL_US_OVRE |
@@ -1202,7 +1214,8 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 		if (pending & ATMEL_US_TIMEOUT) {
 			atmel_uart_writel(port, ATMEL_US_IDR,
 					  ATMEL_US_TIMEOUT);
-			tasklet_schedule(&atmel_port->tasklet_rx);
+			atmel_tasklet_schedule(atmel_port,
+					       &atmel_port->tasklet_rx);
 		}
 	}
 
@@ -1232,7 +1245,7 @@ atmel_handle_transmit(struct uart_port *port, unsigned int pending)
 		/* Either PDC or interrupt transmission */
 		atmel_uart_writel(port, ATMEL_US_IDR,
 				  atmel_port->tx_done_mask);
-		tasklet_schedule(&atmel_port->tasklet_tx);
+		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
 	}
 }
 
@@ -1793,8 +1806,11 @@ static int atmel_startup(struct uart_port *port)
 		return retval;
 	}
 
-	tasklet_enable(&atmel_port->tasklet_rx);
-	tasklet_enable(&atmel_port->tasklet_tx);
+	atomic_set(&atmel_port->tasklet_shutdown, 0);
+	tasklet_init(&atmel_port->tasklet_rx, atmel_tasklet_rx_func,
+			(unsigned long)port);
+	tasklet_init(&atmel_port->tasklet_tx, atmel_tasklet_tx_func,
+			(unsigned long)port);
 
 	/*
 	 * Initialize DMA (if necessary)
@@ -1913,31 +1929,36 @@ static void atmel_shutdown(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
+	/* Disable interrupts at device level */
+	atmel_uart_writel(port, ATMEL_US_IDR, -1);
+
+	/* Prevent spurious interrupts from scheduling the tasklet */
+	atomic_inc(&atmel_port->tasklet_shutdown);
+
 	/*
 	 * Prevent any tasklets being scheduled during
 	 * cleanup
 	 */
 	del_timer_sync(&atmel_port->uart_timer);
 
+	/* Make sure that no interrupt is on the fly */
+	synchronize_irq(port->irq);
+
 	/*
 	 * Clear out any scheduled tasklets before
 	 * we destroy the buffers
 	 */
-	tasklet_disable(&atmel_port->tasklet_rx);
-	tasklet_disable(&atmel_port->tasklet_tx);
 	tasklet_kill(&atmel_port->tasklet_rx);
 	tasklet_kill(&atmel_port->tasklet_tx);
 
 	/*
 	 * Ensure everything is stopped and
-	 * disable all interrupts, port and break condition.
+	 * disable port and break condition.
 	 */
 	atmel_stop_rx(port);
 	atmel_stop_tx(port);
 
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA);
-	atmel_uart_writel(port, ATMEL_US_IDR, -1);
-
 
 	/*
 	 * Shut-down the DMA.
@@ -2321,13 +2342,6 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	port->irq	= pdev->resource[1].start;
 	port->rs485_config	= atmel_config_rs485;
 
-	tasklet_init(&atmel_port->tasklet_rx, atmel_tasklet_rx_func,
-			(unsigned long)port);
-	tasklet_init(&atmel_port->tasklet_tx, atmel_tasklet_tx_func,
-			(unsigned long)port);
-	tasklet_disable(&atmel_port->tasklet_rx);
-	tasklet_disable(&atmel_port->tasklet_tx);
-
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
 	if (pdata && pdata->regs) {
@@ -2712,6 +2726,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	atmel_port->uart.line = ret;
 	atmel_serial_probe_fifos(atmel_port, pdev);
 
+	atomic_set(&atmel_port->tasklet_shutdown, 0);
 	spin_lock_init(&atmel_port->lock_suspended);
 
 	ret = atmel_init_port(atmel_port, pdev);
-- 
2.9.0
