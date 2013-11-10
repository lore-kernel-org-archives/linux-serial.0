From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 11/29] ARM: shmobile: r8a7779: Use macros to declare SCIF devices
Date: Sun, 10 Nov 2013 04:33:23 +0100
Message-ID: <1384054421-13357-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37370 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758593Ab3KJDdU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Nov 2013 22:33:20 -0500
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

Replace copy-n-paste SCIF platform data and device declaration with a
macro. This reduces the amount of code and improves readability.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 124 +++++++--------------------------
 1 file changed, 24 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 51a43c5..79cdb8a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -188,107 +188,31 @@ void __init r8a7779_pinmux_init(void)
 			    ARRAY_SIZE(r8a7779_pinctrl_devices));
 }
 
-static struct plat_sci_port scif0_platform_data = {
-	.mapbase	= 0xffe40000,
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
-	.scbrr_algo_id	= SCBRR_ALGO_2,
-	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x78)),
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
-	.mapbase	= 0xffe41000,
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
-	.scbrr_algo_id	= SCBRR_ALGO_2,
-	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x79)),
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
-	.mapbase	= 0xffe42000,
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
-	.scbrr_algo_id	= SCBRR_ALGO_2,
-	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x7a)),
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
-	.mapbase	= 0xffe43000,
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
-	.scbrr_algo_id	= SCBRR_ALGO_2,
-	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x7b)),
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
-	.mapbase	= 0xffe44000,
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
-	.scbrr_algo_id	= SCBRR_ALGO_2,
-	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x7c)),
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
-	.mapbase	= 0xffe45000,
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
-	.scbrr_algo_id	= SCBRR_ALGO_2,
-	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x7d)),
-};
+/* SCIF */
+#define R8A7779_SCIF(index, baseaddr, irq)			\
+static struct plat_sci_port scif##index##_platform_data = {	\
+	.type		= PORT_SCIF,				\
+	.mapbase	= baseaddr,				\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
+	.irqs		= SCIx_IRQ_MUXED(irq),			\
+	.scbrr_algo_id	= SCBRR_ALGO_2,				\
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
+};								\
+								\
+static struct platform_device scif##index##_device = {		\
+	.name		= "sh-sci",				\
+	.id		= index,				\
+	.dev		= {					\
+		.platform_data	= &scif##index##_platform_data,	\
+	},							\
+}
 
-static struct platform_device scif5_device = {
-	.name		= "sh-sci",
-	.id		= 5,
-	.dev		= {
-		.platform_data	= &scif5_platform_data,
-	},
-};
+R8A7779_SCIF(0, 0xffe40000, gic_iid(0x78));
+R8A7779_SCIF(1, 0xffe41000, gic_iid(0x79));
+R8A7779_SCIF(2, 0xffe42000, gic_iid(0x7a));
+R8A7779_SCIF(3, 0xffe43000, gic_iid(0x7b));
+R8A7779_SCIF(4, 0xffe44000, gic_iid(0x7c));
+R8A7779_SCIF(5, 0xffe45000, gic_iid(0x7d));
 
 /* TMU */
 static struct sh_timer_config tmu00_platform_data = {
-- 
1.8.1.5

