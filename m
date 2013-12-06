From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 23/47] ARM: shmobile: sh7372: Declare SCIF register base and IRQ as resources
Date: Fri,  6 Dec 2013 10:59:30 +0100
Message-ID: <1386323994-12850-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 77627dd..798f8ac 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -90,16 +90,21 @@ void __init sh7372_pinmux_init(void)
 #define SH7372_SCIF(scif_type, index, baseaddr, irq)		\
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

