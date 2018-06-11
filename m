From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 18/24] serdev: ttydev: Serdev driver that creates an standard TTY port
Date: Mon, 11 Jun 2018 13:52:34 +0200
Message-ID: <20180611115240.32606-19-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Standard TTY port that can be loaded/unloaded via serdev sysfs. This
serdev driver can only be used by serdev controllers that are compatible
with ttyport.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/Kconfig         | 10 +++++
 drivers/tty/serdev/Makefile        |  2 +
 drivers/tty/serdev/serdev-ttydev.c | 60 ++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 drivers/tty/serdev/serdev-ttydev.c

diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index 1dbc8352e027..848692caabd6 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -21,4 +21,14 @@ config SERIAL_DEV_CTRL_TTYPORT
 	depends on SERIAL_DEV_BUS != m
 	default y
 
+config SERIAL_DEV_CTRL_TTYDEV
+	tristate "TTY port dynamically loaded by the Serial Device Bus"
+	help
+	  Say Y here if you want to create a bridge driver between the Serial
+	  device bus and the TTY chardevice. This driver can be dynamically
+	  loaded/unloaded by the Serial Device Bus.
+
+	  If unsure, say N.
+	depends on SERIAL_DEV_CTRL_TTYPORT
+
 endif
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index 0cbdb9444d9d..5c807b77d12d 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -3,3 +3,5 @@ serdev-objs := core.o
 obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
 
 obj-$(CONFIG_SERIAL_DEV_CTRL_TTYPORT) += serdev-ttyport.o
+
+obj-$(CONFIG_SERIAL_DEV_CTRL_TTYDEV) += serdev-ttydev.o
diff --git a/drivers/tty/serdev/serdev-ttydev.c b/drivers/tty/serdev/serdev-ttydev.c
new file mode 100644
index 000000000000..180035e101dc
--- /dev/null
+++ b/drivers/tty/serdev/serdev-ttydev.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Ricardo Ribalda <ricardo.ribalda@gmail.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/serdev.h>
+#include <linux/tty.h>
+#include "serport.h"
+
+static int ttydev_serdev_probe(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+	struct serport *serport;
+	struct device *dev;
+
+	if (!ctrl->is_ttyport)
+		return -ENODEV;
+
+	serport = serdev_controller_get_drvdata(ctrl);
+
+	dev = tty_register_device_attr(serport->tty_drv, serport->tty_idx,
+					&serdev->dev, NULL, NULL);
+
+	return dev ? 0 : PTR_ERR(dev);
+}
+
+static void ttydev_serdev_remove(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+	struct serport *serport;
+
+	serport = serdev_controller_get_drvdata(ctrl);
+	tty_unregister_device(serport->tty_drv, serport->tty_idx);
+}
+
+static const struct serdev_device_id ttydev_serdev_id[] = {
+	{ "ttydev", },
+	{ "ttydev_serdev", },
+	{}
+};
+MODULE_DEVICE_TABLE(serdev, ttydev_serdev_id);
+
+static struct serdev_device_driver ttydev_serdev_driver = {
+	.probe = ttydev_serdev_probe,
+	.remove = ttydev_serdev_remove,
+	.driver = {
+		.name = "ttydev_serdev",
+	},
+	.id_table = ttydev_serdev_id,
+};
+
+module_serdev_device_driver(ttydev_serdev_driver);
+
+MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Serdev to ttydev module");
-- 
2.17.1
