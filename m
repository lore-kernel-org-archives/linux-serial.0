From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 21/24] rave-sp: Support for variants on modalias drivers
Date: Mon, 11 Jun 2018 13:52:37 +0200
Message-ID: <20180611115240.32606-22-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Rave-sp behaves differently based on the device variant.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mfd/rave-sp.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index c0ecfbc16dca..d33cb9d914e8 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -654,14 +654,30 @@ static const struct serdev_device_ops rave_sp_serdev_device_ops = {
 	.write_wakeup = serdev_device_write_wakeup,
 };
 
+static struct serdev_device_id rave_sp_serdev_id[] = {
+	{ "rave-sp", (kernel_ulong_t) &rave_sp_legacy},
+	{ "rave-sp-niu", (kernel_ulong_t) &rave_sp_legacy},
+	{ "rave-sp-mezz", (kernel_ulong_t) &rave_sp_legacy},
+	{ "rave-sp-esb", (kernel_ulong_t) &rave_sp_legacy},
+	{ "rave-sp-rdu1", (kernel_ulong_t) &rave_sp_rdu1},
+	{ "rave-sp-rdu2", (kernel_ulong_t) &rave_sp_rdu2},
+	{}
+};
+MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
+
 static int rave_sp_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
+	const struct serdev_device_id *id;
 	struct rave_sp *sp;
 	u32 baud;
 	int ret;
 
-	if (of_property_read_u32(dev->of_node, "current-speed", &baud)) {
+	if (!dev->of_node) {
+		/* Baudrate at zii,rave-sp.txt */
+		baud = 1000000;
+	} else if (of_property_read_u32(dev->of_node,
+					"current-speed", &baud)) {
 		dev_err(dev,
 			"'current-speed' is not specified in device node\n");
 		return -EINVAL;
@@ -675,6 +691,12 @@ static int rave_sp_probe(struct serdev_device *serdev)
 	dev_set_drvdata(dev, sp);
 
 	sp->variant = of_device_get_match_data(dev);
+	if (!sp->variant) {
+		id = serdev_match_id(rave_sp_serdev_id, serdev);
+		if (id)
+			sp->variant = (const struct rave_sp_variant *)
+							id->driver_data;
+	}
 	if (!sp->variant)
 		return -ENODEV;
 
@@ -694,12 +716,6 @@ static int rave_sp_probe(struct serdev_device *serdev)
 
 MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
 
-static struct serdev_device_id rave_sp_serdev_id[] = {
-	{ "rave-sp", },
-	{}
-};
-MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
-
 static struct serdev_device_driver rave_sp_drv = {
 	.probe			= rave_sp_probe,
 	.driver = {
-- 
2.17.1
