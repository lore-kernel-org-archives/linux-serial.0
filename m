From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 13/16] ARM: shmobile: r8a7791: Don't set plat_sci_port scbrr_algo_id field
Date: Thu, 28 Nov 2013 22:43:27 +0100
Message-ID: <1385675010-26904-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35260 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab3K1Vnd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 16:43:33 -0500
In-Reply-To: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7791.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index f15b537..e28404e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -84,11 +84,10 @@ void __init r8a7791_pinmux_init(void)
 	r8a7791_register_gpio(7);
 }
 
-#define __R8A7791_SCIF(scif_type, algo, index, baseaddr, irq)		\
+#define __R8A7791_SCIF(scif_type, index, baseaddr, irq)			\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scbrr_algo_id	= algo,						\
 	.scscr		= SCSCR_RE | SCSCR_TE,				\
 };									\
 									\
@@ -98,13 +97,13 @@ static struct resource scif##index##_resources[] = {			\
 }
 
 #define R8A7791_SCIF(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIF, SCBRR_ALGO_2, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIF, index, baseaddr, irq)
 
 #define R8A7791_SCIFA(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIFA, SCBRR_ALGO_4, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIFA, index, baseaddr, irq)
 
 #define R8A7791_SCIFB(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIFB, SCBRR_ALGO_4, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIFB, index, baseaddr, irq)
 
 R8A7791_SCIFA(0,  0xe6c40000, gic_spi(144)); /* SCIFA0 */
 R8A7791_SCIFA(1,  0xe6c50000, gic_spi(145)); /* SCIFA1 */
-- 
1.8.3.2

