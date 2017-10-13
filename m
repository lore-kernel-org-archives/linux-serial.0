From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 12/16] serial: mvebu-uart: support extended port registers layout
Date: Fri, 13 Oct 2017 11:01:56 +0200
Message-ID: <20171013090200.31034-13-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013090200.31034-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Define the missing register offsets and bit fields for the extended
UART port. Add a second driver data structure filled with its port data,
selected with the right compatible (marvell,armada-3700-uart-ext).

Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/tty/serial/mvebu-uart.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 1074054ee5be..16b0a5aa14e2 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -39,10 +39,13 @@
 
 /* Register Map */
 #define UART_STD_RBR		0x00
+#define UART_EXT_RBR		0x18
 
 #define UART_STD_TSH		0x04
+#define UART_EXT_TSH		0x1C
 
 #define UART_STD_CTRL1		0x08
+#define UART_EXT_CTRL1		0x04
 #define  CTRL_SOFT_RST		BIT(31)
 #define  CTRL_TXFIFO_RST	BIT(15)
 #define  CTRL_RXFIFO_RST	BIT(14)
@@ -55,15 +58,20 @@
 				CTRL_PAR_ERR_INT | CTRL_OVR_ERR_INT)
 
 #define UART_STD_CTRL2		UART_STD_CTRL1
+#define UART_EXT_CTRL2		0x20
 #define  CTRL_STD_TX_RDY_INT	BIT(5)
+#define  CTRL_EXT_TX_RDY_INT	BIT(6)
 #define  CTRL_STD_RX_RDY_INT	BIT(4)
+#define  CTRL_EXT_RX_RDY_INT	BIT(5)
 
 #define UART_STAT		0x0C
 #define  STAT_TX_FIFO_EMP	BIT(13)
 #define  STAT_TX_FIFO_FUL	BIT(11)
 #define  STAT_TX_EMP		BIT(6)
 #define  STAT_STD_TX_RDY	BIT(5)
+#define  STAT_EXT_TX_RDY	BIT(15)
 #define  STAT_STD_RX_RDY	BIT(4)
+#define  STAT_EXT_RX_RDY	BIT(14)
 #define  STAT_BRK_DET		BIT(3)
 #define  STAT_FRM_ERR		BIT(2)
 #define  STAT_PAR_ERR		BIT(1)
@@ -865,12 +873,28 @@ static struct mvebu_uart_driver_data uart_std_driver_data = {
 	.flags.stat_rx_rdy = STAT_STD_RX_RDY,
 };
 
+static struct mvebu_uart_driver_data uart_ext_driver_data = {
+	.is_ext = true,
+	.regs.rbr = UART_EXT_RBR,
+	.regs.tsh = UART_EXT_TSH,
+	.regs.ctrl = UART_EXT_CTRL1,
+	.regs.intr = UART_EXT_CTRL2,
+	.flags.ctrl_tx_rdy_int = CTRL_EXT_TX_RDY_INT,
+	.flags.ctrl_rx_rdy_int = CTRL_EXT_RX_RDY_INT,
+	.flags.stat_tx_rdy = STAT_EXT_TX_RDY,
+	.flags.stat_rx_rdy = STAT_EXT_RX_RDY,
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id mvebu_uart_of_match[] = {
 	{
 		.compatible = "marvell,armada-3700-uart",
 		.data = (void *)&uart_std_driver_data,
 	},
+	{
+		.compatible = "marvell,armada-3700-uart-ext",
+		.data = (void *)&uart_ext_driver_data,
+	},
 	{}
 };
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
