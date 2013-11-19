From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 18/29] ARM: shmobile: sh73a0: Declare SCIF register base and IRQ as resources
Date: Tue, 19 Nov 2013 15:02:19 +0100
Message-ID: <1384869751-9786-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50405 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab3KSOCG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Nov 2013 09:02:06 -0500
In-Reply-To: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 9c94f34..55ed98f 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -75,16 +75,21 @@ void __init sh73a0_pinmux_init(void)
 #define SH73A0_SCIF(scif_type, index, baseaddr, irq)		\
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= scif_type,				\
-	.mapbase	= baseaddr,				\
 	.flags		= UPF_BOOT_AUTOCONF,			\
-	.irqs		= SCIx_IRQ_MUXED(irq),			\
 	.scbrr_algo_id	= SCBRR_ALGO_4,				\
 	.scscr		= SCSCR_RE | SCSCR_TE,			\
 };								\
 								\
+static struct resource scif##index##_resources[] = {		\
+	DEFINE_RES_MEM(baseaddr, 0x100),			\
+	DEFINE_RES_IRQ(irq),					\
+};								\
+								\
 static struct platform_device scif##index##_device = {		\
 	.name		= "sh-sci",				\
 	.id		= index,				\
+	.resource	= scif##index##_resources,		\
+	.num_resources	= ARRAY_SIZE(scif##index##_resources),	\
 	.dev		= {					\
 		.platform_data	= &scif##index##_platform_data,	\
 	},							\
-- 
1.8.3.2

