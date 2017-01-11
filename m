From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 04/18] sh: Don't set sh-sci pdata scscr TIE and RIE bits
Date: Wed, 11 Jan 2017 16:43:26 +0200
Message-ID: <20170111144340.29074-5-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The scscr platform data field is used by the driver in three locations.
One of them masks out all bits except SCSCR_REIE. The two other are the
set_termios handler and the console write handler.

The set_termios handler calls sci_start_rx() to enable the receiver,
which sets the RIE bit unconditionally. It then calls sci_port_disable()
that effectively disables both the transmitter and the receiver. The
TIE bit will thus get set later when the serial cores reenables the
serial port.

The console write handler runs with interrupts disabled, and saves and
restores the SCSCR register value. The RIE and TIE bits are thus not
needed there.

The bits are thus not necessary in platform data, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |  8 ++++----
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c | 16 ++++++++--------
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c | 16 ++++++++--------
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |  3 +--
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index d0d1a36d1264..146a7d9a20fd 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -175,7 +175,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7203", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -197,7 +197,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -219,7 +219,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -241,7 +241,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE,
+	.scscr		= SCSCR_REIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index 0d66fd664836..f111c20177ea 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -227,7 +227,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7264", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -252,7 +252,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -277,7 +277,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -302,7 +302,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -327,7 +327,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -352,7 +352,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -377,7 +377,7 @@ static struct platform_device scif5_device = {
 
 static struct plat_sci_port scif6_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -402,7 +402,7 @@ static struct platform_device scif6_device = {
 
 static struct plat_sci_port scif7_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index 26abbfbeb99a..b3445e59841a 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -249,7 +249,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7269", vectors, groups,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -274,7 +274,7 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -299,7 +299,7 @@ static struct platform_device scif1_device = {
 
 static struct plat_sci_port scif2_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -324,7 +324,7 @@ static struct platform_device scif2_device = {
 
 static struct plat_sci_port scif3_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -349,7 +349,7 @@ static struct platform_device scif3_device = {
 
 static struct plat_sci_port scif4_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -374,7 +374,7 @@ static struct platform_device scif4_device = {
 
 static struct plat_sci_port scif5_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -399,7 +399,7 @@ static struct platform_device scif5_device = {
 
 static struct plat_sci_port scif6_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
@@ -424,7 +424,7 @@ static struct platform_device scif6_device = {
 
 static struct plat_sci_port scif7_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_REIE | SCSCR_TOIE,
+	.scscr		= SCSCR_REIE | SCSCR_TOIE,
 	.type		= PORT_SCIF,
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
 };
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index 62b1559dbe99..4f7b4f9b7d02 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -71,7 +71,7 @@ static DECLARE_INTC_DESC(intc_desc, "sh7705", vectors, NULL,
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TIE | SCSCR_RIE | SCSCR_CKE1 | SCSCR_CKE0,
+	.scscr		= SCSCR_CKE1 | SCSCR_CKE0,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
@@ -94,7 +94,6 @@ static struct platform_device scif0_device = {
 
 static struct plat_sci_port scif1_platform_data = {
 	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_TIE | SCSCR_RIE,
 	.type		= PORT_SCIF,
 	.ops		= &sh770x_sci_port_ops,
 	.regtype	= SCIx_SH7705_SCIF_REGTYPE,
-- 
Regards,

Laurent Pinchart

