From: Fugang Duan <b38611@freescale.com>
Subject: [PATCH] serial: imx: fix throttle/unthrottle callbacks for hardware assisted flow control
Date: Fri, 19 Sep 2014 15:26:40 +0800
Message-ID: <1411111600-24752-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1bon0132.outbound.protection.outlook.com ([157.56.111.132]:37792
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750815AbaISIIG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 04:08:06 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, b38611@freescale.com, shijie8@gmail.com

From: Fugang Duan <B38611@freescale.com>

>From datasheet, UCR2[CTS] bit controls the 'CTS' bit and takes effort only
when the 'CTSC' bit is negated. 'CTS' has no function when 'CTSC' is asserted.
0: The CTS pin is high (inactive)
1: The CTS pin is low (active)

For throttle, it needs to clear 'CTS' and 'CTSC' bits.
For unthrottle, it needs to enable 'CTS' and 'CTSC' bits.

The patch just fix the issue.

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/tty/serial/imx.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 044e86d..070a37e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -823,11 +823,9 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	temp = readl(sport->port.membase + UCR2) & ~UCR2_CTS;
-
+	temp = readl(sport->port.membase + UCR2) & ~(UCR2_CTS | UCR2_CTSC);
 	if (mctrl & TIOCM_RTS)
-		if (!sport->dma_is_enabled)
-			temp |= UCR2_CTS;
+		temp |= UCR2_CTS | UCR2_CTSC;
 
 	writel(temp, sport->port.membase + UCR2);
 
-- 
1.7.8

