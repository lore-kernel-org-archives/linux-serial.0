From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 04/24] Bluetooth: hci_nokia: Add serdev_id_table
Date: Mon, 11 Jun 2018 13:52:20 +0200
Message-ID: <20180611115240.32606-5-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Describe which hardware is supported by the current driver.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/bluetooth/hci_nokia.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 3539fd03f47e..eb3d59894aef 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -801,6 +801,11 @@ static const struct of_device_id nokia_bluetooth_of_match[] = {
 MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
 #endif
 
+static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
+	{ "hp4-bluetooth", },
+	{}
+};
+
 static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 	.probe = nokia_bluetooth_serdev_probe,
 	.remove = nokia_bluetooth_serdev_remove,
@@ -809,6 +814,7 @@ static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 		.pm = &nokia_bluetooth_pm_ops,
 		.of_match_table = of_match_ptr(nokia_bluetooth_of_match),
 	},
+	.id_table = nokia_bluetooth_serdev_id,
 };
 
 module_serdev_device_driver(nokia_bluetooth_serdev_driver);
-- 
2.17.1
