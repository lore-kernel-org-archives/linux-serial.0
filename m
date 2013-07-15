From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts is enabled
Date: Mon, 15 Jul 2013 11:08:55 +0800
Message-ID: <1373857736-30108-2-git-send-email-b32955@freescale.com>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:34468 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753912Ab3GODi4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Jul 2013 23:38:56 -0400
In-Reply-To: <1373857736-30108-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

The originall DMA support works only when the rts/cts is enabled.
But after several patchs, the DMA support has lost this limit.

This patch adds an optional property for the uart DT node
which indicates the uart has rts and cts.

This patch also adds the check for rts/cts before we enable the DMA
for the uart.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../bindings/tty/serial/fsl-mxs-auart.txt          |    3 +++
 drivers/tty/serial/mxs-auart.c                     |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
index 2c00ec6..ef82002 100644
--- a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
@@ -10,6 +10,9 @@ Required properties:
   Refer to dma.txt and fsl-mxs-dma.txt for details.
 - dma-names: "rx" for RX channel, "tx" for TX channel.
 
+Optional properties:
+- fsl,uart-has-rtscts : Indicate the uart has rts and cts
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


