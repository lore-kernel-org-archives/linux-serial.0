From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/4] sh: SH7372 has 6 SCIFA and 1 SCIFB ports
Date: Fri, 21 May 2010 17:49:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005211735080.8450@axis700.grange>
References: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The current SH7372 setup code registers 7 SCIF ports, which is wrong.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/setup-sh7372.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index b2788d0..ba70910 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -37,7 +37,7 @@
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { 80, 80, 80, 80 },
 };
 
@@ -52,7 +52,7 @@ static struct platform_device scif0_device = {
 static struct plat_sci_port scif1_platform_data = {
 	.mapbase	= 0xe6c50000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 81, 81, 81, 81 },
 };
 
@@ -67,7 +67,7 @@ static struct platform_device scif1_device = {
 static struct plat_sci_port scif2_platform_data = {
 	.mapbase	= 0xe6c60000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 82, 82, 82, 82 },
 };
 
@@ -82,7 +82,7 @@ static struct platform_device scif2_device = {
 static struct plat_sci_port scif3_platform_data = {
 	.mapbase	= 0xe6c70000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 83, 83, 83, 83 },
 };
 
@@ -97,7 +97,7 @@ static struct platform_device scif3_device = {
 static struct plat_sci_port scif4_platform_data = {
 	.mapbase	= 0xe6c80000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 89, 89, 89, 89 },
 };
 
@@ -112,7 +112,7 @@ static struct platform_device scif4_device = {
 static struct plat_sci_port scif5_platform_data = {
 	.mapbase	= 0xe6cb0000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs           = { 90, 90, 90, 90 },
 };
 
@@ -127,7 +127,7 @@ static struct platform_device scif5_device = {
 static struct plat_sci_port scif6_platform_data = {
 	.mapbase	= 0xe6c30000,
 	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFB,
 	.irqs           = { 91, 91, 91, 91 },
 };
 
-- 
1.6.2.4

