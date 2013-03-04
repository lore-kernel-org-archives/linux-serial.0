From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial devices
 using DT
Date: Mon,  4 Mar 2013 17:20:54 +0100
Message-ID: <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

We can now use the Device Tree for bringing up our serial devices on
the SoC r8a7740.

We remove the power domain association. We will move the info into the
DT setup as soon as we have support for it. For now this is fine as we
use the power domain governor "pm_domain_always_on_gov" for A3SP.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v4:
We don't move the DT into the r8a7740-armadillo800eva-reference.dts, but
r8a7740.dtsi as the serial device setups are not dependent on any board
confguration.

Renamed sci@0xe6c40000 to sci@e6c40000

 arch/arm/boot/dts/r8a7740.dtsi         |   99 ++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c |  180 --------------------------------
 2 files changed, 99 insertions(+), 180 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 82faf52..ecbc237 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -767,4 +767,103 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	sci@e6c40000 {
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
+	sci@e6c50000 {
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
+	sci@e6c60000 {
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
+	sci@e6c70000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c70000 0x100>;
+		interrupts = <0x0c60>, <0x0c60>, <0x0c60>, <0x0c60>;
+		cell-index = <3>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+
+	sci@e6c80000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c80000 0x100>;
+		interrupts = <0x0d20>, <0x0d20>, <0x0d20>, <0x0d20>;
+		cell-index = <4>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+
+	sci@e6cb0000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6cb0000 0x100>;
+		interrupts = <0x0d40>, <0x0d40>, <0x0d40>, <0x0d40>;
+		cell-index = <5>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+
+	sci@e6cc0000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6cc0000 0x100>;
+		interrupts = <0x04c0>, <0x04c0>, <0x04c0>, <0x04c0>;
+		cell-index = <6>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
+
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
+
+	sci@e6c30000 {
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index f35e7c2..5a563cd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -93,168 +93,6 @@ void __init r8a7740_pinmux_init(void)
 	platform_device_register(&r8a7740_pfc_device);
 }
 
-/* SCIFA0 */
-static struct plat_sci_port scif0_platform_data = {
-	.mapbase	= 0xe6c40000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0c00)),
-};
-
-static struct platform_device scif0_device = {
-	.name		= "sh-sci",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &scif0_platform_data,
-	},
-};
-
-/* SCIFA1 */
-static struct plat_sci_port scif1_platform_data = {
-	.mapbase	= 0xe6c50000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0c20)),
-};
-
-static struct platform_device scif1_device = {
-	.name		= "sh-sci",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &scif1_platform_data,
-	},
-};
-
-/* SCIFA2 */
-static struct plat_sci_port scif2_platform_data = {
-	.mapbase	= 0xe6c60000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0c40)),
-};
-
-static struct platform_device scif2_device = {
-	.name		= "sh-sci",
-	.id		= 2,
-	.dev		= {
-		.platform_data	= &scif2_platform_data,
-	},
-};
-
-/* SCIFA3 */
-static struct plat_sci_port scif3_platform_data = {
-	.mapbase	= 0xe6c70000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0c60)),
-};
-
-static struct platform_device scif3_device = {
-	.name		= "sh-sci",
-	.id		= 3,
-	.dev		= {
-		.platform_data	= &scif3_platform_data,
-	},
-};
-
-/* SCIFA4 */
-static struct plat_sci_port scif4_platform_data = {
-	.mapbase	= 0xe6c80000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0d20)),
-};
-
-static struct platform_device scif4_device = {
-	.name		= "sh-sci",
-	.id		= 4,
-	.dev		= {
-		.platform_data	= &scif4_platform_data,
-	},
-};
-
-/* SCIFA5 */
-static struct plat_sci_port scif5_platform_data = {
-	.mapbase	= 0xe6cb0000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0d40)),
-};
-
-static struct platform_device scif5_device = {
-	.name		= "sh-sci",
-	.id		= 5,
-	.dev		= {
-		.platform_data	= &scif5_platform_data,
-	},
-};
-
-/* SCIFA6 */
-static struct plat_sci_port scif6_platform_data = {
-	.mapbase	= 0xe6cc0000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x04c0)),
-};
-
-static struct platform_device scif6_device = {
-	.name		= "sh-sci",
-	.id		= 6,
-	.dev		= {
-		.platform_data	= &scif6_platform_data,
-	},
-};
-
-/* SCIFA7 */
-static struct plat_sci_port scif7_platform_data = {
-	.mapbase	= 0xe6cd0000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x04e0)),
-};
-
-static struct platform_device scif7_device = {
-	.name		= "sh-sci",
-	.id		= 7,
-	.dev		= {
-		.platform_data	= &scif7_platform_data,
-	},
-};
-
-/* SCIFB */
-static struct plat_sci_port scifb_platform_data = {
-	.mapbase	= 0xe6c30000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFB,
-	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x0d60)),
-};
-
-static struct platform_device scifb_device = {
-	.name		= "sh-sci",
-	.id		= 8,
-	.dev		= {
-		.platform_data	= &scifb_platform_data,
-	},
-};
-
 /* CMT */
 static struct sh_timer_config cmt10_platform_data = {
 	.name = "CMT10",
@@ -379,15 +217,6 @@ static struct platform_device tmu02_device = {
 };
 
 static struct platform_device *r8a7740_devices_dt[] __initdata = {
-	&scif0_device,
-	&scif1_device,
-	&scif2_device,
-	&scif3_device,
-	&scif4_device,
-	&scif5_device,
-	&scif6_device,
-	&scif7_device,
-	&scifb_device,
 	&cmt10_device,
 	&tmu00_device,
 	&tmu01_device,
@@ -812,15 +641,6 @@ void __init r8a7740_add_standard_devices(void)
 
 	/* add devices to PM domain  */
 
-	rmobile_add_device_to_domain("A3SP",	&scif0_device);
-	rmobile_add_device_to_domain("A3SP",	&scif1_device);
-	rmobile_add_device_to_domain("A3SP",	&scif2_device);
-	rmobile_add_device_to_domain("A3SP",	&scif3_device);
-	rmobile_add_device_to_domain("A3SP",	&scif4_device);
-	rmobile_add_device_to_domain("A3SP",	&scif5_device);
-	rmobile_add_device_to_domain("A3SP",	&scif6_device);
-	rmobile_add_device_to_domain("A3SP",	&scif7_device);
-	rmobile_add_device_to_domain("A3SP",	&scifb_device);
 	rmobile_add_device_to_domain("A3SP",	&i2c1_device);
 }
 
-- 
1.7.9.5
