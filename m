From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/5] hsu, earlyprintk: add early printk for hsu_port2 console
Date: Mon, 06 Sep 2010 13:39:28 +0100
Message-ID: <20100906123908.1328.3598.stgit@localhost.localdomain>
References: <20100906123843.1328.3930.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52271 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147Ab0IFNWL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 09:22:11 -0400
In-Reply-To: <20100906123843.1328.3930.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com

From: Feng Tang <feng.tang@intel.com>

To enable early printk of HSU console, simply set "earlyprint=hsu" in
kernel command line.

Currently we put the code in the mrst_earlyprintk.c and it need enable
CONFIG_X86_MRST_EARLY_PRINTK config option

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 arch/x86/include/asm/mrst.h        |    1 
 arch/x86/kernel/early_printk.c     |    3 +
 arch/x86/kernel/mrst_earlyprintk.c |  128 ++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 0 deletions(-)


diff --git a/arch/x86/include/asm/mrst.h b/arch/x86/include/asm/mrst.h
index 704d2fd..b6531da 100644
--- a/arch/x86/include/asm/mrst.h
+++ b/arch/x86/include/asm/mrst.h
@@ -46,5 +46,6 @@ extern enum mrst_timer_options mrst_timer_options;
 #define SFI_MRTC_MAX	8
 
 extern struct console early_mrst_console;
+extern struct console early_hsu_console;
 extern void mrst_early_printk(const char *fmt, ...);
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
index 4aff765..1fb1305 100644
--- a/arch/x86/kernel/mrst_earlyprintk.c
+++ b/arch/x86/kernel/mrst_earlyprintk.c
@@ -9,9 +9,12 @@
  * of the License.
  */
 
+#include <linux/serial_reg.h>
+#include <linux/serial_mfd.h>
 #include <linux/kmsg_dump.h>
 #include <linux/console.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 
@@ -281,3 +284,128 @@ void mrst_early_printk(const char *fmt, ...)
 
 	early_mrst_console.write(&early_mrst_console, buf, n);
 }
+
+
+/* Will use HSU port2 for early console */
+
+/*
+ * Note:
+ * 1. still need GPIO workaround for UART2
+ *
+ */
+static spinlock_t hsu_lock;
+static int hsu_inited;
+static void __iomem *phsu;
+#define HSU_PORT2_PADDR		0xffa28180
+#define MFD_GPIO_HSU_REG	0xff12c064
+
+static void early_hsu_init(void)
+{
+	u8 lcr;
+
+	if (phsu && hsu_inited)
+		return;
+
+	spin_lock_init(&hsu_lock);
+
+	/* GPIO workaround */
+	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, MFD_GPIO_HSU_REG);
+	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
+			(MFD_GPIO_HSU_REG & (PAGE_SIZE - 1)));
+
+	*((u32 *)phsu) = 0x55465;
+
+	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, HSU_PORT2_PADDR);
+	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
+			(HSU_PORT2_PADDR & (PAGE_SIZE - 1)));
+
+	writeb(0x0, phsu + UART_FCR);
+
+	/* set to default 115200 */
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
+	/* clear IRQ status */
+	readb(phsu + UART_LSR);
+	readb(phsu + UART_RX);
+	readb(phsu + UART_IIR);
+	readb(phsu + UART_MSR);
+
+
+
+	writeb(0x7, phsu + UART_FCR);
+
+	hsu_inited = 1;
+}
+
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+static void early_hsu_putc(char ch)
+{
+	unsigned int timeout = 10000; /* 10ms*/
+	u8 status;
+
+	while (timeout--) {
+		status = readb(phsu + UART_LSR);
+		if (status & BOTH_EMPTY)
+			break;
+
+		udelay(1);
+	}
+
+	if (timeout == 0xffffffff)
+		return;
+
+	writeb(ch, phsu + UART_TX);
+}
+
+static void early_hsu_write(struct console *con,
+			const char *str, unsigned n)
+{
+	int  i;
+	unsigned long flags;
+
+	/*
+	printk("%s(): enter\n\n", __func__);
+	*/
+
+	if (unlikely(!hsu_inited))
+		early_hsu_init();
+
+	spin_lock_irqsave(&hsu_lock, flags);
+	for (i = 0; i < n && *str; i++) {
+		if (*str == '\n')
+			early_hsu_putc('\r');
+		early_hsu_putc(*str);
+
+		str++;
+	}
+	spin_unlock_irqrestore(&hsu_lock, flags);
+}
+
+
+struct console early_hsu_console = {
+	.name =		"earlyhsu",
+	.write =	early_hsu_write,
+	.flags =	CON_PRINTBUFFER,
+	.index =	-1,
+};
+
+void hsu_early_printk(const char *fmt, ...)
+{
+	char buf[512];
+	int n;
+	va_list ap;
+
+	va_start(ap, fmt);
+	n = vscnprintf(buf, 512, fmt, ap);
+	va_end(ap);
+
+	early_hsu_console.write(&early_mrst_console, buf, n);
+}

