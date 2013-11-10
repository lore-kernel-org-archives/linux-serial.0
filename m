From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 23/29] ARM: shmobile: r8a7779: Declare SCIF register base and IRQ as resources
Date: Sun, 10 Nov 2013 04:33:35 +0100
Message-ID: <1384054421-13357-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 79cdb8a..2ca72ff 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -192,16 +192,21 @@ void __init r8a7779_pinmux_init(void)
 #define R8A7779_SCIF(index, baseaddr, irq)			\
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= PORT_SCIF,				\
-	.mapbase	= baseaddr,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
-	.irqs		= SCIx_IRQ_MUXED(irq),			\
 	.scbrr_algo_id	= SCBRR_ALGO_2,				\
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
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
1.8.1.5

