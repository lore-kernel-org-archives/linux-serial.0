From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/2] serdev: do not generate modaliases for controllers
Date: Tue,  9 Jan 2018 17:09:16 +0100
Message-ID: <20180109160917.30752-2-johan@kernel.org>
References: <20180109160917.30752-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180109160917.30752-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Serdev controllers are not bound to any drivers and it therefore makes
no sense to generate modaliases for them.

This has already been fixed separately for ACPI controllers for which
uevent errors were also being logged during probe due to the missing
ACPI companions (from which ACPI modaliases are generated).

This patch moves the modalias handling from the bus type to the client
device type. Specifically, this means that only serdev devices (a.k.a.
clients or slaves) will have have MODALIAS fields in their uevent
environments and corresponding modalias sysfs attributes.

Also add the missing static keyword for the modalias device attribute
when moving the definition.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 72 ++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 5dc88f61f506..c8c43834477b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -19,6 +19,38 @@
 static bool is_registered;
 static DEFINE_IDA(ctrl_ida);
 
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	int len;
+
+	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
+	if (len != -ENODEV)
+		return len;
+
+	return of_device_modalias(dev, buf, PAGE_SIZE);
+}
+static DEVICE_ATTR_RO(modalias);
+
+static struct attribute *serdev_device_attrs[] = {
+	&dev_attr_modalias.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(serdev_device);
+
+static int serdev_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	int rc;
+
+	/* TODO: platform modalias */
+
+	rc = acpi_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	return of_device_uevent_modalias(dev, env);
+}
+
 static void serdev_device_release(struct device *dev)
 {
 	struct serdev_device *serdev = to_serdev_device(dev);
@@ -26,6 +58,8 @@ static void serdev_device_release(struct device *dev)
 }
 
 static const struct device_type serdev_device_type = {
+	.groups		= serdev_device_groups,
+	.uevent		= serdev_device_uevent,
 	.release	= serdev_device_release,
 };
 
@@ -49,23 +83,6 @@ static int serdev_device_match(struct device *dev, struct device_driver *drv)
 	return of_driver_match_device(dev, drv);
 }
 
-static int serdev_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	int rc;
-
-	/* TODO: platform modalias */
-
-	/* ACPI enumerated controllers do not have a modalias */
-	if (!dev->of_node && dev->type == &serdev_ctrl_type)
-		return 0;
-
-	rc = acpi_device_uevent_modalias(dev, env);
-	if (rc != -ENODEV)
-		return rc;
-
-	return of_device_uevent_modalias(dev, env);
-}
-
 /**
  * serdev_device_add() - add a device previously constructed via serdev_device_alloc()
  * @serdev:	serdev_device to be added
@@ -305,32 +322,11 @@ static int serdev_drv_remove(struct device *dev)
 	return 0;
 }
 
-static ssize_t modalias_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	int len;
-
-	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
-	if (len != -ENODEV)
-		return len;
-
-	return of_device_modalias(dev, buf, PAGE_SIZE);
-}
-DEVICE_ATTR_RO(modalias);
-
-static struct attribute *serdev_device_attrs[] = {
-	&dev_attr_modalias.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(serdev_device);
-
 static struct bus_type serdev_bus_type = {
 	.name		= "serial",
 	.match		= serdev_device_match,
 	.probe		= serdev_drv_probe,
 	.remove		= serdev_drv_remove,
-	.uevent		= serdev_uevent,
-	.dev_groups	= serdev_device_groups,
 };
 
 /**
-- 
2.15.1
