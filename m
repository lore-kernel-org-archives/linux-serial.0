From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH v3 3/6] serial: imx: Simplify DMA disablement
Date: Thu, 21 Sep 2017 17:18:14 +0100
Message-ID: <1506010697-22114-4-git-send-email-martyn.welch@collabora.co.uk>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

This commits simplify the function imx_disable_dma() by moving
the code for disabling RX and TX DMAs to dedicated functions.
This is a preparation for the next commit.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7835279..2fb3210 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -350,6 +350,24 @@ static void imx_port_rts_auto(struct imx_port *sport, unsigned long *ucr2)
 	*ucr2 |= UCR2_CTSC;
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
 /*
  * interrupts disabled on entry
  */
@@ -1217,13 +1235,8 @@ static void imx_enable_dma(struct imx_port *sport)
 
 static void imx_disable_dma(struct imx_port *sport)
 {
-	unsigned long temp;
-
-	/* clear UCR1 */
-	temp = readl(sport->port.membase + UCR1);
-	temp &= ~(UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN);
-	writel(temp, sport->port.membase + UCR1);
-
+	imx_stop_rx_dma(sport);
+	imx_stop_tx_dma(sport);
 	imx_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
 	sport->dma_is_enabled = 0;
-- 
1.8.3.1
