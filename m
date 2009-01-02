From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 51/75] hso: net driver using tty without locking
Date: Fri, 02 Jan 2009 13:47:39 +0000
Message-ID: <20090102134738.13472.87145.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37632 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758394AbZABNrf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:47:35 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Checking tty == NULL doesn't help us unless we have a clear semantic for
the locking of the tty object in the driver. Use the tty kref objects so that
we can take references to the tty in the USB event handling paths.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/net/usb/hso.c |   54 ++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 42 insertions(+), 12 deletions(-)


diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 9f7896a..d345a6e 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1015,7 +1015,7 @@ static void _hso_serial_set_termios(struct tty_struct *tty,
 	struct hso_serial *serial = get_serial_by_tty(tty);
 	struct ktermios *termios;
 
-	if ((!tty) || (!tty->termios) || (!serial)) {
+	if (!serial) {
 		printk(KERN_ERR "%s: no tty structures", __func__);
 		return;
 	}
@@ -1057,14 +1057,14 @@ static void _hso_serial_set_termios(struct tty_struct *tty,
 	termios->c_cflag |= CS8;	/* character size 8 bits */
 
 	/* baud rate 115200 */
-	tty_encode_baud_rate(serial->tty, 115200, 115200);
+	tty_encode_baud_rate(tty, 115200, 115200);
 
 	/*
 	 * Force low_latency on; otherwise the pushes are scheduled;
 	 * this is bad as it opens up the possibility of dropping bytes
 	 * on the floor.  We don't want to drop bytes on the floor. :)
 	 */
-	serial->tty->low_latency = 1;
+	tty->low_latency = 1;
 	return;
 }
 
@@ -1228,6 +1228,7 @@ static int hso_serial_open(struct tty_struct *tty, struct file *filp)
 
 	/* sanity check */
 	if (serial == NULL || serial->magic != HSO_SERIAL_MAGIC) {
+		WARN_ON(1);
 		tty->driver_data = NULL;
 		D1("Failed to open port");
 		return -ENODEV;
@@ -1242,8 +1243,10 @@ static int hso_serial_open(struct tty_struct *tty, struct file *filp)
 	kref_get(&serial->parent->ref);
 
 	/* setup */
+	spin_lock_irq(&serial->serial_lock);
 	tty->driver_data = serial;
-	serial->tty = tty;
+	serial->tty = tty_kref_get(tty);
+	spin_unlock_irq(&serial->serial_lock);
 
 	/* check for port already opened, if not set the termios */
 	serial->open_count++;
@@ -1285,6 +1288,10 @@ static void hso_serial_close(struct tty_struct *tty, struct file *filp)
 
 	D1("Closing serial port");
 
+	/* Open failed, no close cleanup required */
+	if (serial == NULL)
+		return;
+
 	mutex_lock(&serial->parent->mutex);
 	usb_gone = serial->parent->usb_gone;
 
@@ -1297,10 +1304,13 @@ static void hso_serial_close(struct tty_struct *tty, struct file *filp)
 	kref_put(&serial->parent->ref, hso_serial_ref_free);
 	if (serial->open_count <= 0) {
 		serial->open_count = 0;
-		if (serial->tty) {
+		spin_lock_irq(&serial->serial_lock);
+		if (serial->tty == tty) {
 			serial->tty->driver_data = NULL;
 			serial->tty = NULL;
+			tty_kref_put(tty);
 		}
+		spin_unlock_irq(&serial->serial_lock);
 		if (!usb_gone)
 			hso_stop_serial_device(serial->parent);
 		tasklet_kill(&serial->unthrottle_tasklet);
@@ -1653,6 +1663,7 @@ static void hso_std_serial_write_bulk_callback(struct urb *urb)
 {
 	struct hso_serial *serial = urb->context;
 	int status = urb->status;
+	struct tty_struct *tty;
 
 	/* sanity check */
 	if (!serial) {
@@ -1662,14 +1673,18 @@ static void hso_std_serial_write_bulk_callback(struct urb *urb)
 
 	spin_lock(&serial->serial_lock);
 	serial->tx_urb_used = 0;
+	tty = tty_kref_get(serial->tty);
 	spin_unlock(&serial->serial_lock);
 	if (status) {
 		log_usb_status(status, __func__);
+		tty_kref_put(tty);
 		return;
 	}
 	hso_put_activity(serial->parent);
-	if (serial->tty)
-		tty_wakeup(serial->tty);
+	if (tty) {
+		tty_wakeup(tty);
+		tty_kref_put(tty);
+	}
 	hso_kick_transmit(serial);
 
 	D1(" ");
@@ -1706,6 +1721,7 @@ static void ctrl_callback(struct urb *urb)
 	struct hso_serial *serial = urb->context;
 	struct usb_ctrlrequest *req;
 	int status = urb->status;
+	struct tty_struct *tty;
 
 	/* sanity check */
 	if (!serial)
@@ -1713,9 +1729,11 @@ static void ctrl_callback(struct urb *urb)
 
 	spin_lock(&serial->serial_lock);
 	serial->tx_urb_used = 0;
+	tty = tty_kref_get(serial->tty);
 	spin_unlock(&serial->serial_lock);
 	if (status) {
 		log_usb_status(status, __func__);
+		tty_kref_put(tty);
 		return;
 	}
 
@@ -1734,25 +1752,31 @@ static void ctrl_callback(struct urb *urb)
 		spin_unlock(&serial->serial_lock);
 	} else {
 		hso_put_activity(serial->parent);
-		if (serial->tty)
-			tty_wakeup(serial->tty);
+		if (tty)
+			tty_wakeup(tty);
 		/* response to a write command */
 		hso_kick_transmit(serial);
 	}
+	tty_kref_put(tty);
 }
 
 /* handle RX data for serial port */
 static int put_rxbuf_data(struct urb *urb, struct hso_serial *serial)
 {
-	struct tty_struct *tty = serial->tty;
+	struct tty_struct *tty;
 	int write_length_remaining = 0;
 	int curr_write_len;
+
 	/* Sanity check */
 	if (urb == NULL || serial == NULL) {
 		D1("serial = NULL");
 		return -2;
 	}
 
+	spin_lock(&serial->serial_lock);
+	tty = tty_kref_get(serial->tty);
+	spin_unlock(&serial->serial_lock);
+
 	/* Push data to tty */
 	if (tty) {
 		write_length_remaining = urb->actual_length -
@@ -1774,6 +1798,7 @@ static int put_rxbuf_data(struct urb *urb, struct hso_serial *serial)
 		serial->curr_rx_urb_offset = 0;
 		serial->rx_urb_filled[hso_urb_to_index(serial, urb)] = 0;
 	}
+	tty_kref_put(tty);
 	return write_length_remaining;
 }
 
@@ -2786,15 +2811,20 @@ static void hso_serial_ref_free(struct kref *ref)
 static void hso_free_interface(struct usb_interface *interface)
 {
 	struct hso_serial *hso_dev;
+	struct tty_struct *tty;
 	int i;
 
 	for (i = 0; i < HSO_SERIAL_TTY_MINORS; i++) {
 		if (serial_table[i]
 		    && (serial_table[i]->interface == interface)) {
 			hso_dev = dev2ser(serial_table[i]);
-			if (hso_dev->tty)
-				tty_hangup(hso_dev->tty);
+			spin_lock_irq(&hso_dev->serial_lock);
+			tty = tty_kref_get(hso_dev->tty);
+			spin_unlock_irq(&hso_dev->serial_lock);
+			if (tty)
+				tty_hangup(tty);
 			mutex_lock(&hso_dev->parent->mutex);
+			tty_kref_put(tty);
 			hso_dev->parent->usb_gone = 1;
 			mutex_unlock(&hso_dev->parent->mutex);
 			kref_put(&serial_table[i]->ref, hso_serial_ref_free);

