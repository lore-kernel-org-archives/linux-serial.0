From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 03/18] sh: Don't set sh-sci pdata scscr TE and RE bits
Date: Wed, 11 Jan 2017 16:43:25 +0200
Message-ID: <20170111144340.29074-4-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The bits are set by the driver internally, don't set them in platform
data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |  6 +++---
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c | 16 ++++++++--------
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c | 12 ++++--------
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |  8 ++++----
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c | 24 ++++++++----------------
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c | 24 ++++++++----------------
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |  5 ++---
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |  3 ---
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |  6 ++----
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |  2 --
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |  2 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |  3 +--
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |  8 ++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |  8 ++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  6 +++---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c | 12 ++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  9 +++------
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c | 12 ++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  6 +++---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |  6 +++---
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c | 20 ++++++++++----------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |  4 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c | 12 ++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 12 ++++++------
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |  6 +++---
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |  2 +-
 28 files changed, 103 insertions(+), 135 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index 58c19adae900..f8a77bdad0a6 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -62,7 +62,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, NULL,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -83,7 +83,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -104,7 +104,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
index 26fcdbd4127a..fc6f0677888d 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -130,7 +130,7 @@ static struct platform_device mtu2_device = {
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
index abc0ce9fb800..5b5a67082207 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -179,7 +179,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7201", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -200,7 +200,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -221,7 +221,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -242,7 +242,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -263,7 +263,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -284,7 +284,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -305,7 +305,7 @@ static struct platform_device scif5_device = {
 
 static struct plat_sci_port scif6_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -326,7 +326,7 @@ static struct platform_device scif6_device = {
 
 static struct plat_sci_port scif7_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index 3b4894cba92f..d0d1a36d1264 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -175,8 +175,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7203", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -198,8 +197,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -221,8 +219,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -244,8 +241,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
index 49bc5a34bec1..c540fb8c9e09 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -135,7 +135,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7206", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -156,7 +156,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -177,7 +177,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -198,7 +198,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index 608146455562..0d66fd664836 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -227,8 +227,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7264", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -253,8 +252,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -279,8 +277,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -305,8 +302,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -331,8 +327,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -357,8 +352,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -383,8 +377,7 @@ static struct platform_device scif5_device = {
 
 static struct plat_sci_port scif6_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -409,8 +402,7 @@ static struct platform_device scif6_device = {
 
 static struct plat_sci_port scif7_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index 16ce5aa77bdd..26abbfbeb99a 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -249,8 +249,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7269", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -275,8 +274,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -301,8 +299,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -327,8 +324,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -353,8 +349,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -379,8 +374,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -405,8 +399,7 @@ static struct platform_device scif5_device = {
 
 static struct plat_sci_port scif6_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -431,8 +424,7 @@ static struct platform_device scif6_device = {
 
 static struct plat_sci_port scif7_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
-			  SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index 6a72fd14de21..62b1559dbe99 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -71,8 +71,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7705", vectors, NULL,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TIE | SCSCR_RIE  | SCSCR_TE |
-			  SCSCR_RE  | SCSCR_CKE1 | SCSCR_CKE0,
+	.scscr		= SCSCR_TIE | SCSCR_RIE | SCSCR_CKE1 | SCSCR_CKE0,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
@@ -95,7 +94,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TIE | SCSCR_RIE | SCSCR_TE | SCSCR_RE,
+	.scscr		= SCSCR_TIE | SCSCR_RIE,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 538c10db3537..06682ae414e2 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -111,7 +111,6 @@ static struct platform_device rtc_device = {
 static struct plat_sci_port scif0_platform_data = {
 	.port_reg	= 0xa4000136,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TE | SCSCR_RE,
 	.type		= PORT_SCI,
 	.ops		= &sh770x_sci_port_ops,
 	.regshift	= 1,
@@ -136,7 +135,6 @@ static struct platform_device scif0_device = {
     defined(CONFIG_CPU_SUBTYPE_SH7709)
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TE | SCSCR_RE,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH3_SCIF_REGTYPE,
@@ -162,7 +160,6 @@ static struct platform_device scif1_device = {
 static struct plat_sci_port scif2_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TE | SCSCR_RE,
 	.type		= PORT_IRDA,
 	.ops		= &sh770x_sci_port_ops,
 	.regshift	= 1,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index e9ed300dba5c..6347f9625ed1 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -99,8 +99,7 @@ static struct platform_device rtc_device = {
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TE | SCSCR_RE | SCSCR_REIE |
-			  SCSCR_CKE1 | SCSCR_CKE0,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1 | SCSCR_CKE0,
 	.type		= PORT_SCIF,
 };
 
@@ -121,8 +120,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TE | SCSCR_RE | SCSCR_REIE |
-			  SCSCR_CKE1 | SCSCR_CKE0,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1 | SCSCR_CKE0,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
index 84df85a5b800..d35400c76db7 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -53,7 +53,6 @@ static struct platform_device rtc_device = {
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
 	.type		= PORT_SCIF,
 	.ops		= &sh7720_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
@@ -76,7 +75,6 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
 	.type		= PORT_SCIF,
 	.ops		= &sh7720_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
index e7a7b3cdf68d..fa5f8e7b8150 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
@@ -18,7 +18,7 @@
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 5f08c59b9f3e..9baabdaa214e 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -40,7 +40,6 @@ static struct platform_device rtc_device = {
 static struct plat_sci_port sci_platform_data = {
 	.port_reg	= 0xffe0001C,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TE | SCSCR_RE,
 	.type		= PORT_SCI,
 	.regshift	= 2,
 };
@@ -62,7 +61,7 @@ static struct platform_device sci_device = {
 
 static struct plat_sci_port scif_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TE | SCSCR_RE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index 973b736b3b98..c94a8f746013 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -129,7 +129,7 @@ static DECLARE_INTC_DESC(intc_desc_irq, "sh7760-irq", vectors_irq, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -155,7 +155,7 @@ static struct platform_device scif0_device = {
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
 
@@ -179,7 +179,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -204,7 +204,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCI,
 	.regshift	= 2,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index ceb3dedad983..9de7dc2f3c24 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -19,7 +19,7 @@
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scscr		= SCSCR_CKE1,
 	.type           = PORT_SCIF,
 };
 
@@ -40,7 +40,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scscr		= SCSCR_CKE1,
 	.type           = PORT_SCIF,
 };
 
@@ -61,7 +61,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scscr		= SCSCR_CKE1,
 	.type           = PORT_SCIF,
 };
 
@@ -82,7 +82,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scscr		= SCSCR_CKE1,
 	.type           = PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index f75f67343139..d9a8f242e148 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -22,7 +22,7 @@
 static struct plat_sci_port scif0_platform_data = {
 	.port_reg	= 0xa405013e,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 7aa733307afc..7d41261c5f67 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -180,7 +180,7 @@ struct platform_device dma_device = {
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.ops		= &sh7722_sci_port_ops,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -203,7 +203,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.ops		= &sh7722_sci_port_ops,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -226,7 +226,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.ops		= &sh7722_sci_port_ops,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 3533b56dd465..610571f174ee 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -25,7 +25,7 @@
 static struct plat_sci_port scif0_platform_data = {
 	.port_reg	= 0xa4050160,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
@@ -48,7 +48,7 @@ static struct platform_device scif0_device = {
 static struct plat_sci_port scif1_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
@@ -71,7 +71,7 @@ static struct platform_device scif1_device = {
 static struct plat_sci_port scif2_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
@@ -94,7 +94,7 @@ static struct platform_device scif2_device = {
 static struct plat_sci_port scif3_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
 	.port_reg	= SCIx_NOT_SUPPORTED,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -117,7 +117,7 @@ static struct platform_device scif3_device = {
 static struct plat_sci_port scif4_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -140,7 +140,7 @@ static struct platform_device scif4_device = {
 static struct plat_sci_port scif5_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index ea5780b3c7f6..478a61f73b47 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -292,7 +292,7 @@ static struct platform_device dma1_device = {
 static struct plat_sci_port scif0_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
@@ -315,7 +315,7 @@ static struct platform_device scif0_device = {
 static struct plat_sci_port scif1_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
@@ -338,7 +338,7 @@ static struct platform_device scif1_device = {
 static struct plat_sci_port scif2_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
 };
@@ -361,7 +361,6 @@ static struct platform_device scif2_device = {
 static struct plat_sci_port scif3_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -384,7 +383,6 @@ static struct platform_device scif3_device = {
 static struct plat_sci_port scif4_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -407,7 +405,6 @@ static struct platform_device scif4_device = {
 static struct plat_sci_port scif5_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 69b8a50310d9..51910a8d8df4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -26,7 +26,7 @@
 /* SCIF */
 static struct plat_sci_port scif0_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
@@ -48,7 +48,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
@@ -70,7 +70,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
@@ -92,7 +92,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr          = SCSCR_REIE | SCSCR_TOIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
@@ -114,7 +114,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
@@ -136,7 +136,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_BRG_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 18bcd70cd813..b44061cb8540 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -25,7 +25,7 @@
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -46,7 +46,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -67,7 +67,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 5a47d670ddec..428c16526dcb 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -20,7 +20,7 @@
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -42,7 +42,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -64,7 +64,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
index e9b532a76c37..b2d3206e2704 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
@@ -17,7 +17,7 @@
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -38,7 +38,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -59,7 +59,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -80,7 +80,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -101,7 +101,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -122,7 +122,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -143,7 +143,7 @@ static struct platform_device scif5_device = {
 
 static struct plat_sci_port scif6_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -164,7 +164,7 @@ static struct platform_device scif6_device = {
 
 static struct plat_sci_port scif7_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -185,7 +185,7 @@ static struct platform_device scif7_device = {
 
 static struct plat_sci_port scif8_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
@@ -206,7 +206,7 @@ static struct platform_device scif8_device = {
 
 static struct plat_sci_port scif9_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 3ee7dd9b3a65..59282f760ca9 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -19,7 +19,7 @@
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -41,7 +41,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index c72d5a5d0995..22893c0f1662 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -21,7 +21,7 @@
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -43,7 +43,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -65,7 +65,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -87,7 +87,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -109,7 +109,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -131,7 +131,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 479e79bdd3d0..32525e13aa26 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -29,7 +29,7 @@
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -57,7 +57,7 @@ static struct platform_device scif0_device = {
  */
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -88,7 +88,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -110,7 +110,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -132,7 +132,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
@@ -154,7 +154,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_CKE1,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index a78c5feb4e3b..5495d6693086 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -29,7 +29,7 @@
  */
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -53,7 +53,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
@@ -77,7 +77,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/setup-sh5.c
index 1bf0b2cf6652..5ce34bfd0b4e 100644
--- a/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/setup-sh5.c
@@ -18,7 +18,7 @@
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
-	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
 
-- 
Regards,

Laurent Pinchart
