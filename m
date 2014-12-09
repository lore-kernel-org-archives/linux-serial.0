From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 13/15] serial: imx: Enable UCR4_OREN in startup interface
Date: Tue, 9 Dec 2014 18:11:34 +0900
Message-ID: <1418116296-12082-14-git-send-email-jiada_wang@mentor.com>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jiada_wang@mentor.com, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

Other than enable Receiver Overrun Interrupt Enable (UCR4_OREN)
in start_tx interface, UCR4_OREN should be enabled before enable
of Receiver.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/tty/serial/imx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f0df233..94ee7c5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -611,13 +611,6 @@ static void imx_start_tx(struct uart_port *port)
 		temp &= ~(UCR1_RRDYEN);
 		writel(temp, sport->port.membase + UCR1);
 	}
-	/* Clear any pending ORE flag before enabling interrupt */
-	temp = readl(sport->port.membase + USR2);
-	writel(temp | USR2_ORE, sport->port.membase + USR2);
-
-	temp = readl(sport->port.membase + UCR4);
-	temp |= UCR4_OREN;
-	writel(temp, sport->port.membase + UCR4);
 
 	if (!sport->dma_is_enabled) {
 		temp = readl(sport->port.membase + UCR1);
@@ -1210,6 +1203,14 @@ static int imx_startup(struct uart_port *port)
 
 	writel(temp, sport->port.membase + UCR1);
 
+	/* Clear any pending ORE flag before enabling interrupt */
+	temp = readl(sport->port.membase + USR2);
+	writel(temp | USR2_ORE, sport->port.membase + USR2);
+
+	temp = readl(sport->port.membase + UCR4);
+	temp |= UCR4_OREN;
+	writel(temp, sport->port.membase + UCR4);
+
 	temp = readl(sport->port.membase + UCR2);
 	temp |= (UCR2_RXEN | UCR2_TXEN);
 	if (!sport->have_rtscts)
-- 
1.9.3
