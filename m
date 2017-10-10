From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] serdev: fix registration of second slave
Date: Tue, 10 Oct 2017 18:09:49 +0200
Message-ID: <20171010160949.28982-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Serdev currently only supports a single slave device, but the required
sanity checks to prevent further registration attempts were missing.

If a serial-port node has two child nodes with compatible properties,
the OF code would try to register two slave devices using the same id
and name. Driver core will not allow this (and there will be loud
complaints), but the controller's slave pointer would already have been
set to address of the soon to be deallocated second struct
serdev_device. As the first slave device remains registered, this can
lead to later use-after-free issues when the slave callbacks are
accessed.

Note that while the serdev registration helpers are exported, they are
typically only called by serdev core. Any other (out-of-tree) callers
must serialise registration and deregistration themselves.

Fixes: cd6484e1830b ("serdev: Introduce new bus for serial attached devices")
Cc: stable <stable@vger.kernel.org>	# 4.11
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c68fb3a8ea1c..97db76afced2 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -65,21 +65,32 @@ static int serdev_uevent(struct device *dev, struct kobj_uevent_env *env)
  */
 int serdev_device_add(struct serdev_device *serdev)
 {
+	struct serdev_controller *ctrl = serdev->ctrl;
 	struct device *parent = serdev->dev.parent;
 	int err;
 
 	dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
 
+	/* Only a single slave device is currently supported. */
+	if (ctrl->serdev) {
+		dev_err(&serdev->dev, "controller busy\n");
+		return -EBUSY;
+	}
+	ctrl->serdev = serdev;
+
 	err = device_add(&serdev->dev);
 	if (err < 0) {
 		dev_err(&serdev->dev, "Can't add %s, status %d\n",
 			dev_name(&serdev->dev), err);
-		goto err_device_add;
+		goto err_clear_serdev;
 	}
 
 	dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev->dev));
 
-err_device_add:
+	return 0;
+
+err_clear_serdev:
+	ctrl->serdev = NULL;
 	return err;
 }
 EXPORT_SYMBOL_GPL(serdev_device_add);
@@ -90,7 +101,10 @@ EXPORT_SYMBOL_GPL(serdev_device_add);
  */
 void serdev_device_remove(struct serdev_device *serdev)
 {
+	struct serdev_controller *ctrl = serdev->ctrl;
+
 	device_unregister(&serdev->dev);
+	ctrl->serdev = NULL;
 }
 EXPORT_SYMBOL_GPL(serdev_device_remove);
 
@@ -295,7 +309,6 @@ struct serdev_device *serdev_device_alloc(struct serdev_controller *ctrl)
 		return NULL;
 
 	serdev->ctrl = ctrl;
-	ctrl->serdev = serdev;
 	device_initialize(&serdev->dev);
 	serdev->dev.parent = &ctrl->dev;
 	serdev->dev.bus = &serdev_bus_type;
-- 
2.14.2
