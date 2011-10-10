From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Subject: [Patch 2/6]drivers/usb/serial/ftdi_sio.c: Fill the RX field of the ftdi async_icount structure
Date: Mon, 10 Oct 2011 17:24:16 +0200
Message-ID: <20115.3616.163280.510715@elektron.ikp.physik.tu-darmstadt.de>
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
>From baf6337e71922799e65db9bc4fe1815e2d1611ef Mon Sep 17 00:00:00 2001
From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Date: Mon, 10 Oct 2011 16:43:08 +0200
Subject: Fill the RX field of the ftdi async_icount structure


Signed-off-by: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
---
 drivers/usb/serial/ftdi_sio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index c2b4d13..556e820 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1980,6 +1980,7 @@ static int ftdi_process_packet(struct tty_struct *tty,
 	len -= 2;
 	if (!len)
 		return 0;	/* status only */
+	priv->icount.rx += len;
 	ch = packet + 2;
 
 	if (port->port.console && port->sysrq) {
-- 
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
