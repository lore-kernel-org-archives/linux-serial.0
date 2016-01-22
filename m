From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 2/4] tty: serial: 8250: add optional spinlock arg to serial8250_rx_chars
Date: Fri, 22 Jan 2016 11:27:43 +0100
Message-ID: <877fj1rjs0.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, peter@hurleysoftware.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

serial8250_rx_chars() must be called from interrupt context and with
the port lock held. The port lock is released temporarily within that
function to call tty_flip_buffer_push(). However, there may be other
drivers that need to synchronize the tty_flip_buffer_push() call within
serial8250_rx_chars() with other contexts. Since the port lock cannot
be used for this synchronization, an optional spinlock argument is added.
If non-NULL, this will be locked during the tty_flip_buffer_push() call.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 patch against next-20160122

 drivers/tty/serial/8250/8250_fsl.c  |    2 +-
 drivers/tty/serial/8250/8250_omap.c |    2 +-
 drivers/tty/serial/8250/8250_port.c |    9 +++++++--
 include/linux/serial_8250.h         |    3 ++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 910bfee..790868d 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -49,7 +49,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	lsr = orig_lsr = up->port.serial_in(&up->port, UART_LSR);
 
 	if (lsr & (UART_LSR_DR | UART_LSR_BI))
-		lsr = serial8250_rx_chars(up, lsr);
+		lsr = serial8250_rx_chars(up, lsr, NULL);
 
 	serial8250_modem_status(up);
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a2c0734..6cf3b4f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1024,7 +1024,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 		dma_err = omap_8250_rx_dma(up, iir);
 		if (dma_err) {
-			status = serial8250_rx_chars(up, status);
+			status = serial8250_rx_chars(up, status, NULL);
 			omap_8250_rx_dma(up, 0);
 		}
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8d262bc..e838115 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1418,7 +1418,8 @@ static void serial8250_enable_ms(struct uart_port *port)
  * by this Rx routine.
  */
 unsigned char
-serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
+serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr,
+		    spinlock_t *flip_lock)
 {
 	struct uart_port *port = &up->port;
 	unsigned char ch;
@@ -1485,7 +1486,11 @@ ignore_char:
 		lsr = serial_in(up, UART_LSR);
 	} while ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (--max_count > 0));
 	spin_unlock(&port->lock);
+	if (flip_lock)
+		spin_lock(flip_lock);
 	tty_flip_buffer_push(&port->state->port);
+	if (flip_lock)
+		spin_unlock(flip_lock);
 	spin_lock(&port->lock);
 	return lsr;
 }
@@ -1591,7 +1596,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 			dma_err = up->dma->rx_dma(up, iir);
 
 		if (!up->dma || dma_err)
-			status = serial8250_rx_chars(up, status);
+			status = serial8250_rx_chars(up, status, NULL);
 	}
 	serial8250_modem_status(up);
 	if ((!up->dma || (up->dma && up->dma->tx_err)) &&
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index faa0e03..9c814e3 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -147,7 +147,8 @@ extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
 extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 extern int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
-unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
+unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr,
+				  spinlock_t *flip_lock);
 void serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
-- 
1.7.10.4
