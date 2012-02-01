From: Thomas Tuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/4] qcserial: remove unused "debug" parameter
Date: Wed, 1 Feb 2012 16:07:35 -0500
Message-ID: <20120201210735.GC16802@google.com>
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
 drivers/usb/serial/qcserial.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 5a817d6..0f549c6 100644
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
@@ -298,6 +296,3 @@ module_exit(qcexit);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL v2");
