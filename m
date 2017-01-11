From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 08/18] sh: Don't set the sh-sci platform data scscr CKE0 bit
Date: Wed, 11 Jan 2017 16:43:30 +0200
Message-ID: <20170111144340.29074-9-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The bit is only set by platforms that also set the CKE1 but, in which
case its value is ignored by the device. Don't set it, this simplifies
platform data and only leaves the CKE1 bit to be handled.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh3/setup-sh7705.c | 2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index a60edd8f3db7..f6e392e0d27e 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -70,7 +70,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7705", vectors, NULL,
 			 NULL, prio_registers, NULL);
 
 static struct plat_sci_port scif0_platform_data = {
-	.scscr		= SCSCR_CKE1 | SCSCR_CKE0,
+	.scscr		= SCSCR_CKE1,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index ac2a0aabcec5..ea52410b430d 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -98,7 +98,7 @@ static struct platform_device rtc_device = {
 };
 
 static struct plat_sci_port scif0_platform_data = {
-	.scscr		= SCSCR_REIE | SCSCR_CKE1 | SCSCR_CKE0,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 };
 
@@ -118,7 +118,7 @@ static struct platform_device scif0_device = {
 };
 
 static struct plat_sci_port scif1_platform_data = {
-	.scscr		= SCSCR_REIE | SCSCR_CKE1 | SCSCR_CKE0,
+	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
 };
 
-- 
Regards,

Laurent Pinchart
