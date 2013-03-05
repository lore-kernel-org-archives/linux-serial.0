From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH v5] serial: sh-sci: Add OF support - incremental
Date: Tue,  5 Mar 2013 14:30:39 +0100
Message-ID: <1362490239-17848-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

This is an incremental patch to the "[PATCH v4 1/3] serial: sh-sci: Add
OF support" implementing suggestions from Arnd.

- The compatible pattern has been reworked to include devices with
  legacy register sets.
- DT property interrupt-names added
- Renamed renesas,scbrr-algo-id into renesas,clock-algorithm
- Replaced #ifdef CONFIG_OF with
  +       if (!IS_ENABLED(CONFIG_OF) || !np)
  +                               return NULL;

I opted to show the changes in an incremental patch as it may be easier
to follow the changes and as Paul has the v3 already in his repo.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 .../bindings/tty/serial/renesas,sci-serial.txt     |   41 +++++-----
 arch/arm/boot/dts/r8a7740.dtsi                     |   45 ++++++-----
 drivers/tty/serial/sh-sci.c                        |   81 ++++++++++++--------
 3 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
index 6ad1adf..5b85897 100644
--- a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
@@ -1,10 +1,18 @@
 * Renesas SH-Mobile Serial Communication Interface
 
 Required properties:
-- compatible : Should be "renesas,sci-<port type>-uart", where <port type> may be
-  SCI, SCIF, IRDA, SCIFA or SCIFB.
+- compatible : Should be "renesas,sci-<port type>-serial", where <port type> is
+  "sci", "scif", "irda", "scifa", "scifb"
+  or for legacy devices
+  "sh2_scif_fifodata", "sh3_scif", "sh4_scif", "sh4_scif_no_scsptr",
+  "sh4_scif_fifodata", "sh7705_scif".
 - reg : Address and length of the register set for the device
-- interrupts : Should contain the following IRQs: ERI, RXI, TXI and BRI.
+- interrupts : Should contain the following IRQs in this order:
+	ERI: receive-error interrupt
+	RXI: receive-FIFO-data-full interrupt
+	TXI: transmit-FIFO-data-empty interrupt
+	BRI: break reception interrupt
+- interrupt-names: The IRQ names "eri", "rxi", "txi" and "bri".
 - cell-index : The device id.
 - renesas,scscr : Should contain a bitfield used by the Serial Control Register.
   b7 = SCSCR_TIE
@@ -15,7 +23,8 @@ Required properties:
   b2 = SCSCR_TOIE
   b1 = SCSCR_CKE1
   b0 = SCSCR_CKE0
-- renesas,scbrr-algo-id : Algorithm ID for the Bit Rate Register
+- renesas,clock-algorithm : Choose the clock frequency by selecting one of the
+		    following algorithm IDs for the Bit Rate Register.
   1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
   2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
   3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
@@ -23,31 +32,17 @@ Required properties:
   5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)
 
 Optional properties:
-- renesas,autoconf : Set if device is capable of auto configuration
-- renesas,regtype : Overwrite the register layout. In most cases you can rely
-  on auto-probing (omit this property or set to 0) but some legacy devices
-  use a non-default register layout. Possible layouts are
-  0 = SCIx_PROBE_REGTYPE (default)
-  1 = SCIx_SCI_REGTYPE
-  2 = SCIx_IRDA_REGTYPE
-  3 = SCIx_SCIFA_REGTYPE
-  4 = SCIx_SCIFB_REGTYPE
-  5 = SCIx_SH2_SCIF_FIFODATA_REGTYPE
-  6 = SCIx_SH3_SCIF_REGTYPE
-  7 = SCIx_SH4_SCIF_REGTYPE
-  8 = SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
-  9 = SCIx_SH4_SCIF_FIFODATA_REGTYPE
- 10 = SCIx_SH7705_SCIF_REGTYPE
-
+- renesas,autoconf : Set if device is capable of auto configuration.
 
 Example:
-	sci@0xe6c50000 {
-		compatible = "renesas,sci-SCIFA-uart";
+	sci@e6c50000 {
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6c50000 0x100>;
 		interrupts = <0x0c20>, <0x0c20>, <0x0c20>, <0x0c20>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <1>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index ecbc237..d962dc6 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -769,101 +769,110 @@
 	};
 
 	sci@e6c40000 {
-		compatible = "renesas,sci-SCIFA-uart";
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6c40000 0x100>;
 		interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <0>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 
 	sci@e6c50000 {
-		compatible = "renesas,sci-SCIFA-uart";
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6c50000 0x100>;
 		interrupts = <0x0c20>, <0x0c20>, <0x0c20>, <0x0c20>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <1>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 
 	sci@e6c60000 {
-		compatible = "renesas,sci-SCIFA-uart";
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6c60000 0x100>;
 		interrupts = <0x0c40>, <0x0c40>, <0x0c40>, <0x0c40>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <2>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 
 	sci@e6c70000 {
-		compatible = "renesas,sci-SCIFA-uart";
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6c70000 0x100>;
 		interrupts = <0x0c60>, <0x0c60>, <0x0c60>, <0x0c60>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <3>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 
 	sci@e6c80000 {
-		compatible = "renesas,sci-SCIFA-uart";
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6c80000 0x100>;
 		interrupts = <0x0d20>, <0x0d20>, <0x0d20>, <0x0d20>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <4>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 
 	sci@e6cb0000 {
-		compatible = "renesas,sci-SCIFA-uart";
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6cb0000 0x100>;
 		interrupts = <0x0d40>, <0x0d40>, <0x0d40>, <0x0d40>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <5>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 
 	sci@e6cc0000 {
-		compatible = "renesas,sci-SCIFA-uart";
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6cc0000 0x100>;
 		interrupts = <0x04c0>, <0x04c0>, <0x04c0>, <0x04c0>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <6>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 
 	sci@0xe6cd0000 {
-		compatible = "renesas,sci-SCIFA-uart";
+		compatible = "renesas,sci-scifa-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6cd0000 0x100>;
 		interrupts = <0x04e0>, <0x04e0>, <0x04e0>, <0x04e0>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <7>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 
 	sci@e6c30000 {
-		compatible = "renesas,sci-SCIFB-uart";
+		compatible = "renesas,sci-scifb-serial";
 		interrupt-parent = <&intca>;
 		reg = <0xe6c30000 0x100>;
 		interrupts = <0x0d60>, <0x0d60>, <0x0d60>, <0x0d60>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <8>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,clock-algorithm = <4>;
 		renesas,autoconf;
 	};
 };
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cc1b69c..9468ae1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2354,18 +2354,29 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id of_sci_match[] = {
-	{ .compatible = "renesas,sci-SCI-uart",
-		.data = (void *)PORT_SCI },
-	{ .compatible = "renesas,sci-SCIF-uart",
-		.data = (void *)PORT_SCIF },
-	{ .compatible = "renesas,sci-IRDA-uart",
-		.data = (void *)PORT_IRDA },
-	{ .compatible = "renesas,sci-SCIFA-uart",
-		.data = (void *)PORT_SCIFA },
-	{ .compatible = "renesas,sci-SCIFB-uart",
-		.data = (void *)PORT_SCIFB },
+	{ .compatible = "renesas,sci-sci-serial",
+		.data = (void *)SCIx_SCI_REGTYPE },
+	{ .compatible = "renesas,sci-scif-serial",
+		.data = (void *)SCIx_SH4_SCIF_REGTYPE, },
+	{ .compatible = "renesas,sci-irda-serial",
+		.data = (void *)SCIx_IRDA_REGTYPE },
+	{ .compatible = "renesas,sci-scifa-serial",
+		.data = (void *)SCIx_SCIFA_REGTYPE },
+	{ .compatible = "renesas,sci-scifb-serial",
+		.data = (void *)SCIx_SCIFB_REGTYPE },
+	{ .compatible = "renesas,sci-sh2_scif_fifodata-serial",
+		.data = (void *)SCIx_SH2_SCIF_FIFODATA_REGTYPE },
+	{ .compatible = "renesas,sci-sh3_scif-serial",
+		.data = (void *)SCIx_SH3_SCIF_REGTYPE },
+	{ .compatible = "renesas,sci-sh4_scif-serial",
+		.data = (void *)SCIx_SH4_SCIF_REGTYPE },
+	{ .compatible = "renesas,sci-sh4_scif_no_scsptr-serial",
+		.data = (void *)SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE },
+	{ .compatible = "renesas,sci-sh4_scif_fifodata-serial",
+		.data = (void *)SCIx_SH4_SCIF_FIFODATA_REGTYPE },
+	{ .compatible = "renesas,sci-sh7705_scif-serial",
+		.data = (void *)SCIx_SH7705_SCIF_REGTYPE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, of_sci_match);
@@ -2380,6 +2391,9 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	const __be32 *prop;
 	int i, irq, val;
 
+	if (!IS_ENABLED(CONFIG_OF) || !np)
+		return NULL;
+
 	match = of_match_node(of_sci_match, pdev->dev.of_node);
 	if (!match || !match->data) {
 		dev_err(&pdev->dev, "OF match error\n");
@@ -2422,14 +2436,14 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 	p->scscr = be32_to_cpup(prop);
 
-	prop = of_get_property(np, "renesas,scbrr-algo-id", NULL);
+	prop = of_get_property(np, "renesas,clock-algorithm", NULL);
 	if (!prop) {
-		dev_err(&pdev->dev, "required DT prop scbrr-algo-id missing\n");
+		dev_err(&pdev->dev, "required DT prop clock-algorithm missing\n");
 		return NULL;
 	}
 	val = be32_to_cpup(prop);
 	if (val <= SCBRR_ALGO_INVALID || val >= SCBRR_NR_ALGOS) {
-		dev_err(&pdev->dev, "DT prop scbrr-algo-id out of range\n");
+		dev_err(&pdev->dev, "DT prop clock-algorithm out of range\n");
 		return NULL;
 	}
 	p->scbrr_algo_id = val;
@@ -2438,27 +2452,32 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	if (of_get_property(np, "renesas,autoconf", NULL))
 		p->flags |= UPF_BOOT_AUTOCONF;
 
-	prop = of_get_property(np, "renesas,regtype", NULL);
-	if (prop) {
-		val = be32_to_cpup(prop);
-		if (val < SCIx_PROBE_REGTYPE || val >= SCIx_NR_REGTYPES) {
-			dev_err(&pdev->dev, "DT prop regtype out of range\n");
-			return NULL;
-		}
-		p->regtype = val;
-	}
+	p->regtype = (unsigned int)match->data;
 
-	p->type = (unsigned int)match->data;
+	switch (p->regtype) {
+	case SCIx_SCI_REGTYPE:
+		p->type = PORT_SCI;
+		break;
+	case SCIx_SH4_SCIF_REGTYPE:
+		p->type = PORT_SCIF;
+		break;
+	case SCIx_IRDA_REGTYPE:
+		p->type = PORT_IRDA;
+		break;
+	case SCIx_SCIFA_REGTYPE:
+		p->type = PORT_SCIFA;
+		break;
+	case SCIx_SCIFB_REGTYPE:
+		p->type = PORT_SCIFB;
+		break;
+	default:
+		/* legacy register sets default to PORT_SCIF */
+		p->type = PORT_SCIF;
+		break;
+	}
 
 	return p;
 }
-#else
-static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
-								int *dev_id)
-{
-	return NULL;
-}
-#endif /* CONFIG_OF */
 
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
-- 
1.7.9.5

