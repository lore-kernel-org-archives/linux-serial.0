Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A8C43462
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A01613F9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhEEJVB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:21:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:41480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232501AbhEEJUk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08070B231;
        Wed,  5 May 2021 09:19:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 27/35] serial: make usb_serial_driver::chars_in_buffer return uint
Date:   Wed,  5 May 2021 11:19:20 +0200
Message-Id: <20210505091928.22010-28-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_operations::chars_in_buffer was switched to uint in the previous
patch. So do the same for usb_serial_driver's chars_in_buffer too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/serial/cypress_m8.c       | 8 ++++----
 drivers/usb/serial/digi_acceleport.c  | 4 ++--
 drivers/usb/serial/generic.c          | 6 +++---
 drivers/usb/serial/io_edgeport.c      | 6 +++---
 drivers/usb/serial/io_ti.c            | 6 +++---
 drivers/usb/serial/mos7720.c          | 6 +++---
 drivers/usb/serial/mos7840.c          | 6 +++---
 drivers/usb/serial/opticon.c          | 4 ++--
 drivers/usb/serial/oti6858.c          | 6 +++---
 drivers/usb/serial/sierra.c           | 6 +++---
 drivers/usb/serial/ti_usb_3410_5052.c | 8 ++++----
 drivers/usb/serial/usb-wwan.h         | 2 +-
 drivers/usb/serial/usb_wwan.c         | 6 +++---
 include/linux/usb/serial.h            | 4 ++--
 14 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 5e7d2f9fa0c2..1dca04e1519d 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -129,7 +129,7 @@ static void cypress_set_termios(struct tty_struct *tty,
 static int  cypress_tiocmget(struct tty_struct *tty);
 static int  cypress_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
-static int  cypress_chars_in_buffer(struct tty_struct *tty);
+static unsigned int cypress_chars_in_buffer(struct tty_struct *tty);
 static void cypress_throttle(struct tty_struct *tty);
 static void cypress_unthrottle(struct tty_struct *tty);
 static void cypress_set_dead(struct usb_serial_port *port);
@@ -970,18 +970,18 @@ static void cypress_set_termios(struct tty_struct *tty,
 
 
 /* returns amount of data still left in soft buffer */
-static int cypress_chars_in_buffer(struct tty_struct *tty)
+static unsigned int cypress_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct cypress_private *priv = usb_get_serial_port_data(port);
-	int chars = 0;
+	unsigned int chars;
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
 	chars = kfifo_len(&priv->write_fifo);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, chars);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, chars);
 	return chars;
 }
 
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 5deb900450ee..19ee8191647c 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -224,7 +224,7 @@ static int digi_write(struct tty_struct *tty, struct usb_serial_port *port,
 		const unsigned char *buf, int count);
 static void digi_write_bulk_callback(struct urb *urb);
 static unsigned int digi_write_room(struct tty_struct *tty);
-static int digi_chars_in_buffer(struct tty_struct *tty);
+static unsigned int digi_chars_in_buffer(struct tty_struct *tty);
 static int digi_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void digi_close(struct usb_serial_port *port);
 static void digi_dtr_rts(struct usb_serial_port *port, int on);
@@ -1040,7 +1040,7 @@ static unsigned int digi_write_room(struct tty_struct *tty)
 
 }
 
-static int digi_chars_in_buffer(struct tty_struct *tty)
+static unsigned int digi_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct digi_port *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index bc3cf66af0de..15b6dee3a8e5 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -247,11 +247,11 @@ unsigned int usb_serial_generic_write_room(struct tty_struct *tty)
 	return room;
 }
 
-int usb_serial_generic_chars_in_buffer(struct tty_struct *tty)
+unsigned int usb_serial_generic_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	unsigned long flags;
-	int chars;
+	unsigned int chars;
 
 	if (!port->bulk_out_size)
 		return 0;
@@ -260,7 +260,7 @@ int usb_serial_generic_chars_in_buffer(struct tty_struct *tty)
 	chars = kfifo_len(&port->write_fifo) + port->tx_bytes;
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, chars);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, chars);
 	return chars;
 }
 EXPORT_SYMBOL_GPL(usb_serial_generic_chars_in_buffer);
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index f6cedc87d3e4..1f8dff4390c7 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1391,11 +1391,11 @@ static unsigned int edge_write_room(struct tty_struct *tty)
  *	system,
  *	Otherwise we return a negative error number.
  *****************************************************************************/
-static int edge_chars_in_buffer(struct tty_struct *tty)
+static unsigned int edge_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
-	int num_chars;
+	unsigned int num_chars;
 	unsigned long flags;
 
 	if (edge_port == NULL)
@@ -1413,7 +1413,7 @@ static int edge_chars_in_buffer(struct tty_struct *tty)
 						edge_port->txfifo.count;
 	spin_unlock_irqrestore(&edge_port->ep_lock, flags);
 	if (num_chars) {
-		dev_dbg(&port->dev, "%s - returns %d\n", __func__, num_chars);
+		dev_dbg(&port->dev, "%s - returns %u\n", __func__, num_chars);
 	}
 
 	return num_chars;
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index 94c82c33e629..84b848d2794e 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2087,11 +2087,11 @@ static unsigned int edge_write_room(struct tty_struct *tty)
 	return room;
 }
 
-static int edge_chars_in_buffer(struct tty_struct *tty)
+static unsigned int edge_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
-	int chars = 0;
+	unsigned int chars;
 	unsigned long flags;
 	if (edge_port == NULL)
 		return 0;
@@ -2100,7 +2100,7 @@ static int edge_chars_in_buffer(struct tty_struct *tty)
 	chars = kfifo_len(&port->write_fifo);
 	spin_unlock_irqrestore(&edge_port->ep_lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, chars);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, chars);
 	return chars;
 }
 
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index d9cc7f840d48..ce41009756f3 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -949,11 +949,11 @@ static int mos7720_open(struct tty_struct *tty, struct usb_serial_port *port)
  *	system,
  *	Otherwise we return a negative error number.
  */
-static int mos7720_chars_in_buffer(struct tty_struct *tty)
+static unsigned int mos7720_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	int i;
-	int chars = 0;
+	unsigned int chars = 0;
 	struct moschip_port *mos7720_port;
 
 	mos7720_port = usb_get_serial_port_data(port);
@@ -965,7 +965,7 @@ static int mos7720_chars_in_buffer(struct tty_struct *tty)
 		    mos7720_port->write_urb_pool[i]->status == -EINPROGRESS)
 			chars += URB_TRANSFER_BUFFER_SIZE;
 	}
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, chars);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, chars);
 	return chars;
 }
 
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index f25d4ba43b9a..44f39bf97de1 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -735,12 +735,12 @@ static int mos7840_open(struct tty_struct *tty, struct usb_serial_port *port)
  *	Otherwise we return zero.
  *****************************************************************************/
 
-static int mos7840_chars_in_buffer(struct tty_struct *tty)
+static unsigned int mos7840_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct moschip_port *mos7840_port = usb_get_serial_port_data(port);
 	int i;
-	int chars = 0;
+	unsigned int chars = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mos7840_port->pool_lock, flags);
@@ -751,7 +751,7 @@ static int mos7840_chars_in_buffer(struct tty_struct *tty)
 		}
 	}
 	spin_unlock_irqrestore(&mos7840_port->pool_lock, flags);
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, chars);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, chars);
 	return chars;
 
 }
diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index 37b51947bd0b..aed28c35caff 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -289,12 +289,12 @@ static unsigned int opticon_write_room(struct tty_struct *tty)
 	return 2048;
 }
 
-static int opticon_chars_in_buffer(struct tty_struct *tty)
+static unsigned int opticon_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct opticon_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
-	int count;
+	unsigned int count;
 
 	spin_lock_irqsave(&priv->lock, flags);
 	count = priv->outstanding_bytes;
diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index 4ab9f335dd0e..a5caedbe72e2 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -127,7 +127,7 @@ static void oti6858_write_bulk_callback(struct urb *urb);
 static int oti6858_write(struct tty_struct *tty, struct usb_serial_port *port,
 			const unsigned char *buf, int count);
 static unsigned int oti6858_write_room(struct tty_struct *tty);
-static int oti6858_chars_in_buffer(struct tty_struct *tty);
+static unsigned int oti6858_chars_in_buffer(struct tty_struct *tty);
 static int oti6858_tiocmget(struct tty_struct *tty);
 static int oti6858_tiocmset(struct tty_struct *tty,
 				unsigned int set, unsigned int clear);
@@ -376,10 +376,10 @@ static unsigned int oti6858_write_room(struct tty_struct *tty)
 	return room;
 }
 
-static int oti6858_chars_in_buffer(struct tty_struct *tty)
+static unsigned int oti6858_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	int chars = 0;
+	unsigned int chars;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 753cee5d17a1..4b49b7c33364 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -632,19 +632,19 @@ static unsigned int sierra_write_room(struct tty_struct *tty)
 	return 2048;
 }
 
-static int sierra_chars_in_buffer(struct tty_struct *tty)
+static unsigned int sierra_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct sierra_port_private *portdata = usb_get_serial_port_data(port);
 	unsigned long flags;
-	int chars;
+	unsigned int chars;
 
 	/* NOTE: This overcounts somewhat. */
 	spin_lock_irqsave(&portdata->lock, flags);
 	chars = portdata->outstanding_urbs * MAX_TRANSFER;
 	spin_unlock_irqrestore(&portdata->lock, flags);
 
-	dev_dbg(&port->dev, "%s - %d\n", __func__, chars);
+	dev_dbg(&port->dev, "%s - %u\n", __func__, chars);
 
 	return chars;
 }
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 2c543c175296..34f8ed224abe 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -308,7 +308,7 @@ static void ti_close(struct usb_serial_port *port);
 static int ti_write(struct tty_struct *tty, struct usb_serial_port *port,
 		const unsigned char *data, int count);
 static unsigned int ti_write_room(struct tty_struct *tty);
-static int ti_chars_in_buffer(struct tty_struct *tty);
+static unsigned int ti_chars_in_buffer(struct tty_struct *tty);
 static bool ti_tx_empty(struct usb_serial_port *port);
 static void ti_throttle(struct tty_struct *tty);
 static void ti_unthrottle(struct tty_struct *tty);
@@ -826,18 +826,18 @@ static unsigned int ti_write_room(struct tty_struct *tty)
 }
 
 
-static int ti_chars_in_buffer(struct tty_struct *tty)
+static unsigned int ti_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ti_port *tport = usb_get_serial_port_data(port);
-	int chars = 0;
+	unsigned int chars;
 	unsigned long flags;
 
 	spin_lock_irqsave(&tport->tp_lock, flags);
 	chars = kfifo_len(&port->write_fifo);
 	spin_unlock_irqrestore(&tport->tp_lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, chars);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, chars);
 	return chars;
 }
 
diff --git a/drivers/usb/serial/usb-wwan.h b/drivers/usb/serial/usb-wwan.h
index 6c7c9f3309b0..519101945769 100644
--- a/drivers/usb/serial/usb-wwan.h
+++ b/drivers/usb/serial/usb-wwan.h
@@ -17,7 +17,7 @@ extern int usb_wwan_tiocmset(struct tty_struct *tty,
 			     unsigned int set, unsigned int clear);
 extern int usb_wwan_write(struct tty_struct *tty, struct usb_serial_port *port,
 			  const unsigned char *buf, int count);
-extern int usb_wwan_chars_in_buffer(struct tty_struct *tty);
+extern unsigned int usb_wwan_chars_in_buffer(struct tty_struct *tty);
 #ifdef CONFIG_PM
 extern int usb_wwan_suspend(struct usb_serial *serial, pm_message_t message);
 extern int usb_wwan_resume(struct usb_serial *serial);
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 06212f08d9f9..cb01283d4d15 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -299,12 +299,12 @@ unsigned int usb_wwan_write_room(struct tty_struct *tty)
 }
 EXPORT_SYMBOL(usb_wwan_write_room);
 
-int usb_wwan_chars_in_buffer(struct tty_struct *tty)
+unsigned int usb_wwan_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_wwan_port_private *portdata;
 	int i;
-	int data_len = 0;
+	unsigned int data_len = 0;
 	struct urb *this_urb;
 
 	portdata = usb_get_serial_port_data(port);
@@ -316,7 +316,7 @@ int usb_wwan_chars_in_buffer(struct tty_struct *tty)
 		if (this_urb && test_bit(i, &portdata->out_busy))
 			data_len += this_urb->transfer_buffer_length;
 	}
-	dev_dbg(&port->dev, "%s: %d\n", __func__, data_len);
+	dev_dbg(&port->dev, "%s: %u\n", __func__, data_len);
 	return data_len;
 }
 EXPORT_SYMBOL(usb_wwan_chars_in_buffer);
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 6472d1f7b028..95c729446e27 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -284,7 +284,7 @@ struct usb_serial_driver {
 	void (*set_termios)(struct tty_struct *tty,
 			struct usb_serial_port *port, struct ktermios *old);
 	void (*break_ctl)(struct tty_struct *tty, int break_state);
-	int  (*chars_in_buffer)(struct tty_struct *tty);
+	unsigned int (*chars_in_buffer)(struct tty_struct *tty);
 	void (*wait_until_sent)(struct tty_struct *tty, long timeout);
 	bool (*tx_empty)(struct usb_serial_port *port);
 	void (*throttle)(struct tty_struct *tty);
@@ -348,7 +348,7 @@ int usb_serial_generic_write(struct tty_struct *tty, struct usb_serial_port *por
 void usb_serial_generic_close(struct usb_serial_port *port);
 int usb_serial_generic_resume(struct usb_serial *serial);
 unsigned int usb_serial_generic_write_room(struct tty_struct *tty);
-int usb_serial_generic_chars_in_buffer(struct tty_struct *tty);
+unsigned int usb_serial_generic_chars_in_buffer(struct tty_struct *tty);
 void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout);
 void usb_serial_generic_read_bulk_callback(struct urb *urb);
 void usb_serial_generic_write_bulk_callback(struct urb *urb);
-- 
2.31.1

