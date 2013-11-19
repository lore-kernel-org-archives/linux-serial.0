From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 16/29] ARM: shmobile: r8a7791: Don't define SCIF platform data in an array
Date: Tue, 19 Nov 2013 15:02:17 +0100
Message-ID: <1384869751-9786-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50405 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab3KSOCB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Nov 2013 09:02:01 -0500
In-Reply-To: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/setup-r8a7791.c | 125 ++++++++++++++-------------------
 1 file changed, 52 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 59dd442..8eb9373 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -84,66 +84,45 @@ void __init r8a7791_pinmux_init(void)
 	r8a7791_register_gpio(7);
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
-	.scscr = SCSCR_RE | SCSCR_TE,	\
+#define __R8A7791_SCIF(scif_type, algo, index, baseaddr, irq)		\
+static struct plat_sci_port scif##index##_platform_data = {		\
+	.type		= scif_type,					\
+	.mapbase	= baseaddr,					\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
+	.scbrr_algo_id	= algo,						\
+	.scscr		= SCSCR_RE | SCSCR_TE,				\
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
-	SCIF2, SCIF3, SCIF4, SCIF5, SCIFA3, SCIFA4, SCIFA5 };
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
-	SCIF_DATA(SCIF2, 0xe6e58000, gic_spi(22)), /* SCIF2 */
-	SCIF_DATA(SCIF3, 0xe6ea8000, gic_spi(23)), /* SCIF3 */
-	SCIF_DATA(SCIF4, 0xe6ee0000, gic_spi(24)), /* SCIF4 */
-	SCIF_DATA(SCIF5, 0xe6ee8000, gic_spi(25)), /* SCIF5 */
-	SCIFA_DATA(SCIFA3, 0xe6c70000, gic_spi(29)), /* SCIFA3 */
-	SCIFA_DATA(SCIFA4, 0xe6c78000, gic_spi(30)), /* SCIFA4 */
-	SCIFA_DATA(SCIFA5, 0xe6c80000, gic_spi(31)), /* SCIFA5 */
-};
-
-static inline void r8a7791_register_scif(int idx)
-{
-	platform_device_register_data(&platform_bus, "sh-sci", idx, &scif[idx],
-				      sizeof(struct plat_sci_port));
-}
+#define R8A7791_SCIF(index, baseaddr, irq)				\
+	__R8A7791_SCIF(PORT_SCIF, SCBRR_ALGO_2, index, baseaddr, irq)
+
+#define R8A7791_SCIFA(index, baseaddr, irq)				\
+	__R8A7791_SCIF(PORT_SCIFA, SCBRR_ALGO_4, index, baseaddr, irq)
+
+#define R8A7791_SCIFB(index, baseaddr, irq)				\
+	__R8A7791_SCIF(PORT_SCIFB, SCBRR_ALGO_4, index, baseaddr, irq)
+
+R8A7791_SCIFA(0,  0xe6c40000, gic_spi(144)); /* SCIFA0 */
+R8A7791_SCIFA(1,  0xe6c50000, gic_spi(145)); /* SCIFA1 */
+R8A7791_SCIFB(2,  0xe6c20000, gic_spi(148)); /* SCIFB0 */
+R8A7791_SCIFB(3,  0xe6c30000, gic_spi(149)); /* SCIFB1 */
+R8A7791_SCIFB(4,  0xe6ce0000, gic_spi(150)); /* SCIFB2 */
+R8A7791_SCIFA(5,  0xe6c60000, gic_spi(151)); /* SCIFA2 */
+R8A7791_SCIF(6,   0xe6e60000, gic_spi(152)); /* SCIF0 */
+R8A7791_SCIF(7,   0xe6e68000, gic_spi(153)); /* SCIF1 */
+R8A7791_SCIF(8,   0xe6e58000, gic_spi(22)); /* SCIF2 */
+R8A7791_SCIF(9,   0xe6ea8000, gic_spi(23)); /* SCIF3 */
+R8A7791_SCIF(10,  0xe6ee0000, gic_spi(24)); /* SCIF4 */
+R8A7791_SCIF(11,  0xe6ee8000, gic_spi(25)); /* SCIF5 */
+R8A7791_SCIFA(12, 0xe6c70000, gic_spi(29)); /* SCIFA3 */
+R8A7791_SCIFA(13, 0xe6c78000, gic_spi(30)); /* SCIFA4 */
+R8A7791_SCIFA(14, 0xe6c80000, gic_spi(31)); /* SCIFA5 */
+
+#define r8a7791_register_scif(index)					       \
+	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
+				      &scif##index##_platform_data,	       \
+				      sizeof(scif##index##_platform_data))
 
 static const struct sh_timer_config cmt00_platform_data __initconst = {
 	.name = "CMT00",
@@ -191,21 +170,21 @@ static struct resource irqc0_resources[] = {
 
 void __init r8a7791_add_dt_devices(void)
 {
-	r8a7791_register_scif(SCIFA0);
-	r8a7791_register_scif(SCIFA1);
-	r8a7791_register_scif(SCIFB0);
-	r8a7791_register_scif(SCIFB1);
-	r8a7791_register_scif(SCIFB2);
-	r8a7791_register_scif(SCIFA2);
-	r8a7791_register_scif(SCIF0);
-	r8a7791_register_scif(SCIF1);
-	r8a7791_register_scif(SCIF2);
-	r8a7791_register_scif(SCIF3);
-	r8a7791_register_scif(SCIF4);
-	r8a7791_register_scif(SCIF5);
-	r8a7791_register_scif(SCIFA3);
-	r8a7791_register_scif(SCIFA4);
-	r8a7791_register_scif(SCIFA5);
+	r8a7791_register_scif(0);
+	r8a7791_register_scif(1);
+	r8a7791_register_scif(2);
+	r8a7791_register_scif(3);
+	r8a7791_register_scif(4);
+	r8a7791_register_scif(5);
+	r8a7791_register_scif(6);
+	r8a7791_register_scif(7);
+	r8a7791_register_scif(8);
+	r8a7791_register_scif(9);
+	r8a7791_register_scif(10);
+	r8a7791_register_scif(11);
+	r8a7791_register_scif(12);
+	r8a7791_register_scif(13);
+	r8a7791_register_scif(14);
 	r8a7791_register_cmt(00);
 }
 
-- 
1.8.3.2

