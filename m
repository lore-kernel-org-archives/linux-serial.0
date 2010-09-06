From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/5] mrst_earlyprintk: add a kmsg_dumper to dump the printk
	buffer when panic
Date: Mon, 06 Sep 2010 13:39:01 +0100
Message-ID: <20100906123843.1328.3930.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23748 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147Ab0IFNVo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 09:21:44 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com

From: Feng Tang <feng.tang@intel.com>

As normal max3110 console can't work during panic case, add a helper
function which make debug easier

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 arch/x86/Kconfig                   |   18 ++
 arch/x86/Kconfig.debug             |    4 +
 arch/x86/include/asm/mrst.h        |    5 +
 arch/x86/kernel/Makefile           |    1 
 arch/x86/kernel/early_printk.c     |    5 +
 arch/x86/kernel/mrst_earlyprintk.c |  283 ++++++++++++++++++++++++++++++++++++
 6 files changed, 311 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/kernel/mrst_earlyprintk.c


diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 162d1aa..97d3016 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -420,6 +420,14 @@ config X86_MRST
 	  nor standard legacy replacement devices/features. e.g. Moorestown does
 	  not contain i8259, i8254, HPET, legacy BIOS, most of the io ports.
 
+config MRST_SPI_UART_BOOT_MSG
+	def_bool y
+	prompt "Moorestown SPI UART boot message"
+	depends on (X86_MRST && X86_32)
+	help
+	  Enable this to see boot message during protected mode boot phase, such as
+	  kernel decompression, BAUD rate is set at 115200 8n1
+
 config X86_RDC321X
 	bool "RDC R-321x SoC"
 	depends on X86_32
@@ -630,11 +638,11 @@ config APB_TIMER
        def_bool y if MRST
        prompt "Langwell APB Timer Support" if X86_MRST
        help
-         APB timer is the replacement for 8254, HPET on X86 MID platforms.
-         The APBT provides a stable time base on SMP
-         systems, unlike the TSC, but it is more expensive to access,
-         as it is off-chip. APB timers are always running regardless of CPU
-         C states, they are used as per CPU clockevent device when possible.
+		APB timer is the replacement for 8254, HPET on X86 MID platforms.
+		The APBT provides a stable time base on SMP
+		systems, unlike the TSC, but it is more expensive to access,
+		as it is off-chip. APB timers are always running regardless of CPU
+		C states, they are used as per CPU clockevent device when possible.
 
 # Mark as embedded because too many people got it wrong.
 # The code disables itself when not needed.
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 7f15308..3e104d1 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -43,6 +43,10 @@ config EARLY_PRINTK
 	  with klogd/syslogd or the X server. You should normally N here,
 	  unless you want to debug such a crash.
 
+config X86_MRST_EARLY_PRINTK
+	bool "Early printk for MRST platform support"
+	depends on EARLY_PRINTK && X86_MRST
+
 config EARLY_PRINTK_DBGP
 	bool "Early printk via EHCI debug port"
 	depends on EARLY_PRINTK && PCI
diff --git a/arch/x86/include/asm/mrst.h b/arch/x86/include/asm/mrst.h
index 1635074..704d2fd 100644
--- a/arch/x86/include/asm/mrst.h
+++ b/arch/x86/include/asm/mrst.h
@@ -10,6 +10,9 @@
  */
 #ifndef _ASM_X86_MRST_H
 #define _ASM_X86_MRST_H
+
+#include <linux/sfi.h>
+
 extern int pci_mrst_init(void);
 int __init sfi_parse_mrtc(struct sfi_table_header *table);
 
@@ -42,4 +45,6 @@ extern enum mrst_timer_options mrst_timer_options;
 #define SFI_MTMR_MAX_NUM 8
 #define SFI_MRTC_MAX	8
 
+extern struct console early_mrst_console;
+extern void mrst_early_printk(const char *fmt, ...);
 #endif /* _ASM_X86_MRST_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 11a9925..e0a8357 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault_32.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_X86_MRST_EARLY_PRINTK)	+= mrst_earlyprintk.o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_APB_TIMER)		+= apb_timer.o
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index fa99bae..435a070 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -14,6 +14,7 @@
 #include <xen/hvc-console.h>
 #include <asm/pci-direct.h>
 #include <asm/fixmap.h>
+#include <asm/mrst.h>
 #include <asm/pgtable.h>
 #include <linux/usb/ehci_def.h>
 
@@ -239,6 +240,10 @@ static int __init setup_early_printk(char *buf)
 		if (!strncmp(buf, "xen", 3))
 			early_console_register(&xenboot_console, keep);
 #endif
+#ifdef CONFIG_X86_MRST_EARLY_PRINTK
+		if (!strncmp(buf, "mrst", 4))
+			early_console_register(&early_mrst_console, keep);
+#endif
 		buf++;
 	}
 	return 0;
diff --git a/arch/x86/kernel/mrst_earlyprintk.c b/arch/x86/kernel/mrst_earlyprintk.c
new file mode 100644
index 0000000..4aff765
--- /dev/null
+++ b/arch/x86/kernel/mrst_earlyprintk.c
@@ -0,0 +1,283 @@
+/*
+ * mrst_earlyprintk.c - spi-uart early printk for Intel Moorestown platform
+ *
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#include <linux/kmsg_dump.h>
+#include <linux/console.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/fixmap.h>
+#include <asm/pgtable.h>
+#include <asm/mrst.h>
+
+#define MRST_SPI_TIMEOUT	0x200000
+#define MRST_REGBASE_SPI0	0xff128000
+#define MRST_REGBASE_SPI1	0xff128400
+#define MRST_CLK_SPI0_REG	0xff11d86c
+
+/* Bit fields in CTRLR0 */
+#define SPI_DFS_OFFSET			0
+
+#define SPI_FRF_OFFSET			4
+#define SPI_FRF_SPI			0x0
+#define SPI_FRF_SSP			0x1
+#define SPI_FRF_MICROWIRE		0x2
+#define SPI_FRF_RESV			0x3
+
+#define SPI_MODE_OFFSET			6
+#define SPI_SCPH_OFFSET			6
+#define SPI_SCOL_OFFSET			7
+#define SPI_TMOD_OFFSET			8
+#define	SPI_TMOD_TR			0x0		/* xmit & recv */
+#define SPI_TMOD_TO			0x1		/* xmit only */
+#define SPI_TMOD_RO			0x2		/* recv only */
+#define SPI_TMOD_EPROMREAD		0x3		/* eeprom read mode */
+
+#define SPI_SLVOE_OFFSET		10
+#define SPI_SRL_OFFSET			11
+#define SPI_CFS_OFFSET			12
+
+/* Bit fields in SR, 7 bits */
+#define SR_MASK				0x7f		/* cover 7 bits */
+#define SR_BUSY				(1 << 0)
+#define SR_TF_NOT_FULL			(1 << 1)
+#define SR_TF_EMPT			(1 << 2)
+#define SR_RF_NOT_EMPT			(1 << 3)
+#define SR_RF_FULL			(1 << 4)
+#define SR_TX_ERR			(1 << 5)
+#define SR_DCOL				(1 << 6)
+
+
+struct dw_spi_reg {
+	u32	ctrl0;
+	u32	ctrl1;
+	u32	ssienr;
+	u32	mwcr;
+	u32	ser;
+	u32	baudr;
+	u32	txfltr;
+	u32	rxfltr;
+	u32	txflr;
+	u32	rxflr;
+	u32	sr;
+	u32	imr;
+	u32	isr;
+	u32	risr;
+	u32	txoicr;
+	u32	rxoicr;
+	u32	rxuicr;
+	u32	msticr;
+	u32	icr;
+	u32	dmacr;
+	u32	dmatdlr;
+	u32	dmardlr;
+	u32	idr;
+	u32	version;
+	u32	dr;		/* Currently oper as 32 bits,
+				   though only low 16 bits matters */
+} __packed;
+
+#define dw_readl(dw, name) \
+	__raw_readl(&dw->name)
+#define dw_writel(dw, name, val) \
+	__raw_writel((val), &dw->name)
+
+/* default use SPI0 register for mrst, we will detect Penwell and use SPI1*/
+static unsigned long mrst_spi_paddr = MRST_REGBASE_SPI0;
+
+/* Always contains a accessable address, start with 0 */
+static u32 *pclk_spi0;
+static struct dw_spi_reg *pspi;
+static int mrst_spi_inited;
+static spinlock_t dw_lock;
+static int real_pgt_is_up;
+
+static struct kmsg_dumper dw_dumper;
+static int dumper_registered;
+
+static void dw_kmsg_dump(struct kmsg_dumper *dumper,
+			enum kmsg_dump_reason reason,
+			const char *s1, unsigned long l1,
+			const char *s2, unsigned long l2)
+{
+	int i;
+
+	/* When run to this, we'd better re-init the HW */
+	mrst_spi_inited = 0;
+
+	for (i = 0; i < l1; i++)
+		early_mrst_console.write(&early_mrst_console, s1 + i, 1);
+	for (i = 0; i < l2; i++)
+		early_mrst_console.write(&early_mrst_console, s2 + i, 1);
+}
+
+/*
+ * One trick for the early printk is that it could be called
+ * before and after the real page table is enabled for kernel,
+ * so the PHY IO registers should be mapped twice. And a flag
+ * "real_pgt_is_up" is used as an indicator
+ */
+static void early_mrst_spi_init(void)
+{
+	u32 ctrlr0 = 0;
+	u32 spi0_cdiv;
+	static u32 freq; /* freq info only need be searched once */
+
+	if (pspi && mrst_spi_inited)
+		return;
+
+	spin_lock_init(&dw_lock);
+
+	if (!freq) {
+		set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, MRST_CLK_SPI0_REG);
+		pclk_spi0 = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
+				(MRST_CLK_SPI0_REG & (PAGE_SIZE - 1)));
+
+		spi0_cdiv = ((*pclk_spi0) & 0xe00) >> 9;
+		freq = 100000000 / (spi0_cdiv + 1);
+	}
+
+	if (mrst_identify_cpu() == MRST_CPU_CHIP_PENWELL)
+		mrst_spi_paddr = MRST_REGBASE_SPI1;
+
+	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, mrst_spi_paddr);
+	pspi = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
+			(mrst_spi_paddr & (PAGE_SIZE - 1)));
+
+
+	/* disable SPI controller */
+	dw_writel(pspi, ssienr, 0);
+
+	/* set control param, 8 bits, transmit only mode */
+	ctrlr0 = dw_readl(pspi, ctrl0);
+
+	ctrlr0 &= 0xfcc0;
+	ctrlr0 |= 0xf | (SPI_FRF_SPI << SPI_FRF_OFFSET)
+		      | (SPI_TMOD_TO << SPI_TMOD_OFFSET);
+	dw_writel(pspi, ctrl0, ctrlr0);
+
+	/* change the spi0 clk to comply with 115200 bps,
+	 * use 100000 as dividor to make the clock a little
+	 * slower than baud rate */
+	dw_writel(pspi, baudr, freq/100000);
+
+	/* disable all INT for early phase */
+	dw_writel(pspi, imr, 0x0);
+
+	/* set the cs to max3110 */
+	dw_writel(pspi, ser, 0x2);
+
+	/* enable the HW, the last step for HW init */
+	dw_writel(pspi, ssienr, 0x1);
+
+	mrst_spi_inited = 1;
+
+	/* register the kmsg dumper */
+	if (!dumper_registered) {
+		dw_dumper.dump = dw_kmsg_dump;
+		kmsg_dump_register(&dw_dumper);
+		dumper_registered = 1;
+	}
+}
+
+/* set the ratio rate, INT */
+static void max3110_write_config(void)
+{
+	u16 config;
+
+	/* 115200, TM not set, no parity, 8bit word */
+	config = 0xc001;
+	dw_writel(pspi, dr, config);
+}
+
+/* transfer char to a eligibal word and send to max3110 */
+static void max3110_write_data(char c)
+{
+	u16 data;
+
+	data = 0x8000 | c;
+	dw_writel(pspi, dr, data);
+}
+
+/* slave select should be called in the read/write function */
+static int early_mrst_spi_putc(char c)
+{
+	unsigned int timeout;
+	u32 sr;
+
+	timeout = MRST_SPI_TIMEOUT;
+	/* early putc need make sure the TX FIFO is not full*/
+	while (timeout--) {
+		sr = dw_readl(pspi, sr);
+		if (!(sr & SR_TF_NOT_FULL))
+			cpu_relax();
+		else
+			break;
+	}
+
+	if (timeout == 0xffffffff) {
+		printk(KERN_INFO "SPI: waiting timeout\n");
+		return -1;
+	}
+
+	max3110_write_data(c);
+	return 0;
+}
+
+/* early SPI only use polling mode */
+static void early_mrst_spi_write(struct console *con,
+				const char *str, unsigned n)
+{
+	int  i;
+	unsigned long flags;
+
+	if ((read_cr3() == __pa(swapper_pg_dir)) && !real_pgt_is_up) {
+		mrst_spi_inited = 0;
+		real_pgt_is_up = 1;
+	}
+
+	if (unlikely(!mrst_spi_inited)) {
+		early_mrst_spi_init();
+		max3110_write_config();
+	}
+
+	spin_lock_irqsave(&dw_lock, flags);
+	for (i = 0; i < n && *str; i++) {
+		if (*str == '\n')
+			early_mrst_spi_putc('\r');
+		early_mrst_spi_putc(*str);
+
+		str++;
+	}
+	spin_unlock_irqrestore(&dw_lock, flags);
+}
+
+struct console early_mrst_console = {
+	.name =		"earlymrst",
+	.write =	early_mrst_spi_write,
+	.flags =	CON_PRINTBUFFER,
+	.index =	-1,
+};
+
+/* a debug function */
+void mrst_early_printk(const char *fmt, ...)
+{
+	char buf[512];
+	int n;
+	va_list ap;
+
+	va_start(ap, fmt);
+	n = vscnprintf(buf, 512, fmt, ap);
+	va_end(ap);
+
+	early_mrst_console.write(&early_mrst_console, buf, n);
+}

