From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Subject: [Patch 4/6]drivers/usb/serial/ftdi_sio.c: Fill LSR fields of the ftdi async_icount structure
Date: Mon, 10 Oct 2011 17:24:34 +0200
Message-ID: <20115.3634.92143.735478@elektron.ikp.physik.tu-darmstadt.de>
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
>From 5b1a292d464a8d5ee116bab4ac160421c9a2629c Mon Sep 17 00:00:00 2001
From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Date: Mon, 10 Oct 2011 16:27:47 +0200
Subject: Fill LSR fields of the ftdi async_icount structure


Signed-off-by: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
---
 drivers/usb/serial/ftdi_sio.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index e639933..3f0011c 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1950,6 +1950,14 @@ static int ftdi_process_packet(struct tty_struct *tty,
 	   N.B. packet may be processed more than once, but differences
 	   are only processed once.  */
 	status = packet[0] & FTDI_STATUS_B0_MASK;
+	if (status & FTDI_RS0_CTS)
+		priv->icount.cts++;
+	if (status & FTDI_RS0_DSR)
+		priv->icount.dsr++;
+	if (status & FTDI_RS0_RI)
+		priv->icount.rng++;
+	if (status & FTDI_RS0_RLSD)
+		priv->icount.dcd++;
 	if (status != priv->prev_status) {
 		priv->diff_status |= status ^ priv->prev_status;
 		wake_up_interruptible(&priv->delta_msr_wait);
-- 
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
