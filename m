From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] tty/serdev: add serdev registration interface
Date: Tue, 11 Apr 2017 19:07:30 +0200
Message-ID: <20170411170731.4085-4-johan@kernel.org>
References: <20170411170731.4085-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411170731.4085-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Add a new interface for registering a serdev controller and clients, and
a helper function to deregister serdev devices (or a tty device) that
were previously registered using the new interface.

Once every driver currently using the tty_port_register_device() helpers
have been vetted and converted to use the new serdev registration
interface (at least for deregistration), we can move serdev registration
to the current helpers and get rid of the serdev-specific functions.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c |  6 ++-
 drivers/tty/tty_port.c              | 76 +++++++++++++++++++++++++++++++++++++
 include/linux/serdev.h              |  7 +++-
 include/linux/tty.h                 |  9 +++++
 4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 06e17faa6dfb..8f9d7a0c27d1 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -216,16 +216,18 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 	return ERR_PTR(ret);
 }
 
-void serdev_tty_port_unregister(struct tty_port *port)
+int serdev_tty_port_unregister(struct tty_port *port)
 {
 	struct serdev_controller *ctrl = port->client_data;
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
 
 	if (!serport)
-		return;
+		return -ENODEV;
 
 	serdev_controller_remove(ctrl);
 	port->client_ops = NULL;
 	port->client_data = NULL;
 	serdev_controller_put(ctrl);
+
+	return 0;
 }
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 0c880f17d27e..2b4c62189346 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/serdev.h>
 
 static int tty_port_default_receive_buf(struct tty_port *port,
 					const unsigned char *p,
@@ -134,6 +135,81 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
 
+/**
+ * tty_port_register_device_attr_serdev - register tty or serdev device
+ * @port: tty_port of the device
+ * @driver: tty_driver for this device
+ * @index: index of the tty
+ * @device: parent if exists, otherwise NULL
+ * @drvdata: driver data for the device
+ * @attr_grp: attribute group for the device
+ *
+ * Register a serdev or tty device depending on if the parent device has any
+ * defined serdev clients or not.
+ */
+struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
+		struct tty_driver *driver, unsigned index,
+		struct device *device, void *drvdata,
+		const struct attribute_group **attr_grp)
+{
+	struct device *dev;
+
+	tty_port_link_device(port, driver, index);
+
+	dev = serdev_tty_port_register(port, device, driver, index);
+	if (PTR_ERR(dev) != -ENODEV) {
+		/* Skip creating cdev if we registered a serdev device */
+		return dev;
+	}
+
+	return tty_register_device_attr(driver, index, device, drvdata,
+			attr_grp);
+}
+EXPORT_SYMBOL_GPL(tty_port_register_device_attr_serdev);
+
+/**
+ * tty_port_register_device_serdev - register tty or serdev device
+ * @port: tty_port of the device
+ * @driver: tty_driver for this device
+ * @index: index of the tty
+ * @device: parent if exists, otherwise NULL
+ *
+ * Register a serdev or tty device depending on if the parent device has any
+ * defined serdev clients or not.
+ */
+struct device *tty_port_register_device_serdev(struct tty_port *port,
+		struct tty_driver *driver, unsigned index,
+		struct device *device)
+{
+	return tty_port_register_device_attr_serdev(port, driver, index,
+			device, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(tty_port_register_device_serdev);
+
+
+/**
+ * tty_port_unregister_device - deregister a tty or serdev device
+ * @port: tty_port of the device
+ * @driver: tty_driver for this device
+ * @index: index of the tty
+ *
+ * If a tty or serdev device is registered with a call to
+ * tty_port_register_device_serdev() then this function must be called when
+ * the device is gone.
+ */
+void tty_port_unregister_device(struct tty_port *port,
+		struct tty_driver *driver, unsigned index)
+{
+	int ret;
+
+	ret = serdev_tty_port_unregister(port);
+	if (ret == 0)
+		return;
+
+	tty_unregister_device(driver, index);
+}
+EXPORT_SYMBOL_GPL(tty_port_unregister_device);
+
 int tty_port_alloc_xmit_buf(struct tty_port *port)
 {
 	/* We may sleep in get_zeroed_page() */
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 9519da6253a8..d612953c63c2 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -248,7 +248,7 @@ struct tty_driver;
 struct device *serdev_tty_port_register(struct tty_port *port,
 					struct device *parent,
 					struct tty_driver *drv, int idx);
-void serdev_tty_port_unregister(struct tty_port *port);
+int serdev_tty_port_unregister(struct tty_port *port);
 #else
 static inline struct device *serdev_tty_port_register(struct tty_port *port,
 					   struct device *parent,
@@ -256,7 +256,10 @@ static inline struct device *serdev_tty_port_register(struct tty_port *port,
 {
 	return ERR_PTR(-ENODEV);
 }
-static inline void serdev_tty_port_unregister(struct tty_port *port) {}
+static inline int serdev_tty_port_unregister(struct tty_port *port)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_SERIAL_DEV_CTRL_TTYPORT */
 
 #endif /*_LINUX_SERDEV_H */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1017e904c0a3..0a3eeca4761a 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -555,6 +555,15 @@ extern struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
 		const struct attribute_group **attr_grp);
+extern struct device *tty_port_register_device_serdev(struct tty_port *port,
+		struct tty_driver *driver, unsigned index,
+		struct device *device);
+extern struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
+		struct tty_driver *driver, unsigned index,
+		struct device *device, void *drvdata,
+		const struct attribute_group **attr_grp);
+extern void tty_port_unregister_device(struct tty_port *port,
+		struct tty_driver *driver, unsigned index);
 extern int tty_port_alloc_xmit_buf(struct tty_port *port);
 extern void tty_port_free_xmit_buf(struct tty_port *port);
 extern void tty_port_destroy(struct tty_port *port);
-- 
2.12.2
