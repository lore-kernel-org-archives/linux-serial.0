From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v2 2/3] serial: mxs: enable the DMA only when the RTS/CTS is valid
Date: Tue, 16 Jul 2013 14:55:31 +0800
Message-ID: <1373957732-16638-3-git-send-email-b32955@freescale.com>
References: <1373957732-16638-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:11713
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913Ab3GPHY7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Jul 2013 03:24:59 -0400
In-Reply-To: <1373957732-16638-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Huang Shijie <b32955@freescale.com>

The original DMA support works only when RTS/CTS is enabled.
But after several patches, DMA support has lost this limit.

This patch adds an optional property for the UART DT node
which indicates the UART has RTS and CTS lines.

This patch also adds a macro MXS_AUART_RTSCTS, and uses it to check
RTS/CTS before we enable the DMA for the UART.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../bindings/tty/serial/fsl-mxs-auart.txt          |    4 ++++
 drivers/tty/serial/mxs-auart.c                     |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
index 2c00ec6..59a40f1 100644
--- a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
@@ -10,6 +10,10 @@ Required properties:
   Refer to dma.txt and fsl-mxs-dma.txt for details.
 - dma-names: "rx" for RX channel, "tx" for TX channel.
 
+Optional properties:
+- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines,
+	it also means you enable the DMA support for this UART.
+
 Example:
 auart0: serial@8006a000 {
 	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 465ef0b..27532fd 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -134,6 +134,7 @@ enum mxs_auart_type {
 struct mxs_auart_port {
 	struct uart_port port;
 
+#define MXS_AUART_RTSCTS	1
 #define MXS_AUART_DMA_ENABLED	0x2
 #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
@@ -639,7 +640,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 		 * we can only implement the DMA support for auart
 		 * in mx28.
 		 */
-		if (is_imx28_auart(s)) {
+		if (is_imx28_auart(s) && (s->flags & MXS_AUART_RTSCTS)) {
 			if (!mxs_auart_dma_init(s))
 				/* enable DMA tranfer */
 				ctrl2 |= AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
@@ -1001,6 +1002,8 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	}
 	s->port.line = ret;
 
+	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
+		s->flags |= MXS_AUART_RTSCTS;
 	return 0;
 }
 
-- 
1.7.1


