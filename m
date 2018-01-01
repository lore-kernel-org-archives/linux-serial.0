From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v2 8/9] Bluetooth: drop HCI_UART_INIT_PENDING support
Date: Mon,  1 Jan 2018 21:42:16 +0100
Message-ID: <20180101204217.26165-9-martin.blumenstingl@googlemail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101204217.26165-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The three-wire (H5) protocol is the only protocol which uses
HCI_UART_INIT_PENDING.
Unfortunately the benefits of using this flag are currently unknown. It
was added in commit 9f2aee848fe6 ("Bluetooth: Add delayed init sequence
support for UART controllers"). In my experiments (with the
"rtk_hciattach" tool - a customized version of hciattach for Realtek
chipsets) I started the tool before and after this patch while the
Bluetooth chipset was disabled (by pulling it's enable GPIO LOW). In
both cases hci0 was not created - thus HCI_UART_INIT_PENDING is not
required in that case.

Removing this code also has another benefit: hci_serdev.c does not
support the delayed initialization / registration. Thus the protocol
implementation (hci_h5) never receives any data with this check still
in place. For the H5 protocol this means that the initialization never
completes (because the sync response never arrives). Even if the
initialization would succeed later on the drivers would call
hci_uart_init_ready() which schedules the registration which is
currently not implemented by hci_serdev.c.

Removing the HCI_UART_INIT_PENDING check makes the code easier to read
and also fixes the initalization of devices (implemented with the serdev
library) which use the H5 protocol.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/bluetooth/hci_h5.c     |  3 ---
 drivers/bluetooth/hci_ldisc.c  | 38 --------------------------------------
 drivers/bluetooth/hci_serdev.c |  3 ---
 drivers/bluetooth/hci_uart.h   |  4 +---
 4 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6a8d0d06aba7..6cfc2f276250 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -210,8 +210,6 @@ static int h5_open(struct hci_uart *hu)
 
 	h5->tx_win = H5_TX_WIN_MAX;
 
-	set_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags);
-
 	/* Send initial sync request */
 	h5_link_control(hu, sync, sizeof(sync));
 	mod_timer(&h5->timer, jiffies + H5_SYNC_TIMEOUT);
@@ -316,7 +314,6 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 			h5->tx_win = (data[2] & 0x07);
 		BT_DBG("Three-wire init complete. tx_win %u", h5->tx_win);
 		h5->state = H5_ACTIVE;
-		hci_uart_init_ready(hu);
 		return;
 	} else if (memcmp(data, sleep_req, 2) == 0) {
 		BT_DBG("Peer went to sleep");
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c823914b3a80..5dd3e1bebfe4 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -195,39 +195,6 @@ static void hci_uart_write_work(struct work_struct *work)
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 }
 
-static void hci_uart_init_work(struct work_struct *work)
-{
-	struct hci_uart *hu = container_of(work, struct hci_uart, init_ready);
-	int err;
-	struct hci_dev *hdev;
-
-	if (!test_and_clear_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
-		return;
-
-	err = hci_register_dev(hu->hdev);
-	if (err < 0) {
-		BT_ERR("Can't register HCI device");
-		hdev = hu->hdev;
-		hu->hdev = NULL;
-		hci_free_dev(hdev);
-		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		hu->proto->close(hu);
-		return;
-	}
-
-	set_bit(HCI_UART_REGISTERED, &hu->flags);
-}
-
-int hci_uart_init_ready(struct hci_uart *hu)
-{
-	if (!test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
-		return -EALREADY;
-
-	schedule_work(&hu->init_ready);
-
-	return 0;
-}
-
 /* ------- Interface to HCI layer ------ */
 /* Initialize device */
 static int hci_uart_open(struct hci_dev *hdev)
@@ -490,7 +457,6 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	hu->alignment = 1;
 	hu->padding = 0;
 
-	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
 	percpu_init_rwsem(&hu->proto_lock);
@@ -653,9 +619,6 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	else
 		hdev->dev_type = HCI_PRIMARY;
 
-	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
-		return 0;
-
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hu->hdev = NULL;
@@ -699,7 +662,6 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 	unsigned long valid_flags = BIT(HCI_UART_RAW_DEVICE) |
 				    BIT(HCI_UART_RESET_ON_INIT) |
 				    BIT(HCI_UART_CREATE_AMP) |
-				    BIT(HCI_UART_INIT_PENDING) |
 				    BIT(HCI_UART_EXT_CONFIG) |
 				    BIT(HCI_UART_VND_DETECT);
 
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index e0e6461b9200..fe67eb6d4278 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -333,9 +333,6 @@ int hci_uart_register_device(struct hci_uart *hu,
 	else
 		hdev->dev_type = HCI_PRIMARY;
 
-	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
-		return 0;
-
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		err = -ENODEV;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 66e8c68e4607..47e755ff4092 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -53,7 +53,7 @@
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
 #define HCI_UART_CREATE_AMP	2
-#define HCI_UART_INIT_PENDING	3
+/* 3 is unused - was HCI_UART_INIT_PENDING */
 #define HCI_UART_EXT_CONFIG	4
 #define HCI_UART_VND_DETECT	5
 
@@ -83,7 +83,6 @@ struct hci_uart {
 	unsigned long		flags;
 	unsigned long		hdev_flags;
 
-	struct work_struct	init_ready;
 	struct work_struct	write_work;
 
 	const struct hci_uart_proto *proto;
@@ -115,7 +114,6 @@ int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_proto *p
 void hci_uart_unregister_device(struct hci_uart *hu);
 
 int hci_uart_tx_wakeup(struct hci_uart *hu);
-int hci_uart_init_ready(struct hci_uart *hu);
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
