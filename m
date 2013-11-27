From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 20/29] ARM: shmobile: r8a73a4: Declare SCIF register base and IRQ as resources
Date: Thu, 28 Nov 2013 00:18:30 +0100
Message-ID: <1385594319-5758-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 605298b..ef32ce2 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -43,11 +43,14 @@ void __init r8a73a4_pinmux_init(void)
 #define R8A73A4_SCIF(scif_type, _scscr, index, baseaddr, irq)	\
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= scif_type,				\
-	.mapbase	= baseaddr,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
 	.scbrr_algo_id	= SCBRR_ALGO_4,				\
 	.scscr		= _scscr,				\
-	.irqs		= SCIx_IRQ_MUXED(irq),			\
+};								\
+								\
+static struct resource scif##index##_resources[] = {		\
+	DEFINE_RES_MEM(baseaddr, 0x100),			\
+	DEFINE_RES_IRQ(irq),					\
 }
 
 #define R8A73A4_SCIFA(index, baseaddr, irq)	\
@@ -66,9 +69,11 @@ R8A73A4_SCIFB(4, 0xe6ce0000, gic_spi(150)); /* SCIFB2 */
 R8A73A4_SCIFB(5, 0xe6cf0000, gic_spi(151)); /* SCIFB3 */
 
 #define r8a73a4_register_scif(index)					       \
-	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
-				      &scif##index##_platform_data,	       \
-				      sizeof(scif##index##_platform_data))
+	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+					  scif##index##_resources,	       \
+					  ARRAY_SIZE(scif##index##_resources), \
+					  &scif##index##_platform_data,	       \
+					  sizeof(scif##index##_platform_data))
 
 static const struct renesas_irqc_config irqc0_data = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ31 */
-- 
1.8.3.2

