From: Colin Leitner <colin.leitner-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH] USB: pl2303: fixed handling of CS5 setting
Date: Mon, 04 Nov 2013 19:40:43 +0100
Message-ID: <5277EA2B.1020806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This patch fixes the CS5 setting on the PL2303 USB-to-serial devices. CS5 has a
value of 0 and the CSIZE setting has been skipped altogether by the enclosing
if. Tested on 3.11.6 and the scope shows the correct output after the fix has
been applied.

Tagged to be added to stable, because it fixes a user visible driver bug and is
simple enough to backport easily.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Colin Leitner <colin.leitner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/serial/pl2303.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 1e6de4c..1e3318d 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -361,23 +361,21 @@ static void pl2303_set_termios(struct tty_struct *tty,
 			    0, 0, buf, 7, 100);
 	dev_dbg(&port->dev, "0xa1:0x21:0:0  %d - %7ph\n", i, buf);

-	if (C_CSIZE(tty)) {
-		switch (C_CSIZE(tty)) {
-		case CS5:
-			buf[6] = 5;
-			break;
-		case CS6:
-			buf[6] = 6;
-			break;
-		case CS7:
-			buf[6] = 7;
-			break;
-		default:
-		case CS8:
-			buf[6] = 8;
-		}
-		dev_dbg(&port->dev, "data bits = %d\n", buf[6]);
+	switch (C_CSIZE(tty)) {
+	case CS5:
+		buf[6] = 5;
+		break;
+	case CS6:
+		buf[6] = 6;
+		break;
+	case CS7:
+		buf[6] = 7;
+		break;
+	default:
+	case CS8:
+		buf[6] = 8;
 	}
+	dev_dbg(&port->dev, "data bits = %d\n", buf[6]);

 	/* For reference buf[0]:buf[3] baud rate value */
 	pl2303_encode_baudrate(tty, port, &buf[0]);
-- 
1.7.10.4
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
