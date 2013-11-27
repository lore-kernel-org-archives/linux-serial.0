From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 13/29] ARM: shmobile: r8a73a4: Don't define SCIF platform data in an array
Date: Thu, 28 Nov 2013 00:18:23 +0100
Message-ID: <1385594319-5758-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56632 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758443Ab3K0XSt (ORCPT
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
 arch/arm/mach-shmobile/setup-r8a73a4.c | 58 +++++++++++++++-------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index cc94b64..605298b 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -40,41 +40,35 @@ void __init r8a73a4_pinmux_init(void)
 					ARRAY_SIZE(pfc_resources));
 }
 
-#define SCIF_COMMON(scif_type, baseaddr, irq)			\
+#define R8A73A4_SCIF(scif_type, _scscr, index, baseaddr, irq)	\
+static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= scif_type,				\
 	.mapbase	= baseaddr,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
 	.scbrr_algo_id	= SCBRR_ALGO_4,				\
-	.irqs		= SCIx_IRQ_MUXED(irq)
-
-#define SCIFA_DATA(index, baseaddr, irq)		\
-[index] = {						\
-	SCIF_COMMON(PORT_SCIFA, baseaddr, irq),		\
-	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE0,	\
+	.scscr		= _scscr,				\
+	.irqs		= SCIx_IRQ_MUXED(irq),			\
 }
 
-#define SCIFB_DATA(index, baseaddr, irq)	\
-[index] = {					\
-	SCIF_COMMON(PORT_SCIFB, baseaddr, irq),	\
-	.scscr = SCSCR_RE | SCSCR_TE,		\
-}
+#define R8A73A4_SCIFA(index, baseaddr, irq)	\
+	R8A73A4_SCIF(PORT_SCIFA, SCSCR_RE | SCSCR_TE | SCSCR_CKE0, \
+		     index, baseaddr, irq)
 
-enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFB3 };
+#define R8A73A4_SCIFB(index, baseaddr, irq)	\
+	R8A73A4_SCIF(PORT_SCIFB, SCSCR_RE | SCSCR_TE, \
+		     index, baseaddr, irq)
 
-static const struct plat_sci_port scif[] = {
-	SCIFA_DATA(SCIFA0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
-	SCIFA_DATA(SCIFA1, 0xe6c50000, gic_spi(145)), /* SCIFA1 */
-	SCIFB_DATA(SCIFB0, 0xe6c20000, gic_spi(148)), /* SCIFB0 */
-	SCIFB_DATA(SCIFB1, 0xe6c30000, gic_spi(149)), /* SCIFB1 */
-	SCIFB_DATA(SCIFB2, 0xe6ce0000, gic_spi(150)), /* SCIFB2 */
-	SCIFB_DATA(SCIFB3, 0xe6cf0000, gic_spi(151)), /* SCIFB3 */
-};
+R8A73A4_SCIFA(0, 0xe6c40000, gic_spi(144)); /* SCIFA0 */
+R8A73A4_SCIFA(1, 0xe6c50000, gic_spi(145)); /* SCIFA1 */
+R8A73A4_SCIFB(2, 0xe6c20000, gic_spi(148)); /* SCIFB0 */
+R8A73A4_SCIFB(3, 0xe6c30000, gic_spi(149)); /* SCIFB1 */
+R8A73A4_SCIFB(4, 0xe6ce0000, gic_spi(150)); /* SCIFB2 */
+R8A73A4_SCIFB(5, 0xe6cf0000, gic_spi(151)); /* SCIFB3 */
 
-static inline void r8a73a4_register_scif(int idx)
-{
-	platform_device_register_data(&platform_bus, "sh-sci", idx, &scif[idx],
-				      sizeof(struct plat_sci_port));
-}
+#define r8a73a4_register_scif(index)					       \
+	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
+				      &scif##index##_platform_data,	       \
+				      sizeof(scif##index##_platform_data))
 
 static const struct renesas_irqc_config irqc0_data = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ31 */
@@ -192,12 +186,12 @@ static struct resource cmt10_resources[] = {
 
 void __init r8a73a4_add_dt_devices(void)
 {
-	r8a73a4_register_scif(SCIFA0);
-	r8a73a4_register_scif(SCIFA1);
-	r8a73a4_register_scif(SCIFB0);
-	r8a73a4_register_scif(SCIFB1);
-	r8a73a4_register_scif(SCIFB2);
-	r8a73a4_register_scif(SCIFB3);
+	r8a73a4_register_scif(0);
+	r8a73a4_register_scif(1);
+	r8a73a4_register_scif(2);
+	r8a73a4_register_scif(3);
+	r8a73a4_register_scif(4);
+	r8a73a4_register_scif(5);
 	r8a7790_register_cmt(10);
 }
 
-- 
1.8.3.2

