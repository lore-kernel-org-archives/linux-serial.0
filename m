From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 40/48] pch_phub: Support new device ML7223
Date: Mon, 23 May 2011 12:10:46 -0700
Message-ID: <1306177854-18172-40-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42124 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932294Ab1EWTMH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:12:07 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Support new device OKI SEMICONDUCTOR ML7223 IOH(Input/Output Hub).
The ML7223 IOH is for MP(Media Phone) use.
The ML7223 is companion chip for Intel Atom E6xx series.
The ML7223 is completely compatible for Intel EG20T PCH.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/misc/Kconfig    |   12 ++--
 drivers/misc/pch_phub.c |  153 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 136 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4e007c6..915c31e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -459,7 +459,7 @@ config BMP085
 	  module will be called bmp085.
 
 config PCH_PHUB
-	tristate "PCH Packet Hub of Intel Topcliff / OKI SEMICONDUCTOR ML7213"
+	tristate "Intel EG20T PCH / OKI SEMICONDUCTOR IOH(ML7213/ML7223) PHUB"
 	depends on PCI
 	help
 	  This driver is for PCH(Platform controller Hub) PHUB(Packet Hub) of
@@ -467,10 +467,12 @@ config PCH_PHUB
 	  processor. The Topcliff has MAC address and Option ROM data in SROM.
 	  This driver can access MAC address and Option ROM data in SROM.
 
-	  This driver also can be used for OKI SEMICONDUCTOR's ML7213 which is
-	  for IVI(In-Vehicle Infotainment) use.
-	  ML7213 is companion chip for Intel Atom E6xx series.
-	  ML7213 is completely compatible for Intel EG20T PCH.
+	  This driver also can be used for OKI SEMICONDUCTOR IOH(Input/
+	  Output Hub), ML7213 and ML7223.
+	  ML7213 IOH is for IVI(In-Vehicle Infotainment) use and ML7223 IOH is
+	  for MP(Media Phone) use.
+	  ML7213/ML7223 is companion chip for Intel Atom E6xx series.
+	  ML7213/ML7223 is completely compatible for Intel EG20T PCH.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called pch_phub.
diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index a19cb71..5fe79df 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -34,12 +34,18 @@
 #define PHUB_TIMEOUT 0x05		/* Time out value for Status Register */
 #define PCH_PHUB_ROM_WRITE_ENABLE 0x01	/* Enabling for writing ROM */
 #define PCH_PHUB_ROM_WRITE_DISABLE 0x00	/* Disabling for writing ROM */
-#define PCH_PHUB_MAC_START_ADDR 0x20C  /* MAC data area start address offset */
-#define PCH_PHUB_ROM_START_ADDR_EG20T 0x14 /* ROM data area start address offset
+#define PCH_PHUB_MAC_START_ADDR_EG20T 0x14  /* MAC data area start address
+					       offset */
+#define PCH_PHUB_MAC_START_ADDR_ML7223 0x20C  /* MAC data area start address
+						 offset */
+#define PCH_PHUB_ROM_START_ADDR_EG20T 0x80 /* ROM data area start address offset
 					      (Intel EG20T PCH)*/
 #define PCH_PHUB_ROM_START_ADDR_ML7213 0x400 /* ROM data area start address
 						offset(OKI SEMICONDUCTOR ML7213)
 					      */
+#define PCH_PHUB_ROM_START_ADDR_ML7223 0x400 /* ROM data area start address
+						offset(OKI SEMICONDUCTOR ML7223)
+					      */
 
 /* MAX number of INT_REDUCE_CONTROL registers */
 #define MAX_NUM_INT_REDUCE_CONTROL_REG 128
@@ -63,6 +69,10 @@
 #define PCI_VENDOR_ID_ROHM			0x10db
 #define PCI_DEVICE_ID_ROHM_ML7213_PHUB		0x801A
 
+/* Macros for ML7223 */
+#define PCI_DEVICE_ID_ROHM_ML7223_mPHUB	0x8012 /* for Bus-m */
+#define PCI_DEVICE_ID_ROHM_ML7223_nPHUB	0x8002 /* for Bus-n */
+
 /* SROM ACCESS Macro */
 #define PCH_WORD_ADDR_MASK (~((1 << 2) - 1))
 
@@ -100,6 +110,9 @@
  * @clkcfg_reg:				CLK CFG register val
  * @pch_phub_base_address:		Register base address
  * @pch_phub_extrom_base_address:	external rom base address
+ * @pch_mac_start_address:		MAC address area start address
+ * @pch_opt_rom_start_address:		Option ROM start address
+ * @ioh_type:				Save IOH type
  */
 struct pch_phub_reg {
 	u32 phub_id_reg;
@@ -117,6 +130,9 @@ struct pch_phub_reg {
 	u32 clkcfg_reg;
 	void __iomem *pch_phub_base_address;
 	void __iomem *pch_phub_extrom_base_address;
+	u32 pch_mac_start_address;
+	u32 pch_opt_rom_start_address;
+	int ioh_type;
 };
 
 /* SROM SPEC for MAC address assignment offset */
@@ -319,7 +335,7 @@ static void pch_phub_read_serial_rom_val(struct pch_phub_reg *chip,
 {
 	unsigned int mem_addr;
 
-	mem_addr = PCH_PHUB_ROM_START_ADDR_EG20T +
+	mem_addr = chip->pch_mac_start_address +
 			pch_phub_mac_offset[offset_address];
 
 	pch_phub_read_serial_rom(chip, mem_addr, data);
@@ -336,7 +352,7 @@ static int pch_phub_write_serial_rom_val(struct pch_phub_reg *chip,
 	int retval;
 	unsigned int mem_addr;
 
-	mem_addr = PCH_PHUB_ROM_START_ADDR_EG20T +
+	mem_addr = chip->pch_mac_start_address +
 			pch_phub_mac_offset[offset_address];
 
 	retval = pch_phub_write_serial_rom(chip, mem_addr, data);
@@ -384,6 +400,48 @@ static int pch_phub_gbe_serial_rom_conf(struct pch_phub_reg *chip)
 	return retval;
 }
 
+/* pch_phub_gbe_serial_rom_conf_mp - makes SerialROM header format configuration
+ * for Gigabit Ethernet MAC address
+ */
+static int pch_phub_gbe_serial_rom_conf_mp(struct pch_phub_reg *chip)
+{
+	int retval;
+	u32 offset_addr;
+
+	offset_addr = 0x200;
+	retval = pch_phub_write_serial_rom(chip, 0x03 + offset_addr, 0xbc);
+	retval |= pch_phub_write_serial_rom(chip, 0x02 + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x01 + offset_addr, 0x40);
+	retval |= pch_phub_write_serial_rom(chip, 0x00 + offset_addr, 0x02);
+
+	retval |= pch_phub_write_serial_rom(chip, 0x07 + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x06 + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x05 + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x04 + offset_addr, 0x80);
+
+	retval |= pch_phub_write_serial_rom(chip, 0x0b + offset_addr, 0xbc);
+	retval |= pch_phub_write_serial_rom(chip, 0x0a + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x09 + offset_addr, 0x40);
+	retval |= pch_phub_write_serial_rom(chip, 0x08 + offset_addr, 0x18);
+
+	retval |= pch_phub_write_serial_rom(chip, 0x13 + offset_addr, 0xbc);
+	retval |= pch_phub_write_serial_rom(chip, 0x12 + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x11 + offset_addr, 0x40);
+	retval |= pch_phub_write_serial_rom(chip, 0x10 + offset_addr, 0x19);
+
+	retval |= pch_phub_write_serial_rom(chip, 0x1b + offset_addr, 0xbc);
+	retval |= pch_phub_write_serial_rom(chip, 0x1a + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x19 + offset_addr, 0x40);
+	retval |= pch_phub_write_serial_rom(chip, 0x18 + offset_addr, 0x3a);
+
+	retval |= pch_phub_write_serial_rom(chip, 0x1f + offset_addr, 0x01);
+	retval |= pch_phub_write_serial_rom(chip, 0x1e + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x1d + offset_addr, 0x00);
+	retval |= pch_phub_write_serial_rom(chip, 0x1c + offset_addr, 0x00);
+
+	return retval;
+}
+
 /**
  * pch_phub_read_gbe_mac_addr() - Read Gigabit Ethernet MAC address
  * @offset_address:	Gigabit Ethernet MAC address offset value.
@@ -406,7 +464,10 @@ static int pch_phub_write_gbe_mac_addr(struct pch_phub_reg *chip, u8 *data)
 	int retval;
 	int i;
 
-	retval = pch_phub_gbe_serial_rom_conf(chip);
+	if (chip->ioh_type == 1) /* EG20T */
+		retval = pch_phub_gbe_serial_rom_conf(chip);
+	else	/* ML7223 */
+		retval = pch_phub_gbe_serial_rom_conf_mp(chip);
 	if (retval)
 		return retval;
 
@@ -441,12 +502,16 @@ static ssize_t pch_phub_bin_read(struct file *filp, struct kobject *kobj,
 	}
 
 	/* Get Rom signature */
-	pch_phub_read_serial_rom(chip, 0x80, (unsigned char *)&rom_signature);
+	pch_phub_read_serial_rom(chip, chip->pch_opt_rom_start_address,
+				(unsigned char *)&rom_signature);
 	rom_signature &= 0xff;
-	pch_phub_read_serial_rom(chip, 0x81, (unsigned char *)&tmp);
+	pch_phub_read_serial_rom(chip, chip->pch_opt_rom_start_address + 1,
+				(unsigned char *)&tmp);
 	rom_signature |= (tmp & 0xff) << 8;
 	if (rom_signature == 0xAA55) {
-		pch_phub_read_serial_rom(chip, 0x82, &rom_length);
+		pch_phub_read_serial_rom(chip,
+					 chip->pch_opt_rom_start_address + 2,
+					 &rom_length);
 		orom_size = rom_length * 512;
 		if (orom_size < off) {
 			addr_offset = 0;
@@ -458,8 +523,9 @@ static ssize_t pch_phub_bin_read(struct file *filp, struct kobject *kobj,
 		}
 
 		for (addr_offset = 0; addr_offset < count; addr_offset++) {
-			pch_phub_read_serial_rom(chip, 0x80 + addr_offset + off,
-							 &buf[addr_offset]);
+			pch_phub_read_serial_rom(chip,
+			    chip->pch_opt_rom_start_address + addr_offset + off,
+			    &buf[addr_offset]);
 		}
 	} else {
 		err = -ENODATA;
@@ -502,8 +568,9 @@ static ssize_t pch_phub_bin_write(struct file *filp, struct kobject *kobj,
 		if (PCH_PHUB_OROM_SIZE < off + addr_offset)
 			goto return_ok;
 
-		ret = pch_phub_write_serial_rom(chip, 0x80 + addr_offset + off,
-						       buf[addr_offset]);
+		ret = pch_phub_write_serial_rom(chip,
+			    chip->pch_opt_rom_start_address + addr_offset + off,
+			    buf[addr_offset]);
 		if (ret) {
 			err = ret;
 			goto return_err;
@@ -603,19 +670,22 @@ static int __devinit pch_phub_probe(struct pci_dev *pdev,
 	dev_dbg(&pdev->dev, "%s : pci_iomap SUCCESS and value "
 		"in pch_phub_base_address variable is %p\n", __func__,
 		chip->pch_phub_base_address);
-	chip->pch_phub_extrom_base_address = pci_map_rom(pdev, &rom_size);
 
-	if (chip->pch_phub_extrom_base_address == 0) {
-		dev_err(&pdev->dev, "%s : pci_map_rom FAILED", __func__);
-		ret = -ENOMEM;
-		goto err_pci_map;
+	if (id->driver_data != 3) {
+		chip->pch_phub_extrom_base_address =\
+						   pci_map_rom(pdev, &rom_size);
+		if (chip->pch_phub_extrom_base_address == 0) {
+			dev_err(&pdev->dev, "%s: pci_map_rom FAILED", __func__);
+			ret = -ENOMEM;
+			goto err_pci_map;
+		}
+		dev_dbg(&pdev->dev, "%s : "
+			"pci_map_rom SUCCESS and value in "
+			"pch_phub_extrom_base_address variable is %p\n",
+			__func__, chip->pch_phub_extrom_base_address);
 	}
-	dev_dbg(&pdev->dev, "%s : "
-		"pci_map_rom SUCCESS and value in "
-		"pch_phub_extrom_base_address variable is %p\n", __func__,
-		chip->pch_phub_extrom_base_address);
 
-	if (id->driver_data == 1) {
+	if (id->driver_data == 1) { /* EG20T PCH */
 		retval = sysfs_create_file(&pdev->dev.kobj,
 					   &dev_attr_pch_mac.attr);
 		if (retval)
@@ -642,7 +712,9 @@ static int __devinit pch_phub_probe(struct pci_dev *pdev,
 		iowrite32(0x000affaa, chip->pch_phub_base_address + 0x14);
 		/* set the interrupt delay value */
 		iowrite32(0x25, chip->pch_phub_base_address + 0x44);
-	} else if (id->driver_data == 2) {
+		chip->pch_opt_rom_start_address = PCH_PHUB_ROM_START_ADDR_EG20T;
+		chip->pch_mac_start_address = PCH_PHUB_MAC_START_ADDR_EG20T;
+	} else if (id->driver_data == 2) { /* ML7213 IOH */
 		retval = sysfs_create_bin_file(&pdev->dev.kobj, &pch_bin_attr);
 		if (retval)
 			goto err_sysfs_create;
@@ -653,7 +725,38 @@ static int __devinit pch_phub_probe(struct pci_dev *pdev,
 		 * Device8(USB OHCI #0/ USB EHCI #0):a
 		 */
 		iowrite32(0x000affa0, chip->pch_phub_base_address + 0x14);
+		chip->pch_opt_rom_start_address =\
+						 PCH_PHUB_ROM_START_ADDR_ML7213;
+	} else if (id->driver_data == 3) { /* ML7223 IOH Bus-m*/
+		/* set the prefech value
+		 * Device8(GbE)
+		 */
+		iowrite32(0x000a0000, chip->pch_phub_base_address + 0x14);
+		chip->pch_opt_rom_start_address =\
+						 PCH_PHUB_ROM_START_ADDR_ML7223;
+		chip->pch_mac_start_address = PCH_PHUB_MAC_START_ADDR_ML7223;
+	} else if (id->driver_data == 4) { /* ML7223 IOH Bus-n*/
+		retval = sysfs_create_file(&pdev->dev.kobj,
+					   &dev_attr_pch_mac.attr);
+		if (retval)
+			goto err_sysfs_create;
+		retval = sysfs_create_bin_file(&pdev->dev.kobj, &pch_bin_attr);
+		if (retval)
+			goto exit_bin_attr;
+		/* set the prefech value
+		 * Device2(USB OHCI #0,1,2,3/ USB EHCI #0):a
+		 * Device4(SDIO #0,1):f
+		 * Device6(SATA 2):f
+		 */
+		iowrite32(0x0000ffa0, chip->pch_phub_base_address + 0x14);
+		/* set the interrupt delay value */
+		iowrite32(0x25, chip->pch_phub_base_address + 0x140);
+		chip->pch_opt_rom_start_address =\
+						 PCH_PHUB_ROM_START_ADDR_ML7223;
+		chip->pch_mac_start_address = PCH_PHUB_MAC_START_ADDR_ML7223;
 	}
+
+	chip->ioh_type = id->driver_data;
 	pci_set_drvdata(pdev, chip);
 
 	return 0;
@@ -733,6 +836,8 @@ static int pch_phub_resume(struct pci_dev *pdev)
 static struct pci_device_id pch_phub_pcidev_id[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PCH1_PHUB),       1,  },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ROHM_ML7213_PHUB), 2,  },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ROHM_ML7223_mPHUB), 3,  },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ROHM_ML7223_nPHUB), 4,  },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pch_phub_pcidev_id);
@@ -759,5 +864,5 @@ static void __exit pch_phub_pci_exit(void)
 module_init(pch_phub_pci_init);
 module_exit(pch_phub_pci_exit);
 
-MODULE_DESCRIPTION("PCH Packet Hub PCI Driver");
+MODULE_DESCRIPTION("Intel EG20T PCH/OKI SEMICONDUCTOR IOH(ML7213/ML7223) PHUB");
 MODULE_LICENSE("GPL");
-- 
1.7.4.2

