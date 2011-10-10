From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Subject: [Patch 6/6]drivers/usb/serial/ftdi_sio.c: Use ftdi async_icount structure for TIOCMIWAIT, as in other drivers
Date: Mon, 10 Oct 2011 17:24:51 +0200
Message-ID: <20115.3651.485093.501609@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


-- 
Uwe Bonnes                bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
>From c36f80fcade7eb4614aa39f738c3aaaac9fdde0f Mon Sep 17 00:00:00 2001
From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Date: Mon, 10 Oct 2011 16:36:00 +0200
Subject: Use ftdi async_icount structure for TIOCMIWAIT, as in other drivers


Signed-off-by: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
---
 drivers/usb/serial/ftdi_sio.c |   41 ++++++++++++++++-------------------------
 1 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 5515661..748a8d6 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2324,6 +2324,8 @@ static int ftdi_ioctl(struct tty_struct *tty,
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct async_icount cnow;
+	struct async_icount cprev;
 
 	dbg("%s cmd 0x%04x", __func__, cmd);
 
@@ -2343,41 +2345,30 @@ static int ftdi_ioctl(struct tty_struct *tty,
 	 * - mask passed in arg for lines of interest
 	 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
 	 * Caller should use TIOCGICOUNT to see which one it was.
-	 * (except that the driver doesn't support it !)
 	 *
 	 * This code is borrowed from linux/drivers/char/serial.c
 	 */
 	case TIOCMIWAIT:
-		while (priv != NULL) {
+		cprev = priv->icount;
+		while (1) {
 			interruptible_sleep_on(&priv->delta_msr_wait);
 			/* see if a signal did it */
 			if (signal_pending(current))
 				return -ERESTARTSYS;
-			else {
-				char diff = priv->diff_status;
-
-				if (diff == 0)
-					return -EIO; /* no change => error */
-
-				/* Consume all events */
-				priv->diff_status = 0;
-
-				/* Return 0 if caller wanted to know about
-				   these bits */
-				if (((arg & TIOCM_RNG) && (diff & FTDI_RS0_RI)) ||
-				    ((arg & TIOCM_DSR) && (diff & FTDI_RS0_DSR)) ||
-				    ((arg & TIOCM_CD)  && (diff & FTDI_RS0_RLSD)) ||
-				    ((arg & TIOCM_CTS) && (diff & FTDI_RS0_CTS))) {
-					return 0;
-				}
-				/*
-				 * Otherwise caller can't care less about what
-				 * happened,and so we continue to wait for more
-				 * events.
-				 */
+			cnow = priv->icount;
+			if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
+			    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts)
+				return -EIO; /* no change => error */
+			if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
+			    ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
+			    ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
+			    ((arg & TIOCM_CTS) && (cnow.cts != cprev.cts))) {
+				return 0;
 			}
+			cprev = cnow;
 		}
-		return 0;
+		/* not reached */
+		break;
 	case TIOCSERGETLSR:
 		return get_lsr_info(port, (struct serial_struct __user *)arg);
 		break;
-- 
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
