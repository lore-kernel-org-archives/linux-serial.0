From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 14/29] ARM: shmobile: r8a7778: Don't define SCIF platform data in an array
Date: Thu, 28 Nov 2013 00:18:24 +0100
Message-ID: <1385594319-5758-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56631 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758461Ab3K0XSt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 18:18:49 -0500
In-Reply-To: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

The SCIF driver is transitioning to platform resources. Board code will
thus need to define an array of resources for each SCIF device. This is
incompatible with the macro-based SCIF platform data definition as an
array. Rework the macro to define platform data as individual
structures.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 36 ++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 81701cf..676257e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -44,8 +44,8 @@
 #include <asm/hardware/cache-l2x0.h>
 
 /* SCIF */
-#define SCIF_INFO(baseaddr, irq)				\
-{								\
+#define R8A7778_SCIF(index, baseaddr, irq)			\
+static struct plat_sci_port scif##index##_platform_data = {	\
 	.mapbase	= baseaddr,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
@@ -54,14 +54,17 @@
 	.irqs		= SCIx_IRQ_MUXED(irq),			\
 }
 
-static struct plat_sci_port scif_platform_data[] __initdata = {
-	SCIF_INFO(0xffe40000, gic_iid(0x66)),
-	SCIF_INFO(0xffe41000, gic_iid(0x67)),
-	SCIF_INFO(0xffe42000, gic_iid(0x68)),
-	SCIF_INFO(0xffe43000, gic_iid(0x69)),
-	SCIF_INFO(0xffe44000, gic_iid(0x6a)),
-	SCIF_INFO(0xffe45000, gic_iid(0x6b)),
-};
+R8A7778_SCIF(0, 0xffe40000, gic_iid(0x66));
+R8A7778_SCIF(1, 0xffe41000, gic_iid(0x67));
+R8A7778_SCIF(2, 0xffe42000, gic_iid(0x68));
+R8A7778_SCIF(3, 0xffe43000, gic_iid(0x69));
+R8A7778_SCIF(4, 0xffe44000, gic_iid(0x6a));
+R8A7778_SCIF(5, 0xffe45000, gic_iid(0x6b));
+
+#define r8a7778_register_scif(index)					       \
+	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
+				      &scif##index##_platform_data,	       \
+				      sizeof(scif##index##_platform_data))
 
 /* TMU */
 static struct resource sh_tmu0_resources[] __initdata = {
@@ -287,8 +290,6 @@ static void __init r8a7778_register_hspi(int id)
 
 void __init r8a7778_add_dt_devices(void)
 {
-	int i;
-
 #ifdef CONFIG_CACHE_L2X0
 	void __iomem *base = ioremap_nocache(0xf0100000, 0x1000);
 	if (base) {
@@ -300,11 +301,12 @@ void __init r8a7778_add_dt_devices(void)
 	}
 #endif
 
-	for (i = 0; i < ARRAY_SIZE(scif_platform_data); i++)
-		platform_device_register_data(&platform_bus, "sh-sci", i,
-					      &scif_platform_data[i],
-					      sizeof(struct plat_sci_port));
-
+	r8a7778_register_scif(0);
+	r8a7778_register_scif(1);
+	r8a7778_register_scif(2);
+	r8a7778_register_scif(3);
+	r8a7778_register_scif(4);
+	r8a7778_register_scif(5);
 	r8a7778_register_tmu(0);
 	r8a7778_register_tmu(1);
 }
-- 
1.8.3.2

