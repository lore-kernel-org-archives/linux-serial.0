From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] usb/serial: Remove unnecessary check for console
Date: Sat, 23 Feb 2013 10:11:35 -0500
Message-ID: <1361632295-5863-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The tty port ops shutdown() routine is not called for console ports;
remove extra check.

Signed-off-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
---
 drivers/usb/serial/usb-serial.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index a19ed74..8424478 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -256,22 +256,18 @@ static int serial_open(struct tty_struct *tty, struct file *filp)
  * serial_down - shut down hardware
  * @tport: tty port to shut down
  *
- * Shut down a USB serial port unless it is the console.  We never
- * shut down the console hardware as it will always be in use. Serialized
- * against activate by the tport mutex and kept to matching open/close pairs
+ * Shut down a USB serial port. Serialized against activate by the
+ * tport mutex and kept to matching open/close pairs
  * of calls by the ASYNCB_INITIALIZED flag.
+ *
+ * Not called if tty is console.
  */
 static void serial_down(struct tty_port *tport)
 {
 	struct usb_serial_port *port =
 		container_of(tport, struct usb_serial_port, port);
 	struct usb_serial_driver *drv = port->serial->type;
-	/*
-	 * The console is magical.  Do not hang up the console hardware
-	 * or there will be tears.
-	 */
-	if (port->port.console)
-		return;
+
 	if (drv->close)
 		drv->close(port);
 }
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
