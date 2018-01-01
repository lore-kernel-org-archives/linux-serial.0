From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v2 7/9] bluetooth: btrtl: load the config blob from devicetree when available
Date: Mon,  1 Jan 2018 21:42:15 +0100
Message-ID: <20180101204217.26165-8-martin.blumenstingl@googlemail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101204217.26165-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Some Realtek bluetooth devices need a "config" blob. The btrtl driver
currently only allows loading this config blob via the request_firmware
mechanism.

The UART Bluetooth chips use this config blob to specify the baudrate,
whether flow control is used and some other unknown bits. This means
that the config blob is board-specific - thus loading it via
request_firmware means that the rootfs is tied to a specific board.

The UART Bluetooth chips are implemented through serdev. This means
there is also a devicetree node which describes the Bluetooth chip.
Thus we can also load the blob from the devicetree node to keep the
filesystem independent of any board configuration data. In the future
this could be extended to support ACPI as well (in case that's needed).

Parse the devicetree node if it exists and obtain the config blob from
there. Otherwise fall back to using the "old" request_firmware
mechanism.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/bluetooth/btrtl.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 25e9743643f5..1494269cf4d7 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <asm/unaligned.h>
+#include <linux/of.h>
 #include <linux/usb.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -379,6 +380,41 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev)
 }
 EXPORT_SYMBOL_GPL(btrtl_free);
 
+static int rtl_load_config_from_dt(struct hci_dev *hdev,
+				   struct btrtl_device_info *btrtl_dev)
+{
+	struct device_node *np = hdev->dev.parent->of_node;
+	int ret, config_len;
+
+	if (!of_device_is_available(np))
+		return -ENOENT;
+
+	if (!of_find_property(np, "realtek,config-data", NULL))
+		return -ENOENT;
+
+	config_len = of_property_count_u8_elems(np, "realtek,config-data");
+	if (config_len <= 0)
+		return -ENOENT;
+
+	btrtl_dev->cfg_data = kzalloc(config_len, GFP_KERNEL);
+	if (!btrtl_dev->cfg_data)
+		return -ENOMEM;
+
+	ret = of_property_read_u8_array(np, "realtek,config-data",
+					btrtl_dev->cfg_data, config_len);
+	if (ret) {
+		kfree(btrtl_dev->cfg_data);
+		return ret;
+	}
+
+	btrtl_dev->cfg_len = config_len;
+
+	bt_dev_dbg(hdev, "rtl: using config data with len %d from DT",
+		   config_len);
+
+	return 0;
+}
+
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
 {
 	struct btrtl_device_info *btrtl_dev;
@@ -480,12 +516,15 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
 		goto err_free;
 	}
 
-	if (cfg_name) {
+	/* try loading the config blob from device-tree first: */
+	ret = rtl_load_config_from_dt(hdev, btrtl_dev);
+	/* fall back to loading the config via request_firmware: */
+	if (ret && cfg_name) {
 		btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
 						   &btrtl_dev->cfg_data);
 		if (cfg_needed && btrtl_dev->cfg_len <= 0) {
 			bt_dev_err(hdev,
-				   "mandatory config file %s not found\n",
+				   "mandatory config blob not found in %s or DT\n",
 				   cfg_name);
 			ret = btrtl_dev->fw_len;
 			goto err_free;
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
