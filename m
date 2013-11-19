From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 24/29] ARM: shmobile: r8a7790: Declare SCIF register base and IRQ as resources
Date: Tue, 19 Nov 2013 15:02:25 +0100
Message-ID: <1384869751-9786-25-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50405 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab3KSOCI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Nov 2013 09:02:08 -0500
In-Reply-To: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 8344743..70bb553 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -81,11 +81,14 @@ void __init r8a7790_pinmux_init(void)
 #define __R8A7790_SCIF(scif_type, _scscr, algo, index, baseaddr, irq)	\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
-	.mapbase	= baseaddr,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
 	.scbrr_algo_id	= algo,						\
 	.scscr		= _scscr,					\
-	.irqs		= SCIx_IRQ_MUXED(irq),				\
+};									\
+									\
+static struct resource scif##index##_resources[] = {			\
+	DEFINE_RES_MEM(baseaddr, 0x100),				\
+	DEFINE_RES_IRQ(irq),						\
 }
 
 #define R8A7790_SCIF(index, baseaddr, irq)				\
@@ -116,9 +119,11 @@ R8A7790_HSCIF(8, 0xe62c0000, gic_spi(154)); /* HSCIF0 */
 R8A7790_HSCIF(9, 0xe62c8000, gic_spi(155)); /* HSCIF1 */
 
 #define r8a7790_register_scif(index)					       \
-	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
-				      &scif##index##_platform_data,	       \
-				      sizeof(scif##index##_platform_data))
+	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+					  scif##index##_resources,	       \
+					  ARRAY_SIZE(scif##index##_resources), \
+					  &scif##index##_platform_data,	       \
+					  sizeof(scif##index##_platform_data))
 
 static const struct renesas_irqc_config irqc0_data __initconst = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
-- 
1.8.3.2

