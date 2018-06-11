From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 07/24] serdev: Allows dynamic creation of devices via sysfs
Date: Mon, 11 Jun 2018 13:52:23 +0200
Message-ID: <20180611115240.32606-8-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Allow creating and deleting devices via sysfs. Devices created will be
matched to serdev drivers via modalias (the string provided by the user)
and deleted via their name. Eg:

 # Create device
root@qt5022:~# echo ttydev > /sys/bus/serial/devices/serial0/new_device

 # Delete device
root@qt5022:~#
	echo serial0-0 > /sys/bus/serial/devices/serial0/delete_device

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 69 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 2c79f47fc0db..5df01d8cf307 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -75,7 +75,76 @@ static void serdev_ctrl_release(struct device *dev)
 	kfree(ctrl);
 }
 
+static ssize_t
+new_device_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct serdev_controller *ctrl = to_serdev_controller(dev);
+	struct serdev_device *serdev;
+	char *nline;
+	int len;
+	int err;
+
+	serdev = serdev_device_alloc(ctrl);
+	if (!serdev)
+		return -ENOMEM;
+
+	nline = strchr(buf, '\n');
+	if (nline)
+		len = nline - buf;
+	else
+		len = strlen(buf);
+	len = min(SERDEV_NAME_SIZE - 1, len);
+
+	strncpy(serdev->modalias, buf, len);
+	serdev->modalias[len] = '\0';
+
+	err = serdev_device_add(serdev);
+	if (err) {
+		serdev_device_put(serdev);
+		return err;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t
+delete_device_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct serdev_controller *ctrl = to_serdev_controller(dev);
+	struct serdev_device *serdev = ctrl->serdev;
+	char *nline;
+	int len;
+
+	nline = strchr(buf, '\n');
+	if (nline)
+		len = nline - buf;
+	else
+		len = strlen(buf);
+	len = min(SERDEV_NAME_SIZE - 1, len);
+
+	if (!ctrl->serdev ||
+	    strncmp(dev_name(&serdev->dev), buf, len))
+		return -ENODEV;
+
+	serdev_device_remove(serdev);
+
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL,
+				  delete_device_store);
+
+static struct attribute *serdev_ctrl_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(serdev_ctrl);
+
 static const struct device_type serdev_ctrl_type = {
+	.groups		= serdev_ctrl_groups,
 	.release	= serdev_ctrl_release,
 };
 
-- 
2.17.1
