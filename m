From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v1 4/8] Bluetooth: btrtl: add support for retrieving the UART settings
Date: Fri, 17 Nov 2017 23:35:39 +0100
Message-ID: <20171117223543.32429-5-martin.blumenstingl@googlemail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171117223543.32429-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The UART settings are embedded in the config blob. This has to be parsed
to successfully initialize the Bluetooth part of the RTL8723BS (which is
an SDIO chip, but the Bluetooth part is connected via UART).

The Realtek "rtl8723bs_bt" and "rtl8723ds_bt" userspace Bluetooth UART
initialization tools (rtk_hciattach) use the following sequence:
- send H5 sync pattern (already supported by hci_h5)
- get LMP version (already supported by btrtl)
- get ROM version (already supported by btrtl)
- load the firmware and config for the current chipset (already
  supported by btrtl)
- read UART settings from the config blob (part of this patch)
- send UART settings via a vendor command to the device (which changes
  the baudrate of the device and enables or disables flow control
  depending on the config)
- change the baudrate and flow control settings on the host
- send the firmware and config blob to the device (already supported by
  btrtl)

Sending the last firmware and config blob download command
(rtl_download_cmd) fails if the UART settings are not updated
beforehand. This is presumably because the device applies the config
right after the firmware and config blob download - which means that at
this point the host is using different UART settings than the device
(which will obviously result in non-working communication).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/bluetooth/btrtl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btrtl.h |  25 +++++++++++
 2 files changed, 137 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 07f96b8000f1..45b872f5ad22 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -34,6 +34,7 @@
 #define RTL_ROM_LMP_8821A	0x8821
 #define RTL_ROM_LMP_8761A	0x8761
 #define RTL_ROM_LMP_8822B	0x8822
+#define RTL_CONFIG_MAGIC	0x8723ab55
 
 struct btrtl_device_info {
 	u16 lmp_subver;
@@ -522,6 +523,117 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btrtl_setup_realtek);
 
+unsigned int btrtl_convert_baudrate(u32 device_baudrate)
+{
+	switch (device_baudrate) {
+	case 0x0252a00a:
+		return 230400;
+
+	case 0x05f75004:
+		return 921600;
+
+	case 0x00005004:
+		return 1000000;
+
+	case 0x04928002:
+	case 0x01128002:
+		return 1500000;
+
+	case 0x00005002:
+		return 2000000;
+
+	case 0x0000b001:
+		return 2500000;
+
+	case 0x04928001:
+		return 3000000;
+
+	case 0x052a6001:
+		return 3500000;
+
+	case 0x00005001:
+		return 4000000;
+
+	case 0x0252c014:
+	default:
+		return 115200;
+	}
+}
+
+int btrtl_get_uart_settings(struct hci_dev *hdev,
+			    struct btrtl_device_info *btrtl_dev,
+			    unsigned int *controller_baudrate,
+			    u32 *device_baudrate, bool *flow_control)
+{
+	struct rtl_vendor_config *config;
+	struct rtl_vendor_config_entry *entry;
+	int i, total_data_len;
+	bool found = false;
+
+	total_data_len = btrtl_dev->cfg_len - sizeof(*config);
+	if (total_data_len <= 0) {
+		bt_dev_warn(hdev, "rtl: no config loaded");
+		return -EINVAL;
+	}
+
+	config = (struct rtl_vendor_config *)btrtl_dev->cfg_data;
+	if (le32_to_cpu(config->signature) != RTL_CONFIG_MAGIC) {
+		bt_dev_err(hdev, "rtl: invalid config magic");
+		return -EINVAL;
+	}
+
+	if (total_data_len < le16_to_cpu(config->total_len)) {
+		bt_dev_err(hdev, "rtl: config is too short");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < total_data_len; ) {
+		entry = ((void *)config->entry) + i;
+
+		switch (le16_to_cpu(entry->offset)) {
+		case 0xc:
+			if (entry->len < sizeof(*device_baudrate)) {
+				bt_dev_err(hdev,
+					   "rtl: invalid UART config entry");
+				return -EINVAL;
+			}
+
+			*device_baudrate = get_unaligned_le32(entry->data);
+			*controller_baudrate = btrtl_convert_baudrate(
+							*device_baudrate);
+
+			if (entry->len >= 13)
+				*flow_control = !!(entry->data[12] & BIT(2));
+			else
+				*flow_control = false;
+
+			found = true;
+			break;
+
+		default:
+			bt_dev_dbg(hdev,
+				   "rtl: skipping config entry 0x%x (len %u)",
+				   le16_to_cpu(entry->offset), entry->len);
+			break;
+		};
+
+		i += sizeof(*entry) + entry->len;
+	}
+
+	if (!found) {
+		bt_dev_err(hdev, "rtl: no UART config entry found");
+		return -ENOENT;
+	}
+
+	bt_dev_dbg(hdev, "rtl: device baudrate = 0x%08x", *device_baudrate);
+	bt_dev_dbg(hdev, "rtl: controller baudrate = %u",
+		   *controller_baudrate);
+	bt_dev_dbg(hdev, "rtl: flow control %d", *flow_control);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
+
 MODULE_AUTHOR("Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 21c28dcbe5e0..2e7856fa5ac7 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -40,6 +40,18 @@ struct rtl_epatch_header {
 	__le16 num_patches;
 } __packed;
 
+struct rtl_vendor_config_entry {
+	__le16 offset;
+	__u8 len;
+	__u8 data[0];
+} __packed;
+
+struct rtl_vendor_config {
+	__le32 signature;
+	__le16 total_len;
+	struct rtl_vendor_config_entry entry[0];
+} __packed;
+
 #if IS_ENABLED(CONFIG_BT_RTL)
 
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev);
@@ -47,6 +59,10 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev);
 int btrtl_download_firmware(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev);
 int btrtl_setup_realtek(struct hci_dev *hdev);
+int btrtl_get_uart_settings(struct hci_dev *hdev,
+			    struct btrtl_device_info *btrtl_dev,
+			    unsigned int *controller_baudrate,
+			    u32 *device_baudrate, bool *flow_control);
 
 #else
 
@@ -70,4 +86,13 @@ static inline int btrtl_setup_realtek(struct hci_dev *hdev)
 	return -EOPNOTSUPP;
 }
 
+static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
+					  struct btrtl_device_info *btrtl_dev,
+					  unsigned int *controller_baudrate,
+					  u32 *device_baudrate,
+					  bool *flow_control)
+{
+	return -ENOENT;
+}
+
 #endif
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
