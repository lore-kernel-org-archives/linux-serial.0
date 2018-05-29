From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 03/19] Bluetooth: hci_ll: Add serdev_id_table
Date: Tue, 29 May 2018 15:09:58 +0200
Message-ID: <20180529131014.18641-4-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Describe which hardware is supported by the current driver.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/bluetooth/hci_ll.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 27e414b4e3a2..c31942c9b466 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -776,6 +776,22 @@ static const struct of_device_id hci_ti_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, hci_ti_of_match);
 
+static struct serdev_device_id hci_ti_id[] = {
+	{ "cc2560", },
+	{ "wl1271-st", },
+	{ "wl1273-st", },
+	{ "wl1281-st", },
+	{ "wl1283-st", },
+	{ "wl1285-st", },
+	{ "wl1801-st", },
+	{ "wl1805-st", },
+	{ "wl1807-st", },
+	{ "wl1831-st", },
+	{ "wl1835-st", },
+	{ "wl1837-st", },
+	{},
+};
+
 static struct serdev_device_driver hci_ti_drv = {
 	.driver		= {
 		.name	= "hci-ti",
@@ -783,6 +799,7 @@ static struct serdev_device_driver hci_ti_drv = {
 	},
 	.probe	= hci_ti_probe,
 	.remove	= hci_ti_remove,
+	.id_table = hci_ti_id,
 };
 #else
 #define ll_setup NULL
-- 
2.17.0
