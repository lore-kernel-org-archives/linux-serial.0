From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 23/24] serdev: get/put controller
Date: Mon, 11 Jun 2018 13:52:39 +0200
Message-ID: <20180611115240.32606-24-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Allow access serdev controllers by other drivers in a safe way.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 23 +++++++++++++++++++++++
 include/linux/serdev.h    |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 6b24b0a74fbf..06310110104a 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -724,6 +724,29 @@ void serdev_controller_remove(struct serdev_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(serdev_controller_remove);
 
+struct serdev_controller *serdev_get_controller(int nr)
+{
+	struct serdev_controller *ctrl;
+
+	ctrl = idr_find(&ctrl_idr, nr);
+	if (!ctrl)
+		return NULL;
+
+	get_device(&ctrl->dev);
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(serdev_get_controller);
+
+void serdev_put_controller(struct serdev_controller *ctrl)
+{
+	if (!ctrl)
+		return;
+
+	put_device(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(serdev_put_controller);
+
 /**
  * serdev_driver_register() - Register client driver with serdev core
  * @sdrv:	client driver to be associated with client-device.
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index bf282b3781b9..1ef6e6503650 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -182,6 +182,8 @@ void serdev_device_remove(struct serdev_device *);
 struct serdev_controller *serdev_controller_alloc(struct device *, size_t);
 int serdev_controller_add(struct serdev_controller *);
 void serdev_controller_remove(struct serdev_controller *);
+void serdev_put_controller(struct serdev_controller *ctrl);
+struct serdev_controller *serdev_get_controller(int nr);
 
 static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl)
 {
-- 
2.17.1
