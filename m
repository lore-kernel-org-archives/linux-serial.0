From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] serial: Add note about migration to driver SCCNXP
Date: Sat, 25 Aug 2012 19:24:20 +0400
Message-ID: <1345908260-6948-2-git-send-email-shc_work@mail.ru>
References: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp12.mail.ru ([94.100.176.89]:42638 "EHLO smtp12.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab2HYPYe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 25 Aug 2012 11:24:34 -0400
In-Reply-To: <1345908260-6948-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This patch adds note about migration to driver SCCNXP in the code
of driver SC26XX and in MIPS SNI board initialization with example.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/mips/sni/a20r.c        |   32 ++++++++++++++++++++++++++++++++
 drivers/tty/serial/sc26xx.c |    3 +++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sni/a20r.c b/arch/mips/sni/a20r.c
index c48194c..b2d4f49 100644
--- a/arch/mips/sni/a20r.c
+++ b/arch/mips/sni/a20r.c
@@ -133,6 +133,38 @@ static struct platform_device sc26xx_pdev = {
 	}
 };
 
+#warning "Please try migrate to use new driver SCCNXP and report the status" \
+	 "in the linux-serial mailing list."
+
+/* The code bellow is a replacement of SC26XX to SCCNXP */
+#if 0
+#include <linux/platform_data/sccnxp.h>
+
+static struct sccnxp_pdata sccnxp_data = {
+	.reg_shift	= 2,
+	.frequency	= 3686400,
+	.mctrl_cfg[0]	= MCTRL_SIG(DTR_OP, LINE_OP7) |
+			  MCTRL_SIG(RTS_OP, LINE_OP3) |
+			  MCTRL_SIG(DSR_IP, LINE_IP5) |
+			  MCTRL_SIG(DCD_IP, LINE_IP6),
+	.mctrl_cfg[1]	= MCTRL_SIG(DTR_OP, LINE_OP2) |
+			  MCTRL_SIG(RTS_OP, LINE_OP1) |
+			  MCTRL_SIG(DSR_IP, LINE_IP0) |
+			  MCTRL_SIG(CTS_IP, LINE_IP1) |
+			  MCTRL_SIG(DCD_IP, LINE_IP2) |
+			  MCTRL_SIG(RNG_IP, LINE_IP3),
+};
+
+static struct platform_device sc2681_pdev = {
+	.name		= "sc2681",
+	.resource	= sc2xxx_rsrc,
+	.num_resources	= ARRAY_SIZE(sc2xxx_rsrc),
+	.dev	= {
+		.platform_data	= &sccnxp_data,
+	},
+};
+#endif
+
 static u32 a20r_ack_hwint(void)
 {
 	u32 status = read_c0_status();
diff --git a/drivers/tty/serial/sc26xx.c b/drivers/tty/serial/sc26xx.c
index e0b4b0a..72589e4 100644
--- a/drivers/tty/serial/sc26xx.c
+++ b/drivers/tty/serial/sc26xx.c
@@ -21,6 +21,9 @@
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 
+#warning "Please try migrate to use new driver SCCNXP and report the status" \
+	 "in the linux-serial mailing list."
+
 #if defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
-- 
1.7.8.6

