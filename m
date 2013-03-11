From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] serial: imx: Add Rx Fifo overrun error message
Date: Mon, 11 Mar 2013 11:27:08 +0100
Message-ID: <1362997628-20246-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:41458 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753330Ab3CKKhT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Mar 2013 06:37:19 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/tty/serial/imx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 147c9e1..fe72099 100644
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
 
@@ -598,6 +606,12 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	if (sts & USR1_AWAKE)
 		writel(USR1_AWAKE, sport->port.membase + USR1);
 
+	sts2 = readl(sport->port.membase + USR2);
+	if (sts2 & USR2_ORE) {
+		dev_err(sport->port.dev, "Rx FIFO overrun\n");
+		writel(sts2 | USR2_ORE, sport->port.membase + USR2);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
1.8.1.5

