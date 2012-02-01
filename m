From: ttuttle <ttuttle@chromium.org>
Subject: [PATCH] qcserial: several fixes
Date: Wed, 1 Feb 2012 15:39:50 -0500
Message-ID: <20120201203950.GA14586@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:56854 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab2BAUjy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Feb 2012 15:39:54 -0500
Received: by yhgm50 with SMTP id m50so184637yhg.1
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2012 12:39:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

1. Remove the unused "debug" parameter.
2. Add several new serial devices.
3. Disable autosuspend, as it has been flaky.
4. Log if we find too many altsettings.

Signed-off-by: ttuttle <ttuttle@chromium.org>
---
 drivers/usb/serial/qcserial.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 1d5deee..be9050f 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -22,8 +22,6 @@
 #define DRIVER_AUTHOR "Qualcomm Inc"
 #define DRIVER_DESC "Qualcomm USB Serial driver"
 
-static bool debug;
-
 static const struct usb_device_id id_table[] = {
 	{USB_DEVICE(0x05c6, 0x9211)},	/* Acer Gobi QDL device */
 	{USB_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
@@ -36,6 +34,11 @@ static const struct usb_device_id id_table[] = {
 	{USB_DEVICE(0x413c, 0x8171)},	/* Dell Gobi QDL device */
 	{USB_DEVICE(0x1410, 0xa001)},	/* Novatel Gobi Modem device */
 	{USB_DEVICE(0x1410, 0xa008)},	/* Novatel Gobi QDL device */
+	{USB_DEVICE(0x1410, 0xa010)},	/* Novatel Gobi QDL device */
+	{USB_DEVICE(0x1410, 0xa011)},	/* Novatel Gobi QDL device */
+	{USB_DEVICE(0x1410, 0xa012)},	/* Novatel Gobi QDL device */
+	{USB_DEVICE(0x1410, 0xa013)},	/* Novatel Gobi QDL device */
+	{USB_DEVICE(0x1410, 0xa014)},	/* Novatel Gobi QDL device */
 	{USB_DEVICE(0x0b05, 0x1776)},	/* Asus Gobi Modem device */
 	{USB_DEVICE(0x0b05, 0x1774)},	/* Asus Gobi QDL device */
 	{USB_DEVICE(0x19d2, 0xfff3)},	/* ONDA Gobi Modem device */
@@ -86,7 +89,16 @@ static const struct usb_device_id id_table[] = {
 	{USB_DEVICE(0x16d8, 0x8002)},	/* CMDTech Gobi 2000 Modem device (VU922) */
 	{USB_DEVICE(0x05c6, 0x9204)},	/* Gobi 2000 QDL device */
 	{USB_DEVICE(0x05c6, 0x9205)},	/* Gobi 2000 Modem device */
+
+	{USB_DEVICE(0x05c6, 0x920c)},	/* Gobi 3000 QDL */
+	{USB_DEVICE(0x05c6, 0x920d)},	/* Gobi 3000 Composite */
+	{USB_DEVICE(0x1410, 0xa020)},   /* Novatel Gobi 3000 QDL */
+	{USB_DEVICE(0x1410, 0xa021)},	/* Novatel Gobi 3000 Composite */
+	{USB_DEVICE(0x413c, 0x8193)},	/* Dell Gobi 3000 QDL */
+	{USB_DEVICE(0x413c, 0x8194)},	/* Dell Gobi 3000 Composite */
 	{USB_DEVICE(0x1199, 0x9013)},	/* Sierra Wireless Gobi 3000 Modem device (MC8355) */
+	{USB_DEVICE(0x12D1, 0x14F0)},	/* Sony Gobi 3000 QDL */
+	{USB_DEVICE(0x12D1, 0x14F1)},	/* Sony Gobi 3000 Composite */
 	{ }				/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);
@@ -123,16 +135,18 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 
 	spin_lock_init(&data->susp_lock);
 
-	usb_enable_autosuspend(serial->dev);
-
 	switch (nintf) {
 	case 1:
 		/* QDL mode */
 		/* Gobi 2000 has a single altsetting, older ones have two */
 		if (serial->interface->num_altsetting == 2)
 			intf = &serial->interface->altsetting[1];
-		else if (serial->interface->num_altsetting > 2)
+		else if (serial->interface->num_altsetting > 2) {
+			dev_err(&serial->dev->dev,
+				"too many altsettings: %u",
+				serial->interface->num_altsetting);
 			break;
+		}
 
 		if (intf->desc.bNumEndpoints == 2 &&
 		    usb_endpoint_is_bulk_in(&intf->endpoint[0].desc) &&
@@ -280,6 +294,3 @@ module_exit(qcexit);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL v2");
-
-module_param(debug, bool, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(debug, "Debug enabled or not");
-- 
1.7.7.3

