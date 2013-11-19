From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 10/29] ARM: shmobile: r8a7740: Use macros to declare SCIF devices
Date: Tue, 19 Nov 2013 15:02:11 +0100
Message-ID: <1384869751-9786-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50405 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab3KSOB4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Nov 2013 09:01:56 -0500
In-Reply-To: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

Replace copy-n-paste SCIF platform data and device declaration with a
macro. This reduces the amount of code and improves readability.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 191 +++++----------------------------
 1 file changed, 29 insertions(+), 162 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index b7d4b2c..8778b57 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -203,167 +203,34 @@ static struct platform_device irqpin3_device = {
 	},
 };
 
-/* SCIFA0 */
-static struct plat_sci_port scif0_platform_data = {
-	.mapbase	= 0xe6c40000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(100)),
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
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(101)),
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
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(102)),
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
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(103)),
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
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(104)),
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
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(105)),
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
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(106)),
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
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(107)),
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
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(108)),
-};
+/* SCIF */
+#define R8A7740_SCIF(scif_type, index, baseaddr, irq)		\
+static struct plat_sci_port scif##index##_platform_data = {	\
+	.type		= scif_type,				\
+	.mapbase	= baseaddr,				\
+	.flags		= UPF_BOOT_AUTOCONF,			\
+	.irqs		= SCIx_IRQ_MUXED(irq),			\
+	.scbrr_algo_id	= SCBRR_ALGO_4,				\
+	.scscr		= SCSCR_RE | SCSCR_TE,			\
+};								\
+								\
+static struct platform_device scif##index##_device = {		\
+	.name		= "sh-sci",				\
+	.id		= index,				\
+	.dev		= {					\
+		.platform_data	= &scif##index##_platform_data,	\
+	},							\
+}
 
-static struct platform_device scifb_device = {
-	.name		= "sh-sci",
-	.id		= 8,
-	.dev		= {
-		.platform_data	= &scifb_platform_data,
-	},
-};
+R8A7740_SCIF(PORT_SCIFA, 0, 0xe6c40000, gic_spi(100));
+R8A7740_SCIF(PORT_SCIFA, 1, 0xe6c50000, gic_spi(101));
+R8A7740_SCIF(PORT_SCIFA, 2, 0xe6c60000, gic_spi(102));
+R8A7740_SCIF(PORT_SCIFA, 3, 0xe6c70000, gic_spi(103));
+R8A7740_SCIF(PORT_SCIFA, 4, 0xe6c80000, gic_spi(104));
+R8A7740_SCIF(PORT_SCIFA, 5, 0xe6cb0000, gic_spi(105));
+R8A7740_SCIF(PORT_SCIFA, 6, 0xe6cc0000, gic_spi(106));
+R8A7740_SCIF(PORT_SCIFA, 7, 0xe6cd0000, gic_spi(107));
+R8A7740_SCIF(PORT_SCIFB, 8, 0xe6c30000, gic_spi(108));
 
 /* CMT */
 static struct sh_timer_config cmt10_platform_data = {
@@ -528,7 +395,7 @@ static struct platform_device *r8a7740_devices_dt[] __initdata = {
 	&scif5_device,
 	&scif6_device,
 	&scif7_device,
-	&scifb_device,
+	&scif8_device,
 	&cmt10_device,
 };
 
@@ -981,7 +848,7 @@ void __init r8a7740_add_standard_devices(void)
 	rmobile_add_device_to_domain("A3SP",	&scif5_device);
 	rmobile_add_device_to_domain("A3SP",	&scif6_device);
 	rmobile_add_device_to_domain("A3SP",	&scif7_device);
-	rmobile_add_device_to_domain("A3SP",	&scifb_device);
+	rmobile_add_device_to_domain("A3SP",	&scif8_device);
 	rmobile_add_device_to_domain("A3SP",	&i2c1_device);
 }
 
-- 
1.8.3.2

