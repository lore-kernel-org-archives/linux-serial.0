From: "George Spelvin" <linux@horizon.com>
Subject: [PATCH 1/2] serial/8250.c: Change to singly linked handler chain.
Date: Fri, 14 Nov 2008 00:30:41 -0500
Message-ID: <20081114053042.11532.qmail@science.horizon.com>
References: <20081113150308.3590.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:19101 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750782AbYKNFan (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2008 00:30:43 -0500
In-Reply-To: <20081113150308.3590.qmail@science.horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux@horizon.com

This is a prerequisite to the interesting patch 2/2.  This compiles,
but hasn't been tested yet.  It's out here for style comments.

This just converts the list of struct uart_8250_port attached to a single
IRQ from doubly linked to singly.  It should have no behavior differences.


---
 drivers/serial/8250.c |   93 +++++++++++++++++++++++++++----------------------
 1 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 18caa95..7f66335 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -116,7 +116,7 @@ static unsigned int probe_rsa_count;
 struct uart_8250_port {
 	struct uart_port	port;
 	struct timer_list	timer;		/* "no irq" timer */
-	struct list_head	list;		/* ports on this IRQ */
+	struct uart_8250_port	*next;		/* ports on this IRQ */
 	unsigned short		capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
@@ -146,7 +146,7 @@ struct uart_8250_port {
 
 struct irq_info {
 	spinlock_t		lock;
-	struct list_head	*head;
+	struct uart_8250_port	*head;
 };
 
 static struct irq_info irq_lists[NR_IRQS];
@@ -1432,13 +1432,16 @@ serial8250_handle_port(struct uart_8250_port *up)
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
+	check_modem_status(up);
+
 	status = serial_inp(up, UART_LSR);
 
 	DEBUG_INTR("status = %x...", status);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI))
+	if (status & (UART_LSR_DR | UART_LSR_BI)) {
 		receive_chars(up, &status);
-	check_modem_status(up);
+		check_modem_status(up);
+	}
 	if (status & UART_LSR_THRE)
 		transmit_chars(up);
 
@@ -1458,23 +1461,39 @@ serial8250_handle_port(struct uart_8250_port *up)
  *
  * This means we need to loop through all ports. checking that they
  * don't have an interrupt pending.
+ *
+ * Fencepost consideration: serial8250_handle_port only polls each
+ * interrupt source once; it does not itself loop until the port
+ * has deasserted the interrupt line.  Therefore, it is necessary to
+ * loop here until each port has had its IIR read in the idle state.
+ * "end" points to the beginning of the most recent run of idle ports.
+ * It is NULL if the current port is not idle.  The loop ends when we
+ * are about to check end again.
  */
 static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 {
 	struct irq_info *i = dev_id;
-	struct list_head *l, *end = NULL;
+	struct uart_8250_port *up, *end = NULL;
 	int pass_counter = 0, handled = 0;
 
 	DEBUG_INTR("serial8250_interrupt(%d)...", irq);
 
 	spin_lock(&i->lock);
 
-	l = i->head;
+	up = i->head;
 	do {
-		struct uart_8250_port *up;
 		unsigned int iir;
 
-		up = list_entry(l, struct uart_8250_port, list);
+		if (up == NULL) {
+			if (pass_counter++ > PASS_LIMIT) {
+				/* If we hit this, we're dead. */
+				printk(KERN_ERR "serial8250: too much work for "
+					"irq%d\n", irq);
+				break;
+			}
+			up = i->head;
+			continue;
+		}
 
 		iir = serial_in(up, UART_IIR);
 		if (!(iir & UART_IIR_NO_INT)) {
@@ -1486,9 +1505,10 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 		} else if (up->port.iotype == UPIO_DWAPB &&
 			  (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 			/* The DesignWare APB UART has an Busy Detect (0x07)
-			 * interrupt meaning an LCR write attempt occured while the
-			 * UART was busy. The interrupt must be cleared by reading
-			 * the UART status register (USR) and the LCR re-written. */
+			 * interrupt meaning an LCR write attempt occured
+			 * while the UART was busy. The interrupt must
+			 * be cleared by reading the UART status register
+			 * (USR) and re-writing the LCR. */
 			unsigned int status;
 			status = *(volatile u32 *)up->port.private_data;
 			serial_out(up, UART_LCR, up->lcr);
@@ -1497,17 +1517,10 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
 			end = NULL;
 		} else if (end == NULL)
-			end = l;
+			end = up;
 
-		l = l->next;
-
-		if (l == i->head && pass_counter++ > PASS_LIMIT) {
-			/* If we hit this, we're dead. */
-			printk(KERN_ERR "serial8250: too much work for "
-				"irq%d\n", irq);
-			break;
-		}
-	} while (l != end);
+		up = up->next;
+	} while (up != end);
 
 	spin_unlock(&i->lock);
 
@@ -1525,39 +1538,35 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
  */
 static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
 {
+	struct uart_8250_port *p, **pptr = &i->head;
+
 	spin_lock_irq(&i->lock);
 
-	if (!list_empty(i->head)) {
-		if (i->head == &up->list)
-			i->head = i->head->next;
-		list_del(&up->list);
-	} else {
-		BUG_ON(i->head != &up->list);
-		i->head = NULL;
+	while ((p = *pptr) != up) {
+		BUG_ON(p == NULL);
+		pptr = &p->next;
 	}
 
+	*pptr = up->next;
+
 	spin_unlock_irq(&i->lock);
 }
 
 static int serial_link_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i = irq_lists + up->port.irq;
-	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? IRQF_SHARED : 0;
+	int ret = 0;
+	struct uart_8250_port *head;
 
 	spin_lock_irq(&i->lock);
+	up->next = head = i->head;
+	i->head = up;
+	spin_unlock_irq(&i->lock);
 
-	if (i->head) {
-		list_add(&up->list, i->head);
-		spin_unlock_irq(&i->lock);
-
-		ret = 0;
-	} else {
-		INIT_LIST_HEAD(&up->list);
-		i->head = &up->list;
-		spin_unlock_irq(&i->lock);
-
+	if (!head) {
+		int irq_flag = up->port.flags & UPF_SHARE_IRQ ? IRQF_SHARED : 0;
 		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  irq_flags, "serial", i);
+				  irq_flag, "serial", i);
 		if (ret < 0)
 			serial_do_unlink(i, up);
 	}
@@ -1570,8 +1579,8 @@ static void serial_unlink_irq_chain(struct uart_8250_port *up)
 	struct irq_info *i = irq_lists + up->port.irq;
 
 	BUG_ON(i->head == NULL);
-
-	if (list_empty(i->head))
+	serial_do_unlink(i, up);
+	if (i->head == NULL);
 		free_irq(up->port.irq, i);
 
 	serial_do_unlink(i, up);
-- 
1.5.6.5

