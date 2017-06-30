From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 4/7] serial: imx: Simplify DMA disablement
Date: Fri, 30 Jun 2017 14:04:43 +0200
Message-ID: <20170630120446.13994-5-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170630120446.13994-1-romain.perier@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Romain Perier <romain.perier@collabora.com>, Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

This commits simplify the function imx_disable_dma() by moving
the code for disabling RX and TX DMAs to dedicated functions.
Also move away CTSC and CTS as this is not related to DMA.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 81fb413..e8cf7cf 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1208,6 +1208,24 @@ static int imx_uart_dma_init(struct imx_port *sport)
 	return ret;
 }
 
+static void imx_stop_tx_dma(struct imx_port *sport)
+{
+	unsigned long temp;
+
+	temp = readl(sport->port.membase + UCR1);
+	temp &= ~UCR1_TDMAEN;
+	writel(temp, sport->port.membase + UCR1);
+}
+
+static void imx_stop_rx_dma(struct imx_port *sport)
+{
+	unsigned long temp;
+
+	temp = readl(sport->port.membase + UCR1);
+	temp &= ~(UCR1_RDMAEN | UCR1_ATDMAEN);
+	writel(temp, sport->port.membase + UCR1);
+}
+
 static void imx_enable_dma(struct imx_port *sport)
 {
 	unsigned long temp;
@@ -1233,17 +1251,8 @@ static void imx_enable_dma(struct imx_port *sport)
 
 static void imx_disable_dma(struct imx_port *sport)
 {
-	unsigned long temp;
-
-	/* clear UCR1 */
-	temp = readl(sport->port.membase + UCR1);
-	temp &= ~(UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN);
-	writel(temp, sport->port.membase + UCR1);
-
-	/* clear UCR2 */
-	temp = readl(sport->port.membase + UCR2);
-	temp &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
-	writel(temp, sport->port.membase + UCR2);
+	imx_stop_rx_dma(sport);
+	imx_stop_tx_dma(sport);
 
 	imx_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
-- 
1.8.3.1
