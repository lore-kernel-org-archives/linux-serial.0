From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 13/24] Bluetooth: hci_nokia: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 13:52:29 +0200
Message-ID: <20180611115240.32606-14-ricardo.ribalda@gmail.com>
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
 drivers/bluetooth/hci_nokia.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index eb3d59894aef..fef285608f10 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -803,8 +803,10 @@ MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
 
 static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
 	{ "hp4-bluetooth", },
+	{ "nokia-bluetooth", },
 	{}
 };
+MODULE_DEVICE_TABLE(serdev, nokia_bluetooth_serdev_id);
 
 static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
 	.probe = nokia_bluetooth_serdev_probe,
-- 
2.17.1
