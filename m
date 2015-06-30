From: Paul Osmialowski <pawelo@king.net.pl>
Subject: [PATCH v2 6/9] arm: twr-k70f120m: extend Freescale eDMA driver with
 the ability to support Kinetis SoC
Date: Tue, 30 Jun 2015 14:27:27 +0200
Message-ID: <1435667250-28299-7-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sergei Poselenov <sposelenov@emcraft.com>, Paul Bolle <pebolle@tiscali.nl>, Paul Osmialowski <pawelo@king.net.pl>, Arnd Bergmann <arnd@arndb.de>, Jingchang Lu <jingchang.lu@freescale.com>, Yuri Tikhonov <yur@emcraft.com>, Rob Herring <r.herring@freescale.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Alexander Potashev <aspotashev@emcraft.com>, Frank Li <Frank.Li@freescale.com>, Thomas Gleixner <tglx@linutronix.de>, Anson Huang <b20788@freescale.com>
List-Id: linux-serial@vger.kernel.org

Surprisingly small amount of work was required in order to extend already
existing eDMA driver with the support for Kinetis SoC architecture.

Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
---
 Documentation/devicetree/bindings/dma/fsl-edma.txt |  38 ++++++-
 drivers/dma/fsl-edma.c                             | 114 ++++++++++++++++-----
 2 files changed, 125 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-edma.txt b/Documentation/devicetree/bindings/dma/fsl-edma.txt
index 191d7bd..88c3e20 100644
--- a/Documentation/devicetree/bindings/dma/fsl-edma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-edma.txt
@@ -9,6 +9,7 @@ group, DMAMUX0 or DMAMUX1, but not both.
 Required properties:
 - compatible :
 	- "fsl,vf610-edma" for eDMA used similar to that on Vybrid vf610 SoC
+	- "fsl,kinetis-edma" for eDMA used similar to that on Kinetis SoC
 - reg : Specifies base physical address(s) and size of the eDMA registers.
 	The 1st region is eDMA control register's address and size.
 	The 2nd and the 3rd regions are programmable channel multiplexing
@@ -16,7 +17,8 @@ Required properties:
 - interrupts : A list of interrupt-specifiers, one for each entry in
 	interrupt-names.
 - interrupt-names : Should contain:
-	"edma-tx" - the transmission interrupt
+	"edma-tx" - the transmission interrupt (Vybrid)
+	"edma-tx-n,m" - interrupt for channels n (0-15) and m (16-31) (Kinetis)
 	"edma-err" - the error interrupt
 - #dma-cells : Must be <2>.
 	The 1st cell specifies the DMAMUX(0 for DMAMUX0 and 1 for DMAMUX1).
@@ -28,6 +30,7 @@ Required properties:
 - clock-names : A list of channel group clock names. Should contain:
 	"dmamux0" - clock name of mux0 group
 	"dmamux1" - clock name of mux1 group
+	"edma"    - clock gate for whole controller (Kinetis only)
 - clocks : A list of phandle and clock-specifier pairs, one for each entry in
 	clock-names.
 
@@ -54,6 +57,39 @@ edma0: dma-controller@40018000 {
 		<&clks VF610_CLK_DMAMUX1>;
 };
 
+edma: dma-controller@40008000 {
+	compatible = "fsl,kinetis-edma";
+	reg = <0x40008000 0x2000>, /* DMAC */
+		<0x40021000 0x1000>, /* DMAMUX0 */
+		<0x40022000 0x1000>; /* DMAMUX1 */
+	#dma-cells = <2>;
+	dma-channels = <32>;
+	interrupts =	 <0>,  <1>,  <2>,  <3>,
+			 <4>,  <5>,  <6>,  <7>,
+			 <8>,  <9>, <10>, <11>,
+			<12>, <13>, <14>, <15>,
+			<16>;
+	interrupt-names = "edma-tx-0,16",
+			  "edma-tx-1,17",
+			  "edma-tx-2,18",
+			  "edma-tx-3,19",
+			  "edma-tx-4,20",
+			  "edma-tx-5,21",
+			  "edma-tx-6,22",
+			  "edma-tx-7,23",
+			  "edma-tx-8,24",
+			  "edma-tx-9,25",
+			  "edma-tx-10,26",
+			  "edma-tx-11,27",
+			  "edma-tx-12,28",
+			  "edma-tx-13,29",
+			  "edma-tx-14,30",
+			  "edma-tx-15,31",
+			  "edma-err";
+	clocks = <&mcg_cclk_gate 6 1>,
+		 <&mcg_pclk_gate 5 1>, <&mcg_pclk_gate 5 2>;
+	clock-names = "edma", "dmamux0", "dmamux1";
+};
 
 * DMA clients
 DMA client drivers that uses the DMA function must use the format described
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 915eec3..e41a3b9 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -164,13 +164,13 @@ struct fsl_edma_desc {
 struct fsl_edma_engine {
 	struct dma_device	dma_dev;
 	void __iomem		*membase;
+	struct clk		*clk;
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
 	struct mutex		fsl_edma_mutex;
 	u32			n_chans;
-	int			txirq;
-	int			errirq;
 	bool			big_endian;
+	bool			kinetis;
 	struct fsl_edma_chan	chans[];
 };
 
@@ -788,42 +788,85 @@ static void fsl_edma_free_chan_resources(struct dma_chan *chan)
 }
 
 static int
-fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
+fsl_edma_irq_init(struct platform_device *pdev,
+		  struct fsl_edma_engine *fsl_edma)
 {
+	struct device_node *np = pdev->dev.of_node;
+	int irq, errirq;
 	int ret;
 
-	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
-	if (fsl_edma->txirq < 0) {
-		dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
-		return fsl_edma->txirq;
-	}
-
-	fsl_edma->errirq = platform_get_irq_byname(pdev, "edma-err");
-	if (fsl_edma->errirq < 0) {
+	errirq = platform_get_irq_byname(pdev, "edma-err");
+	if (errirq < 0) {
 		dev_err(&pdev->dev, "Can't get edma-err irq.\n");
-		return fsl_edma->errirq;
+		return irq;
 	}
 
-	if (fsl_edma->txirq == fsl_edma->errirq) {
-		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
-				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't register eDMA IRQ.\n");
-			 return  ret;
+	if (fsl_edma->kinetis) {
+		int i;
+		int irqs = of_irq_count(np);
+
+		if (irqs <= 1) {
+			dev_err(&pdev->dev, "Wrong eDMA irq count %d\n", irqs);
+			return -EINVAL;
 		}
-	} else {
-		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
+
+		for (i = 0; i < (irqs - 1); i++) {
+			char irq_name[32];
+
+			sprintf(irq_name, "edma-tx-%d,%d", i, 16 + i);
+			irq = platform_get_irq_byname(pdev, irq_name);
+			if (irq < 0) {
+				dev_err(&pdev->dev, "Can't get %s irq.\n",
+							irq_name);
+				return irq;
+			}
+
+			ret = devm_request_irq(&pdev->dev, irq,
 				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
-			return  ret;
+			if (ret) {
+				dev_err(&pdev->dev, "Can't register %s IRQ.\n",
+							irq_name);
+				return  ret;
+			}
 		}
 
-		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
-				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
+		ret = devm_request_irq(&pdev->dev, errirq,
+			fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't register eDMA err IRQ.\n");
-			return  ret;
+		return  ret;
+		}
+	} else {
+		irq = platform_get_irq_byname(pdev, "edma-tx");
+		if (irq < 0) {
+			dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
+			return irq;
+		}
+
+		if (irq == errirq) {
+			ret = devm_request_irq(&pdev->dev, irq,
+				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
+			if (ret) {
+				dev_err(&pdev->dev,
+						"Can't register eDMA IRQ.\n");
+				return  ret;
+			}
+		} else {
+			ret = devm_request_irq(&pdev->dev, irq,
+				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
+			if (ret) {
+				dev_err(&pdev->dev,
+					    "Can't register eDMA tx IRQ.\n");
+				return  ret;
+			}
+
+			ret = devm_request_irq(&pdev->dev, errirq,
+				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
+			if (ret) {
+				dev_err(&pdev->dev,
+					    "Can't register eDMA err IRQ.\n");
+				return  ret;
+			}
 		}
 	}
 
@@ -851,6 +894,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fsl_edma->n_chans = chans;
+	fsl_edma->kinetis = of_device_is_compatible(np, "fsl,kinetis-edma");
 	mutex_init(&fsl_edma->fsl_edma_mutex);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -858,6 +902,20 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (IS_ERR(fsl_edma->membase))
 		return PTR_ERR(fsl_edma->membase);
 
+	if (fsl_edma->kinetis) {
+		fsl_edma->clk = devm_clk_get(&pdev->dev, "edma");
+		if (IS_ERR(fsl_edma->clk)) {
+			dev_err(&pdev->dev, "Missing EDMA clock.\n");
+			return PTR_ERR(fsl_edma->clk);
+		}
+
+		ret = clk_prepare_enable(fsl_edma->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "EDMA clk failed.\n");
+			return ret;
+		}
+	}
+
 	for (i = 0; i < DMAMUX_NR; i++) {
 		char clkname[32];
 
@@ -956,10 +1014,14 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	for (i = 0; i < DMAMUX_NR; i++)
 		clk_disable_unprepare(fsl_edma->muxclk[i]);
 
+	if (fsl_edma->kinetis)
+		clk_disable_unprepare(fsl_edma->clk);
+
 	return 0;
 }
 
 static const struct of_device_id fsl_edma_dt_ids[] = {
+	{ .compatible = "fsl,kinetis-edma", },
 	{ .compatible = "fsl,vf610-edma", },
 	{ /* sentinel */ }
 };
-- 
2.3.6
