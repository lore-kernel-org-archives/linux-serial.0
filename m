From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 25/47] ARM: shmobile: r7s72100: Declare SCIF register base and IRQ as resources
Date: Fri,  6 Dec 2013 10:59:32 +0100
Message-ID: <1386323994-12850-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33750 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757809Ab3LFKA3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Dec 2013 05:00:29 -0500
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r7s72100.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 6ae7e32..81b995b 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -36,9 +36,15 @@ static const struct plat_sci_port scif##index##_platform_data = {	\
 	.scbrr_algo_id	= SCBRR_ALGO_2,					\
 	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |	\
 			  SCSCR_REIE,					\
-	.mapbase	= baseaddr,					\
-	.irqs		= { irq + 1, irq + 2, irq + 3, irq },		\
-}
+};									\
+									\
+static struct resource scif##index##_resources[] = {			\
+	DEFINE_RES_MEM(baseaddr, 0x100),				\
+	DEFINE_RES_IRQ(irq + 1),					\
+	DEFINE_RES_IRQ(irq + 2),					\
+	DEFINE_RES_IRQ(irq + 3),					\
+	DEFINE_RES_IRQ(irq),						\
+}									\
 
 R7S72100_SCIF(0, 0xe8007000, gic_iid(221));
 R7S72100_SCIF(1, 0xe8007800, gic_iid(225));
@@ -50,9 +56,11 @@ R7S72100_SCIF(6, 0xe800a000, gic_iid(245));
 R7S72100_SCIF(7, 0xe800a800, gic_iid(249));
 
 #define r7s72100_register_scif(index)					       \
-	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
-				      &scif##index##_platform_data,	       \
-				      sizeof(scif##index##_platform_data))
+	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+					  scif##index##_resources,	       \
+					  ARRAY_SIZE(scif##index##_resources), \
+					  &scif##index##_platform_data,	       \
+					  sizeof(scif##index##_platform_data))
 
 
 static struct sh_timer_config mtu2_0_platform_data __initdata = {
-- 
1.8.3.2

