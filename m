From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 43/45] drivers: tty: serial: pmac_zilog: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:13 +0100
Message-ID: <1552602855-26086-44-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/pmac_zilog.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index bcb5bf7..bce19b0 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1411,7 +1411,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 	if (of_address_to_resource(np, 0, &r_ports))
 		return -ENODEV;
 	uap->port.mapbase = r_ports.start;
-	uap->port.membase = ioremap(uap->port.mapbase, 0x1000);
+	uap->port.membase = devm_ioremap(uap->port->dev, uap->port.mapbase, 0x1000);
 
 	uap->control_reg = uap->port.membase;
 	uap->data_reg = uap->control_reg + 0x10;
@@ -1428,14 +1428,16 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 	memset(&r_rxdma, 0, sizeof(struct resource));
 #endif	
 	if (ZS_HAS_DMA(uap)) {
-		uap->tx_dma_regs = ioremap(r_txdma.start, 0x100);
+		uap->tx_dma_regs = devm_ioremap(uap->port.dev,
+					        r_txdma.start, 0x100);
 		if (uap->tx_dma_regs == NULL) {	
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
 		}
-		uap->rx_dma_regs = ioremap(r_rxdma.start, 0x100);
+		uap->rx_dma_regs = devm_ioremap(uap->port.dev,
+					        r_rxdma.start, 0x100);
 		if (uap->rx_dma_regs == NULL) {	
-			iounmap(uap->tx_dma_regs);
+			devm_iounmap(uap->port.dev, uap->tx_dma_regs);
 			uap->tx_dma_regs = NULL;
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
@@ -1530,9 +1532,9 @@ static void pmz_dispose_port(struct uart_pmac_port *uap)
 	struct device_node *np;
 
 	np = uap->node;
-	iounmap(uap->rx_dma_regs);
-	iounmap(uap->tx_dma_regs);
-	iounmap(uap->control_reg);
+	devm_iounmap(uap->port.dev, uap->rx_dma_regs);
+	devm_iounmap(uap->port.dev, uap->tx_dma_regs);
+	devm_iounmap(uap->port.dev, uap->control_reg);
 	uap->node = NULL;
 	of_node_put(np);
 	memset(uap, 0, sizeof(struct uart_pmac_port));
-- 
1.9.1
