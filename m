From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 08/47] serial: sh-sci: Don't check IRQ in verify port operation
Date: Fri,  6 Dec 2013 10:59:15 +0100
Message-ID: <1386323994-12850-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

The IRQ number can't be modified by the user as the port is fixed.
There's no need to check the new IRQ number as it will be ignored by the
core.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b5dd0ad..40ced29 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2117,10 +2117,6 @@ static void sci_config_port(struct uart_port *port, int flags)
 
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
1.8.3.2

