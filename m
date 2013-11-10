From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 12/29] ARM: shmobile: r7s72100: Don't define SCIF platform data in an array
Date: Sun, 10 Nov 2013 04:33:24 +0100
Message-ID: <1384054421-13357-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37369 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758639Ab3KJDdV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Nov 2013 22:33:21 -0500
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/setup-r7s72100.c | 49 +++++++++++++++------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index d4eb509..dbcbb81 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -27,8 +27,8 @@
 #include <mach/r7s72100.h>
 #include <asm/mach/arch.h>
 
-#define SCIF_DATA(index, baseaddr, irq)					\
-[index] = {								\
+#define R7S72100_SCIF(index, baseaddr, irq)				\
+static const struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= PORT_SCIF,					\
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,		\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
@@ -39,35 +39,30 @@
 	.irqs		= { irq + 1, irq + 2, irq + 3, irq },		\
 }
 
-enum { SCIF0, SCIF1, SCIF2, SCIF3, SCIF4, SCIF5, SCIF6, SCIF7 };
+R7S72100_SCIF(0, 0xe8007000, gic_iid(221));
+R7S72100_SCIF(1, 0xe8007800, gic_iid(225));
+R7S72100_SCIF(2, 0xe8008000, gic_iid(229));
+R7S72100_SCIF(3, 0xe8008800, gic_iid(233));
+R7S72100_SCIF(4, 0xe8009000, gic_iid(237));
+R7S72100_SCIF(5, 0xe8009800, gic_iid(241));
+R7S72100_SCIF(6, 0xe800a000, gic_iid(245));
+R7S72100_SCIF(7, 0xe800a800, gic_iid(249));
 
-static const struct plat_sci_port scif[] __initconst = {
-	SCIF_DATA(SCIF0, 0xe8007000, gic_iid(221)), /* SCIF0 */
-	SCIF_DATA(SCIF1, 0xe8007800, gic_iid(225)), /* SCIF1 */
-	SCIF_DATA(SCIF2, 0xe8008000, gic_iid(229)), /* SCIF2 */
-	SCIF_DATA(SCIF3, 0xe8008800, gic_iid(233)), /* SCIF3 */
-	SCIF_DATA(SCIF4, 0xe8009000, gic_iid(237)), /* SCIF4 */
-	SCIF_DATA(SCIF5, 0xe8009800, gic_iid(241)), /* SCIF5 */
-	SCIF_DATA(SCIF6, 0xe800a000, gic_iid(245)), /* SCIF6 */
-	SCIF_DATA(SCIF7, 0xe800a800, gic_iid(249)), /* SCIF7 */
-};
-
-static inline void r7s72100_register_scif(int idx)
-{
-	platform_device_register_data(&platform_bus, "sh-sci", idx, &scif[idx],
-				      sizeof(struct plat_sci_port));
-}
+#define r7s72100_register_scif(index)					       \
+	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
+					  &scif##index##_platform_data,	       \
+					  sizeof(scif##index##_platform_data))
 
 void __init r7s72100_add_dt_devices(void)
 {
-	r7s72100_register_scif(SCIF0);
-	r7s72100_register_scif(SCIF1);
-	r7s72100_register_scif(SCIF2);
-	r7s72100_register_scif(SCIF3);
-	r7s72100_register_scif(SCIF4);
-	r7s72100_register_scif(SCIF5);
-	r7s72100_register_scif(SCIF6);
-	r7s72100_register_scif(SCIF7);
+	r7s72100_register_scif(0);
+	r7s72100_register_scif(1);
+	r7s72100_register_scif(2);
+	r7s72100_register_scif(3);
+	r7s72100_register_scif(4);
+	r7s72100_register_scif(5);
+	r7s72100_register_scif(6);
+	r7s72100_register_scif(7);
 }
 
 void __init r7s72100_init_early(void)
-- 
1.8.1.5

