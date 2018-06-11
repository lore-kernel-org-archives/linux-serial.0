From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 20/24] serdev: Make match_id accessible by drivers
Date: Mon, 11 Jun 2018 13:52:36 +0200
Message-ID: <20180611115240.32606-21-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Drivers that make use of the driver_data field require to transverse the
id_table. There is no reason to have one implementation per driver.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 12 +++++++-----
 include/linux/serdev.h    |  3 +++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 587d2796b3d5..3084b6d10179 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -158,17 +158,19 @@ static const struct device_type serdev_ctrl_type = {
 	.release	= serdev_ctrl_release,
 };
 
-static int serdev_match_id(const struct serdev_device_id *id,
-			   const struct serdev_device *sdev)
+const struct serdev_device_id *serdev_match_id(
+			const struct serdev_device_id *id,
+			const struct serdev_device *sdev)
 {
 	while (id->name[0]) {
 		if (!strcmp(sdev->modalias, id->name))
-			return 1;
+			return id;
 		id++;
 	}
 
-	return 0;
+	return NULL;
 }
+EXPORT_SYMBOL_GPL(serdev_match_id);
 
 static int serdev_device_match(struct device *dev, struct device_driver *drv)
 {
@@ -186,7 +188,7 @@ static int serdev_device_match(struct device *dev, struct device_driver *drv)
 		return 1;
 
 	if (sdrv->id_table)
-		return serdev_match_id(sdrv->id_table, sdev);
+		return serdev_match_id(sdrv->id_table, sdev) != NULL;
 
 	return strcmp(sdev->modalias, drv->name) == 0;
 }
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 07d63933bdb9..bf282b3781b9 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -172,6 +172,9 @@ static inline void serdev_controller_put(struct serdev_controller *ctrl)
 		put_device(&ctrl->dev);
 }
 
+const struct serdev_device_id *serdev_match_id(
+		const struct serdev_device_id *id,
+		const struct serdev_device *sdev);
 struct serdev_device *serdev_device_alloc(struct serdev_controller *);
 int serdev_device_add(struct serdev_device *);
 void serdev_device_remove(struct serdev_device *);
-- 
2.17.1
