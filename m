From: Denys Zagorui <dzagorui@cisco.com>
Subject: [PATCH v3] serial: 8250: convert to threaded IRQ
Date: Mon,  4 Dec 2017 17:26:27 +0200
Message-ID: <20171204152627.23906-1-dzagorui@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
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
v1 -> v2:
        - Fix spin-lock inconsistent usage.
        - After rescheduling check that all ports
          have been serviced again.
v2 -> v3:
        - Add changelog.

 drivers/tty/serial/8250/8250_core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..20d8e5fe2dc4 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -54,7 +54,7 @@ static struct uart_driver serial8250_reg;
 
 static unsigned int skip_txen_test; /* force skip of txen test at init time */
 
-#define PASS_LIMIT	512
+#define PASS_LIMIT	32
 
 #include <asm/serial.h>
 /*
@@ -131,10 +131,13 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
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
 
@@ -142,9 +145,20 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
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
@@ -213,8 +227,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
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
