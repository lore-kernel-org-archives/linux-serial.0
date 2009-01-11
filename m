From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 5/6] ti_usb_3410_5052: add Multi-Tech modem support
Date: Sun, 11 Jan 2009 19:49:00 +0000
Message-ID: <20090111194858.16074.95907.stgit@localhost.localdomain>
References: <20090111194656.16074.14975.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41726 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752529AbZAKTtN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Jan 2009 14:49:13 -0500
In-Reply-To: <20090111194656.16074.14975.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Chris Adams <cmadams@hiwaay.net>

Add Multi-Tech cellular modem support to the ti_usb_3410_5052 driver.

Signed-off-by: Chris Adams <cmadams@hiwaay.net>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/ti_usb_3410_5052.c |   36 ++++++++++++++++++++++++++++-----
 drivers/usb/serial/ti_usb_3410_5052.h |    8 +++++++
 2 files changed, 39 insertions(+), 5 deletions(-)


diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 1cdb151..dbae994 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -176,9 +176,14 @@ static unsigned int product_5052_count;
 /* the array dimension is the number of default entries plus */
 /* TI_EXTRA_VID_PID_COUNT user defined entries plus 1 terminating */
 /* null entry */
-static struct usb_device_id ti_id_table_3410[2+TI_EXTRA_VID_PID_COUNT+1] = {
+static struct usb_device_id ti_id_table_3410[7+TI_EXTRA_VID_PID_COUNT+1] = {
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_PRODUCT_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_EZ430_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_GSM_NO_FW_PRODUCT_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_CDMA_NO_FW_PRODUCT_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_CDMA_PRODUCT_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_GSM_PRODUCT_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_EDGE_PRODUCT_ID) },
 };
 
 static struct usb_device_id ti_id_table_5052[4+TI_EXTRA_VID_PID_COUNT+1] = {
@@ -191,6 +196,11 @@ static struct usb_device_id ti_id_table_5052[4+TI_EXTRA_VID_PID_COUNT+1] = {
 static struct usb_device_id ti_id_table_combined[6+2*TI_EXTRA_VID_PID_COUNT+1] = {
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_PRODUCT_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_EZ430_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_GSM_NO_FW_PRODUCT_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_CDMA_NO_FW_PRODUCT_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_CDMA_PRODUCT_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_GSM_PRODUCT_ID) },
+	{ USB_DEVICE(MTS_VENDOR_ID, MTS_EDGE_PRODUCT_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_5052_BOOT_PRODUCT_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_5152_BOOT_PRODUCT_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_5052_EEPROM_PRODUCT_ID) },
@@ -1689,10 +1699,26 @@ static int ti_download_firmware(struct ti_device *tdev)
 	sprintf(buf, "ti_usb-v%04x-p%04x.fw", dev->descriptor.idVendor,
 	    dev->descriptor.idProduct);
 	if ((status = request_firmware(&fw_p, buf, &dev->dev)) != 0) {
-		if (tdev->td_is_3410)
-			strcpy(buf, "ti_3410.fw");
-		else
-			strcpy(buf, "ti_5052.fw");
+		buf[0] = '\0';
+		if (dev->descriptor.idVendor == MTS_VENDOR_ID) {
+			switch (dev->descriptor.idProduct) {
+			case MTS_CDMA_PRODUCT_ID:
+				strcpy(buf, "mts_cdma.fw");
+				break;
+			case MTS_GSM_PRODUCT_ID:
+				strcpy(buf, "mts_gsm.fw");
+				break;
+			case MTS_EDGE_PRODUCT_ID:
+				strcpy(buf, "mts_edge.fw");
+				break;
+			}
+		}
+		if (buf[0] == '\0') {
+			if (tdev->td_is_3410)
+				strcpy(buf, "ti_3410.fw");
+			else
+				strcpy(buf, "ti_5052.fw");
+		}
 		status = request_firmware(&fw_p, buf, &dev->dev);
 	}
 	if (status) {
diff --git a/drivers/usb/serial/ti_usb_3410_5052.h b/drivers/usb/serial/ti_usb_3410_5052.h
index b5541bf..7e4752f 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.h
+++ b/drivers/usb/serial/ti_usb_3410_5052.h
@@ -34,6 +34,14 @@
 #define TI_5052_EEPROM_PRODUCT_ID	0x505A	/* EEPROM, no firmware */
 #define TI_5052_FIRMWARE_PRODUCT_ID	0x505F	/* firmware is running */
 
+/* Multi-Tech vendor and product ids */
+#define MTS_VENDOR_ID			0x06E0
+#define MTS_GSM_NO_FW_PRODUCT_ID	0xF108
+#define MTS_CDMA_NO_FW_PRODUCT_ID	0xF109
+#define MTS_CDMA_PRODUCT_ID		0xF110
+#define MTS_GSM_PRODUCT_ID		0xF111
+#define MTS_EDGE_PRODUCT_ID		0xF112
+
 /* Commands */
 #define TI_GET_VERSION			0x01
 #define TI_GET_PORT_STATUS		0x02

