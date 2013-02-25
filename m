From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH v2 3/3] ARM: mach-shmobile: r8a7740: Setup the serial devices using DT
Date: Mon, 25 Feb 2013 13:06:55 -0600
Message-ID: <1361819215-4115-3-git-send-email-hechtb+renesas@gmail.com>
References: <1361819215-4115-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1361819215-4115-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

We can now use the Device Tree for bringing up our serial devices. We
need to add an alternative early_devices list in setup-r8a7740 without
the serial devices and move them into the Armadillo-reference .dts config file.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2:
 - adjusted compatible lines
 - used new properties

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   94 ++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c             |   15 +++-
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 1e339cd..52645b6 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -134,6 +134,100 @@
 		renesas,pins = "eth_base";
 		renesas,function = "eth";
 	};
+
+	sci@0xe6c40000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c40000 0x100>;
+		interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
+		cell-index = <0>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+
+	sci@0xe6c50000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c50000 0x100>;
+		interrupts = <0x0c20>, <0x0c20>, <0x0c20>, <0x0c20>;
+		cell-index = <1>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+
+	sci@0xe6c60000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c60000 0x100>;
+		interrupts = <0x0c40>, <0x0c40>, <0x0c40>, <0x0c40>;
+		cell-index = <2>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+
+	sci@0xe6c70000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c70000 0x100>;
+		interrupts = <0x0c60>, <0x0c60>, <0x0c60>, <0x0c60>;
+		cell-index = <3>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+	sci@0xe6c80000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c80000 0x100>;
+		interrupts = <0x0d20>, <0x0d20>, <0x0d20>, <0x0d20>;
+		cell-index = <4>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+	sci@0xe6cb0000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6cb0000 0x100>;
+		interrupts = <0x0d40>, <0x0d40>, <0x0d40>, <0x0d40>;
+		cell-index = <5>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+	sci@0xe6cc0000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6cc0000 0x100>;
+		interrupts = <0x04c0>, <0x04c0>, <0x04c0>, <0x04c0>;
+		cell-index = <6>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+	sci@0xe6cd0000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6cd0000 0x100>;
+		interrupts = <0x04e0>, <0x04e0>, <0x04e0>, <0x04e0>;
+		cell-index = <7>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+	sci@0xe6c30000 {
+		compatible = "renesas,sci-SCIFB-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c30000 0x100>;
+		interrupts = <0x0d60>, <0x0d60>, <0x0d60>, <0x0d60>;
+		cell-index = <8>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
 };
 
 &gpio {
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 5312aad..5f7597a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -394,6 +394,13 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&tmu02_device,
 };
 
+static struct platform_device *r8a7740_early_devices_dt[] __initdata = {
+	&cmt10_device,
+	&tmu00_device,
+	&tmu01_device,
+	&tmu02_device,
+};
+
 /* DMA */
 static const struct sh_dmae_slave_config r8a7740_dmae_slaves[] = {
 	{
@@ -839,8 +846,8 @@ void __init r8a7740_add_early_devices_dt(void)
 {
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
 
-	early_platform_add_devices(r8a7740_early_devices,
-				   ARRAY_SIZE(r8a7740_early_devices));
+	early_platform_add_devices(r8a7740_early_devices_dt,
+				   ARRAY_SIZE(r8a7740_early_devices_dt));
 
 	/* setup early console here as well */
 	shmobile_setup_console();
@@ -852,8 +859,8 @@ static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
 
 void __init r8a7740_add_standard_devices_dt(void)
 {
-	platform_add_devices(r8a7740_early_devices,
-			    ARRAY_SIZE(r8a7740_early_devices));
+	platform_add_devices(r8a7740_early_devices_dt,
+			    ARRAY_SIZE(r8a7740_early_devices_dt));
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     r8a7740_auxdata_lookup, NULL);
-- 
1.7.9.5

