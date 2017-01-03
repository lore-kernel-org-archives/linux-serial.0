From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 07/19] sh: Don't set sh-sci port_reg
Date: Wed,  4 Jan 2017 01:06:27 +0200
Message-ID: <20170103230639.19660-8-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The driver considers all negative or zero values of the port_reg field
as invalid. The four platforms that set the field to a register address
all use an address higher than 0x7fffffff, which is thus considered by
the driver as invalid. The feature is thus never used, remove it.

The feature could be implemented properly in the future using the
pinctrl and GPIO APIs if desired.

While at it, don't set the field to SCIx_NOT_SUPPORTED (-1) either,
leaving it unset leads to the same result. This will allow removing the
SCIx_NOT_SUPPORTED macro.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  | 2 --
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  | 1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c | 1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c | 6 ------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 6 ------
 5 files changed, 16 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index e64fe24d860c..e1e54258b822 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -109,7 +109,6 @@ static struct platform_device rtc_device = {
 };
 
 static struct plat_sci_port scif0_platform_data = {
-	.port_reg	= 0xa4000136,
 	.type		= PORT_SCI,
 	.ops		= &sh770x_sci_port_ops,
 	.regshift	= 1,
@@ -156,7 +155,6 @@ static struct platform_device scif1_device = {
 #if defined(CONFIG_CPU_SUBTYPE_SH7707) || \
     defined(CONFIG_CPU_SUBTYPE_SH7709)
 static struct plat_sci_port scif2_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.type		= PORT_IRDA,
 	.ops		= &sh770x_sci_port_ops,
 	.regshift	= 1,
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index f693f122a286..d98a55416306 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -38,7 +38,6 @@ static struct platform_device rtc_device = {
 };
 
 static struct plat_sci_port sci_platform_data = {
-	.port_reg	= 0xffe0001C,
 	.type		= PORT_SCI,
 	.regshift	= 2,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 3fc1a3ab634e..646918713d9a 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -20,7 +20,6 @@
 #include <asm/clock.h>
 
 static struct plat_sci_port scif0_platform_data = {
-	.port_reg	= 0xa405013e,
 	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 9f47ec950af8..6c5cb234aa33 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -23,7 +23,6 @@
 
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
-	.port_reg	= 0xa4050160,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -45,7 +44,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -67,7 +65,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -89,7 +86,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
@@ -111,7 +107,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
@@ -133,7 +128,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 3ce55884c787..c20258b18775 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -290,7 +290,6 @@ static struct platform_device dma1_device = {
 
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -312,7 +311,6 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -334,7 +332,6 @@ static struct platform_device scif1_device = {
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_REIE,
 	.type           = PORT_SCIF,
 	.regtype	= SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
@@ -356,7 +353,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -377,7 +373,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -398,7 +393,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.port_reg	= SCIx_NOT_SUPPORTED,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
-- 
Regards,

Laurent Pinchart

