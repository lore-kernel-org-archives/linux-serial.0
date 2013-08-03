From: Huang Shijie <shijie8@gmail.com>
Subject: [PATCH v3 1/3] serial: mxs: enable the DMA only when the RTS/CTS is valid
Date: Sat,  3 Aug 2013 10:09:14 -0400
Message-ID: <1375538956-15862-2-git-send-email-shijie8@gmail.com>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Huang Shijie <b32955@freescale.com>, stable@vger.kernel.org, Huang Shijie <shijie8@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: Huang Shijie <b32955@freescale.com>

The original DMA support works only when RTS/CTS is enabled.
(see the "e800163 serial: mxs-auart: add the DMA support for mx28")
But after several patches, DMA support has lost this limit.
(see the "bcc20f9 serial: mxs-auart: move to use generic DMA helper")

So an UART without the RTS/CTS lines may also enables the DMA support,
in which case the UART may gets unpredictable results.

This patch adds an optional property for the UART DT node
which indicates the UART has RTS and CTS lines, and it also means you
enable the DMA support for this UART.

This patch also adds a macro MXS_AUART_RTSCTS, and uses it to check
RTS/CTS before we enable the DMA for the UART.

Cc: stable@vger.kernel.org
Signed-off-by: Huang Shijie <b32955@freescale.com>
Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 .../bindings/tty/serial/fsl-mxs-auart.txt          |    4 ++++
 drivers/tty/serial/mxs-auart.c                     |    7 ++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

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
index 736e95c..eac7b58 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -137,6 +137,7 @@ struct mxs_auart_port {
 #define MXS_AUART_DMA_ENABLED	0x2
 #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
+#define MXS_AUART_RTSCTS	4  /* bit 4 */
 	unsigned long flags;
 	unsigned int ctrl;
 	enum mxs_auart_type devtype;
@@ -639,7 +640,8 @@ static void mxs_auart_settermios(struct uart_port *u,
 		 * we can only implement the DMA support for auart
 		 * in mx28.
 		 */
-		if (is_imx28_auart(s) && (s->flags & MXS_AUART_DMA_CONFIG)) {
+		if (is_imx28_auart(s) && (s->flags & MXS_AUART_DMA_CONFIG)
+				&& test_bit(MXS_AUART_RTSCTS, &s->flags)) {
 			if (!mxs_auart_dma_init(s))
 				/* enable DMA tranfer */
 				ctrl2 |= AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
@@ -1009,6 +1011,9 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 
 	s->flags |= MXS_AUART_DMA_CONFIG;
 
+	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
+		set_bit(MXS_AUART_RTSCTS, &s->flags);
+
 	return 0;
 }
 
-- 
1.7.4.4
