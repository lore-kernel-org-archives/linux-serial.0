From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v1 5/8] Bluetooth: btrtl: add support for the RTL8723BS and RTL8723DS chips
Date: Fri, 17 Nov 2017 23:35:40 +0100
Message-ID: <20171117223543.32429-6-martin.blumenstingl@googlemail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171117223543.32429-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The Realtek RTL8723BS and RTL8723DS chipsets are SDIO wifi chips. They
also contain a Bluetooth module which is connected via UART to the host.

Realtek's userspace initialization tool (rtk_hciattach) differentiates
these two via the HCI version and revision returned by the
HCI_OP_READ_LOCAL_VERSION command.
Additionally we apply these checks only the for UART devices. Everything
else is assumed to be a "RTL8723B" which was originally supported by the
driver (communicating via USB).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/bluetooth/btrtl.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 45b872f5ad22..d896f9421250 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -418,9 +418,33 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
 		has_rom_version = false;
 		break;
 	case RTL_ROM_LMP_8723B:
-		fw_name = "rtl_bt/rtl8723b_fw.bin";
-		cfg_name = "rtl_bt/rtl8723b_config.bin";
+		/* all variants support reading the ROM version */
 		has_rom_version = true;
+
+		/*
+		 * RTL8723 devices exist in different variants:
+		 * - RTL8723BS (SDIO chip with UART Bluetooth)
+		 * - RTL8723DS (SDIO chip with UART Bluetooth)
+		 * - for backwards-compatibility everything else is assumed to
+		 *   be an RTL8723B communicating over USB
+		 *
+		 * Only UART devices really need the config because that
+		 * contains the UART speed / flow control settings.
+		 */
+		if (hdev->bus == HCI_UART && resp->hci_ver == 6 &&
+		    le16_to_cpu(resp->hci_rev) == 0xb) {
+			fw_name = "rtl_bt/rtl8723bs_fw.bin";
+			cfg_name = "rtl_bt/rtl8723bs_config.bin";
+			cfg_needed = true;
+		} else if (hdev->bus == HCI_UART && resp->hci_ver == 8 &&
+			   le16_to_cpu(resp->hci_rev) == 0xd) {
+			fw_name = "rtl_bt/rtl8723ds_fw.bin";
+			cfg_name = "rtl_bt/rtl872ds_config.bin";
+			cfg_needed = true;
+		} else {
+			fw_name = "rtl_bt/rtl8723b_fw.bin";
+			cfg_name = "rtl_bt/rtl8723b_config.bin";
+		}
 		break;
 	case RTL_ROM_LMP_8821A:
 		fw_name = "rtl_bt/rtl8821a_fw.bin";
@@ -641,6 +665,10 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
