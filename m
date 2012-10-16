From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 1/3] serial: mxs-auart: distinguish the different SOCs
Date: Tue, 16 Oct 2012 14:03:04 +0800
Message-ID: <1350367386-7742-2-git-send-email-b32955@freescale.com>
References: <1350367386-7742-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:21201
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753958Ab2JPGfl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Oct 2012 02:35:41 -0400
In-Reply-To: <1350367386-7742-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, lauri.hintsala@bluegiga.com, vinod.koul@intel.com, Huang Shijie <shijie8@gmail.com>, Huang Shijie <b32955@freescale.com>

From: Huang Shijie <shijie8@gmail.com>

The current mxs-auart driver is used for both mx23 and mx28.

But in mx23, the DMA has a bug(see errata:2836). We can not add the
DMA support in mx23, but we can add DMA support to auart in mx28.

So in order to add the DMA support for the auart in mx28, we should add
the platform_device_id to distinguish the distinguish SOCs.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../bindings/tty/serial/fsl-mxs-auart.txt          |    2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   10 +++---
 drivers/tty/serial/mxs-auart.c                     |   28 +++++++++++++++----
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
index 2ee903f..a154bf1 100644
--- a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
@@ -8,7 +8,7 @@ Required properties:
 
 Example:
 auart0: serial@8006a000 {
-	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+	compatible = "fsl,imx28-auart";
 	reg = <0x8006a000 0x2000>;
 	interrupts = <112 70 71>;
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e16d631..6ed9215 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -795,7 +795,7 @@
 			};
 
 			auart0: serial@8006a000 {
-				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+				compatible = "fsl,imx28-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
 				clocks = <&clks 45>;
@@ -803,7 +803,7 @@
 			};
 
 			auart1: serial@8006c000 {
-				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+				compatible = "fsl,imx28-auart";
 				reg = <0x8006c000 0x2000>;
 				interrupts = <113 72 73>;
 				clocks = <&clks 45>;
@@ -811,7 +811,7 @@
 			};
 
 			auart2: serial@8006e000 {
-				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+				compatible = "fsl,imx28-auart";
 				reg = <0x8006e000 0x2000>;
 				interrupts = <114 74 75>;
 				clocks = <&clks 45>;
@@ -819,7 +819,7 @@
 			};
 
 			auart3: serial@80070000 {
-				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+				compatible = "fsl,imx28-auart";
 				reg = <0x80070000 0x2000>;
 				interrupts = <115 76 77>;
 				clocks = <&clks 45>;
@@ -827,7 +827,7 @@
 			};
 
 			auart4: serial@80072000 {
-				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+				compatible = "fsl,imx28-auart";
 				reg = <0x80072000 0x2000>;
 				interrupts = <116 78 79>;
 				clocks = <&clks 45>;
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6db3baa..cd9ec1d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -37,6 +37,11 @@
 
 #include <asm/cacheflush.h>
 
+/* Use the platform_id to distinguish different Archs. */
+#define IS_MX23			0x0
+#define IS_MX28			0x1
+#define AUART_IS_MX23(x)	((x)->pdev->id_entry->driver_data == IS_MX23)
+
 #define MXS_AUART_PORTS 5
 
 #define AUART_CTRL0			0x00000000
@@ -124,6 +129,7 @@ struct mxs_auart_port {
 
 	struct clk *clk;
 	struct device *dev;
+	struct platform_device *pdev;
 };
 
 static void mxs_auart_stop_tx(struct uart_port *u);
@@ -680,6 +686,19 @@ static struct uart_driver auart_driver = {
 #endif
 };
 
+static const struct platform_device_id auart_ids[] = {
+	{ .name = "imx23-auart", .driver_data = IS_MX23, },
+	{ .name = "imx28-auart", .driver_data = IS_MX28, },
+	{},
+};
+
+static struct of_device_id mxs_auart_dt_ids[] = {
+	{ .compatible = "fsl,imx23-auart", .data = (void *)&auart_ids[0] },
+	{ .compatible = "fsl,imx28-auart", .data = (void *)&auart_ids[1] },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
+
 /*
  * This function returns 1 if pdev isn't a device instatiated by dt, 0 if it
  * could successfully get all information from dt or a negative errno.
@@ -701,6 +720,8 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	}
 	s->port.line = ret;
 
+	pdev->id_entry = of_match_device(mxs_auart_dt_ids, &pdev->dev)->data;
+
 	return 0;
 }
 
@@ -753,6 +774,7 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 
 	s->flags = 0;
 	s->ctrl = 0;
+	s->pdev = pdev;
 
 	s->irq = platform_get_irq(pdev, 0);
 	s->port.irq = s->irq;
@@ -805,12 +827,6 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id mxs_auart_dt_ids[] = {
-	{ .compatible = "fsl,imx23-auart", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
-
 static struct platform_driver mxs_auart_driver = {
 	.probe = mxs_auart_probe,
 	.remove = __devexit_p(mxs_auart_remove),
-- 
1.7.0.4


