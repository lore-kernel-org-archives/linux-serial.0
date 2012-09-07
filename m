From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/2] serial: pl011: delete reset callback
Date: Fri, 7 Sep 2012 10:02:48 +0200
Message-ID: <1347004968-15329-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Anmar Oueja <anmar.oueja@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

Since commit 4fd0690bb0c3955983560bb2767ee82e2b197f9b
"serial: pl011: implement workaround for CTS clear event issue"
the PL011 UART is no longer at risk to hang up, so get rid
of the callback altogether.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 21 ---------------------
 include/linux/amba/serial.h        |  1 -
 2 files changed, 22 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index dd629b7..c8922bc 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -542,33 +542,12 @@ static struct stedma40_chan_cfg uart2_dma_cfg_tx = {
 };
 #endif
 
-#define PRCC_K_SOFTRST_SET      0x18
-#define PRCC_K_SOFTRST_CLEAR    0x1C
-static void ux500_uart0_reset(void)
-{
-	void __iomem *prcc_rst_set, *prcc_rst_clr;
-
-	prcc_rst_set = (void __iomem *)IO_ADDRESS(U8500_CLKRST1_BASE +
-			PRCC_K_SOFTRST_SET);
-	prcc_rst_clr = (void __iomem *)IO_ADDRESS(U8500_CLKRST1_BASE +
-			PRCC_K_SOFTRST_CLEAR);
-
-	/* Activate soft reset PRCC_K_SOFTRST_CLEAR */
-	writel((readl(prcc_rst_clr) | 0x1), prcc_rst_clr);
-	udelay(1);
-
-	/* Release soft reset PRCC_K_SOFTRST_SET */
-	writel((readl(prcc_rst_set) | 0x1), prcc_rst_set);
-	udelay(1);
-}
-
 static struct amba_pl011_data uart0_plat = {
 #ifdef CONFIG_STE_DMA40
 	.dma_filter = stedma40_filter,
 	.dma_rx_param = &uart0_dma_cfg_rx,
 	.dma_tx_param = &uart0_dma_cfg_tx,
 #endif
-	.reset = ux500_uart0_reset,
 };
 
 static struct amba_pl011_data uart1_plat = {
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index d117b29..f612c78 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -205,7 +205,6 @@ struct amba_pl011_data {
 	void *dma_tx_param;
         void (*init) (void);
 	void (*exit) (void);
-	void (*reset) (void);
 };
 #endif
 
-- 
1.7.11.3
