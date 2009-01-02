From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 50/75] tty: kref nozomi
Date: Fri, 02 Jan 2009 13:47:32 +0000
Message-ID: <20090102134731.13472.82519.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37622 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758110AbZABNrU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:47:20 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Update the nozomi driver to use krefs
---

 drivers/char/nozomi.c |   85 ++++++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 40 deletions(-)


diff --git a/drivers/char/nozomi.c b/drivers/char/nozomi.c
index 9a34a19..d6102b6 100644
--- a/drivers/char/nozomi.c
+++ b/drivers/char/nozomi.c
@@ -353,6 +353,7 @@ struct ctrl_ul {
 
 /* This holds all information that is needed regarding a port */
 struct port {
+	struct tty_port port;
 	u8 update_flow_control;
 	struct ctrl_ul ctrl_ul;
 	struct ctrl_dl ctrl_dl;
@@ -365,8 +366,6 @@ struct port {
 	u8 toggle_ul;
 	u16 token_dl;
 
-	struct tty_struct *tty;
-	int tty_open_count;
 	/* mutex to ensure one access patch to this port */
 	struct mutex tty_sem;
 	wait_queue_head_t tty_wait;
@@ -788,14 +787,14 @@ static void disable_transmit_dl(enum port_type port, struct nozomi *dc)
  * Return 1 - send buffer to card and ack.
  * Return 0 - don't ack, don't send buffer to card.
  */
-static int send_data(enum port_type index, const struct nozomi *dc)
+static int send_data(enum port_type index, struct nozomi *dc)
 {
 	u32 size = 0;
-	const struct port *port = &dc->port[index];
+	struct port *port = &dc->port[index];
 	const u8 toggle = port->toggle_ul;
 	void __iomem *addr = port->ul_addr[toggle];
 	const u32 ul_size = port->ul_size[toggle];
-	struct tty_struct *tty = port->tty;
+	struct tty_struct *tty = tty_port_tty_get(&port->port);
 
 	/* Get data from tty and place in buf for now */
 	size = __kfifo_get(port->fifo_ul, dc->send_buf,
@@ -803,6 +802,7 @@ static int send_data(enum port_type index, const struct nozomi *dc)
 
 	if (size == 0) {
 		DBG4("No more data to send, disable link:");
+		tty_kref_put(tty);
 		return 0;
 	}
 
@@ -815,6 +815,7 @@ static int send_data(enum port_type index, const struct nozomi *dc)
 	if (tty)
 		tty_wakeup(tty);
 
+	tty_kref_put(tty);
 	return 1;
 }
 
@@ -826,7 +827,7 @@ static int receive_data(enum port_type index, struct nozomi *dc)
 	u32 offset = 4;
 	struct port *port = &dc->port[index];
 	void __iomem *addr = port->dl_addr[port->toggle_dl];
-	struct tty_struct *tty = port->tty;
+	struct tty_struct *tty = tty_port_tty_get(&port->port);
 	int i;
 
 	if (unlikely(!tty)) {
@@ -870,7 +871,7 @@ static int receive_data(enum port_type index, struct nozomi *dc)
 	}
 
 	set_bit(index, &dc->flip);
-
+	tty_kref_put(tty);
 	return 1;
 }
 
@@ -1276,9 +1277,15 @@ static irqreturn_t interrupt_handler(int irq, void *dev_id)
 
 exit_handler:
 	spin_unlock(&dc->spin_mutex);
-	for (a = 0; a < NOZOMI_MAX_PORTS; a++)
-		if (test_and_clear_bit(a, &dc->flip))
-			tty_flip_buffer_push(dc->port[a].tty);
+	for (a = 0; a < NOZOMI_MAX_PORTS; a++) {
+		struct tty_struct *tty;
+		if (test_and_clear_bit(a, &dc->flip)) {
+			tty = tty_port_tty_get(&dc->port[a].port);
+			if (tty)
+				tty_flip_buffer_push(tty);
+			tty_kref_put(tty);
+		}
+	}
 	return IRQ_HANDLED;
 none:
 	spin_unlock(&dc->spin_mutex);
@@ -1453,12 +1460,10 @@ static int __devinit nozomi_card_init(struct pci_dev *pdev,
 
 	for (i = 0; i < MAX_PORT; i++) {
 		mutex_init(&dc->port[i].tty_sem);
-		dc->port[i].tty_open_count = 0;
-		dc->port[i].tty = NULL;
+		tty_port_init(&dc->port[i].port);
 		tty_register_device(ntty_driver, dc->index_start + i,
 							&pdev->dev);
 	}
-
 	return 0;
 
 err_free_sbuf:
@@ -1482,14 +1487,16 @@ static void __devexit tty_exit(struct nozomi *dc)
 
 	flush_scheduled_work();
 
-	for (i = 0; i < MAX_PORT; ++i)
-		if (dc->port[i].tty && \
-				list_empty(&dc->port[i].tty->hangup_work.entry))
-			tty_hangup(dc->port[i].tty);
-
+	for (i = 0; i < MAX_PORT; ++i) {
+		struct tty_struct *tty = tty_port_tty_get(&dc->port[i].port);
+		if (tty && list_empty(&tty->hangup_work.entry))
+			tty_hangup(tty);
+		tty_kref_put(tty);
+	}
+	/* Racy below - surely should wait for scheduled work to be done or
+	   complete off a hangup method ? */
 	while (dc->open_ttys)
 		msleep(1);
-
 	for (i = dc->index_start; i < dc->index_start + MAX_PORT; ++i)
 		tty_unregister_device(ntty_driver, i);
 }
@@ -1579,23 +1586,22 @@ static int ntty_open(struct tty_struct *tty, struct file *file)
 	if (mutex_lock_interruptible(&port->tty_sem))
 		return -ERESTARTSYS;
 
-	port->tty_open_count++;
+	port->port.count++;
 	dc->open_ttys++;
 
 	/* Enable interrupt downlink for channel */
-	if (port->tty_open_count == 1) {
+	if (port->port.count == 1) {
+		/* FIXME: is this needed now ? */
 		tty->low_latency = 1;
 		tty->driver_data = port;
-		port->tty = tty;
+		tty_port_tty_set(&port->port, tty);
 		DBG1("open: %d", port->token_dl);
 		spin_lock_irqsave(&dc->spin_mutex, flags);
 		dc->last_ier = dc->last_ier | port->token_dl;
 		writew(dc->last_ier, dc->reg_ier);
 		spin_unlock_irqrestore(&dc->spin_mutex, flags);
 	}
-
 	mutex_unlock(&port->tty_sem);
-
 	return 0;
 }
 
@@ -1606,31 +1612,30 @@ static int ntty_open(struct tty_struct *tty, struct file *file)
 static void ntty_close(struct tty_struct *tty, struct file *file)
 {
 	struct nozomi *dc = get_dc_by_tty(tty);
-	struct port *port = tty->driver_data;
+	struct port *nport = tty->driver_data;
+	struct tty_port *port = &nport->port;
 	unsigned long flags;
 
-	if (!dc || !port)
+	if (!dc || !nport)
 		return;
 
-	if (mutex_lock_interruptible(&port->tty_sem))
-		return;
+	/* Users cannot interrupt a close */
+	mutex_lock(&nport->tty_sem);
 
-	if (!port->tty_open_count)
-		goto exit;
+	WARN_ON(!port->count);
 
 	dc->open_ttys--;
-	port->tty_open_count--;
+	port->count--;
+	tty_port_tty_set(port, NULL);
 
-	if (port->tty_open_count == 0) {
-		DBG1("close: %d", port->token_dl);
+	if (port->count == 0) {
+		DBG1("close: %d", nport->token_dl);
 		spin_lock_irqsave(&dc->spin_mutex, flags);
-		dc->last_ier &= ~(port->token_dl);
+		dc->last_ier &= ~(nport->token_dl);
 		writew(dc->last_ier, dc->reg_ier);
 		spin_unlock_irqrestore(&dc->spin_mutex, flags);
 	}
-
-exit:
-	mutex_unlock(&port->tty_sem);
+	mutex_unlock(&nport->tty_sem);
 }
 
 /*
@@ -1660,7 +1665,7 @@ static int ntty_write(struct tty_struct *tty, const unsigned char *buffer,
 		return -EAGAIN;
 	}
 
-	if (unlikely(!port->tty_open_count)) {
+	if (unlikely(!port->port.count)) {
 		DBG1(" ");
 		goto exit;
 	}
@@ -1710,7 +1715,7 @@ static int ntty_write_room(struct tty_struct *tty)
 	if (!mutex_trylock(&port->tty_sem))
 		return 0;
 
-	if (!port->tty_open_count)
+	if (!port->port.count)
 		goto exit;
 
 	room = port->fifo_ul->size - __kfifo_len(port->fifo_ul);
@@ -1866,7 +1871,7 @@ static s32 ntty_chars_in_buffer(struct tty_struct *tty)
 		goto exit_in_buffer;
 	}
 
-	if (unlikely(!port->tty_open_count)) {
+	if (unlikely(!port->port.count)) {
 		dev_err(&dc->pdev->dev, "No tty open?\n");
 		rval = -ENODEV;
 		goto exit_in_buffer;

