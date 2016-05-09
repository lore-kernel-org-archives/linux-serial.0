From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/7] tty: 8250, kill DEBUG_INTR
Date: Mon,  9 May 2016 09:11:59 +0200
Message-ID: <1462777919-10367-7-git-send-email-jslaby@suse.cz>
References: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Convert DEBUG_INTR to pr_debug:
* defined semantics (DEBUG, DYNAMIC_DEBUG)
* KERN_DEBUG level instead of KERN_DEFAULT
* emit __func__ and \n
* verified 'fmt' even when !DEBUG

I wonder if anybody ever used that or whether we should just drop the
lines.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/8250/8250.h      | 6 ------
 drivers/tty/serial/8250/8250_core.c | 4 ++--
 drivers/tty/serial/8250/8250_port.c | 6 +++---
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 563ccbe3612b..31b3d55211d0 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -235,9 +235,3 @@ static inline int serial_index(struct uart_port *port)
 {
 	return port->minor - 64;
 }
-
-#if 0
-#define DEBUG_INTR(fmt...)	printk(fmt)
-#else
-#define DEBUG_INTR(fmt...)	do { } while (0)
-#endif
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e938ac93743a..fa823a54cf35 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -114,7 +114,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 	struct list_head *l, *end = NULL;
 	int pass_counter = 0, handled = 0;
 
-	DEBUG_INTR("serial8250_interrupt(%d)...", irq);
+	pr_debug("%s(%d): start\n", __func__, irq);
 
 	spin_lock(&i->lock);
 
@@ -144,7 +144,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
 	spin_unlock(&i->lock);
 
-	DEBUG_INTR("end.\n");
+	pr_debug("%s(%d): end\n", __func__, irq);
 
 	return IRQ_RETVAL(handled);
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d4036038a4dd..b10d05f2004b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1686,7 +1686,7 @@ static void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
 		lsr &= port->read_status_mask;
 
 		if (lsr & UART_LSR_BI) {
-			DEBUG_INTR("handling break....");
+			pr_debug("%s: handling break\n", __func__);
 			flag = TTY_BREAK;
 		} else if (lsr & UART_LSR_PE)
 			flag = TTY_PARITY;
@@ -1757,7 +1757,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	DEBUG_INTR("THRE...");
+	pr_debug("%s: THRE\n", __func__);
 
 	/*
 	 * With RPM enabled, we have to wait until the FIFO is empty before the
@@ -1823,7 +1823,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	status = serial_port_in(port, UART_LSR);
 
-	DEBUG_INTR("status = %x...", status);
+	pr_debug("%s: status = %x\n", __func__, status);
 
 	if (status & (UART_LSR_DR | UART_LSR_BI)) {
 		if (!up->dma || handle_rx_dma(up, iir))
-- 
2.8.2
