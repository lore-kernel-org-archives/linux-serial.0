From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 4/4] serial: sccnxp: Add DT support
Date: Wed, 31 Jul 2013 14:55:45 +0400
Message-ID: <1375268145-13393-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp38.i.mail.ru ([94.100.177.98]:58560 "EHLO smtp38.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966Ab3GaK4H (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Jul 2013 06:56:07 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Grant Likely <grant.likely@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

Add DT support to the SCCNCP serial driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../bindings/tty/serial/sccnxp-serial.txt          | 53 ++++++++++++++++++++++
 drivers/tty/serial/sccnxp.c                        | 46 +++++++++++++++----
 include/linux/platform_data/serial-sccnxp.h        |  6 +--
 3 files changed, 93 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt b/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
new file mode 100644
index 0000000..d18b169
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
@@ -0,0 +1,53 @@
+* NXP (Philips) SCC+++(SCN+++) serial driver
+
+Required properties:
+- compatible: Should be "nxp,<ictype>". The supported ICs include sc2681,
+  sc2691, sc2692, sc2891, sc2892, sc28202, sc68681 and sc68692.
+- reg: Address and length of the register set for the device.
+- interrupts: Should contain the interrupt number. If omitted,
+  polling mode will be used instead, so "poll-interval" property should
+  be populated in this case.
+
+Optional properties:
+- clocks: Phandle to input clock. If omitted, default IC frequency will be
+  used instead.
+- poll-interval: Poll interval time in nanoseconds.
+- vcc-supply: The regulator supplying the VCC to drive the chip.
+- nxp,sccnxp-io-cfg: Array contains values for the emulated modem signals.
+  The number of values depends on the UART-number in the selected chip.
+  Each value should be composed according to the following rules:
+  (LINE1 << SIGNAL1) | ... | (LINEX << SIGNALX), where:
+   LINE - VALUE:
+    OP0 - 1
+    OP1 - 2
+    OP2 - 3
+    OP3 - 4
+    OP4 - 5
+    OP5 - 6
+    OP6 - 7
+    OP7 - 8
+    IP0 - 9
+    IP1 - 10
+    IP2 - 11
+    IP3 - 12
+    IP4 - 13
+    IP5 - 14
+    IP6 - 15
+   SIGNAL - VALUE:
+    DTR - 0
+    RTS - 4
+    DSR - 8
+    CTS - 12
+    DCD - 16
+    RNG - 20
+    DIR - 24
+
+Example (Dual UART with direction control on OP0 & OP1):
+sc2892@10100000 {
+	compatible = "nxp,sc2892";
+	reg = <0x10100000 0x10>;
+	poll-interval = <10000>;
+	clocks = <&sc2892_clk>;
+	vcc-supply = <&sc2892_reg>;
+	nxp,sccnxp-io-cfg = <0x01000000 0x02000000>;
+};
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index ef53c7a..cf14528 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -20,6 +20,8 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/console.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/io.h>
@@ -853,10 +855,25 @@ static const struct platform_device_id sccnxp_id_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, sccnxp_id_table);
 
+static const struct of_device_id sccnxp_dt_id_table[] = {
+	{ .compatible = "nxp,sc2681",	.data = &sc2681, },
+	{ .compatible = "nxp,sc2691",	.data = &sc2691, },
+	{ .compatible = "nxp,sc2692",	.data = &sc2692, },
+	{ .compatible = "nxp,sc2891",	.data = &sc2891, },
+	{ .compatible = "nxp,sc2892",	.data = &sc2892, },
+	{ .compatible = "nxp,sc28202",	.data = &sc28202, },
+	{ .compatible = "nxp,sc68681",	.data = &sc68681, },
+	{ .compatible = "nxp,sc68692",	.data = &sc68692, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sccnxp_dt_id_table);
+
 static int sccnxp_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct sccnxp_pdata *pdata = dev_get_platdata(&pdev->dev);
+	const struct of_device_id *of_id =
+		of_match_device(sccnxp_dt_id_table, &pdev->dev);
 	int i, ret, uartclk;
 	struct sccnxp_port *s;
 	void __iomem *membase;
@@ -875,7 +892,22 @@ static int sccnxp_probe(struct platform_device *pdev)
 
 	spin_lock_init(&s->lock);
 
-	s->chip = (struct sccnxp_chip *)pdev->id_entry->driver_data;
+	if (of_id) {
+		s->chip = (struct sccnxp_chip *)of_id->data;
+
+		of_property_read_u32(pdev->dev.of_node, "poll-interval",
+				     &s->pdata.poll_time_us);
+		of_property_read_u32(pdev->dev.of_node, "reg-shift",
+				     &s->pdata.reg_shift);
+		of_property_read_u32_array(pdev->dev.of_node,
+					   "nxp,sccnxp-io-cfg",
+					   s->pdata.mctrl_cfg, s->chip->nr);
+	} else {
+		s->chip = (struct sccnxp_chip *)pdev->id_entry->driver_data;
+
+		if (pdata)
+			memcpy(&s->pdata, pdata, sizeof(struct sccnxp_pdata));
+	}
 
 	s->regulator = devm_regulator_get(&pdev->dev, "vcc");
 	if (!IS_ERR(s->regulator)) {
@@ -906,16 +938,11 @@ static int sccnxp_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	if (pdata)
-		memcpy(&s->pdata, pdata, sizeof(struct sccnxp_pdata));
-
 	if (s->pdata.poll_time_us) {
 		dev_info(&pdev->dev, "Using poll mode, resolution %u usecs\n",
 			 s->pdata.poll_time_us);
 		s->poll = 1;
-	}
-
-	if (!s->poll) {
+	} else {
 		s->irq = platform_get_irq(pdev, 0);
 		if (s->irq < 0) {
 			dev_err(&pdev->dev, "Missing irq resource data\n");
@@ -1016,8 +1043,9 @@ static int sccnxp_remove(struct platform_device *pdev)
 
 static struct platform_driver sccnxp_uart_driver = {
 	.driver = {
-		.name	= SCCNXP_NAME,
-		.owner	= THIS_MODULE,
+		.name		= SCCNXP_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= sccnxp_dt_id_table,
 	},
 	.probe		= sccnxp_probe,
 	.remove		= sccnxp_remove,
diff --git a/include/linux/platform_data/serial-sccnxp.h b/include/linux/platform_data/serial-sccnxp.h
index af0c8c3..98373d6 100644
--- a/include/linux/platform_data/serial-sccnxp.h
+++ b/include/linux/platform_data/serial-sccnxp.h
@@ -78,11 +78,11 @@
 /* SCCNXP platform data structure */
 struct sccnxp_pdata {
 	/* Shift for A0 line */
-	const u8		reg_shift;
+	u32	reg_shift;
 	/* Modem control lines configuration */
-	const u32		mctrl_cfg[SCCNXP_MAX_UARTS];
+	u32	mctrl_cfg[SCCNXP_MAX_UARTS];
 	/* Timer value for polling mode (usecs) */
-	const unsigned int	poll_time_us;
+	u32	poll_time_us;
 };
 
 #endif
-- 
1.8.1.5

