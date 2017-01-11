From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 09/18] sh: Don't set the sh-sci platform data REIE bit when not implemented
Date: Wed, 11 Jan 2017 16:43:31 +0200
Message-ID: <20170111144340.29074-10-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

According to the datasheets, the sh7760 SIM and sh7723 SCIFA instances
don't implement the REIE bit. Don't set it in platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  | 1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index 641b85865a63..0c0cdfc69dcc 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -200,7 +200,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCI,
 	.regshift	= 2,
 };
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 6c5cb234aa33..1c1b3c469831 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -86,7 +86,6 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -107,7 +106,6 @@ static struct platform_device scif3_device = {
 };
 
 static struct plat_sci_port scif4_platform_data = {
-	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
@@ -128,7 +126,6 @@ static struct platform_device scif4_device = {
 };
 
 static struct plat_sci_port scif5_platform_data = {
-	.scscr		= SCSCR_REIE,
 	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
-- 
Regards,

Laurent Pinchart
