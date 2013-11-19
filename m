From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 22/29] ARM: shmobile: r8a7778: Declare SCIF register base and IRQ as resources
Date: Tue, 19 Nov 2013 15:02:23 +0100
Message-ID: <1384869751-9786-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 37ce2df..d492c2c 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -46,12 +46,15 @@
 /* SCIF */
 #define R8A7778_SCIF(index, baseaddr, irq)			\
 static struct plat_sci_port scif##index##_platform_data = {	\
-	.mapbase	= baseaddr,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
 	.scbrr_algo_id	= SCBRR_ALGO_2,				\
 	.type		= PORT_SCIF,				\
-	.irqs		= SCIx_IRQ_MUXED(irq),			\
+};								\
+								\
+static struct resource scif##index##_resources[] = {		\
+	DEFINE_RES_MEM(baseaddr, 0x100),			\
+	DEFINE_RES_IRQ(irq),					\
 }
 
 R8A7778_SCIF(0, 0xffe40000, gic_iid(0x66));
@@ -62,9 +65,11 @@ R8A7778_SCIF(4, 0xffe44000, gic_iid(0x6a));
 R8A7778_SCIF(5, 0xffe45000, gic_iid(0x6b));
 
 #define r8a7778_register_scif(index)					       \
-	platform_device_register_data(&platform_bus, "sh-sci", index,	       \
-				      &scif##index##_platform_data,	       \
-				      sizeof(scif##index##_platform_data))
+	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+					  scif##index##_resources,	       \
+					  ARRAY_SIZE(scif##index##_resources), \
+					  &scif##index##_platform_data,	       \
+					  sizeof(scif##index##_platform_data))
 
 /* TMU */
 static struct resource sh_tmu0_resources[] __initdata = {
-- 
1.8.3.2

