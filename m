From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v1 6/8] Bluetooth: hci_h5: add support for Realtek UART Bluetooth modules
Date: Fri, 17 Nov 2017 23:35:41 +0100
Message-ID: <20171117223543.32429-7-martin.blumenstingl@googlemail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171117223543.32429-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Realtek RTL8723BS and RTL8723DS are SDIO wifi chips with an embedded
Bluetooth controller which connects to the host via UART.
The H5 protocol is used for communication between host and device.

The Realtek "rtl8723bs_bt" and "rtl8723ds_bt" userspace Bluetooth UART
initialization tools (rtk_hciattach) use the following sequence:
1) send H5 sync pattern (already supported by hci_h5)
2) get LMP version (already supported by btrtl)
3) get ROM version (already supported by btrtl)
4) load the firmware and config for the current chipset (already
   supported by btrtl)
5) read UART settings from the config blob (already supported by btrtl)
6) send UART settings via a vendor command to the device (which changes
   the baudrate of the device and enables or disables flow control
   depending on the config)
7) change the baudrate and flow control settings on the host
8) send the firmware and config blob to the device (already supported by
   btrtl)

This uses the serdev library as well as the existing btrtl driver to
initialize the Bluetooth functionality, which consists of:
- identifying the device and loading the corresponding firmware and
  config blobs (steps #2, #3 and #4)
- configuring the baudrate and flow control (steps #6 and #7)
- uploading the firmware to the device (step #8)

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/bluetooth/Kconfig  |   1 +
 drivers/bluetooth/hci_h5.c | 195 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 60e1c7d6986d..3001f1200c72 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -146,6 +146,7 @@ config BT_HCIUART_LL
 config BT_HCIUART_3WIRE
 	bool "Three-wire UART (H5) protocol support"
 	depends on BT_HCIUART
+	select BT_RTL if SERIAL_DEV_BUS
 	help
 	  The HCI Three-wire UART Transport Layer makes it possible to
 	  user the Bluetooth HCI over a serial port interface. The HCI
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6a8d0d06aba7..7d584e5928bf 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -28,7 +28,14 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/serdev.h>
+
 #include "hci_uart.h"
+#include "btrtl.h"
 
 #define HCI_3WIRE_ACK_PKT	0
 #define HCI_3WIRE_LINK_PKT	15
@@ -97,6 +104,13 @@ struct h5 {
 	} sleep;
 };
 
+struct h5_device {
+	struct hci_uart hu;
+	struct gpio_desc *disable_gpio;
+	struct gpio_desc *reset_gpio;
+	int (*vendor_setup)(struct h5_device *h5_dev);
+};
+
 static void h5_reset_rx(struct h5 *h5);
 
 static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
@@ -190,6 +204,7 @@ static int h5_open(struct hci_uart *hu)
 {
 	struct h5 *h5;
 	const unsigned char sync[] = { 0x01, 0x7e };
+	int err;
 
 	BT_DBG("hu %p", hu);
 
@@ -210,6 +225,14 @@ static int h5_open(struct hci_uart *hu)
 
 	h5->tx_win = H5_TX_WIN_MAX;
 
+	if (hu->serdev) {
+		err = serdev_device_open(hu->serdev);
+		if (err) {
+			bt_dev_err(hu->hdev, "failed to open serdev: %d", err);
+			return err;
+		}
+	}
+
 	set_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags);
 
 	/* Send initial sync request */
@@ -219,6 +242,23 @@ static int h5_open(struct hci_uart *hu)
 	return 0;
 }
 
+static int h5_setup(struct hci_uart *hu)
+{
+	int err;
+	struct h5_device *h5_dev;
+
+	if (!hu->serdev)
+		return 0;
+
+	h5_dev = serdev_device_get_drvdata(hu->serdev);
+
+	err = h5_dev->vendor_setup(h5_dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int h5_close(struct hci_uart *hu)
 {
 	struct h5 *h5 = hu->priv;
@@ -229,6 +269,15 @@ static int h5_close(struct hci_uart *hu)
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
 
+	if (hu->serdev) {
+		struct h5_device *h5_dev;
+
+		h5_dev = serdev_device_get_drvdata(hu->serdev);
+		gpiod_set_value_cansleep(h5_dev->disable_gpio, 1);
+
+		serdev_device_close(hu->serdev);
+	}
+
 	kfree(h5);
 
 	return 0;
@@ -316,7 +365,10 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 			h5->tx_win = (data[2] & 0x07);
 		BT_DBG("Three-wire init complete. tx_win %u", h5->tx_win);
 		h5->state = H5_ACTIVE;
-		hci_uart_init_ready(hu);
+
+		/* serdev does not support the "init_ready" signal */
+		if (!hu->serdev)
+			hci_uart_init_ready(hu);
 		return;
 	} else if (memcmp(data, sleep_req, 2) == 0) {
 		BT_DBG("Peer went to sleep");
@@ -739,10 +791,147 @@ static int h5_flush(struct hci_uart *hu)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SERIAL_DEV_BUS)
+static int h5_setup_realtek(struct h5_device *h5_dev)
+{
+	struct hci_uart *hu = &h5_dev->hu;
+	int err = 0, retry = 3;
+	struct sk_buff *skb;
+	struct btrtl_device_info *btrtl_dev;
+	__le32 baudrate_data;
+	u32 device_baudrate;
+	unsigned int controller_baudrate;
+	bool flow_control;
+
+	/* devices always start with flow control disabled and even parity */
+	serdev_device_set_flow_control(hu->serdev, false);
+	serdev_device_set_parity(hu->serdev, true, false);
+
+	do {
+		/* Configure BT_DISn and BT_RST_N to LOW state */
+		gpiod_set_value_cansleep(h5_dev->reset_gpio, 1);
+		gpiod_set_value_cansleep(h5_dev->disable_gpio, 1);
+		msleep(500);
+		gpiod_set_value_cansleep(h5_dev->reset_gpio, 0);
+		gpiod_set_value_cansleep(h5_dev->disable_gpio, 0);
+		msleep(500);
+
+		btrtl_dev = btrtl_initialize(hu->hdev);
+		if (!IS_ERR(btrtl_dev))
+			break;
+
+		/* Toggle BT_DISn and retry */
+	} while (retry--);
+
+	if (IS_ERR(btrtl_dev))
+		return PTR_ERR(btrtl_dev);
+
+	err = btrtl_get_uart_settings(hu->hdev, btrtl_dev,
+				      &controller_baudrate, &device_baudrate,
+				      &flow_control);
+	if (err)
+		goto out_free;
+
+	baudrate_data = cpu_to_le32(device_baudrate);
+	skb = __hci_cmd_sync(hu->hdev, 0xfc17, sizeof(baudrate_data),
+			     &baudrate_data, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hu->hdev, "set baud rate command failed");
+		err = -PTR_ERR(skb);
+		goto out_free;
+	} else {
+		kfree_skb(skb);
+	}
+
+	msleep(500);
+
+	serdev_device_set_baudrate(hu->serdev, controller_baudrate);
+	serdev_device_set_flow_control(hu->serdev, flow_control);
+
+	err = btrtl_download_firmware(hu->hdev, btrtl_dev);
+
+out_free:
+	btrtl_free(btrtl_dev);
+
+	return err;
+}
+
+static const struct hci_uart_proto h5p;
+
+static int hci_h5_probe(struct serdev_device *serdev)
+{
+	struct hci_uart *hu;
+	struct h5_device *h5_dev;
+
+	h5_dev = devm_kzalloc(&serdev->dev, sizeof(*h5_dev), GFP_KERNEL);
+	if (!h5_dev)
+		return -ENOMEM;
+
+	hu = &h5_dev->hu;
+	hu->serdev = serdev;
+
+	serdev_device_set_drvdata(serdev, h5_dev);
+
+	h5_dev->vendor_setup = of_device_get_match_data(&serdev->dev);
+
+	h5_dev->disable_gpio = devm_gpiod_get_optional(&serdev->dev, "disable",
+						       GPIOD_OUT_LOW);
+	if (IS_ERR(h5_dev->disable_gpio))
+		return PTR_ERR(h5_dev->disable_gpio);
+
+	h5_dev->reset_gpio = devm_gpiod_get_optional(&serdev->dev, "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(h5_dev->reset_gpio))
+		return PTR_ERR(h5_dev->reset_gpio);
+
+	hci_uart_set_speeds(hu, 115200, 0);
+
+	return hci_uart_register_device(hu, &h5p);
+}
+
+static void hci_h5_remove(struct serdev_device *serdev)
+{
+	struct h5_device *h5_dev = serdev_device_get_drvdata(serdev);
+	struct hci_uart *hu = &h5_dev->hu;
+	struct hci_dev *hdev = hu->hdev;
+
+	cancel_work_sync(&hu->write_work);
+
+	hci_unregister_dev(hdev);
+	hci_free_dev(hdev);
+	hu->proto->close(hu);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id hci_h5_of_match[] = {
+	{
+		.compatible = "realtek,rtl8723bs-bluetooth",
+		.data = h5_setup_realtek
+	},
+	{
+		.compatible = "realtek,rtl8723ds-bluetooth",
+		.data = h5_setup_realtek
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hci_h5_of_match);
+#endif
+
+static struct serdev_device_driver hci_h5_drv = {
+	.driver		= {
+		.name	= "hci-h5",
+		.of_match_table = of_match_ptr(hci_h5_of_match),
+	},
+	.probe	= hci_h5_probe,
+	.remove	= hci_h5_remove,
+};
+#endif
+
 static const struct hci_uart_proto h5p = {
 	.id		= HCI_UART_3WIRE,
 	.name		= "Three-wire (H5)",
 	.open		= h5_open,
+	.setup		= h5_setup,
 	.close		= h5_close,
 	.recv		= h5_recv,
 	.enqueue	= h5_enqueue,
@@ -752,10 +941,14 @@ static const struct hci_uart_proto h5p = {
 
 int __init h5_init(void)
 {
+	serdev_device_driver_register(&hci_h5_drv);
+
 	return hci_uart_register_proto(&h5p);
 }
 
 int __exit h5_deinit(void)
 {
+	serdev_device_driver_unregister(&hci_h5_drv);
+
 	return hci_uart_unregister_proto(&h5p);
 }
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
