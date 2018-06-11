From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 19/24] serdev: Instantiate a ttydev serdev if acpi and of fails
Date: Mon, 11 Jun 2018 13:52:35 +0200
Message-ID: <20180611115240.32606-20-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

If a serdev ttyport controller does not have an acpi nor an of child,
create a ttydev as a child of that controller.

Doing this allows the removal, addition and replacement of ttydev devices
at runtime.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 49 ++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 584cb994213a..587d2796b3d5 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -628,6 +628,26 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 }
 #endif /* CONFIG_ACPI */
 
+#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
+static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
+{
+	struct serdev_device *serdev;
+	int err;
+
+	serdev = serdev_device_alloc(ctrl);
+	if (!serdev)
+		return -ENOMEM;
+
+	strcpy(serdev->modalias, "ttydev");
+
+	err = serdev_device_add(serdev);
+	if (err)
+		serdev_device_put(serdev);
+
+	return err;
+}
+#endif
+
 /**
  * serdev_controller_add() - Add an serdev controller
  * @ctrl:	controller to be registered.
@@ -637,7 +657,7 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
  */
 int serdev_controller_add(struct serdev_controller *ctrl)
 {
-	int ret_of, ret_acpi, ret;
+	int ret_of, ret_acpi, ret, ret_tty = -ENODEV;
 
 	/* Can't register until after driver model init */
 	if (WARN_ON(!is_registered))
@@ -648,21 +668,28 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 		return ret;
 
 	ret_of = of_serdev_register_devices(ctrl);
+	if (!ret_of)
+		goto out_dev_ok;
+
 	ret_acpi = acpi_serdev_register_devices(ctrl);
-	if (ret_of && ret_acpi) {
-		dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
-			ret_of, ret_acpi);
-		ret = -ENODEV;
-		goto out_dev_del;
-	}
+	if (!ret_acpi)
+		goto out_dev_ok;
+
+#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
+	ret_tty = serdev_controller_add_ttydev(ctrl);
+	if (!ret_tty)
+		goto out_dev_ok;
+#endif
 
+	dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d tty:%d\n",
+		ret_of, ret_acpi, ret_tty);
+	device_del(&ctrl->dev);
+	return -ENODEV;
+
+out_dev_ok:
 	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
 		ctrl->nr, &ctrl->dev);
 	return 0;
-
-out_dev_del:
-	device_del(&ctrl->dev);
-	return ret;
 };
 EXPORT_SYMBOL_GPL(serdev_controller_add);
 
-- 
2.17.1
