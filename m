From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 26/27] sh: sh7734: Correct SCIF type for BRG
Date: Mon, 14 Dec 2015 19:57:35 +0100
Message-ID: <1450119456-964-27-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The SCIF variant in the sh7734 SoC is not the common "SH-4(A)" variant,
but a derivative with added "Baud Rate Generator for External Clock"
(BRG). Correct the regtype value in platform data to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested due to lack of hardware.
This shouldn't make any difference until the additional clocks are
provided by the platform.

v3:
  - No changes.
---
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index f617bcb734dfeb76..69b8a50310d9a23f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -28,7 +28,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.type           = PORT_SCIF,
-	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
 
 static struct resource scif0_resources[] = {
@@ -50,7 +50,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.type           = PORT_SCIF,
-	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
 
 static struct resource scif1_resources[] = {
@@ -72,7 +72,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.type           = PORT_SCIF,
-	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
 
 static struct resource scif2_resources[] = {
@@ -94,7 +94,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.type           = PORT_SCIF,
-	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
 
 static struct resource scif3_resources[] = {
@@ -116,7 +116,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.type           = PORT_SCIF,
-	.regtype        = SCIx_SH4_SCIF_REGTYPE,
+	.regtype        = SCIx_SH4_SCIF_BRG_REGTYPE,
 };
 
 static struct resource scif4_resources[] = {
@@ -138,7 +138,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
 	.type           = PORT_SCIF,
-	.regtype		= SCIx_SH4_SCIF_REGTYPE,
+	.regtype	= SCIx_SH4_SCIF_BRG_REGTYPE,
 };
 
 static struct resource scif5_resources[] = {
-- 
1.9.1

