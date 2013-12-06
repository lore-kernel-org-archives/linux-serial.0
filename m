From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 21/47] ARM: shmobile: r8a7790: Don't define SCIF platform data in an array
Date: Fri,  6 Dec 2013 10:59:28 +0100
Message-ID: <1386323994-12850-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

The SCIF driver is transitioning to platform resources. Board code will
thus need to define an array of resources for each SCIF device. This is
incompatible with the macro-based SCIF platform data definition as an
array. Rework the macro to define platform data as individual
structures.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 112 +++++++++++++++------------------
 1 file changed, 49 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 3543c3b..8344743 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -78,61 +78,47 @@ void __init r8a7790_pinmux_init(void)
 	r8a7790_register_gpio(5);
 }
 
-#define SCIF_COMMON(scif_type, baseaddr, irq)			\
-	.type		= scif_type,				\
-	.mapbase	= baseaddr,				\
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
-	.irqs		= SCIx_IRQ_MUXED(irq)
-
-#define SCIFA_DATA(index, baseaddr, irq)		\
-[index] = {						\
-	SCIF_COMMON(PORT_SCIFA, baseaddr, irq),		\
-	.scbrr_algo_id	= SCBRR_ALGO_4,			\
-	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE0,	\
+#define __R8A7790_SCIF(scif_type, _scscr, algo, index, baseaddr, irq)	\
+static struct plat_sci_port scif##index##_platform_data = {		\
+	.type		= scif_type,					\
+	.mapbase	= baseaddr,					\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
+	.scbrr_algo_id	= algo,						\
+	.scscr		= _scscr,					\
+	.irqs		= SCIx_IRQ_MUXED(irq),				\
 }
 
-#define SCIFB_DATA(index, baseaddr, irq)	\
-[index] = {					\
-	SCIF_COMMON(PORT_SCIFB, baseaddr, irq),	\
-	.scbrr_algo_id	= SCBRR_ALGO_4,		\
-	.scscr = SCSCR_RE | SCSCR_TE,		\
-}
-
-#define SCIF_DATA(index, baseaddr, irq)		\
-[index] = {						\
-	SCIF_COMMON(PORT_SCIF, baseaddr, irq),		\
-	.scbrr_algo_id	= SCBRR_ALGO_2,			\
-	.scscr = SCSCR_RE | SCSCR_TE,	\
-}
-
-#define HSCIF_DATA(index, baseaddr, irq)		\
-[index] = {						\
-	SCIF_COMMON(PORT_HSCIF, baseaddr, irq),		\
-	.scbrr_algo_id	= SCBRR_ALGO_6,			\
-	.scscr = SCSCR_RE | SCSCR_TE,	\
-}
-
-enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFA2, SCIF0, SCIF1,
-       HSCIF0, HSCIF1 };
-
-static const struct plat_sci_port scif[] __initconst = {
-	SCIFA_DATA(SCIFA0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
-	SCIFA_DATA(SCIFA1, 0xe6c50000, gic_spi(145)), /* SCIFA1 */
-	SCIFB_DATA(SCIFB0, 0xe6c20000, gic_spi(148)), /* SCIFB0 */
-	SCIFB_DATA(SCIFB1, 0xe6c30000, gic_spi(149)), /* SCIFB1 */
-	SCIFB_DATA(SCIFB2, 0xe6ce0000, gic_spi(150)), /* SCIFB2 */
-	SCIFA_DATA(SCIFA2, 0xe6c60000, gic_spi(151)), /* SCIFA2 */
-	SCIF_DATA(SCIF0, 0xe6e60000, gic_spi(152)), /* SCIF0 */
-	SCIF_DATA(SCIF1, 0xe6e68000, gic_spi(153)), /* SCIF1 */
-	HSCIF_DATA(HSCIF0, 0xe62c0000, gic_spi(154)), /* HSCIF0 */
-	HSCIF_DATA(HSCIF1, 0xe62c8000, gic_spi(155)), /* HSCIF1 */
-};
-
-static inline void r8a7790_register_scif(int idx)
-{
-	platform_device_register_data(&platform_bus, "sh-sci", idx, &scif[idx],
-				      sizeof(struct plat_sci_port));
-}
+#define R8A7790_SCIF(index, baseaddr, irq)				\
+	__R8A7790_SCIF(PORT_SCIF, SCSCR_RE | SCSCR_TE,			\
+		       SCBRR_ALGO_2, index, baseaddr, irq)
+
+#define R8A7790_SCIFA(index, baseaddr, irq)				\
+	__R8A7790_SCIF(PORT_SCIFA, SCSCR_RE | SCSCR_TE | SCSCR_CKE0,	\
+		       SCBRR_ALGO_4, index, baseaddr, irq)
+
+#define R8A7790_SCIFB(index, baseaddr, irq)				\
+	__R8A7790_SCIF(PORT_SCIFB, SCSCR_RE | SCSCR_TE,			\
+		       SCBRR_ALGO_4, index, baseaddr, irq)
+
+#define R8A7790_HSCIF(index, baseaddr, irq)				\
+	__R8A7790_SCIF(PORT_HSCIF, SCSCR_RE | SCSCR_TE,			\
+		       SCBRR_ALGO_6, index, baseaddr, irq)
+
+R8A7790_SCIFA(0, 0xe6c40000, gic_spi(144)); /* SCIFA0 */
+R8A7790_SCIFA(1, 0xe6c50000, gic_spi(145)); /* SCIFA1 */
+R8A7790_SCIFB(2, 0xe6c20000, gic_spi(148)); /* SCIFB0 */
+R8A7790_SCIFB(3, 0xe6c30000, gic_spi(149)); /* SCIFB1 */
+R8A7790_SCIFB(4, 0xe6ce0000, gic_spi(150)); /* SCIFB2 */
+R8A7790_SCIFA(5, 0xe6c60000, gic_spi(151)); /* SCIFA2 */
+R8A7790_SCIF(6,  0xe6e60000, gic_spi(152)); /* SCIF0 */
+R8A7790_SCIF(7,  0xe6e68000, gic_spi(153)); /* SCIF1 */
+R8A7790_HSCIF(8, 0xe62c0000, gic_spi(154)); /* HSCIF0 */
+R8A7790_HSCIF(9, 0xe62c8000, gic_spi(155)); /* HSCIF1 */
+
+#define r8a7790_register_scif(index)					       \
+	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
+				      &scif##index##_platform_data,	       \
+				      sizeof(scif##index##_platform_data))
 
 static const struct renesas_irqc_config irqc0_data __initconst = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
@@ -185,16 +171,16 @@ static const struct resource cmt00_resources[] __initconst = {
 
 void __init r8a7790_add_dt_devices(void)
 {
-	r8a7790_register_scif(SCIFA0);
-	r8a7790_register_scif(SCIFA1);
-	r8a7790_register_scif(SCIFB0);
-	r8a7790_register_scif(SCIFB1);
-	r8a7790_register_scif(SCIFB2);
-	r8a7790_register_scif(SCIFA2);
-	r8a7790_register_scif(SCIF0);
-	r8a7790_register_scif(SCIF1);
-	r8a7790_register_scif(HSCIF0);
-	r8a7790_register_scif(HSCIF1);
+	r8a7790_register_scif(0);
+	r8a7790_register_scif(1);
+	r8a7790_register_scif(2);
+	r8a7790_register_scif(3);
+	r8a7790_register_scif(4);
+	r8a7790_register_scif(5);
+	r8a7790_register_scif(6);
+	r8a7790_register_scif(7);
+	r8a7790_register_scif(8);
+	r8a7790_register_scif(9);
 	r8a7790_register_cmt(00);
 }
 
-- 
1.8.3.2

