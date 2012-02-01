From: Thomas Tuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/4] qcserial: log when an interface has too many
 altsettings
Date: Wed, 1 Feb 2012 16:07:23 -0500
Message-ID: <20120201210723.GB16802@google.com>
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
 drivers/usb/serial/qcserial.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 26e3e30..5a817d6 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -145,8 +145,12 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
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
-- 
1.7.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
