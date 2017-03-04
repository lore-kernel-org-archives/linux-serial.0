From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 05/10] Bluetooth: hci_serdev: do not open device in hci open
Date: Sat,  4 Mar 2017 12:58:28 +0100
Message-ID: <20170304115833.3538-6-sre@kernel.org>
References: <20170304115833.3538-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170304115833.3538-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The device driver may need to communicate with the UART
device while the Bluetooth device is closed (e.g. due
to interrupts).

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/bluetooth/hci_serdev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index b2f7293a3162..b396d13a7b50 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -111,13 +111,9 @@ static void hci_uart_write_work(struct work_struct *work)
 /* Initialize device */
 static int hci_uart_open(struct hci_dev *hdev)
 {
-	struct hci_uart *hu  = hci_get_drvdata(hdev);
-
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	serdev_device_set_client_ops(hu->serdev, &hci_serdev_client_ops);
-
-	return serdev_device_open(hu->serdev);
+	return 0;
 }
 
 /* Reset device */
@@ -143,15 +139,11 @@ static int hci_uart_flush(struct hci_dev *hdev)
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
-	struct hci_uart *hu  = hci_get_drvdata(hdev);
-
 	BT_DBG("hdev %p", hdev);
 
 	hci_uart_flush(hdev);
 	hdev->flush = NULL;
 
-	serdev_device_close(hu->serdev);
-
 	return 0;
 }
 
@@ -298,6 +290,8 @@ int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_proto *p
 
 	BT_DBG("");
 
+	serdev_device_set_client_ops(hu->serdev, &hci_serdev_client_ops);
+
 	err = p->open(hu);
 	if (err)
 		return err;
@@ -366,5 +360,6 @@ int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_proto *p
 err_alloc:
 	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	p->close(hu);
+
 	return err;
 }
-- 
2.11.0
