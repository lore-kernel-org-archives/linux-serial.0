From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 08/24] serdev: Provide modalias attribute for modalias devices
Date: Mon, 11 Jun 2018 13:52:24 +0200
Message-ID: <20180611115240.32606-9-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Create modalias sysfs attribute for modalias devices.
This is required by modprobe/udev to autoload the serdev driver.

Eg:
root@qt5022:~# cat /sys/bus/serial/devices/serial1-0/modalias
serdev:ttydev

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 5df01d8cf307..b9bb0c0ee319 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -23,12 +23,17 @@ static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	int len;
+	struct serdev_device *serdev = to_serdev_device(dev);
 
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
-	return of_device_modalias(dev, buf, PAGE_SIZE);
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
+	return sprintf(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->modalias);
 }
 static DEVICE_ATTR_RO(modalias);
 
-- 
2.17.1
