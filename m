From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 06/19] sh: Don't set the sh-sci pdata UPF_BOOT_AUTOCONF flags
Date: Wed,  4 Jan 2017 01:06:26 +0200
Message-ID: <20170103230639.19660-7-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The flag is set by the driver internally, don't set it in platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |  3 ---
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |  1 -
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |  8 --------
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |  4 ----
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |  4 ----
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |  8 --------
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |  8 --------
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |  2 --
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |  3 ---
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |  2 --
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |  2 --
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |  1 -
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |  2 --
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |  4 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |  4 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  3 ---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  6 ------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  6 ------
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |  6 ------
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  3 ---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |  3 ---
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c | 10 ----------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |  2 --
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  6 ------
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  6 ------
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |  3 ---
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |  2 +-
 28 files changed, 1 insertion(+), 112 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index f8a77bdad0a6..95796ad00fbe 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -61,7 +61,6 @@ static DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, NULL,
 			 NULL, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -82,7 +81,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -103,7 +101,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
index fc6f0677888d..060fdd369f09 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -129,7 +129,6 @@ static struct platform_device mtu2_device = {
 };
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
index 5b5a67082207..c1301f68d3cd 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -178,7 +178,6 @@ static DECLARE_INTC_DESC(intc_desc, "sh7201", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -199,7 +198,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -220,7 +218,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -241,7 +238,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -262,7 +258,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -283,7 +278,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -304,7 +298,6 @@ static struct platform_device scif5_device = {
 };
 
 static struct plat_sci_port scif6_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -325,7 +318,6 @@ static struct platform_device scif6_device = {
 };
 
 static struct plat_sci_port scif7_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index 146a7d9a20fd..32ec732e28e5 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -174,7 +174,6 @@ static DECLARE_INTC_DESC(intc_desc, "sh7203", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -196,7 +195,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -218,7 +216,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -240,7 +237,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
index c540fb8c9e09..8d8d354851ce 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -134,7 +134,6 @@ static DECLARE_INTC_DESC(intc_desc, "sh7206", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -155,7 +154,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -176,7 +174,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -197,7 +194,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index aebaa7a4da46..ab71eab690fd 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -226,7 +226,6 @@ static DECLARE_INTC_DESC(intc_desc, "sh7264", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -251,7 +250,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -276,7 +274,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -301,7 +298,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -326,7 +322,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -351,7 +346,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -376,7 +370,6 @@ static struct platform_device scif5_device = {
 };
 
 static struct plat_sci_port scif6_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -401,7 +394,6 @@ static struct platform_device scif6_device = {
 };
 
 static struct plat_sci_port scif7_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index 6d7ac07b4e54..c7e81b20967c 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -248,7 +248,6 @@ static DECLARE_INTC_DESC(intc_desc, "sh7269", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -273,7 +272,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -298,7 +296,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -323,7 +320,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -348,7 +344,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -373,7 +368,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -398,7 +392,6 @@ static struct platform_device scif5_device = {
 };
 
 static struct plat_sci_port scif6_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
@@ -423,7 +416,6 @@ static struct platform_device scif6_device = {
 };
 
 static struct plat_sci_port scif7_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index 4f7b4f9b7d02..a60edd8f3db7 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -70,7 +70,6 @@ static DECLARE_INTC_DESC(intc_desc, "sh7705", vectors, NULL,
 			 NULL, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_CKE1 | SCSCR_CKE0,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
@@ -93,7 +92,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 06682ae414e2..e64fe24d860c 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -110,7 +110,6 @@ static struct platform_device rtc_device = {
 
 static struct plat_sci_port scif0_platform_data = {
 	.port_reg	= 0xa4000136,
-	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCI,
 	.ops		= &sh770x_sci_port_ops,
 	.regshift	= 1,
@@ -134,7 +133,6 @@ static struct platform_device scif0_device = {
     defined(CONFIG_CPU_SUBTYPE_SH7707) || \
     defined(CONFIG_CPU_SUBTYPE_SH7709)
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH3_SCIF_REGTYPE,
@@ -159,7 +157,6 @@ static struct platform_device scif1_device = {
     defined(CONFIG_CPU_SUBTYPE_SH7709)
 static struct plat_sci_port scif2_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_IRDA,
 	.ops		= &sh770x_sci_port_ops,
 	.regshift	= 1,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index 6347f9625ed1..ac2a0aabcec5 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -98,7 +98,6 @@ static struct platform_device rtc_device = {
 };
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1 | SCSCR_CKE0,
 	.type		= PORT_SCIF,
 };
@@ -119,7 +118,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1 | SCSCR_CKE0,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
index d35400c76db7..bf34b4e2e9ef 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -52,7 +52,6 @@ static struct platform_device rtc_device = {
 };
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
 	.ops		= &sh7720_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
@@ -74,7 +73,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
 	.ops		= &sh7720_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
index fa5f8e7b8150..2623f820d510 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
@@ -17,7 +17,6 @@
 #include <linux/io.h>
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 9baabdaa214e..f693f122a286 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -39,7 +39,6 @@ static struct platform_device rtc_device = {
 
 static struct plat_sci_port sci_platform_data = {
 	.port_reg	= 0xffe0001C,
-	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCI,
 	.regshift	= 2,
 };
@@ -60,7 +59,6 @@ static struct platform_device sci_device = {
 };
 
 static struct plat_sci_port scif_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index c94a8f746013..641b85865a63 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -128,7 +128,6 @@ static DECLARE_INTC_DESC(intc_desc_irq, "sh7760-irq", vectors_irq, groups,
 			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -153,7 +152,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
 	.scscr		= SCSCR_REIE,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -178,7 +176,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -203,7 +200,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCI,
 	.regshift	= 2,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index 9de7dc2f3c24..5788073a7c30 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -18,7 +18,6 @@
 
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_CKE1,
 	.type           = PORT_SCIF,
 };
@@ -39,7 +38,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_CKE1,
 	.type           = PORT_SCIF,
 };
@@ -60,7 +58,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_CKE1,
 	.type           = PORT_SCIF,
 };
@@ -81,7 +78,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_CKE1,
 	.type           = PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index d9a8f242e148..3fc1a3ab634e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -21,7 +21,6 @@
 
 static struct plat_sci_port scif0_platform_data = {
 	.port_reg	= 0xa405013e,
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 7d41261c5f67..6b3a26e61abb 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -179,7 +179,6 @@ struct platform_device dma_device = {
 
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.ops		= &sh7722_sci_port_ops,
@@ -202,7 +201,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.ops		= &sh7722_sci_port_ops,
@@ -225,7 +223,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.ops		= &sh7722_sci_port_ops,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 610571f174ee..9f47ec950af8 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -24,7 +24,6 @@
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
 	.port_reg	= 0xa4050160,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -47,7 +46,6 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -70,7 +68,6 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -92,7 +89,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
@@ -116,7 +112,6 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
@@ -139,7 +134,6 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 478a61f73b47..3ce55884c787 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -291,7 +291,6 @@ static struct platform_device dma1_device = {
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -314,7 +313,6 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -337,7 +335,6 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -360,7 +357,6 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -382,7 +378,6 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -404,7 +399,6 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.flags          = UPF_BOOT_AUTOCONF,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 51910a8d8df4..8c0c9da6b5b3 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -25,7 +25,6 @@
 
 /* SCIF */
 static struct plat_sci_port scif0_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
@@ -47,7 +46,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
@@ -69,7 +67,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
@@ -91,7 +88,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_REIE | SCSCR_TOIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
@@ -113,7 +109,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
@@ -135,7 +130,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_BRG_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index b44061cb8540..a46a19b49e08 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -24,7 +24,6 @@
 #include <cpu/sh7757.h>
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -45,7 +44,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -66,7 +64,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 428c16526dcb..40e6cda914d3 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -19,7 +19,6 @@
 #include <linux/usb/ohci_pdriver.h>
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -41,7 +40,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -63,7 +61,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
index b2d3206e2704..82e3bdf2e1b6 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
@@ -16,7 +16,6 @@
 #include <linux/io.h>
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -37,7 +36,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -58,7 +56,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -79,7 +76,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -100,7 +96,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -121,7 +116,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -142,7 +136,6 @@ static struct platform_device scif5_device = {
 };
 
 static struct plat_sci_port scif6_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -163,7 +156,6 @@ static struct platform_device scif6_device = {
 };
 
 static struct plat_sci_port scif7_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -184,7 +176,6 @@ static struct platform_device scif7_device = {
 };
 
 static struct plat_sci_port scif8_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
@@ -205,7 +196,6 @@ static struct platform_device scif8_device = {
 };
 
 static struct plat_sci_port scif9_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 59282f760ca9..d90ff67a4633 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -18,7 +18,6 @@
 #include <cpu/dma-register.h>
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -40,7 +39,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 22893c0f1662..b0d6f82f2d71 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -20,7 +20,6 @@
 #include <cpu/dma-register.h>
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -42,7 +41,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -64,7 +62,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -86,7 +83,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -108,7 +104,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -130,7 +125,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 32525e13aa26..17aac38a6e90 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -28,7 +28,6 @@
 #include <asm/mmzone.h>
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -56,7 +55,6 @@ static struct platform_device scif0_device = {
  * The rest of these all have multiplexed IRQs
  */
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -87,7 +85,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -109,7 +106,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -131,7 +127,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
@@ -153,7 +148,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index 5495d6693086..ee14d92d840f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -28,7 +28,6 @@
  * all rather than adding infrastructure to hack around it.
  */
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -52,7 +51,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
@@ -76,7 +74,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/setup-sh5.c
index 5ce34bfd0b4e..084a9cc99175 100644
--- a/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/setup-sh5.c
@@ -17,7 +17,7 @@
 #include <asm/addrspace.h>
 
 static struct plat_sci_port scif0_platform_data = {
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.flags		= UPF_IOREMAP,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
-- 
Regards,

Laurent Pinchart
