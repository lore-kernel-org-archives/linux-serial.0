From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Subject: [Patch 3/6]drivers/usb/serial/ftdi_sio.c:Fill TX field of the ftdi async_icount structure
Date: Mon, 10 Oct 2011 17:24:27 +0200
Message-ID: <20115.3627.241851.661804@elektron.ikp.physik.tu-darmstadt.de>
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
>From a5012f7548c61660bc9cff26355aa56118c0460b Mon Sep 17 00:00:00 2001
From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Date: Mon, 10 Oct 2011 16:24:29 +0200
Subject: Fill TX field of the ftdi async_icount structure


Signed-off-by: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
---
 drivers/usb/serial/ftdi_sio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 556e820..e639933 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1914,6 +1914,7 @@ static int ftdi_prepare_write_buffer(struct usb_serial_port *port,
 			c = kfifo_out(&port->write_fifo, &buffer[i + 1], len);
 			if (!c)
 				break;
+			priv->icount.tx += c;
 			buffer[i] = (c << 2) + 1;
 			count += c + 1;
 		}
@@ -1921,6 +1922,7 @@ static int ftdi_prepare_write_buffer(struct usb_serial_port *port,
 	} else {
 		count = kfifo_out_locked(&port->write_fifo, dest, size,
 								&port->lock);
+		priv->icount.tx += count;
 	}
 
 	return count;
-- 
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
