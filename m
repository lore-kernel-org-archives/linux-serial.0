From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 12/24] Bluetooth: hci_ll: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 13:52:28 +0200
Message-ID: <20180611115240.32606-13-ricardo.ribalda@gmail.com>
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
 drivers/bluetooth/hci_ll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 276fdf677df4..3fbe7045e857 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -789,6 +789,7 @@ static struct serdev_device_id hci_ti_id[] = {
 	{ "wl1831-st", },
 	{ "wl1835-st", },
 	{ "wl1837-st", },
+	{ "hci-ti", },
 	{}
 };
 MODULE_DEVICE_TABLE(serdev, hci_ti_id);
-- 
2.17.1
