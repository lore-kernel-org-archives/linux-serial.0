From: Denys Zagorui <dzagorui@cisco.com>
Subject: [PATCH v2] serial: 8250: convert to threaded IRQ
Date: Wed, 15 Nov 2017 14:40:02 +0200
Message-ID: <20171115124002.32039-1-dzagorui@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jslaby@suse.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

During using virtualization it is common to see
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
 drivers/tty/serial/8250/8250_core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d29b512a7d9f..05a59f31c29f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -58,7 +58,7 @@ static struct uart_driver serial8250_reg;
 
 static unsigned int skip_txen_test; /* force skip of txen test at init time */
 
-#define PASS_LIMIT	512
+#define PASS_LIMIT	32
 
 #include <asm/serial.h>
 /*
@@ -135,10 +135,13 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 		l = l->next;
 
 		if (l == i->head && pass_counter++ > PASS_LIMIT) {
-			/* If we hit this, we're dead. */
-			printk_ratelimited(KERN_ERR
-				"serial8250: too much work for irq%d\n", irq);
-			break;
+			spin_unlock(&i->lock);
+			cond_resched();
+			spin_lock(&i->lock);
+			end = NULL;
+			l = i->head;
+			pass_counter = 0;
+			continue;
 		}
 	} while (l != end);
 
@@ -146,9 +149,20 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
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
@@ -217,8 +231,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
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
-- 
2.11.0
