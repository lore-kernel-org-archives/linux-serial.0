From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [RFC v2 4/9] Bluetooth: btrtl: split the device initialization into smaller parts
Date: Mon,  1 Jan 2018 21:42:12 +0100
Message-ID: <20180101204217.26165-5-martin.blumenstingl@googlemail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101204217.26165-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This prepares the btrtl code so it can be used to initialize Bluetooth
modules connected via UART (these are found for example on the RTL8723BS
and RTL8723DS SDIO chips, which come with an embedded UART Bluetooth
module).

The Realtek "rtl8723bs_bt" and "rtl8723ds_bt" userspace Bluetooth UART
initialization tools (rtk_hciattach) use the following sequence:
1) send H5 sync pattern (already supported by hci_h5)
2) get LMP version (already supported by btrtl)
3) get ROM version (already supported by btrtl)
4) load the firmware and config for the current chipset (already
   supported by btrtl)
5) read UART settings from the config blob (currently not supported)
6) send UART settings via a vendor command to the device (which changes
   the baudrate of the device and enables or disables flow control
   depending on the config)
7) change the baudrate and flow control settings on the host
8) send the firmware and config blob to the device (already supported by
   btrtl)

The main reason why the initialization has to be split is step #7. This
requires changes to the underlying "bus", which should be kept outside
of the "generic" btrtl driver.
The idea for this split is borrowed from the btbcm driver but adjusted
where needed (the btrtl driver for example needs two blobs: firmware and
config, while the btbcm only needs one).

This also prepares the code for step #5 (parsing the config blob) by
centralizing the code which loads the firmware and config blobs and
storing the result in the new struct btrtl_device_info.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/bluetooth/btrtl.c | 273 +++++++++++++++++++++++++++-------------------
 drivers/bluetooth/btrtl.h |  21 ++++
 2 files changed, 180 insertions(+), 114 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 3e5296287808..300ee15875e6 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -35,6 +35,15 @@
 #define RTL_ROM_LMP_8761A	0x8761
 #define RTL_ROM_LMP_8822B	0x8822
 
+struct btrtl_device_info {
+	u16 lmp_subver;
+	u8 rom_version;
+	u8 *fw_data;
+	int fw_len;
+	u8 *cfg_data;
+	int cfg_len;
+};
+
 static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 {
 	struct rtl_rom_version_evt *rom_version;
@@ -64,16 +73,16 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 	return 0;
 }
 
-static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
-				   const struct firmware *fw,
+static int rtl8723b_parse_firmware(struct hci_dev *hdev,
+				   struct btrtl_device_info *btrtl_dev,
 				   unsigned char **_buf)
 {
 	const u8 extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
 	struct rtl_epatch_header *epatch_info;
 	unsigned char *buf;
-	int i, ret, len;
+	int i, len;
 	size_t min_size;
-	u8 opcode, length, data, rom_version = 0;
+	u8 opcode, length, data;
 	int project_id = -1;
 	const unsigned char *fwptr, *chip_id_base;
 	const unsigned char *patch_length_base, *patch_offset_base;
@@ -90,15 +99,11 @@ static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
 		{ RTL_ROM_LMP_8822B, 8 },
 	};
 
-	ret = rtl_read_rom_version(hdev, &rom_version);
-	if (ret)
-		return ret;
-
 	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
-	if (fw->size < min_size)
+	if (btrtl_dev->fw_len < min_size)
 		return -EINVAL;
 
-	fwptr = fw->data + fw->size - sizeof(extension_sig);
+	fwptr = btrtl_dev->fw_data + btrtl_dev->fw_len - sizeof(extension_sig);
 	if (memcmp(fwptr, extension_sig, sizeof(extension_sig)) != 0) {
 		BT_ERR("%s: extension section signature mismatch", hdev->name);
 		return -EINVAL;
@@ -110,7 +115,7 @@ static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
 	 * Once we have that, we double-check that that project_id is suitable
 	 * for the hardware we are working with.
 	 */
-	while (fwptr >= fw->data + (sizeof(struct rtl_epatch_header) + 3)) {
+	while (fwptr >= btrtl_dev->fw_data + (sizeof(*epatch_info) + 3)) {
 		opcode = *--fwptr;
 		length = *--fwptr;
 		data = *--fwptr;
@@ -150,13 +155,14 @@ static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
 		return -EINVAL;
 	}
 
-	if (lmp_subver != project_id_to_lmp_subver[i].lmp_subver) {
+	if (btrtl_dev->lmp_subver != project_id_to_lmp_subver[i].lmp_subver) {
 		BT_ERR("%s: firmware is for %x but this is a %x", hdev->name,
-		       project_id_to_lmp_subver[i].lmp_subver, lmp_subver);
+		       project_id_to_lmp_subver[i].lmp_subver,
+		       btrtl_dev->lmp_subver);
 		return -EINVAL;
 	}
 
-	epatch_info = (struct rtl_epatch_header *)fw->data;
+	epatch_info = (struct rtl_epatch_header *)btrtl_dev->fw_data;
 	if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) != 0) {
 		BT_ERR("%s: bad EPATCH signature", hdev->name);
 		return -EINVAL;
@@ -173,16 +179,16 @@ static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
 	 * Find the right patch for this chip.
 	 */
 	min_size += 8 * num_patches;
-	if (fw->size < min_size)
+	if (btrtl_dev->fw_len < min_size)
 		return -EINVAL;
 
-	chip_id_base = fw->data + sizeof(struct rtl_epatch_header);
+	chip_id_base = btrtl_dev->fw_data + sizeof(struct rtl_epatch_header);
 	patch_length_base = chip_id_base + (sizeof(u16) * num_patches);
 	patch_offset_base = patch_length_base + (sizeof(u16) * num_patches);
 	for (i = 0; i < num_patches; i++) {
 		u16 chip_id = get_unaligned_le16(chip_id_base +
 						 (i * sizeof(u16)));
-		if (chip_id == rom_version + 1) {
+		if (chip_id == btrtl_dev->rom_version + 1) {
 			patch_length = get_unaligned_le16(patch_length_base +
 							  (i * sizeof(u16)));
 			patch_offset = get_unaligned_le32(patch_offset_base +
@@ -193,20 +199,21 @@ static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
 
 	if (!patch_offset) {
 		BT_ERR("%s: didn't find patch for chip id %d",
-		       hdev->name, rom_version);
+		       hdev->name, btrtl_dev->rom_version);
 		return -EINVAL;
 	}
 
 	BT_DBG("length=%x offset=%x index %d", patch_length, patch_offset, i);
 	min_size = patch_offset + patch_length;
-	if (fw->size < min_size)
+	if (btrtl_dev->fw_len < min_size)
 		return -EINVAL;
 
 	/* Copy the firmware into a new buffer and write the version at
 	 * the end.
 	 */
 	len = patch_length;
-	buf = kmemdup(fw->data + patch_offset, patch_length, GFP_KERNEL);
+	buf = kmemdup(btrtl_dev->fw_data + patch_offset, patch_length,
+		      GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -268,7 +275,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	return ret;
 }
 
-static int rtl_load_config(struct hci_dev *hdev, const char *name, u8 **buff)
+static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 {
 	const struct firmware *fw;
 	int ret;
@@ -287,95 +294,37 @@ static int rtl_load_config(struct hci_dev *hdev, const char *name, u8 **buff)
 	return ret;
 }
 
-static int btrtl_setup_rtl8723a(struct hci_dev *hdev)
+static int btrtl_setup_rtl8723a(struct hci_dev *hdev,
+				struct btrtl_device_info *btrtl_dev)
 {
-	const struct firmware *fw;
-	int ret;
-
-	bt_dev_info(hdev, "rtl: loading rtl_bt/rtl8723a_fw.bin");
-	ret = request_firmware(&fw, "rtl_bt/rtl8723a_fw.bin", &hdev->dev);
-	if (ret < 0) {
-		BT_ERR("%s: Failed to load rtl_bt/rtl8723a_fw.bin", hdev->name);
-		return ret;
-	}
-
-	if (fw->size < 8) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (btrtl_dev->fw_len < 8)
+		return -EINVAL;
 
 	/* Check that the firmware doesn't have the epatch signature
 	 * (which is only for RTL8723B and newer).
 	 */
-	if (!memcmp(fw->data, RTL_EPATCH_SIGNATURE, 8)) {
+	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8)) {
 		BT_ERR("%s: unexpected EPATCH signature!", hdev->name);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	ret = rtl_download_firmware(hdev, fw->data, fw->size);
-
-out:
-	release_firmware(fw);
-	return ret;
+	return rtl_download_firmware(hdev, btrtl_dev->fw_data,
+				     btrtl_dev->fw_len);
 }
 
-static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
-				const char *fw_name)
+static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
+				struct btrtl_device_info *btrtl_dev)
 {
 	unsigned char *fw_data = NULL;
-	const struct firmware *fw;
 	int ret;
-	int cfg_sz;
-	u8 *cfg_buff = NULL;
 	u8 *tbuff;
-	char *cfg_name = NULL;
-	bool config_needed = false;
 
-	switch (lmp_subver) {
-	case RTL_ROM_LMP_8723B:
-		cfg_name = "rtl_bt/rtl8723b_config.bin";
-		break;
-	case RTL_ROM_LMP_8821A:
-		cfg_name = "rtl_bt/rtl8821a_config.bin";
-		break;
-	case RTL_ROM_LMP_8761A:
-		cfg_name = "rtl_bt/rtl8761a_config.bin";
-		break;
-	case RTL_ROM_LMP_8822B:
-		cfg_name = "rtl_bt/rtl8822b_config.bin";
-		config_needed = true;
-		break;
-	default:
-		BT_ERR("%s: rtl: no config according to lmp_subver %04x",
-		       hdev->name, lmp_subver);
-		break;
-	}
-
-	if (cfg_name) {
-		cfg_sz = rtl_load_config(hdev, cfg_name, &cfg_buff);
-		if (cfg_sz < 0) {
-			cfg_sz = 0;
-			if (config_needed)
-				BT_ERR("Necessary config file %s not found\n",
-				       cfg_name);
-		}
-	} else
-		cfg_sz = 0;
-
-	bt_dev_info(hdev, "rtl: loading %s", fw_name);
-	ret = request_firmware(&fw, fw_name, &hdev->dev);
-	if (ret < 0) {
-		BT_ERR("%s: Failed to load %s", hdev->name, fw_name);
-		goto err_req_fw;
-	}
-
-	ret = rtl8723b_parse_firmware(hdev, lmp_subver, fw, &fw_data);
+	ret = rtl8723b_parse_firmware(hdev, btrtl_dev, &fw_data);
 	if (ret < 0)
 		goto out;
 
-	if (cfg_sz) {
-		tbuff = kzalloc(ret + cfg_sz, GFP_KERNEL);
+	if (btrtl_dev->cfg_len > 0) {
+		tbuff = kzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
 		if (!tbuff) {
 			ret = -ENOMEM;
 			goto out;
@@ -384,22 +333,18 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
 		memcpy(tbuff, fw_data, ret);
 		kfree(fw_data);
 
-		memcpy(tbuff + ret, cfg_buff, cfg_sz);
-		ret += cfg_sz;
+		memcpy(tbuff + ret, btrtl_dev->cfg_data, btrtl_dev->cfg_len);
+		ret += btrtl_dev->cfg_len;
 
 		fw_data = tbuff;
 	}
 
-	bt_dev_info(hdev, "cfg_sz %d, total size %d", cfg_sz, ret);
+	bt_dev_info(hdev, "cfg_sz %d, total size %d", btrtl_dev->cfg_len, ret);
 
 	ret = rtl_download_firmware(hdev, fw_data, ret);
 
 out:
-	release_firmware(fw);
 	kfree(fw_data);
-err_req_fw:
-	if (cfg_sz)
-		kfree(cfg_buff);
 	return ret;
 }
 
@@ -425,15 +370,34 @@ static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
 	return skb;
 }
 
-int btrtl_setup_realtek(struct hci_dev *hdev)
+void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
+	kfree(btrtl_dev->fw_data);
+	kfree(btrtl_dev->cfg_data);
+	kfree(btrtl_dev);
+}
+EXPORT_SYMBOL_GPL(btrtl_free);
+
+struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
+{
+	struct btrtl_device_info *btrtl_dev;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
-	u16 lmp_subver;
+	bool cfg_needed = false, has_rom_version;
+	const char *cfg_name, *fw_name;
+	int ret;
+
+	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
+	if (!btrtl_dev) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
 
 	skb = btrtl_read_local_version(hdev);
-	if (IS_ERR(skb))
-		return -PTR_ERR(skb);
+	if (IS_ERR(skb)) {
+		ret = -PTR_ERR(skb);
+		goto err_free;
+	}
 
 	resp = (struct hci_rp_read_local_version *)skb->data;
 	bt_dev_info(hdev, "rtl: examining hci_ver=%02x hci_rev=%04x "
@@ -441,36 +405,117 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 		    resp->hci_ver, resp->hci_rev,
 		    resp->lmp_ver, resp->lmp_subver);
 
-	lmp_subver = le16_to_cpu(resp->lmp_subver);
+	btrtl_dev->lmp_subver = le16_to_cpu(resp->lmp_subver);
+
 	kfree_skb(skb);
 
+	switch (btrtl_dev->lmp_subver) {
+	case RTL_ROM_LMP_8723A:
+	case RTL_ROM_LMP_3499:
+		fw_name = "rtl_bt/rtl8723a_fw.bin";
+		cfg_name = NULL;
+		has_rom_version = false;
+		break;
+	case RTL_ROM_LMP_8723B:
+		fw_name = "rtl_bt/rtl8723b_fw.bin";
+		cfg_name = "rtl_bt/rtl8723b_config.bin";
+		has_rom_version = true;
+		break;
+	case RTL_ROM_LMP_8821A:
+		fw_name = "rtl_bt/rtl8821a_fw.bin";
+		cfg_name = "rtl_bt/rtl8821a_config.bin";
+		has_rom_version = true;
+		break;
+	case RTL_ROM_LMP_8761A:
+		fw_name = "rtl_bt/rtl8761a_fw.bin";
+		cfg_name = "rtl_bt/rtl8761a_config.bin";
+		has_rom_version = true;
+		break;
+	case RTL_ROM_LMP_8822B:
+		fw_name = "rtl_bt/rtl8822b_fw.bin";
+		cfg_name = "rtl_bt/rtl8822b_config.bin";
+		has_rom_version = true;
+		cfg_needed = true;
+		break;
+	default:
+		bt_dev_info(hdev, "rtl: assuming no firmware upload needed");
+		return btrtl_dev;
+	}
+
+	if (has_rom_version) {
+		ret = rtl_read_rom_version(hdev, &btrtl_dev->rom_version);
+		if (ret)
+			goto err_free;
+	}
+
+	btrtl_dev->fw_len = rtl_load_file(hdev, fw_name, &btrtl_dev->fw_data);
+	if (btrtl_dev->fw_len < 0) {
+		bt_dev_err(hdev, "firmware file %s not found\n", fw_name);
+		ret = btrtl_dev->fw_len;
+		goto err_free;
+	}
+
+	if (cfg_name) {
+		btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
+						   &btrtl_dev->cfg_data);
+		if (cfg_needed && btrtl_dev->cfg_len <= 0) {
+			bt_dev_err(hdev,
+				   "mandatory config file %s not found\n",
+				   cfg_name);
+			ret = btrtl_dev->fw_len;
+			goto err_free;
+		}
+	}
+
+	return btrtl_dev;
+
+err_free:
+	btrtl_free(btrtl_dev);
+err_alloc:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(btrtl_initialize);
+
+int btrtl_download_firmware(struct hci_dev *hdev,
+			    struct btrtl_device_info *btrtl_dev)
+{
 	/* Match a set of subver values that correspond to stock firmware,
 	 * which is not compatible with standard btusb.
 	 * If matched, upload an alternative firmware that does conform to
 	 * standard btusb. Once that firmware is uploaded, the subver changes
 	 * to a different value.
 	 */
-	switch (lmp_subver) {
+	switch (btrtl_dev->lmp_subver) {
 	case RTL_ROM_LMP_8723A:
 	case RTL_ROM_LMP_3499:
-		return btrtl_setup_rtl8723a(hdev);
+		return btrtl_setup_rtl8723a(hdev, btrtl_dev);
 	case RTL_ROM_LMP_8723B:
-		return btrtl_setup_rtl8723b(hdev, lmp_subver,
-					    "rtl_bt/rtl8723b_fw.bin");
 	case RTL_ROM_LMP_8821A:
-		return btrtl_setup_rtl8723b(hdev, lmp_subver,
-					    "rtl_bt/rtl8821a_fw.bin");
 	case RTL_ROM_LMP_8761A:
-		return btrtl_setup_rtl8723b(hdev, lmp_subver,
-					    "rtl_bt/rtl8761a_fw.bin");
 	case RTL_ROM_LMP_8822B:
-		return btrtl_setup_rtl8723b(hdev, lmp_subver,
-					    "rtl_bt/rtl8822b_fw.bin");
+		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
 	default:
 		bt_dev_info(hdev, "rtl: assuming no firmware upload needed");
 		return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(btrtl_download_firmware);
+
+int btrtl_setup_realtek(struct hci_dev *hdev)
+{
+	struct btrtl_device_info *btrtl_dev;
+	int ret;
+
+	btrtl_dev = btrtl_initialize(hdev);
+	if (IS_ERR(btrtl_dev))
+		return PTR_ERR(btrtl_dev);
+
+	ret = btrtl_download_firmware(hdev, btrtl_dev);
+
+	btrtl_free(btrtl_dev);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(btrtl_setup_realtek);
 
 MODULE_AUTHOR("Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>");
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 38ffe4890cd1..21c28dcbe5e0 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -17,6 +17,8 @@
 
 #define RTL_FRAG_LEN 252
 
+struct btrtl_device_info;
+
 struct rtl_download_cmd {
 	__u8 index;
 	__u8 data[RTL_FRAG_LEN];
@@ -40,10 +42,29 @@ struct rtl_epatch_header {
 
 #if IS_ENABLED(CONFIG_BT_RTL)
 
+struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev);
+void btrtl_free(struct btrtl_device_info *btrtl_dev);
+int btrtl_download_firmware(struct hci_dev *hdev,
+			    struct btrtl_device_info *btrtl_dev);
 int btrtl_setup_realtek(struct hci_dev *hdev);
 
 #else
 
+static inline struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void btrtl_free(struct btrtl_device_info *btrtl_dev)
+{
+}
+
+static inline int btrtl_download_firmware(struct hci_dev *hdev,
+					  struct btrtl_device_info *btrtl_dev)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btrtl_setup_realtek(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
