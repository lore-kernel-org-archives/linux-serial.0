From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 09/29] ARM: shmobile: sh73a0: Use macros to declare SCIF devices
Date: Sun, 10 Nov 2013 04:33:21 +0100
Message-ID: <1384054421-13357-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Replace copy-n-paste SCIF platform data and device declaration with a
macro. This reduces the amount of code and improves readability.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 187 +++++-----------------------------
 1 file changed, 27 insertions(+), 160 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 65151c4..9c94f34 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -71,167 +71,34 @@ void __init sh73a0_pinmux_init(void)
 					ARRAY_SIZE(pfc_resources));
 }
 
-static struct plat_sci_port scif0_platform_data = {
-	.mapbase	= 0xe6c40000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { gic_spi(72), gic_spi(72),
-			    gic_spi(72), gic_spi(72) },
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
-static struct plat_sci_port scif1_platform_data = {
-	.mapbase	= 0xe6c50000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { gic_spi(73), gic_spi(73),
-			    gic_spi(73), gic_spi(73) },
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
-static struct plat_sci_port scif2_platform_data = {
-	.mapbase	= 0xe6c60000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { gic_spi(74), gic_spi(74),
-			    gic_spi(74), gic_spi(74) },
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
-static struct plat_sci_port scif3_platform_data = {
-	.mapbase	= 0xe6c70000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { gic_spi(75), gic_spi(75),
-			    gic_spi(75), gic_spi(75) },
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
-static struct plat_sci_port scif4_platform_data = {
-	.mapbase	= 0xe6c80000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { gic_spi(78), gic_spi(78),
-			    gic_spi(78), gic_spi(78) },
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
-static struct plat_sci_port scif5_platform_data = {
-	.mapbase	= 0xe6cb0000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { gic_spi(79), gic_spi(79),
-			    gic_spi(79), gic_spi(79) },
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
-static struct plat_sci_port scif6_platform_data = {
-	.mapbase	= 0xe6cc0000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { gic_spi(156), gic_spi(156),
-			    gic_spi(156), gic_spi(156) },
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
-static struct plat_sci_port scif7_platform_data = {
-	.mapbase	= 0xe6cd0000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { gic_spi(143), gic_spi(143),
-			    gic_spi(143), gic_spi(143) },
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
-static struct plat_sci_port scif8_platform_data = {
-	.mapbase	= 0xe6c30000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFB,
-	.irqs		= { gic_spi(80), gic_spi(80),
-			    gic_spi(80), gic_spi(80) },
-};
+/* SCIF */
+#define SH73A0_SCIF(scif_type, index, baseaddr, irq)		\
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
 
-static struct platform_device scif8_device = {
-	.name		= "sh-sci",
-	.id		= 8,
-	.dev		= {
-		.platform_data	= &scif8_platform_data,
-	},
-};
+SH73A0_SCIF(PORT_SCIFA, 0, 0xe6c40000, gic_spi(72));
+SH73A0_SCIF(PORT_SCIFA, 1, 0xe6c50000, gic_spi(73));
+SH73A0_SCIF(PORT_SCIFA, 2, 0xe6c60000, gic_spi(74));
+SH73A0_SCIF(PORT_SCIFA, 3, 0xe6c70000, gic_spi(75));
+SH73A0_SCIF(PORT_SCIFA, 4, 0xe6c80000, gic_spi(78));
+SH73A0_SCIF(PORT_SCIFA, 5, 0xe6cb0000, gic_spi(79));
+SH73A0_SCIF(PORT_SCIFA, 6, 0xe6cc0000, gic_spi(156));
+SH73A0_SCIF(PORT_SCIFA, 7, 0xe6cd0000, gic_spi(143));
+SH73A0_SCIF(PORT_SCIFB, 8, 0xe6c30000, gic_spi(80));
 
 static struct sh_timer_config cmt10_platform_data = {
 	.name = "CMT10",
-- 
1.8.1.5

