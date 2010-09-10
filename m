From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 2/4] x86, earlyprintk: add hsu early console for Intel Medfield platform
Date: Fri, 10 Sep 2010 11:10:18 +0800
Message-ID: <1284088220-12276-2-git-send-email-feng.tang@intel.com>
References: <1284088220-12276-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52575 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532Ab0IJCuU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Sep 2010 22:50:20 -0400
In-Reply-To: <1284088220-12276-1-git-send-email-feng.tang@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com, alan@linux.intel.com, mingo@elte.hu
Cc: Feng Tang <feng.tang@intel.com>, x86 maintainers <x86@kernel.org>

Intel Medfield platform has a high speed UART device, which could act
as a early console. To enable early printk of HSU console, simply add
"earlyprintk=hsu" in kernel command line.

Currently we put the code in the mrst_earlyprintk.c as it is also for
Intel MID platforms like the mrst early console

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: x86 maintainers <x86@kernel.org>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 arch/x86/include/asm/mrst.h        |    1 +
 arch/x86/kernel/early_printk.c     |    3 +
 arch/x86/kernel/mrst_earlyprintk.c |   95 +++++++++++++++++++++++++++++++++++-
 3 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/mrst.h b/arch/x86/include/asm/mrst.h
index 4b891b3..37bae64 100644
--- a/arch/x86/include/asm/mrst.h
+++ b/arch/x86/include/asm/mrst.h
@@ -46,4 +46,5 @@ extern enum mrst_timer_options mrst_timer_options;
 #define SFI_MRTC_MAX	8
 
 extern struct console early_mrst_console;
+extern struct console early_hsu_console;
 #endif /* _ASM_X86_MRST_H */
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 435a070..fd095e7 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -243,6 +243,9 @@ static int __init setup_early_printk(char *buf)
 #ifdef CONFIG_X86_MRST_EARLY_PRINTK
 		if (!strncmp(buf, "mrst", 4))
 			early_console_register(&early_mrst_console, keep);
+
+		if (!strncmp(buf, "hsu", 3))
+			early_console_register(&early_hsu_console, keep);
 #endif
 		buf++;
 	}
diff --git a/arch/x86/kernel/mrst_earlyprintk.c b/arch/x86/kernel/mrst_earlyprintk.c
index 7c29025..c3f5348 100644
--- a/arch/x86/kernel/mrst_earlyprintk.c
+++ b/arch/x86/kernel/mrst_earlyprintk.c
@@ -1,5 +1,5 @@
 /*
- * mrst_earlyprintk.c - spi-uart early printk for Intel Moorestown platform
+ * mrst_earlyprintk.c - early consols for Intel MID platforms
  *
  * Copyright (c) 2009 Intel Corporation
  *
@@ -9,9 +9,19 @@
  * of the License.
  */
 
+/*
+ * This file implements 2 early consoles named: mrst and hsu.
+ * mrst is based on Maxim3110 spi-uart device, it exist in both
+ * Moorestown and Medfield platforms, while hsu is based on a High
+ * Speed UART device which only exist in Medfield platform
+ */
+
+#include <linux/serial_reg.h>
+#include <linux/serial_mfd.h>
 #include <linux/kmsg_dump.h>
 #include <linux/console.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 
@@ -239,3 +249,86 @@ struct console early_mrst_console = {
 	.flags =	CON_PRINTBUFFER,
 	.index =	-1,
 };
+
+/*
+ * Following is the early console based on Medfield HSU(High
+ * Speed UART) device.
+ */
+#define HSU_PORT2_PADDR		0xffa28180
+
+static int hsu_init_done;
+static void __iomem *phsu;
+
+static void early_hsu_init(void)
+{
+	u8 lcr;
+
+	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, HSU_PORT2_PADDR);
+	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
+			(HSU_PORT2_PADDR & (PAGE_SIZE - 1)));
+
+	writeb(0x0, phsu + UART_FCR);
+
+	/* Set to default 115200 */
+	lcr = readb(phsu + UART_LCR);
+	writeb((0x80 | lcr), phsu + UART_LCR);
+	writeb(0x18, phsu + UART_DLL);
+	writeb(lcr,  phsu + UART_LCR);
+	writel(0x3600, phsu + UART_MUL*4);
+
+	writeb(0x8, phsu + UART_MCR);
+	writeb(0x7, phsu + UART_FCR);
+	writeb(0x3, phsu + UART_LCR);
+
+	/* Clear IRQ status */
+	readb(phsu + UART_LSR);
+	readb(phsu + UART_RX);
+	readb(phsu + UART_IIR);
+	readb(phsu + UART_MSR);
+
+	/* Enable FIFO */
+	writeb(0x7, phsu + UART_FCR);
+
+	hsu_init_done = 1;
+}
+
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+
+static void early_hsu_putc(char ch)
+{
+	unsigned int timeout = 10000; /* 10ms */
+	u8 status;
+
+	while (--timeout) {
+		status = readb(phsu + UART_LSR);
+		if (status & BOTH_EMPTY)
+			break;
+		udelay(1);
+	}
+
+	/* Only write the char when timeout doesn't happen */
+	if (timeout)
+		writeb(ch, phsu + UART_TX);
+}
+
+static void early_hsu_write(struct console *con, const char *str, unsigned n)
+{
+	int i;
+
+	if (unlikely(!hsu_init_done))
+		early_hsu_init();
+
+	for (i = 0; i < n && *str; i++) {
+		if (*str == '\n')
+			early_hsu_putc('\r');
+		early_hsu_putc(*str);
+		str++;
+	}
+}
+
+struct console early_hsu_console = {
+	.name =		"earlyhsu",
+	.write =	early_hsu_write,
+	.flags =	CON_PRINTBUFFER,
+	.index =	-1,
+};
-- 
1.7.0.4

