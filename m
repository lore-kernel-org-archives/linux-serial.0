From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Subject: [Patch 5/6]drivers/usb/serial/ftdi_sio.c:Fill MSR fields of the ftdi async_icount structure
Date: Mon, 10 Oct 2011 17:24:46 +0200
Message-ID: <20115.3646.313018.987679@elektron.ikp.physik.tu-darmstadt.de>
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
>From 5d98873e11e291b51550d4d5f0094784a2fdd212 Mon Sep 17 00:00:00 2001
From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Date: Mon, 10 Oct 2011 17:08:11 +0200
Subject: Fill MSR fields of the ftdi async_icount structure


Signed-off-by: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
---
 drivers/usb/serial/ftdi_sio.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 3f0011c..5515661 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1970,15 +1970,20 @@ static int ftdi_process_packet(struct tty_struct *tty,
 		 * over framing errors */
 		if (packet[1] & FTDI_RS_BI) {
 			flag = TTY_BREAK;
+			priv->icount.brk++;
 			usb_serial_handle_break(port);
 		} else if (packet[1] & FTDI_RS_PE) {
 			flag = TTY_PARITY;
+			priv->icount.parity++;
 		} else if (packet[1] & FTDI_RS_FE) {
 			flag = TTY_FRAME;
+			priv->icount.frame++;
 		}
 		/* Overrun is special, not associated with a char */
-		if (packet[1] & FTDI_RS_OE)
+		if (packet[1] & FTDI_RS_OE) {
+			priv->icount.overrun++;
 			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+		}
 	}
 
 	/* save if the transmitter is empty or not */
-- 
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
