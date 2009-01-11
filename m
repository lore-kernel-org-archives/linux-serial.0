From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4/6] ti_usb_3410_5052: support alternate firmware
Date: Sun, 11 Jan 2009 19:48:53 +0000
Message-ID: <20090111194846.16074.99569.stgit@localhost.localdomain>
References: <20090111194656.16074.14975.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41725 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752147AbZAKTtG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Jan 2009 14:49:06 -0500
In-Reply-To: <20090111194656.16074.14975.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Chris Adams <cmadams@hiwaay.net>

The TI USB serial driver supports specifying alternate vendor and
product IDs (since the chips can and are used in devices under other
vendor/product IDs).  However, the alternate IDs were not loaded in the
combined product table.  This patch also adds support for loading
alternate firmware for alternate vendor/product IDs.

Signed-off-by: Chris Adams <cmadams@hiwaay.net>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/ti_usb_3410_5052.c |   44 ++++++++++++++++++++++-----------
 1 files changed, 29 insertions(+), 15 deletions(-)


diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 01d0c70..1cdb151 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -145,7 +145,7 @@ static int ti_command_in_sync(struct ti_device *tdev, __u8 command,
 static int ti_write_byte(struct ti_device *tdev, unsigned long addr,
 	__u8 mask, __u8 byte);
 
-static int ti_download_firmware(struct ti_device *tdev, int type);
+static int ti_download_firmware(struct ti_device *tdev);
 
 /* circular buffer */
 static struct circ_buf *ti_buf_alloc(void);
@@ -176,7 +176,7 @@ static unsigned int product_5052_count;
 /* the array dimension is the number of default entries plus */
 /* TI_EXTRA_VID_PID_COUNT user defined entries plus 1 terminating */
 /* null entry */
-static struct usb_device_id ti_id_table_3410[1+TI_EXTRA_VID_PID_COUNT+1] = {
+static struct usb_device_id ti_id_table_3410[2+TI_EXTRA_VID_PID_COUNT+1] = {
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_PRODUCT_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_EZ430_ID) },
 };
@@ -188,7 +188,7 @@ static struct usb_device_id ti_id_table_5052[4+TI_EXTRA_VID_PID_COUNT+1] = {
 	{ USB_DEVICE(TI_VENDOR_ID, TI_5052_FIRMWARE_PRODUCT_ID) },
 };
 
-static struct usb_device_id ti_id_table_combined[] = {
+static struct usb_device_id ti_id_table_combined[6+2*TI_EXTRA_VID_PID_COUNT+1] = {
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_PRODUCT_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_EZ430_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_5052_BOOT_PRODUCT_ID) },
@@ -304,21 +304,28 @@ MODULE_DEVICE_TABLE(usb, ti_id_table_combined);
 
 static int __init ti_init(void)
 {
-	int i, j;
+	int i, j, c;
 	int ret;
 
 	/* insert extra vendor and product ids */
+	c = ARRAY_SIZE(ti_id_table_combined) - 2 * TI_EXTRA_VID_PID_COUNT - 1;
 	j = ARRAY_SIZE(ti_id_table_3410) - TI_EXTRA_VID_PID_COUNT - 1;
-	for (i = 0; i < min(vendor_3410_count, product_3410_count); i++, j++) {
+	for (i = 0; i < min(vendor_3410_count, product_3410_count); i++, j++, c++) {
 		ti_id_table_3410[j].idVendor = vendor_3410[i];
 		ti_id_table_3410[j].idProduct = product_3410[i];
 		ti_id_table_3410[j].match_flags = USB_DEVICE_ID_MATCH_DEVICE;
+		ti_id_table_combined[c].idVendor = vendor_3410[i];
+		ti_id_table_combined[c].idProduct = product_3410[i];
+		ti_id_table_combined[c].match_flags = USB_DEVICE_ID_MATCH_DEVICE;
 	}
 	j = ARRAY_SIZE(ti_id_table_5052) - TI_EXTRA_VID_PID_COUNT - 1;
-	for (i = 0; i < min(vendor_5052_count, product_5052_count); i++, j++) {
+	for (i = 0; i < min(vendor_5052_count, product_5052_count); i++, j++, c++) {
 		ti_id_table_5052[j].idVendor = vendor_5052[i];
 		ti_id_table_5052[j].idProduct = product_5052[i];
 		ti_id_table_5052[j].match_flags = USB_DEVICE_ID_MATCH_DEVICE;
+		ti_id_table_combined[c].idVendor = vendor_5052[i];
+		ti_id_table_combined[c].idProduct = product_5052[i];
+		ti_id_table_combined[c].match_flags = USB_DEVICE_ID_MATCH_DEVICE;
 	}
 
 	ret = usb_serial_register(&ti_1port_device);
@@ -390,11 +397,7 @@ static int ti_startup(struct usb_serial *serial)
 
 	/* if we have only 1 configuration, download firmware */
 	if (dev->descriptor.bNumConfigurations == 1) {
-		if (tdev->td_is_3410)
-			status = ti_download_firmware(tdev, 3410);
-		else
-			status = ti_download_firmware(tdev, 5052);
-		if (status)
+		if ((status = ti_download_firmware(tdev)) != 0)
 			goto free_tdev;
 
 		/* 3410 must be reset, 5052 resets itself */
@@ -1671,9 +1674,9 @@ static int ti_do_download(struct usb_device *dev, int pipe,
 	return status;
 }
 
-static int ti_download_firmware(struct ti_device *tdev, int type)
+static int ti_download_firmware(struct ti_device *tdev)
 {
-	int status = -ENOMEM;
+	int status;
 	int buffer_size;
 	__u8 *buffer;
 	struct usb_device *dev = tdev->td_serial->dev;
@@ -1681,9 +1684,18 @@ static int ti_download_firmware(struct ti_device *tdev, int type)
 		tdev->td_serial->port[0]->bulk_out_endpointAddress);
 	const struct firmware *fw_p;
 	char buf[32];
-	sprintf(buf, "ti_usb-%d.bin", type);
 
-	if (request_firmware(&fw_p, buf, &dev->dev)) {
+	/* try ID specific firmware first, then try generic firmware */
+	sprintf(buf, "ti_usb-v%04x-p%04x.fw", dev->descriptor.idVendor,
+	    dev->descriptor.idProduct);
+	if ((status = request_firmware(&fw_p, buf, &dev->dev)) != 0) {
+		if (tdev->td_is_3410)
+			strcpy(buf, "ti_3410.fw");
+		else
+			strcpy(buf, "ti_5052.fw");
+		status = request_firmware(&fw_p, buf, &dev->dev);
+	}
+	if (status) {
 		dev_err(&dev->dev, "%s - firmware not found\n", __func__);
 		return -ENOENT;
 	}
@@ -1699,6 +1711,8 @@ static int ti_download_firmware(struct ti_device *tdev, int type)
 		memset(buffer + fw_p->size, 0xff, buffer_size - fw_p->size);
 		status = ti_do_download(dev, pipe, buffer, fw_p->size);
 		kfree(buffer);
+	} else {
+		status = -ENOMEM;
 	}
 	release_firmware(fw_p);
 	if (status) {

