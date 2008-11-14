From: "George Spelvin" <linux@horizon.com>
Subject: [PATCH 2/2] serial/8250.c: Use self-adjusting list for port poll
 order.
Date: Fri, 14 Nov 2008 00:33:14 -0500
Message-ID: <20081114053314.12093.qmail@science.horizon.com>
References: <20081113150308.3590.qmail@science.horizon.com>
 <20081114053042.11532.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:15036 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750727AbYKNFdP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2008 00:33:15 -0500
In-Reply-To: <20081114053042.11532.qmail@science.horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux@horizon.com

This is the interesting patch.  It changes the uart_8250_port list to
a self-adjusting one.  Busy ports move to the front, and idle ones
migrate to the end.  This reduces overal possing effort when there is
a mix of busy and idle ports.

Comments?

---
 drivers/serial/8250.c |   49 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 7f66335..96e784f 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1469,18 +1469,27 @@ serial8250_handle_port(struct uart_8250_port *up)
  * "end" points to the beginning of the most recent run of idle ports.
  * It is NULL if the current port is not idle.  The loop ends when we
  * are about to check end again.
+ *
+ * Optimization: this will finish sooner if we can check all busy
+ * ports first, starting the final verify-idle pass as soon as possible.
+ * To achieve this, busy ports are moved to the front of the list.
+ * *tailp marks the boundary between the front and the back of the list;
+ * when a port is found to be busy, it is removed from between *upp
+ * and upp->next, and reinserted at *tailp.
  */
 static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 {
 	struct irq_info *i = dev_id;
-	struct uart_8250_port *up, *end = NULL;
+	struct uart_8250_port *up, **upp, *end = NULL, **tailp;
 	int pass_counter = 0, handled = 0;
 
 	DEBUG_INTR("serial8250_interrupt(%d)...", irq);
 
+	tailp = upp = &i->head;
+
 	spin_lock(&i->lock);
 
-	up = i->head;
+	up = *upp;
 	do {
 		unsigned int iir;
 
@@ -1491,7 +1500,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 					"irq%d\n", irq);
 				break;
 			}
-			up = i->head;
+			tailp = upp = &i->head;
 			continue;
 		}
 
@@ -1499,11 +1508,8 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 		if (!(iir & UART_IIR_NO_INT)) {
 			serial8250_handle_port(up);
 
-			handled = 1;
-
-			end = NULL;
-		} else if (up->port.iotype == UPIO_DWAPB &&
-			  (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
+		} else if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY &&
+			   up->port.iotype == UPIO_DWAPB) {
 			/* The DesignWare APB UART has an Busy Detect (0x07)
 			 * interrupt meaning an LCR write attempt occured
 			 * while the UART was busy. The interrupt must
@@ -1513,14 +1519,27 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 			status = *(volatile u32 *)up->port.private_data;
 			serial_out(up, UART_LCR, up->lcr);
 
-			handled = 1;
-
-			end = NULL;
-		} else if (end == NULL)
-			end = up;
+		} else {
+			/* Port does not have interrupt asserted. */
+			if (end == NULL)
+				end = up;	/* Start of run of idle ports */
+			upp = &up->next;	/* Do not move anything */
+			continue;
+		}
 
-		up = up->next;
-	} while (up != end);
+		/* up had activity */
+		handled = 1;
+		end = NULL;
+		/* Move to front of list; append after *tailp */
+		if (tailp != upp) {
+			*upp = up->next;
+			up->next = *tailp;
+			*tailp = up;
+			tailp = &up->next;
+		} else {
+			tailp = upp = &up->next;
+		}
+	} while ((up = *upp) != end);
 
 	spin_unlock(&i->lock);
 
-- 
1.5.6.5

