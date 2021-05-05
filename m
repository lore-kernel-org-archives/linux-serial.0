Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDB2C43603
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31516613F0
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhEEJUu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232463AbhEEJUh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49D18B279;
        Wed,  5 May 2021 09:19:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 23/35] USB: serial: make usb_serial_driver::write_room return uint
Date:   Wed,  5 May 2021 11:19:16 +0200
Message-Id: <20210505091928.22010-24-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Line disciplines expect a positive value or zero returned from
tty->ops->write_room (invoked by tty_write_room). Both of them were
switched in the previous patch. So now, switch also
usb_serial_driver::write_room and all its users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/serial/cyberjack.c        | 4 ++--
 drivers/usb/serial/cypress_m8.c       | 8 ++++----
 drivers/usb/serial/digi_acceleport.c  | 8 ++++----
 drivers/usb/serial/garmin_gps.c       | 2 +-
 drivers/usb/serial/generic.c          | 6 +++---
 drivers/usb/serial/io_edgeport.c      | 6 +++---
 drivers/usb/serial/io_ti.c            | 6 +++---
 drivers/usb/serial/ir-usb.c           | 6 +++---
 drivers/usb/serial/keyspan.c          | 4 ++--
 drivers/usb/serial/kobil_sct.c        | 4 ++--
 drivers/usb/serial/mos7720.c          | 6 +++---
 drivers/usb/serial/mos7840.c          | 7 +++----
 drivers/usb/serial/opticon.c          | 2 +-
 drivers/usb/serial/oti6858.c          | 6 +++---
 drivers/usb/serial/quatech2.c         | 4 ++--
 drivers/usb/serial/sierra.c           | 2 +-
 drivers/usb/serial/ti_usb_3410_5052.c | 8 ++++----
 drivers/usb/serial/usb-wwan.h         | 2 +-
 drivers/usb/serial/usb_wwan.c         | 6 +++---
 include/linux/usb/serial.h            | 4 ++--
 20 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
index cf389224d528..51e5aac3bf4c 100644
--- a/drivers/usb/serial/cyberjack.c
+++ b/drivers/usb/serial/cyberjack.c
@@ -53,7 +53,7 @@ static int  cyberjack_open(struct tty_struct *tty,
 static void cyberjack_close(struct usb_serial_port *port);
 static int cyberjack_write(struct tty_struct *tty,
 	struct usb_serial_port *port, const unsigned char *buf, int count);
-static int cyberjack_write_room(struct tty_struct *tty);
+static unsigned int cyberjack_write_room(struct tty_struct *tty);
 static void cyberjack_read_int_callback(struct urb *urb);
 static void cyberjack_read_bulk_callback(struct urb *urb);
 static void cyberjack_write_bulk_callback(struct urb *urb);
@@ -240,7 +240,7 @@ static int cyberjack_write(struct tty_struct *tty,
 	return count;
 }
 
-static int cyberjack_write_room(struct tty_struct *tty)
+static unsigned int cyberjack_write_room(struct tty_struct *tty)
 {
 	/* FIXME: .... */
 	return CYBERJACK_LOCAL_BUF_SIZE;
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 166ee2286fda..5e7d2f9fa0c2 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -122,7 +122,7 @@ static void cypress_dtr_rts(struct usb_serial_port *port, int on);
 static int  cypress_write(struct tty_struct *tty, struct usb_serial_port *port,
 			const unsigned char *buf, int count);
 static void cypress_send(struct usb_serial_port *port);
-static int  cypress_write_room(struct tty_struct *tty);
+static unsigned int cypress_write_room(struct tty_struct *tty);
 static void cypress_earthmate_init_termios(struct tty_struct *tty);
 static void cypress_set_termios(struct tty_struct *tty,
 			struct usb_serial_port *port, struct ktermios *old);
@@ -789,18 +789,18 @@ static void cypress_send(struct usb_serial_port *port)
 
 
 /* returns how much space is available in the soft buffer */
-static int cypress_write_room(struct tty_struct *tty)
+static unsigned int cypress_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct cypress_private *priv = usb_get_serial_port_data(port);
-	int room = 0;
+	unsigned int room;
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
 	room = kfifo_avail(&priv->write_fifo);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, room);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, room);
 	return room;
 }
 
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 8b2f06539f2c..5deb900450ee 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -223,7 +223,7 @@ static int digi_tiocmset(struct tty_struct *tty, unsigned int set,
 static int digi_write(struct tty_struct *tty, struct usb_serial_port *port,
 		const unsigned char *buf, int count);
 static void digi_write_bulk_callback(struct urb *urb);
-static int digi_write_room(struct tty_struct *tty);
+static unsigned int digi_write_room(struct tty_struct *tty);
 static int digi_chars_in_buffer(struct tty_struct *tty);
 static int digi_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void digi_close(struct usb_serial_port *port);
@@ -1020,11 +1020,11 @@ static void digi_write_bulk_callback(struct urb *urb)
 		tty_port_tty_wakeup(&port->port);
 }
 
-static int digi_write_room(struct tty_struct *tty)
+static unsigned int digi_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct digi_port *priv = usb_get_serial_port_data(port);
-	int room;
+	unsigned int room;
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&priv->dp_port_lock, flags);
@@ -1035,7 +1035,7 @@ static int digi_write_room(struct tty_struct *tty)
 		room = port->bulk_out_size - 2 - priv->dp_out_buf_len;
 
 	spin_unlock_irqrestore(&priv->dp_port_lock, flags);
-	dev_dbg(&port->dev, "digi_write_room: port=%d, room=%d\n", priv->dp_port_num, room);
+	dev_dbg(&port->dev, "digi_write_room: port=%d, room=%u\n", priv->dp_port_num, room);
 	return room;
 
 }
diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 50e8bdc77e71..756d1ac7e96f 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1113,7 +1113,7 @@ static int garmin_write(struct tty_struct *tty, struct usb_serial_port *port,
 }
 
 
-static int garmin_write_room(struct tty_struct *tty)
+static unsigned int garmin_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	/*
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index d10aa3d2ee49..bc3cf66af0de 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -230,11 +230,11 @@ int usb_serial_generic_write(struct tty_struct *tty,
 }
 EXPORT_SYMBOL_GPL(usb_serial_generic_write);
 
-int usb_serial_generic_write_room(struct tty_struct *tty)
+unsigned int usb_serial_generic_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	unsigned long flags;
-	int room;
+	unsigned int room;
 
 	if (!port->bulk_out_size)
 		return 0;
@@ -243,7 +243,7 @@ int usb_serial_generic_write_room(struct tty_struct *tty)
 	room = kfifo_avail(&port->write_fifo);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, room);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, room);
 	return room;
 }
 
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index e6fe3882bf69..f6cedc87d3e4 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1355,11 +1355,11 @@ static void send_more_port_data(struct edgeport_serial *edge_serial,
  *	we return the amount of room that we have for this port	(the txCredits)
  *	otherwise we return a negative error number.
  *****************************************************************************/
-static int edge_write_room(struct tty_struct *tty)
+static unsigned int edge_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
-	int room;
+	unsigned int room;
 	unsigned long flags;
 
 	if (edge_port == NULL)
@@ -1377,7 +1377,7 @@ static int edge_write_room(struct tty_struct *tty)
 	room = edge_port->txCredits - edge_port->txfifo.count;
 	spin_unlock_irqrestore(&edge_port->ep_lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, room);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, room);
 	return room;
 }
 
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index 39503fdccebf..94c82c33e629 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2067,11 +2067,11 @@ static void edge_send(struct usb_serial_port *port, struct tty_struct *tty)
 		tty_wakeup(tty);
 }
 
-static int edge_write_room(struct tty_struct *tty)
+static unsigned int edge_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
-	int room = 0;
+	unsigned int room;
 	unsigned long flags;
 
 	if (edge_port == NULL)
@@ -2083,7 +2083,7 @@ static int edge_write_room(struct tty_struct *tty)
 	room = kfifo_avail(&port->write_fifo);
 	spin_unlock_irqrestore(&edge_port->ep_lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, room);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, room);
 	return room;
 }
 
diff --git a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
index 172261a908d8..7b44dbea95cd 100644
--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -47,7 +47,7 @@ static int xbof = -1;
 static int  ir_startup (struct usb_serial *serial);
 static int ir_write(struct tty_struct *tty, struct usb_serial_port *port,
 		const unsigned char *buf, int count);
-static int ir_write_room(struct tty_struct *tty);
+static unsigned int ir_write_room(struct tty_struct *tty);
 static void ir_write_bulk_callback(struct urb *urb);
 static void ir_process_read_urb(struct urb *urb);
 static void ir_set_termios(struct tty_struct *tty,
@@ -339,10 +339,10 @@ static void ir_write_bulk_callback(struct urb *urb)
 	usb_serial_port_softint(port);
 }
 
-static int ir_write_room(struct tty_struct *tty)
+static unsigned int ir_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	int count = 0;
+	unsigned int count = 0;
 
 	if (port->bulk_out_size == 0)
 		return 0;
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index b04a029e3657..87b89c99d517 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -1453,13 +1453,13 @@ static void usa67_glocont_callback(struct urb *urb)
 	}
 }
 
-static int keyspan_write_room(struct tty_struct *tty)
+static unsigned int keyspan_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct keyspan_port_private	*p_priv;
 	const struct keyspan_device_details	*d_details;
 	int				flip;
-	int				data_len;
+	unsigned int			data_len;
 	struct urb			*this_urb;
 
 	p_priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index a9bc546626ab..4ed8b8b0a361 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -53,7 +53,7 @@ static int  kobil_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void kobil_close(struct usb_serial_port *port);
 static int  kobil_write(struct tty_struct *tty, struct usb_serial_port *port,
 			 const unsigned char *buf, int count);
-static int  kobil_write_room(struct tty_struct *tty);
+static unsigned int kobil_write_room(struct tty_struct *tty);
 static int  kobil_ioctl(struct tty_struct *tty,
 			unsigned int cmd, unsigned long arg);
 static int  kobil_tiocmget(struct tty_struct *tty);
@@ -358,7 +358,7 @@ static int kobil_write(struct tty_struct *tty, struct usb_serial_port *port,
 }
 
 
-static int kobil_write_room(struct tty_struct *tty)
+static unsigned int kobil_write_room(struct tty_struct *tty)
 {
 	/* FIXME */
 	return 8;
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 6ee83886e2c9..d9cc7f840d48 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1033,11 +1033,11 @@ static void mos7720_break(struct tty_struct *tty, int break_state)
  *	If successful, we return the amount of room that we have for this port
  *	Otherwise we return a negative error number.
  */
-static int mos7720_write_room(struct tty_struct *tty)
+static unsigned int mos7720_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct moschip_port *mos7720_port;
-	int room = 0;
+	unsigned int room = 0;
 	int i;
 
 	mos7720_port = usb_get_serial_port_data(port);
@@ -1051,7 +1051,7 @@ static int mos7720_write_room(struct tty_struct *tty)
 			room += URB_TRANSFER_BUFFER_SIZE;
 	}
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, room);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, room);
 	return room;
 }
 
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 28e4093794e0..f25d4ba43b9a 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -815,15 +815,14 @@ static void mos7840_break(struct tty_struct *tty, int break_state)
  *	this function is called by the tty driver when it wants to know how many
  *	bytes of data we can accept for a specific port.
  *	If successful, we return the amount of room that we have for this port
- *	Otherwise we return a negative error number.
  *****************************************************************************/
 
-static int mos7840_write_room(struct tty_struct *tty)
+static unsigned int mos7840_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct moschip_port *mos7840_port = usb_get_serial_port_data(port);
 	int i;
-	int room = 0;
+	unsigned int room = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mos7840_port->pool_lock, flags);
@@ -834,7 +833,7 @@ static int mos7840_write_room(struct tty_struct *tty)
 	spin_unlock_irqrestore(&mos7840_port->pool_lock, flags);
 
 	room = (room == 0) ? 0 : room - URB_TRANSFER_BUFFER_SIZE + 1;
-	dev_dbg(&mos7840_port->port->dev, "%s - returns %d\n", __func__, room);
+	dev_dbg(&mos7840_port->port->dev, "%s - returns %u\n", __func__, room);
 	return room;
 
 }
diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index 40c713fae0c3..37b51947bd0b 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -267,7 +267,7 @@ static int opticon_write(struct tty_struct *tty, struct usb_serial_port *port,
 	return ret;
 }
 
-static int opticon_write_room(struct tty_struct *tty)
+static unsigned int opticon_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct opticon_private *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index 65cd0341fa78..4ab9f335dd0e 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -126,7 +126,7 @@ static void oti6858_read_bulk_callback(struct urb *urb);
 static void oti6858_write_bulk_callback(struct urb *urb);
 static int oti6858_write(struct tty_struct *tty, struct usb_serial_port *port,
 			const unsigned char *buf, int count);
-static int oti6858_write_room(struct tty_struct *tty);
+static unsigned int oti6858_write_room(struct tty_struct *tty);
 static int oti6858_chars_in_buffer(struct tty_struct *tty);
 static int oti6858_tiocmget(struct tty_struct *tty);
 static int oti6858_tiocmset(struct tty_struct *tty,
@@ -363,10 +363,10 @@ static int oti6858_write(struct tty_struct *tty, struct usb_serial_port *port,
 	return count;
 }
 
-static int oti6858_write_room(struct tty_struct *tty)
+static unsigned int oti6858_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	int room = 0;
+	unsigned int room;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 5f2e7f668e68..3b5f2032ecdb 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -870,12 +870,12 @@ static void qt2_update_lsr(struct usb_serial_port *port, unsigned char *ch)
 
 }
 
-static int qt2_write_room(struct tty_struct *tty)
+static unsigned int qt2_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct qt2_port_private *port_priv;
 	unsigned long flags = 0;
-	int r;
+	unsigned int r;
 
 	port_priv = usb_get_serial_port_data(port);
 
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 54e16ffc30a0..753cee5d17a1 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -613,7 +613,7 @@ static void sierra_instat_callback(struct urb *urb)
 	}
 }
 
-static int sierra_write_room(struct tty_struct *tty)
+static unsigned int sierra_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct sierra_port_private *portdata = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index caa46ac23db9..2c543c175296 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -307,7 +307,7 @@ static int ti_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void ti_close(struct usb_serial_port *port);
 static int ti_write(struct tty_struct *tty, struct usb_serial_port *port,
 		const unsigned char *data, int count);
-static int ti_write_room(struct tty_struct *tty);
+static unsigned int ti_write_room(struct tty_struct *tty);
 static int ti_chars_in_buffer(struct tty_struct *tty);
 static bool ti_tx_empty(struct usb_serial_port *port);
 static void ti_throttle(struct tty_struct *tty);
@@ -810,18 +810,18 @@ static int ti_write(struct tty_struct *tty, struct usb_serial_port *port,
 }
 
 
-static int ti_write_room(struct tty_struct *tty)
+static unsigned int ti_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ti_port *tport = usb_get_serial_port_data(port);
-	int room = 0;
+	unsigned int room;
 	unsigned long flags;
 
 	spin_lock_irqsave(&tport->tp_lock, flags);
 	room = kfifo_avail(&port->write_fifo);
 	spin_unlock_irqrestore(&tport->tp_lock, flags);
 
-	dev_dbg(&port->dev, "%s - returns %d\n", __func__, room);
+	dev_dbg(&port->dev, "%s - returns %u\n", __func__, room);
 	return room;
 }
 
diff --git a/drivers/usb/serial/usb-wwan.h b/drivers/usb/serial/usb-wwan.h
index b5331d03092f..6c7c9f3309b0 100644
--- a/drivers/usb/serial/usb-wwan.h
+++ b/drivers/usb/serial/usb-wwan.h
@@ -11,7 +11,7 @@ extern int usb_wwan_open(struct tty_struct *tty, struct usb_serial_port *port);
 extern void usb_wwan_close(struct usb_serial_port *port);
 extern int usb_wwan_port_probe(struct usb_serial_port *port);
 extern void usb_wwan_port_remove(struct usb_serial_port *port);
-extern int usb_wwan_write_room(struct tty_struct *tty);
+extern unsigned int usb_wwan_write_room(struct tty_struct *tty);
 extern int usb_wwan_tiocmget(struct tty_struct *tty);
 extern int usb_wwan_tiocmset(struct tty_struct *tty,
 			     unsigned int set, unsigned int clear);
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 3eb72c59ede6..06212f08d9f9 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -278,12 +278,12 @@ static void usb_wwan_outdat_callback(struct urb *urb)
 	}
 }
 
-int usb_wwan_write_room(struct tty_struct *tty)
+unsigned int usb_wwan_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_wwan_port_private *portdata;
 	int i;
-	int data_len = 0;
+	unsigned int data_len = 0;
 	struct urb *this_urb;
 
 	portdata = usb_get_serial_port_data(port);
@@ -294,7 +294,7 @@ int usb_wwan_write_room(struct tty_struct *tty)
 			data_len += OUT_BUFLEN;
 	}
 
-	dev_dbg(&port->dev, "%s: %d\n", __func__, data_len);
+	dev_dbg(&port->dev, "%s: %u\n", __func__, data_len);
 	return data_len;
 }
 EXPORT_SYMBOL(usb_wwan_write_room);
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 8c63fa9bfc74..6472d1f7b028 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -276,7 +276,7 @@ struct usb_serial_driver {
 	int  (*write)(struct tty_struct *tty, struct usb_serial_port *port,
 			const unsigned char *buf, int count);
 	/* Called only by the tty layer */
-	int  (*write_room)(struct tty_struct *tty);
+	unsigned int (*write_room)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty,
 		      unsigned int cmd, unsigned long arg);
 	void (*get_serial)(struct tty_struct *tty, struct serial_struct *ss);
@@ -347,7 +347,7 @@ int usb_serial_generic_write(struct tty_struct *tty, struct usb_serial_port *por
 		const unsigned char *buf, int count);
 void usb_serial_generic_close(struct usb_serial_port *port);
 int usb_serial_generic_resume(struct usb_serial *serial);
-int usb_serial_generic_write_room(struct tty_struct *tty);
+unsigned int usb_serial_generic_write_room(struct tty_struct *tty);
 int usb_serial_generic_chars_in_buffer(struct tty_struct *tty);
 void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout);
 void usb_serial_generic_read_bulk_callback(struct urb *urb);
-- 
2.31.1

