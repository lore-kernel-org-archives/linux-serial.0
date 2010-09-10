From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 1/4] x86, earlyprintk: add earlyprintk for Intel Moorestown platform
Date: Fri, 10 Sep 2010 11:10:17 +0800
Message-ID: <1284088220-12276-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52575 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917Ab0IJCuT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Sep 2010 22:50:19 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com, alan@linux.intel.com, mingo@elte.hu
Cc: Feng Tang <feng.tang@intel.com>, x86 maintainers <x86@kernel.org>

Intel Moorestown platform has a spi-uart device(Maxim3110), which
connects to a Designware spi core controller. This patch will add
early console function based on it.

As it will be used long before Linux spi subsystem get initialised,
we simply directly manipulate the spi controller's register to
acheive the early console func. This is safe as it will be disabled
when devices subsytem get initialised.

To use it, user need enable CONFIG_X86_MRST_EARLY_PRINTK in kenrel
config and add "earlyprintk=mrst" in kernel command line.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: x86 maintainers <x86@kernel.org>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 arch/x86/Kconfig.debug             |    4 +
 arch/x86/include/asm/mrst.h        |    4 +
 arch/x86/kernel/Makefile           |    1 +
 arch/x86/kernel/early_printk.c     |    5 +
 arch/x86/kernel/mrst_earlyprintk.c |  241 ++++++++++++++++++++++++++++++++++++
 5 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/kernel/mrst_earlyprintk.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 7508508..9c10cd6 100644
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
index 1635074..4b891b3 100644
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
 
@@ -42,4 +45,5 @@ extern enum mrst_timer_options mrst_timer_options;
 #define SFI_MTMR_MAX_NUM 8
 #define SFI_MRTC_MAX	8
 
+extern struct console early_mrst_console;
 #endif /* _ASM_X86_MRST_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0925676..e6dbe95 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault_32.o
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
index 0000000..7c29025
--- /dev/null
+++ b/arch/x86/kernel/mrst_earlyprintk.c
@@ -0,0 +1,241 @@
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
+/* Default use SPI0 register for mrst, we will detect Penwell and use SPI1*/
+static unsigned long mrst_spi_paddr = MRST_REGBASE_SPI0;
+
+static u32 *pclk_spi0;
+/* Always contains an accessable address, start with 0 */
+static struct dw_spi_reg *pspi;
+static int mrst_spi_init_done;
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
+	mrst_spi_init_done = 0;
+
+	for (i = 0; i < l1; i++)
+		early_mrst_console.write(&early_mrst_console, s1 + i, 1);
+	for (i = 0; i < l2; i++)
+		early_mrst_console.write(&early_mrst_console, s2 + i, 1);
+}
+
+static void early_mrst_spi_init(void)
+{
+	u32 ctrlr0 = 0;
+	u32 spi0_cdiv;
+	static u32 freq; /* freq info only need be searched once */
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
+	/* Disable SPI controller */
+	dw_writel(pspi, ssienr, 0);
+
+	/* Set control param, 8 bits, transmit only mode */
+	ctrlr0 = dw_readl(pspi, ctrl0);
+
+	ctrlr0 &= 0xfcc0;
+	ctrlr0 |= 0xf | (SPI_FRF_SPI << SPI_FRF_OFFSET)
+		      | (SPI_TMOD_TO << SPI_TMOD_OFFSET);
+	dw_writel(pspi, ctrl0, ctrlr0);
+
+	/* Change the spi0 clk to comply with 115200 bps,
+	 * use 100000 as dividor to make the clock a little
+	 * slower than baud rate */
+	dw_writel(pspi, baudr, freq/100000);
+
+	/* Disable all INT for early phase */
+	dw_writel(pspi, imr, 0x0);
+
+	/* Set the cs to spi-uart */
+	dw_writel(pspi, ser, 0x2);
+
+	/* Enable the HW, the last step for HW init */
+	dw_writel(pspi, ssienr, 0x1);
+
+	mrst_spi_init_done = 1;
+
+	/* Register the kmsg dumper */
+	if (!dumper_registered) {
+		dw_dumper.dump = dw_kmsg_dump;
+		kmsg_dump_register(&dw_dumper);
+		dumper_registered = 1;
+	}
+}
+
+/* Set the ratio rate, INT */
+static void max3110_write_config(void)
+{
+	u16 config;
+
+	/* 115200, TM not set, no parity, 8bit word */
+	config = 0xc001;
+	dw_writel(pspi, dr, config);
+}
+
+/* Translate char to a eligibal word and send to max3110 */
+static void max3110_write_data(char c)
+{
+	u16 data;
+
+	data = 0x8000 | c;
+	dw_writel(pspi, dr, data);
+}
+
+/* Slave select should be called in the read/write function */
+static void early_mrst_spi_putc(char c)
+{
+	unsigned int timeout;
+	u32 sr;
+
+	timeout = MRST_SPI_TIMEOUT;
+	/* Early putc need make sure the TX FIFO is not full*/
+	while (--timeout) {
+		sr = dw_readl(pspi, sr);
+		if (!(sr & SR_TF_NOT_FULL))
+			cpu_relax();
+		else
+			break;
+	}
+
+	if (!timeout)
+		pr_warning("SPI: waiting timeout\n");
+	else
+		max3110_write_data(c);
+}
+
+/* Early SPI only use polling mode */
+static void early_mrst_spi_write(struct console *con, const char *str, unsigned n)
+{
+	int i;
+
+	if (unlikely(!mrst_spi_init_done)) {
+		early_mrst_spi_init();
+		max3110_write_config();
+	}
+
+	for (i = 0; i < n && *str; i++) {
+		if (*str == '\n')
+			early_mrst_spi_putc('\r');
+		early_mrst_spi_putc(*str);
+		str++;
+	}
+}
+
+struct console early_mrst_console = {
+	.name =		"earlymrst",
+	.write =	early_mrst_spi_write,
+	.flags =	CON_PRINTBUFFER,
+	.index =	-1,
+};
-- 
1.7.0.4

