From: Denys Zagorui <dzagorui@cisco.com>
Subject: [PATCH] serial: 8250: convert to threaded IRQ
Date: Thu,  9 Nov 2017 16:15:06 +0200
Message-ID: <20171109141506.2805-1-dzagorui@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Due using virtualization it is common to see
many "too much work for irq*" messages.

There are fixes proposed erlier:

-  e7328ae1848966181a7ac47e8ae6cddbd2cf55f3 (serial:
   8250, increase PASS_LIMIT)
-  f4f653e9875e573860e783fecbebde284a8626f5 (serial:
   8250, disable "too much work" messages

First one doesn't help now, last one was reverted
(12de375ec493ab1767d4a07dde823e63ae5edc21) in fact
it doesn't fix anything. So procesing interrupts in
kthread give us an opportunity to perform rescheduling
periodically.

Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 drivers/tty/serial/8250/8250_core.c | 23 ++++++++++++++++-------
 drivers/tty/serial/8250/8250_port.c |  5 ++---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d29b512a7d9f..0c2f6352523a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -58,7 +58,7 @@ static struct uart_driver serial8250_reg;
 
 static unsigned int skip_txen_test; /* force skip of txen test at init time */
 
-#define PASS_LIMIT	512
+#define PASS_LIMIT	32
 
 #include <asm/serial.h>
 /*
@@ -135,10 +135,8 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 		l = l->next;
 
 		if (l == i->head && pass_counter++ > PASS_LIMIT) {
-			/* If we hit this, we're dead. */
-			printk_ratelimited(KERN_ERR
-				"serial8250: too much work for irq%d\n", irq);
-			break;
+			cond_resched();
+			pass_counter = 0;
 		}
 	} while (l != end);
 
@@ -146,9 +144,20 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
 	pr_debug("%s(%d): end\n", __func__, irq);
 
+	enable_irq(i->irq);
+
 	return IRQ_RETVAL(handled);
 }
 
+static irqreturn_t serial8250_hard_irq(int irq, void *dev_id)
+{
+	struct irq_info *i = dev_id;
+
+	disable_irq_nosync(i->irq);
+
+	return IRQ_WAKE_THREAD;
+}
+
 /*
  * To support ISA shared interrupts, we need to have one interrupt
  * handler that ensures that the IRQ line has been deasserted
@@ -217,8 +226,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 		i->head = &up->list;
 		spin_unlock_irq(&i->lock);
 		irq_flags |= up->port.irqflags;
-		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  irq_flags, up->port.name, i);
+		ret = request_threaded_irq(up->port.irq, serial8250_hard_irq,
+						serial8250_interrupt, irq_flags, up->port.name, i);
 		if (ret < 0)
 			serial_do_unlink(i, up);
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f0cc04f62b67..6d2c7bd1f402 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1852,13 +1852,12 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	unsigned char status;
-	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
 
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	status = serial_port_in(port, UART_LSR);
 
@@ -1870,7 +1869,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
 		serial8250_tx_chars(up);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	spin_unlock(&port->lock);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
-- 
2.11.0
