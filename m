From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 25/29] ARM: shmobile: r8a7791: Declare SCIF register base and IRQ as resources
Date: Sun, 10 Nov 2013 04:33:37 +0100
Message-ID: <1384054421-13357-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37370 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758610Ab3KJDdd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Nov 2013 22:33:33 -0500
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7791.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 8eb9373..557db8f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -87,11 +87,14 @@ void __init r8a7791_pinmux_init(void)
 #define __R8A7791_SCIF(scif_type, algo, index, baseaddr, irq)		\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
-	.mapbase	= baseaddr,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
 	.scbrr_algo_id	= algo,						\
 	.scscr		= SCSCR_RE | SCSCR_TE,				\
-	.irqs		= SCIx_IRQ_MUXED(irq),				\
+};									\
+									\
+static struct resource scif##index##_resources[] = {			\
+	DEFINE_RES_MEM(baseaddr, 0x100),				\
+	DEFINE_RES_IRQ(irq),						\
 }
 
 #define R8A7791_SCIF(index, baseaddr, irq)				\
@@ -120,9 +123,11 @@ R8A7791_SCIFA(13, 0xe6c78000, gic_spi(30)); /* SCIFA4 */
 R8A7791_SCIFA(14, 0xe6c80000, gic_spi(31)); /* SCIFA5 */
 
 #define r8a7791_register_scif(index)					       \
-	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
-				      &scif##index##_platform_data,	       \
-				      sizeof(scif##index##_platform_data))
+	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+					  scif##index##_resources,	       \
+					  ARRAY_SIZE(scif##index##_resources), \
+					  &scif##index##_platform_data,	       \
+					  sizeof(scif##index##_platform_data))
 
 static const struct sh_timer_config cmt00_platform_data __initconst = {
 	.name = "CMT00",
-- 
1.8.1.5

