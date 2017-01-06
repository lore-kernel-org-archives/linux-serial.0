From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 8/9] serdev: add a tty port controller driver
Date: Fri,  6 Jan 2017 10:26:34 -0600
Message-ID: <20170106162635.19677-9-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106162635.19677-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Add a serdev controller driver for tty ports.

The controller is registered with serdev when tty ports are registered
with the TTY core. As the TTY core is built-in only, this has the side
effect of making serdev built-in as well.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serdev/Kconfig          |   8 ++
 drivers/tty/serdev/Makefile         |   2 +
 drivers/tty/serdev/serdev-ttyport.c | 244 ++++++++++++++++++++++++++++++++++++
 include/linux/serdev.h              |  20 +++
 4 files changed, 274 insertions(+)
 create mode 100644 drivers/tty/serdev/serdev-ttyport.c

diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index 3b6ecd187bef..7eac4cc42785 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -6,3 +6,11 @@ menuconfig SERIAL_DEV_BUS
 	help
 	  Core support for devices connected via a serial port.
 
+if SERIAL_DEV_BUS
+
+config SERIAL_DEV_CTRL_TTYPORT
+	bool "Serial device TTY port controller"
+	depends on TTY
+	depends on SERIAL_DEV_BUS=y
+
+endif
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index 01a9b62183f4..0cbdb9444d9d 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -1,3 +1,5 @@
 serdev-objs := core.o
 
 obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
+
+obj-$(CONFIG_SERIAL_DEV_CTRL_TTYPORT) += serdev-ttyport.o
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
new file mode 100644
index 000000000000..ed6fd675ece6
--- /dev/null
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -0,0 +1,244 @@
+/*
+ * Copyright (C) 2016 Linaro Ltd., Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/serdev.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+
+#define SERPORT_BUSY	1
+#define SERPORT_ACTIVE	2
+#define SERPORT_DEAD	3
+
+struct serport {
+	struct tty_port *port;
+	struct tty_struct *tty;
+	struct tty_driver *tty_drv;
+	int tty_idx;
+	struct mutex lock;
+	unsigned long flags;
+};
+
+/*
+ * Callback functions from the tty port.
+ */
+
+static int ttyport_receive_buf(struct tty_port *port, const unsigned char *cp,
+				const unsigned char *fp, size_t count)
+{
+	struct serdev_controller *ctrl = port->client_data;
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+
+	mutex_lock(&serport->lock);
+
+	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
+		goto out;
+
+	serdev_controller_receive_buf(ctrl, cp, count);
+
+out:
+	mutex_unlock(&serport->lock);
+	return count;
+}
+
+static void ttyport_write_wakeup(struct tty_port *port)
+{
+	struct serdev_controller *ctrl = port->client_data;
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+
+	clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		serdev_controller_write_wakeup(ctrl);
+}
+
+static const struct tty_port_client_operations client_ops = {
+	.receive_buf = ttyport_receive_buf,
+	.write_wakeup = ttyport_write_wakeup,
+};
+
+/*
+ * Callback functions from the serdev core.
+ */
+
+static int ttyport_write_buf(struct serdev_controller *ctrl, const unsigned char *data, size_t len)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+	return serport->tty->ops->write(serport->tty, data, len);
+}
+
+static void ttyport_write_flush(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	tty_driver_flush_buffer(tty);
+}
+
+static int ttyport_write_room(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	return tty_write_room(tty);
+}
+
+
+static int ttyport_open(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty;
+	struct ktermios ktermios;
+
+	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
+	serport->tty = tty;
+
+	serport->port->client_ops = &client_ops;
+	serport->port->client_data = ctrl;
+
+	tty->receive_room = 65536;
+
+	if (tty->ops->open)
+		tty->ops->open(serport->tty, NULL);
+	else
+		tty_port_open(serport->port, tty, NULL);
+
+	/* Bring the UART into a known 8 bits no parity hw fc state */
+	ktermios = tty->termios;
+	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
+			      INLCR | IGNCR | ICRNL | IXON);
+	ktermios.c_oflag &= ~OPOST;
+	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
+	ktermios.c_cflag &= ~(CSIZE | PARENB);
+	ktermios.c_cflag |= CS8;
+	ktermios.c_cflag |= CRTSCTS;
+	tty_set_termios(tty, &ktermios);
+
+	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+
+	mutex_lock(&serport->lock);
+	set_bit(SERPORT_ACTIVE, &serport->flags);
+	mutex_unlock(&serport->lock);
+
+	tty_unlock(serport->tty);
+	return 0;
+}
+
+static void ttyport_close(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	mutex_lock(&serport->lock);
+
+	if (tty->ops->close)
+		tty->ops->close(tty, NULL);
+
+	tty_release_struct(tty, serport->tty_idx);
+
+	clear_bit(SERPORT_ACTIVE, &serport->flags);
+	mutex_unlock(&serport->lock);
+}
+
+static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl, unsigned int speed)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	struct ktermios ktermios = tty->termios;
+
+	ktermios.c_cflag &= ~CBAUD;
+	tty_termios_encode_baud_rate(&ktermios, speed, speed);
+
+	/* tty_set_termios() return not checked as it is always 0 */
+	tty_set_termios(tty, &ktermios);
+	return speed;
+}
+
+static void ttyport_set_flow_control(struct serdev_controller *ctrl, bool enable)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	struct ktermios ktermios = tty->termios;
+
+	if (enable)
+		ktermios.c_cflag |= CRTSCTS;
+	else
+		ktermios.c_cflag &= ~CRTSCTS;
+
+	tty_set_termios(tty, &ktermios);
+}
+
+struct serdev_controller_ops ctrl_ops = {
+	.write_buf = ttyport_write_buf,
+	.write_flush = ttyport_write_flush,
+	.write_room = ttyport_write_room,
+	.open = ttyport_open,
+	.close = ttyport_close,
+	.set_flow_control = ttyport_set_flow_control,
+	.set_baudrate = ttyport_set_baudrate,
+};
+
+int serdev_tty_port_register(struct tty_port *port, struct device *parent,
+			    struct tty_driver *drv, int idx)
+{
+	struct serdev_controller *ctrl;
+	struct serport *serport;
+	int ret;
+
+	if (!port || !drv || !parent || !parent->of_node)
+		return -ENODEV;
+
+	ctrl = serdev_controller_alloc(parent, sizeof(struct serport));
+	if (!ctrl)
+		return -ENOMEM;
+	serport = serdev_controller_get_drvdata(ctrl);
+
+	mutex_init(&serport->lock);
+	serport->port = port;
+	serport->tty_idx = idx;
+	serport->tty_drv = drv;
+
+	ctrl->ops = &ctrl_ops;
+
+	ret = serdev_controller_add(ctrl);
+	if (ret)
+		goto err;
+
+	printk(KERN_INFO "serdev: Serial port %s\n", drv->name);
+	return 0;
+
+err:
+	serdev_controller_put(ctrl);
+	return ret;
+}
+
+void serdev_tty_port_unregister(struct tty_port *port)
+{
+	struct serdev_controller *ctrl = port->client_data;
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+
+	if (!serport)
+		return;
+
+	serdev_controller_remove(ctrl);
+	port->client_ops = NULL;
+	port->client_data = NULL;
+	serdev_controller_put(ctrl);
+}
+
+MODULE_AUTHOR("Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org");
+MODULE_DESCRIPTION("TTY port serial bus controller");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 4dc4ee62c2bb..d0e396744da5 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -204,4 +204,24 @@ static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
 	return 0;
 }
 
+/*
+ * serdev hooks into TTY core
+ */
+struct tty_port;
+struct tty_driver;
+
+#ifdef CONFIG_SERIAL_DEV_CTRL_TTYPORT
+int serdev_tty_port_register(struct tty_port *port, struct device *parent,
+			    struct tty_driver *drv, int idx);
+void serdev_tty_port_unregister(struct tty_port *port);
+#else
+static inline int serdev_tty_port_register(struct tty_port *port,
+					   struct device *parent,
+					   struct tty_driver *drv, int idx)
+{
+	return -ENODEV;
+}
+static inline void serdev_tty_port_unregister(struct tty_port *port) {}
+#endif
+
 #endif
-- 
2.10.1
