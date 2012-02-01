From: Thomas Tuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/4] qcserial: add several new serial devices
Date: Wed, 1 Feb 2012 16:07:17 -0500
Message-ID: <20120201210717.GA16802@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Thomas Tuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/usb/serial/qcserial.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 1d5deee..26e3e30 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -36,6 +36,11 @@ static const struct usb_device_id id_table[] = {
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
@@ -86,7 +91,16 @@ static const struct usb_device_id id_table[] = {
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
-- 
1.7.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
