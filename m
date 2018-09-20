From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1] tty: serial: imx: enable IDDMAEN for the last tail data
Date: Thu, 20 Sep 2018 23:26:00 +0800
Message-ID: <1537457160-10792-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jslaby@suse.com, fugang.duan@nxp.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

enable IDDMAEN in UCR4 to let sdma script has the chance to detect
the idle status and transfer the last tail data with the interrupt
notifying uart driver.Otherwise, the last dma done interrupt of the
tail data in rxfifo whose size is less than watermark may never be
received by uart driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/tty/serial/imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 239c0fa..bbb1693 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1278,7 +1278,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 
 static void imx_uart_enable_dma(struct imx_port *sport)
 {
-	u32 ucr1;
+	u32 ucr1, ucr4;
 
 	imx_uart_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
 
@@ -1287,18 +1287,26 @@ static void imx_uart_enable_dma(struct imx_port *sport)
 	ucr1 |= UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN;
 	imx_uart_writel(sport, ucr1, UCR1);
 
+	ucr4 = imx_uart_readl(sport, UCR4);
+	ucr4 |= UCR4_IDDMAEN;
+	imx_uart_writel(sport, ucr4, UCR4);
+
 	sport->dma_is_enabled = 1;
 }
 
 static void imx_uart_disable_dma(struct imx_port *sport)
 {
-	u32 ucr1;
+	u32 ucr1, ucr4;
 
 	/* clear UCR1 */
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
+	ucr4 = imx_uart_readl(sport, UCR4);
+	ucr4 &= ~UCR4_IDDMAEN;
+	imx_uart_writel(sport, ucr4, UCR4);
+
 	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
 	sport->dma_is_enabled = 0;
-- 
2.7.4
