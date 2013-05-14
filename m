From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2] serial: imx: Add Rx Fifo overrun error message
Date: Tue, 14 May 2013 17:06:07 +0200
Message-ID: <1368543967-4984-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:38444 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757829Ab3ENPGM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 May 2013 11:06:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This patch enables the overrun error (ORE) interrupt and increases the
counter in case of overrun.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v2:
* Added a patch description what this patch actually does
* Added uart_icount overrun counter increase

 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 147c9e1..72bc1db 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -449,6 +449,13 @@ static void imx_start_tx(struct uart_port *port)
 		temp &= ~(UCR1_RRDYEN);
 		writel(temp, sport->port.membase + UCR1);
 	}
+	/* Clear any pending ORE flag before enabling interrupt */
+	temp = readl(sport->port.membase + USR2);
+	writel(temp | USR2_ORE, sport->port.membase + USR2);
+
+	temp = readl(sport->port.membase + UCR4);
+	temp |= UCR4_OREN;
+	writel(temp, sport->port.membase + UCR4);
 
 	temp = readl(sport->port.membase + UCR1);
 	writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
@@ -582,6 +589,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
 	unsigned int sts;
+	unsigned int sts2;
 
 	sts = readl(sport->port.membase + USR1);
 
@@ -598,6 +606,13 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	if (sts & USR1_AWAKE)
 		writel(USR1_AWAKE, sport->port.membase + USR1);
 
+	sts2 = readl(sport->port.membase + USR2);
+	if (sts2 & USR2_ORE) {
+		dev_err(sport->port.dev, "Rx FIFO overrun\n");
+		sport->port.icount.overrun++;
+		writel(sts2 | USR2_ORE, sport->port.membase + USR2);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
1.8.1.5

