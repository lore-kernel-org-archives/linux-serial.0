From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 05/19] sh: sh726[49]: Don't set sh-sci pdata scscr TOIE bit
Date: Wed,  4 Jan 2017 01:06:25 +0200
Message-ID: <20170103230639.19660-6-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The SCIF ports on sh7264 and sh7269 don't support the TOIE bit according
to the datasheets.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c | 16 ++++++++--------
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index f111c20177ea..aebaa7a4da46 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -227,7 +227,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7264", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -252,7 +252,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -277,7 +277,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -302,7 +302,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -327,7 +327,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -352,7 +352,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -377,7 +377,7 @@ static struct platform_device scif5_device = {
 
 static struct plat_sci_port scif6_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -402,7 +402,7 @@ static struct platform_device scif6_device = {
 
 static struct plat_sci_port scif7_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index b3445e59841a..6d7ac07b4e54 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -249,7 +249,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7269", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -274,7 +274,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -299,7 +299,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -324,7 +324,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -349,7 +349,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -374,7 +374,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -399,7 +399,7 @@ static struct platform_device scif5_device = {
 
 static struct plat_sci_port scif6_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -424,7 +424,7 @@ static struct platform_device scif6_device = {
 
 static struct plat_sci_port scif7_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
-- 
Regards,

Laurent Pinchart
