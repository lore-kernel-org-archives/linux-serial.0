From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 04/29] serial: sh-sci: Remove duplicate interrupt check in verify port op
Date: Thu, 28 Nov 2013 00:18:14 +0100
Message-ID: <1385594319-5758-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

The driver checks if the interrupt number is greater than nr_irqs and
returns an error in that case. The same check is already performed by
the caller, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index feb1a6a..d1d779f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2115,7 +2115,7 @@ static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	struct sci_port *s = to_sci_port(port);
 
-	if (ser->irq != s->cfg->irqs[SCIx_TXI_IRQ] || ser->irq > nr_irqs)
+	if (ser->irq != s->cfg->irqs[SCIx_TXI_IRQ])
 		return -EINVAL;
 	if (ser->baud_base < 2400)
 		/* No paper tape reader for Mitch.. */
-- 
1.8.3.2

