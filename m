From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 11/24] Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 13:52:27 +0200
Message-ID: <20180611115240.32606-12-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Export serdev table to the module header, allowing module autoload via
udev/modprobe.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f4d7846c06b8..ff0fd3502a90 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1327,8 +1327,10 @@ MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 
 static const struct serdev_device_id bcm_serdev_id[] = {
 	{ "bcm43438-bt", },
+	{ "hci_uart_bcm", },
 	{}
 };
+MODULE_DEVICE_TABLE(serdev, bcm_serdev_id);
 
 static struct serdev_device_driver bcm_serdev_driver = {
 	.probe = bcm_serdev_probe,
-- 
2.17.1
