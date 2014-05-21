From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 2/2 v2] serial: imx: remove the redundant code
Date: Wed, 21 May 2014 09:09:47 +0800
Message-ID: <1400634587-513-1-git-send-email-b32955@freescale.com>
References: <1400633789-31979-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1lp0141.outbound.protection.outlook.com ([207.46.163.141]:43537
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751417AbaEUC2R (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 May 2014 22:28:17 -0400
In-Reply-To: <1400633789-31979-2-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Huang Shijie <b32955@freescale.com>

In the imx_startup(), we will reset the uart port which will reset all
the FIFOs, including the URXD.

So the code to clear the RX FIFO is redundant. Just remove it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
fix the typo.
---
 drivers/tty/serial/imx.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 64901d0..febf400 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1161,15 +1161,6 @@ static int imx_startup(struct uart_port *port)
 		temp |= UCR2_IRTS;
 	writel(temp, sport->port.membase + UCR2);
 
-	if (USE_IRDA(sport)) {
-		/* clear RX-FIFO */
-		int i = 64;
-		while ((--i > 0) &&
-			(readl(sport->port.membase + URXD0) & URXD_CHARRDY)) {
-			barrier();
-		}
-	}
-
 	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
 		temp |= IMX21_UCR3_RXDMUXSEL;
-- 
1.7.8

