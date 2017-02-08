From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH] serial: sh-sci: fix hardware RX trigger level setting
Date: Wed,  8 Feb 2017 18:31:14 +0100
Message-ID: <1486575074-20130-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, gregkh@linuxfoundation.org
Cc: wsa@the-dreams.de, linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

1. Do not set the RX trigger level for software timeout devices on reset;
there is no timeout by default, and data will rot.
2. Do set the RX trigger level for hardware timeout devices when set
via sysfs attribute.

Fixes SCIFA-type serial consoles.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f95a56c..9a47cc4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1076,8 +1076,11 @@ static ssize_t rx_trigger_store(struct device *dev,
 
 	if (kstrtol(buf, 0, &r) == -EINVAL)
 		return -EINVAL;
+
 	sci->rx_trigger = scif_set_rtrg(port, r);
-	scif_set_rtrg(port, 1);
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+		scif_set_rtrg(port, 1);
+
 	return count;
 }
 
@@ -2179,7 +2182,11 @@ static void sci_reset(struct uart_port *port)
 			setup_timer(&s->rx_fifo_timer, rx_fifo_timer_fn,
 				    (unsigned long)s);
 		} else {
-			scif_set_rtrg(port, s->rx_trigger);
+			if (port->type == PORT_SCIFA ||
+			    port->type == PORT_SCIFB)
+				scif_set_rtrg(port, 1);
+			else
+				scif_set_rtrg(port, s->rx_trigger);
 		}
 	}
 }
-- 
2.7.4
