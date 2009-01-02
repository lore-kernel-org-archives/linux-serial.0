From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 33/75] tty: Pull the dtr raise into tty port
Date: Fri, 02 Jan 2009 13:45:19 +0000
Message-ID: <20090102134517.13472.96978.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37581 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756187AbZABNqG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:06 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

This moves another per device special out of what should be shared open
wait paths into private methods

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/isicom.c      |   13 ++++++++-----
 drivers/char/mxser.c       |   17 +++++++++++++----
 drivers/char/rocket.c      |   14 ++++++++++----
 drivers/char/synclink.c    |   21 +++++++++++++++------
 drivers/char/synclink_gt.c |   21 +++++++++++++++------
 drivers/char/tty_port.c    |   16 ++++++++++++++++
 include/linux/tty.h        |    2 ++
 7 files changed, 79 insertions(+), 25 deletions(-)


diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index b3da485..a449449 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -328,11 +328,13 @@ static inline void drop_rts(struct isi_port *port)
 }
 
 /* card->lock MUST NOT be held */
-static inline void raise_dtr_rts(struct isi_port *port)
+
+static void isicom_raise_dtr_rts(struct tty_port *port)
 {
-	struct isi_board *card = port->card;
+	struct isi_port *ip = container_of(port, struct isi_port, port);
+	struct isi_board *card = ip->card;
 	unsigned long base = card->base;
-	u16 channel = port->channel;
+	u16 channel = ip->channel;
 
 	if (!lock_card(card))
 		return;
@@ -340,7 +342,7 @@ static inline void raise_dtr_rts(struct isi_port *port)
 	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0f04, base);
 	InterruptTheCard(base);
-	port->status |= (ISI_DTR | ISI_RTS);
+	ip->status |= (ISI_DTR | ISI_RTS);
 	unlock_card(card);
 }
 
@@ -881,7 +883,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	spin_unlock_irqrestore(&card->card_lock, flags);
 
 	while (1) {
-		raise_dtr_rts(ip);
+		tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
@@ -1462,6 +1464,7 @@ static const struct tty_operations isicom_ops = {
 
 static const struct tty_port_operations isicom_port_ops = {
 	.carrier_raised		= isicom_carrier_raised,
+	.raise_dtr_rts		= isicom_raise_dtr_rts,
 };
 
 static int __devinit reset_card(struct pci_dev *pdev,
diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index eafbbcf..ff5ff61 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -547,6 +547,17 @@ static int mxser_carrier_raised(struct tty_port *port)
 	return (inb(mp->ioaddr + UART_MSR) & UART_MSR_DCD)?1:0;
 }
 
+static void mxser_raise_dtr_rts(struct tty_port *port)
+{
+	struct mxser_port *mp = container_of(port, struct mxser_port, port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mp->slock, flags);
+	outb(inb(mp->ioaddr + UART_MCR) |
+		UART_MCR_DTR | UART_MCR_RTS, mp->ioaddr + UART_MCR);
+	spin_unlock_irqrestore(&mp->slock, flags);
+}
+
 static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 		struct mxser_port *mp)
 {
@@ -586,10 +597,7 @@ static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 	spin_unlock_irqrestore(&mp->slock, flags);
 	port->blocked_open++;
 	while (1) {
-		spin_lock_irqsave(&mp->slock, flags);
-		outb(inb(mp->ioaddr + UART_MCR) |
-			UART_MCR_DTR | UART_MCR_RTS, mp->ioaddr + UART_MCR);
-		spin_unlock_irqrestore(&mp->slock, flags);
+		tty_port_raise_dtr_rts(port);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
 			if (port->flags & ASYNC_HUP_NOTIFY)
@@ -2458,6 +2466,7 @@ static const struct tty_operations mxser_ops = {
 
 struct tty_port_operations mxser_port_ops = {
 	.carrier_raised = mxser_carrier_raised,
+	.raise_dtr_rts = mxser_raise_dtr_rts,
 };
 
 /*
diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index 4a4110e..f4d9c39 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -870,6 +870,13 @@ static int carrier_raised(struct tty_port *port)
 	return (sGetChanStatusLo(&info->channel) & CD_ACT) ? 1 : 0;
 }
 
+static void raise_dtr_rts(struct tty_port *port)
+{
+	struct r_port *info = container_of(port, struct r_port, port);
+	sSetDTR(&info->channel);
+	sSetRTS(&info->channel);
+}
+
 /*  info->port.count is considered critical, protected by spinlocks.  */
 static int block_til_ready(struct tty_struct *tty, struct file *filp,
 			   struct r_port *info)
@@ -928,10 +935,8 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	while (1) {
-		if (tty->termios->c_cflag & CBAUD) {
-			sSetDTR(&info->channel);
-			sSetRTS(&info->channel);
-		}
+		if (tty->termios->c_cflag & CBAUD)
+			tty_port_raise_dtr_rts(port);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) || !(info->flags & ROCKET_INITIALIZED)) {
 			if (info->flags & ROCKET_HUP_NOTIFY)
@@ -2381,6 +2386,7 @@ static const struct tty_operations rocket_ops = {
 
 static const struct tty_port_operations rocket_port_ops = {
 	.carrier_raised = carrier_raised,
+	.raise_dtr_rts = raise_dtr_rts,
 };
 
 /*
diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c
index fb2e6b5..ac9f21e 100644
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -3298,6 +3298,18 @@ static int carrier_raised(struct tty_port *port)
 	return (info->serial_signals & SerialSignal_DCD) ? 1 : 0;
 }
 
+static void raise_dtr_rts(struct tty_port *port)
+{
+	struct mgsl_struct *info = container_of(port, struct mgsl_struct, port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&info->irq_spinlock,flags);
+	info->serial_signals |= SerialSignal_RTS + SerialSignal_DTR;
+ 	usc_set_serial_signals(info);
+	spin_unlock_irqrestore(&info->irq_spinlock,flags);
+}
+
+
 /* block_til_ready()
  * 
  * 	Block the current process until the specified port
@@ -3358,12 +3370,8 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 	port->blocked_open++;
 	
 	while (1) {
-		if (tty->termios->c_cflag & CBAUD) {
-			spin_lock_irqsave(&info->irq_spinlock,flags);
-			info->serial_signals |= SerialSignal_RTS + SerialSignal_DTR;
-		 	usc_set_serial_signals(info);
-			spin_unlock_irqrestore(&info->irq_spinlock,flags);
-		}
+		if (tty->termios->c_cflag & CBAUD)
+			tty_port_raise_dtr_rts(port);
 		
 		set_current_state(TASK_INTERRUPTIBLE);
 		
@@ -4321,6 +4329,7 @@ static void mgsl_add_device( struct mgsl_struct *info )
 
 static const struct tty_port_operations mgsl_port_ops = {
 	.carrier_raised = carrier_raised,
+	.raise_dtr_rts = raise_dtr_rts,
 };
 
 
diff --git a/drivers/char/synclink_gt.c b/drivers/char/synclink_gt.c
index 39ccaba..625c9bd 100644
--- a/drivers/char/synclink_gt.c
+++ b/drivers/char/synclink_gt.c
@@ -3143,6 +3143,18 @@ static int carrier_raised(struct tty_port *port)
 	return (info->signals & SerialSignal_DCD) ? 1 : 0;
 }
 
+static void raise_dtr_rts(struct tty_port *port)
+{
+	unsigned long flags;
+	struct slgt_info *info = container_of(port, struct slgt_info, port);
+
+	spin_lock_irqsave(&info->lock,flags);
+	info->signals |= SerialSignal_RTS + SerialSignal_DTR;
+ 	set_signals(info);
+	spin_unlock_irqrestore(&info->lock,flags);
+}
+
+
 /*
  *  block current process until the device is ready to open
  */
@@ -3187,12 +3199,8 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	port->blocked_open++;
 
 	while (1) {
-		if ((tty->termios->c_cflag & CBAUD)) {
-			spin_lock_irqsave(&info->lock,flags);
-			info->signals |= SerialSignal_RTS + SerialSignal_DTR;
-		 	set_signals(info);
-			spin_unlock_irqrestore(&info->lock,flags);
-		}
+		if ((tty->termios->c_cflag & CBAUD))
+			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -3455,6 +3463,7 @@ static void add_device(struct slgt_info *info)
 
 static const struct tty_port_operations slgt_port_ops = {
 	.carrier_raised = carrier_raised,
+	.raise_dtr_rts = raise_dtr_rts,
 };
 
 /*
diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index f54e40c..0557b63 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -111,3 +111,19 @@ int tty_port_carrier_raised(struct tty_port *port)
 	return port->ops->carrier_raised(port);
 }
 EXPORT_SYMBOL(tty_port_carrier_raised);
+
+/**
+ *	tty_port_raise_dtr_rts	-	Riase DTR/RTS
+ *	@port: tty port
+ *
+ *	Wrapper for the DTR/RTS raise logic. For the moment this is used
+ *	to hide some internal details. This will eventually become entirely
+ *	internal to the tty port.
+ */
+
+void tty_port_raise_dtr_rts(struct tty_port *port)
+{
+	if (port->ops->raise_dtr_rts)
+		port->ops->raise_dtr_rts(port);
+}
+EXPORT_SYMBOL(tty_port_raise_dtr_rts);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index bc7bae7..5001bbc 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -185,6 +185,7 @@ struct tty_port;
 struct tty_port_operations {
 	/* Return 1 if the carrier is raised */
 	int (*carrier_raised)(struct tty_port *port);
+	void (*raise_dtr_rts)(struct tty_port *port);
 };
 	
 struct tty_port {
@@ -436,6 +437,7 @@ extern void tty_port_free_xmit_buf(struct tty_port *port);
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 extern int tty_port_carrier_raised(struct tty_port *port);
+extern void tty_port_raise_dtr_rts(struct tty_port *port);
 
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);

