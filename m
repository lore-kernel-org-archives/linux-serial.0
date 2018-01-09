From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/2] serdev: only match serdev devices
Date: Tue,  9 Jan 2018 17:09:17 +0100
Message-ID: <20180109160917.30752-3-johan@kernel.org>
References: <20180109160917.30752-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180109160917.30752-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Only serdev devices (a.k.a. clients or slaves) are bound to drivers so
bail out early from match() in case the device is not a serdev device
(i.e. if it's a serdev controller).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c8c43834477b..f710862f5c06 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -63,6 +63,11 @@ static const struct device_type serdev_device_type = {
 	.release	= serdev_device_release,
 };
 
+static bool is_serdev_device(const struct device *dev)
+{
+	return dev->type == &serdev_device_type;
+}
+
 static void serdev_ctrl_release(struct device *dev)
 {
 	struct serdev_controller *ctrl = to_serdev_controller(dev);
@@ -76,6 +81,9 @@ static const struct device_type serdev_ctrl_type = {
 
 static int serdev_device_match(struct device *dev, struct device_driver *drv)
 {
+	if (!is_serdev_device(dev))
+		return 0;
+
 	/* TODO: platform matching */
 	if (acpi_driver_match_device(dev, drv))
 		return 1;
-- 
2.15.1
