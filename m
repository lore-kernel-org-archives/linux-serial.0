From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 12/16] ARM: shmobile: r8a7790: Don't set plat_sci_port scbrr_algo_id field
Date: Thu, 28 Nov 2013 22:43:26 +0100
Message-ID: <1385675010-26904-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35261 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3K1Vnc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 16:43:32 -0500
In-Reply-To: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 70bb553..bb805a4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -78,11 +78,10 @@ void __init r8a7790_pinmux_init(void)
 	r8a7790_register_gpio(5);
 }
 
-#define __R8A7790_SCIF(scif_type, _scscr, algo, index, baseaddr, irq)	\
+#define __R8A7790_SCIF(scif_type, _scscr, index, baseaddr, irq)		\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scbrr_algo_id	= algo,						\
 	.scscr		= _scscr,					\
 };									\
 									\
@@ -93,19 +92,19 @@ static struct resource scif##index##_resources[] = {			\
 
 #define R8A7790_SCIF(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIF, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_2, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_SCIFA(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIFA, SCSCR_RE | SCSCR_TE | SCSCR_CKE0,	\
-		       SCBRR_ALGO_4, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_SCIFB(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIFB, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_4, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_HSCIF(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_HSCIF, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_6, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 R8A7790_SCIFA(0, 0xe6c40000, gic_spi(144)); /* SCIFA0 */
 R8A7790_SCIFA(1, 0xe6c50000, gic_spi(145)); /* SCIFA1 */
-- 
1.8.3.2

