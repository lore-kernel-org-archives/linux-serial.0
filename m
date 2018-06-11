From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 24/24] serdev: serdev_controller_add_probed_device
Date: Mon, 11 Jun 2018 13:52:40 +0200
Message-ID: <20180611115240.32606-25-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Support adding probed devices by "platform" drivers.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 10 +++++-----
 include/linux/serdev.h    |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 06310110104a..e56a955d4ea9 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -630,8 +630,8 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 }
 #endif /* CONFIG_ACPI */
 
-#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
-static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
+int serdev_controller_add_probed_device(struct serdev_controller *ctrl,
+					const char *name)
 {
 	struct serdev_device *serdev;
 	int err;
@@ -640,7 +640,7 @@ static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
 	if (!serdev)
 		return -ENOMEM;
 
-	strcpy(serdev->modalias, "ttydev");
+	strcpy(serdev->modalias, name);
 
 	err = serdev_device_add(serdev);
 	if (err)
@@ -648,7 +648,7 @@ static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
 
 	return err;
 }
-#endif
+EXPORT_SYMBOL_GPL(serdev_controller_add_probed_device);
 
 /**
  * serdev_controller_add() - Add an serdev controller
@@ -678,7 +678,7 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 		goto out_dev_ok;
 
 #if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
-	ret_tty = serdev_controller_add_ttydev(ctrl);
+	ret_tty = serdev_controller_add_probed_device(ctrl, "ttydev");
 	if (!ret_tty)
 		goto out_dev_ok;
 #endif
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 1ef6e6503650..93f534a21ca9 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -184,6 +184,8 @@ int serdev_controller_add(struct serdev_controller *);
 void serdev_controller_remove(struct serdev_controller *);
 void serdev_put_controller(struct serdev_controller *ctrl);
 struct serdev_controller *serdev_get_controller(int nr);
+int serdev_controller_add_probed_device(struct serdev_controller *ctrl,
+					const char *name);
 
 static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl)
 {
-- 
2.17.1
