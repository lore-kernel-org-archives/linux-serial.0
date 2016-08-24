From: Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 3/6] serio: add buffer receive and write functions
Date: Wed, 24 Aug 2016 18:24:34 -0500
Message-ID: <20160824232437.9446-5-robh@kernel.org>
References: <20160824232437.9446-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824232437.9446-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Currently, serio only supports a character at a time receive and write
functions. In order to support higher speed protocols like bluetooth,
buffer at a time functions are needed.

This mirrors the tty ldisc interface for write and receive_buf. Now that
a whole buffer can be queued, we need to be able to flush the write
queue as well.

While the write path doesn't require any updates to serio port drivers
as buffered write can be emulated with the existing write() function,
the receive path for port drivers must be updated to support the
buffered receive.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/serio/serio.c | 23 +++++++++++++++++++++++
 include/linux/serio.h       | 43 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 9e8eb7a..c994581 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -989,6 +989,11 @@ int serio_open(struct serio *serio, struct serio_driver *drv)
 		serio_set_drv(serio, NULL);
 		return -1;
 	}
+
+	/* Use buffer receive if the driver provides a callback */
+	if (drv->receive_buf)
+		set_bit(SERIO_MODE_BUFFERED, &drv->flags);
+
 	return 0;
 }
 EXPORT_SYMBOL(serio_open);
@@ -1024,6 +1029,24 @@ irqreturn_t serio_interrupt(struct serio *serio,
 }
 EXPORT_SYMBOL(serio_interrupt);
 
+int serio_receive_buf(struct serio *serio, const unsigned char *data, size_t len)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&serio->lock, flags);
+
+        if (likely(serio->drv))
+                ret = serio->drv->receive_buf(serio, data, len);
+	else if (device_is_registered(&serio->dev))
+		serio_rescan(serio);
+
+	spin_unlock_irqrestore(&serio->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(serio_receive_buf);
+
 struct bus_type serio_bus = {
 	.name		= "serio",
 	.drv_groups	= serio_driver_groups,
diff --git a/include/linux/serio.h b/include/linux/serio.h
index c733cff..5d0b69f 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -35,6 +35,8 @@ struct serio {
 	spinlock_t lock;
 
 	int (*write)(struct serio *, unsigned char);
+	int (*write_buf)(struct serio *, const unsigned char *, size_t);
+	void (*write_flush)(struct serio *);
 	int (*open)(struct serio *);
 	void (*close)(struct serio *);
 	int (*start)(struct serio *);
@@ -69,12 +71,16 @@ struct serio {
 
 struct serio_driver {
 	const char *description;
+	unsigned long flags;
+
+#define SERIO_MODE_BUFFERED	1
 
 	const struct serio_device_id *id_table;
 	bool manual_bind;
 
 	void (*write_wakeup)(struct serio *);
 	irqreturn_t (*interrupt)(struct serio *, unsigned char, unsigned int);
+	int (*receive_buf)(struct serio *, const unsigned char *, size_t);
 	int  (*connect)(struct serio *, struct serio_driver *drv);
 	int  (*reconnect)(struct serio *);
 	void (*disconnect)(struct serio *);
@@ -89,6 +95,12 @@ void serio_close(struct serio *serio);
 void serio_rescan(struct serio *serio);
 void serio_reconnect(struct serio *serio);
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags);
+int serio_receive_buf(struct serio *serio, const unsigned char *data, size_t len);
+
+static inline bool serio_buffered_mode_enabled(struct serio *serio)
+{
+	return test_bit(SERIO_MODE_BUFFERED, &serio->drv->flags);
+}
 
 void __serio_register_port(struct serio *serio, struct module *owner);
 
@@ -121,12 +133,35 @@ void serio_unregister_driver(struct serio_driver *drv);
 	module_driver(__serio_driver, serio_register_driver, \
 		       serio_unregister_driver)
 
+static inline int serio_write_buf(struct serio *serio, const unsigned char *data, size_t len)
+{
+	int ret;
+
+	if (serio->write_buf)
+		return serio->write_buf(serio, data, len);
+	else if (serio->write) {
+		int i;
+		for (i = 0; i < len; i++) {
+			ret = serio->write(serio, data[i]);
+			if (ret)
+				break;
+		}
+		return i;
+	}
+
+	return -1;
+}
+
 static inline int serio_write(struct serio *serio, unsigned char data)
 {
-	if (serio->write)
-		return serio->write(serio, data);
-	else
-		return -1;
+	int ret = serio_write_buf(serio, &data, 1);
+	return ret == 1 ? 0 : ret;
+}
+
+static inline void serio_write_flush(struct serio *serio)
+{
+	if (serio->write_flush)
+		serio->write_flush(serio);
 }
 
 static inline void serio_drv_write_wakeup(struct serio *serio)
-- 
2.9.3
