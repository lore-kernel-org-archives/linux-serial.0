From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 1/2] serial: imx: cleanup imx_uart_disable_dma()
Date: Mon,  7 May 2018 23:36:09 +0200
Message-ID: <20180507213610.17330-2-sebastian.reichel@collabora.co.uk>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

Remove unrelated CTSC/CTS disabling from imx_uart_disable_dma() and
move it to imx_uart_shutdown(), which is the only user of the DMA
disabling function. This should not change the driver's behaviour,
but improves readability. After this change imx_uart_disable_dma()
does the reverse thing of imx_uart_enable_dma().

Suggested-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c2fc6bef7a6f..3ca767b1162a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1291,18 +1291,13 @@ static void imx_uart_enable_dma(struct imx_port *sport)
 
 static void imx_uart_disable_dma(struct imx_port *sport)
 {
-	u32 ucr1, ucr2;
+	u32 ucr1;
 
 	/* clear UCR1 */
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
-	/* clear UCR2 */
-	ucr2 = imx_uart_readl(sport, UCR2);
-	ucr2 &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
-	imx_uart_writel(sport, ucr2, UCR2);
-
 	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
 	sport->dma_is_enabled = 0;
@@ -1447,7 +1442,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	ucr2 = imx_uart_readl(sport, UCR2);
-	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
+	ucr2 &= ~(UCR2_TXEN | UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
 	imx_uart_writel(sport, ucr2, UCR2);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-- 
2.17.0
