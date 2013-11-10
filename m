From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 06/29] serial: sh-sci: Don't check IRQ in verify port operation
Date: Sun, 10 Nov 2013 04:33:18 +0100
Message-ID: <1384054421-13357-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

The IRQ number can't be modified by the user as the port is fixed.
There's no need to check the new IRQ number as it will be ignored by the
core.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 47b0ee6..b0c9d24 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2113,10 +2113,6 @@ static void sci_config_port(struct uart_port *port, int flags)
 
 static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	struct sci_port *s = to_sci_port(port);
-
-	if (ser->irq != s->cfg->irqs[SCIx_TXI_IRQ])
-		return -EINVAL;
 	if (ser->baud_base < 2400)
 		/* No paper tape reader for Mitch.. */
 		return -EINVAL;
-- 
1.8.1.5

