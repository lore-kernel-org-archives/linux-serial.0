From: Rob Landley <rob@landley.net>
Subject: [PATCH 2/2] Changes to existing files for 0PF FPGA board.
Date: Thu, 18 Jun 2015 10:19:19 -0700 (PDT)
Message-ID: <1434647946.861922@landley.net>
References: <1434647946.861556@landley.net>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434647946.861556@landley.net>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vivek Goyal <vgoyal@redhat.com>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <davidlohr@hp.com>, Richard Weinberger <richard@nod.at>, Zhigang Lu <zlu@tilera.com>, Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Max Filippov <jcmvbkbc@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-se
List-Id: linux-serial@vger.kernel.org

Changes to existing files to add 0pf j2 board support.

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 50057fe..c121a92 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -66,7 +66,7 @@ config SUPERH32
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select PERF_EVENTS
 	select ARCH_HIBERNATION_POSSIBLE if MMU
-	select SPARSE_IRQ
+	select SPARSE_IRQ if !CPU_SUBTYPE_0PF
 	select HAVE_CC_STACKPROTECTOR
 
 config SUPERH64
@@ -108,6 +108,9 @@ config ARCH_SUSPEND_POSSIBLE
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool n
 
+config ARCH_USES_GETTIMEOFFSET
+	def_bool n
+
 config SYS_SUPPORTS_APM_EMULATION
 	bool
 	select ARCH_SUSPEND_POSSIBLE
@@ -184,6 +187,11 @@ config CPU_SH2A
 	select CPU_SH2
 	select UNCACHED_MAPPING
 
+config CPU_SH2J
+	bool
+	select CPU_SH2
+	select ARCH_USES_GETTIMEOFFSET
+
 config CPU_SH3
 	bool
 	select CPU_HAS_INTEVT
@@ -303,6 +311,12 @@ config CPU_SUBTYPE_MXG
 	help
 	  Select MX-G if running on an R8A03022BG part.
 
+# SH-2J Processor Support
+
+config CPU_SUBTYPE_0PF
+	bool "Support 0PF J2 SoftCore"
+	select CPU_SH2J
+
 # SH-3 Processor Support
 
 config CPU_SUBTYPE_SH7705
@@ -753,6 +767,7 @@ config ZERO_PAGE_OFFSET
 				SH_7751_SOLUTION_ENGINE
 	default "0x00004000" if PAGE_SIZE_16KB || SH_SH03
 	default "0x00002000" if PAGE_SIZE_8KB
+	default "0x0003F000" if CPU_SUBTYPE_0PF
 	default "0x00001000"
 	help
 	  This sets the default offset of zero page.
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index bf5b3f5..e609157 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -4,6 +4,7 @@
 # Copyright (C) 1999  Kaz Kojima
 # Copyright (C) 2002 - 2008  Paul Mundt
 # Copyright (C) 2002  M. R. Brown
+# Copyright (C) 2012  SEI, Inc. (sh2j)
 #
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
@@ -19,6 +20,7 @@ isa-y					:= any
 isa-$(CONFIG_SH_DSP)			:= sh
 isa-$(CONFIG_CPU_SH2)			:= sh2
 isa-$(CONFIG_CPU_SH2A)			:= sh2a
+isa-$(CONFIG_CPU_SH2J)			:= sh2j
 isa-$(CONFIG_CPU_SH3)			:= sh3
 isa-$(CONFIG_CPU_SH4)			:= sh4
 isa-$(CONFIG_CPU_SH4A)			:= sh4a
@@ -31,6 +33,7 @@ isa-y					:= $(isa-y)-up
 endif
 
 cflags-$(CONFIG_CPU_SH2)		:= $(call cc-option,-m2,)
+cflags-$(CONFIG_CPU_SH2J)		:= $(call cc-option,-m2,)
 cflags-$(CONFIG_CPU_SH2A)		+= $(call cc-option,-m2a,) \
 					   $(call cc-option,-m2a-nofpu,) \
 					   $(call cc-option,-m4-nofpu,)
@@ -91,6 +94,7 @@ defaultimage-$(CONFIG_SH_SH7757LCR)		:= uImage
 defaultimage-$(CONFIG_SH_7724_SOLUTION_ENGINE)	:= uImage
 defaultimage-$(CONFIG_SH_7206_SOLUTION_ENGINE)	:= vmlinux
 defaultimage-$(CONFIG_SH_7619_SOLUTION_ENGINE)	:= vmlinux
+defaultimage-$(CONFIG_SH_0PF)			:= vmlinux
 
 # Set some sensible Kbuild defaults
 KBUILD_IMAGE		:= $(defaultimage-y)
@@ -173,6 +177,7 @@ core-$(CONFIG_HD6446X_SERIES)	+= arch/sh/cchips/hd6446x/
 # As an example, in order of preference, SH-2A > SH-2 > common definitions.
 #
 cpuincdir-$(CONFIG_CPU_SH2A)	+= cpu-sh2a
+cpuincdir-$(CONFIG_CPU_SH2J)	+= cpu-sh2j
 cpuincdir-$(CONFIG_CPU_SH2)	+= cpu-sh2
 cpuincdir-$(CONFIG_CPU_SH3)	+= cpu-sh3
 cpuincdir-$(CONFIG_CPU_SH4A)	+= cpu-sh4a
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 89963d13..c6721d2 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -90,6 +90,13 @@ config SH_7343_SOLUTION_ENGINE
 	  Select 7343 SolutionEngine if configuring for a Hitachi
 	  SH7343 (SH-Mobile 3AS) evaluation board.
 
+config 0PF_FPGA
+	bool "0PF FPGA"
+	depends on CPU_SUBTYPE_0PF
+	help
+	  Select 0PF_FPGA if you are configuring for an FPGA with
+	  the SH2j-workalike SoftCore from http://0pf.org
+
 config SH_HP6XX
 	bool "HP6XX"
 	select SYS_SUPPORTS_APM_EMULATION
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index 975a0f6..51a7eb3 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_SH_TITAN)		+= board-titan.o
 obj-$(CONFIG_SH_SH7757LCR)	+= board-sh7757lcr.o
 obj-$(CONFIG_SH_APSH4A3A)	+= board-apsh4a3a.o
 obj-$(CONFIG_SH_APSH4AD0A)	+= board-apsh4ad0a.o
+obj-$(CONFIG_0PF_FPGA)		+= board-0pf.o
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 1506897..aedabf2 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -15,7 +15,7 @@
  */
 enum cpu_type {
 	/* SH-2 types */
-	CPU_SH7619,
+	CPU_SH7619, CPU_0PF,
 
 	/* SH-2A types */
 	CPU_SH7201, CPU_SH7203, CPU_SH7206, CPU_SH7263, CPU_SH7264, CPU_SH7269,
diff --git a/arch/sh/include/cpu-sh2/cpu/cache.h b/arch/sh/include/cpu-sh2/cpu/cache.h
index aa1b2b9..1da5abb 100644
--- a/arch/sh/include/cpu-sh2/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2/cpu/cache.h
@@ -38,6 +38,10 @@
 #define CCR_CACHE_INVALIDATE	CCR_CACHE_CF
 #define CACHE_PHYSADDR_MASK	0x1ffffc00
 
+#elif defined(CONFIG_CPU_SUBTYPE_0PF)
+#define CCR			0xabcd00c0
+#define CCR_CACHE_ENABLE	0x80000000
+#define CCR_CACHE_RESET		0x101
 #endif
 
 #endif /* __ASM_CPU_SH2_CACHE_H */
diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index 0d7360d..cda35ce 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -106,7 +106,7 @@ void __attribute__ ((weak)) l2_cache_init(void)
 /*
  * Generic first-level cache init
  */
-#ifdef CONFIG_SUPERH32
+#if defined(CONFIG_SUPERH32) && !defined(CONFIG_CPU_SUBTYPE_0PF)
 static void cache_init(void)
 {
 	unsigned long ccr, flags;
diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
index 9e6624c..4381fc2 100644
--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -26,6 +26,7 @@ static const char *cpu_name[] = {
 	[CPU_SH5_101]	= "SH5-101",	[CPU_SH5_103]	= "SH5-103",
 	[CPU_MXG]	= "MX-G",	[CPU_SH7723]	= "SH7723",
 	[CPU_SH7366]	= "SH7366",	[CPU_SH7724]	= "SH7724",
+	[CPU_0PF]	= "SH2J-0PF",
 	[CPU_SH7372]	= "SH7372",	[CPU_SH7734]	= "SH7734",
 	[CPU_SH_NONE]	= "Unknown"
 };
diff --git a/arch/sh/kernel/cpu/sh2/Makefile b/arch/sh/kernel/cpu/sh2/Makefile
index f0f059a..7502611 100644
--- a/arch/sh/kernel/cpu/sh2/Makefile
+++ b/arch/sh/kernel/cpu/sh2/Makefile
@@ -5,3 +5,4 @@
 obj-y	:= ex.o probe.o entry.o
 
 obj-$(CONFIG_CPU_SUBTYPE_SH7619) += setup-sh7619.o clock-sh7619.o
+obj-$(CONFIG_CPU_SUBTYPE_0PF) += setup-0pf.o clock-0pf.o
diff --git a/arch/sh/kernel/cpu/sh2/entry.S b/arch/sh/kernel/cpu/sh2/entry.S
index c8a4331..3c997c9 100644
--- a/arch/sh/kernel/cpu/sh2/entry.S
+++ b/arch/sh/kernel/cpu/sh2/entry.S
@@ -3,6 +3,7 @@
  *
  * The SH-2 exception entry
  *
+ * Copyright (C) 2012  SEI,Inc.
  * Copyright (C) 2005-2008 Yoshinori Sato
  * Copyright (C) 2005  AXE,Inc.
  *
@@ -147,7 +148,11 @@ ENTRY(exception_handler)
 	mov	#32,r8
 	cmp/hs	r8,r9
 	bt	trap_entry	! 64 > vec >= 32  is trap
-
+#if defined(CONFIG_CPU_SUBTYPE_0PF)
+	mov	#16,r8
+	cmp/hs	r8,r9
+	bt	interrupt_entry	! 32 > vec >= 16  is interrupt
+#endif
 	mov.l	4f,r8
 	mov	r9,r4
 	shll2	r9
@@ -245,6 +250,19 @@ ENTRY(address_error_trap_handler)
 	.align	2
 1:	.long	do_address_error
 
+#if defined(CONFIG_CPU_SUBTYPE_0PF)
+ENTRY(pc_address_error_trap_handler)
+	mov	r15,r4				! regs
+	mov	#OFF_PC,r0
+	mov.l	@(r0,r15),r6			! pc
+	mov.l	1f,r0
+	jmp	@r0
+	 mov	#0,r5				! writeaccess is unknown
+
+	.align	2
+1:	.long	do_pc_address_error
+#endif // CONFIG_CPU_SUBTYPE_0PF
+
 restore_all:
 	stc	sr,r0
 	or	#0xf0,r0
diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index 6c687ae..9c9e401 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -24,6 +24,12 @@ void cpu_probe(void)
 	boot_cpu_data.dcache.linesz		= L1_CACHE_BYTES;
 	boot_cpu_data.dcache.flags		= 0;
 #endif
+
+#if defined(CONFIG_CPU_SUBTYPE_0PF)
+	boot_cpu_data.type                      = CPU_0PF;
+	boot_cpu_data.dcache.flags              = 0;
+#endif
+
 	/*
 	 * SH-2 doesn't have separate caches
 	 */
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index eb10ff8..7de9bcb 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -20,6 +20,8 @@
 #include <asm/thread_info.h>
 #include <cpu/mmu_context.h>
 
+#include <asm/board-0pf.h>
+
 atomic_t irq_err_count;
 
 /*
@@ -175,11 +177,24 @@ void do_softirq_own_stack(void)
 	);
 }
 #else
+#define noinline __attribute__((noinline))
+static noinline void handle_irq_UART0(unsigned int irq) { generic_handle_irq(irq); }
+static noinline void handle_irq_UART1(unsigned int irq) { generic_handle_irq(irq); }
+static noinline void handle_irq_GPS(unsigned int irq) { generic_handle_irq(irq); }
+static noinline void handle_irq_EMAC(unsigned int irq) { generic_handle_irq(irq); }
 static inline void handle_one_irq(unsigned int irq)
 {
-	generic_handle_irq(irq);
+	switch(irq) {
+	case Irq_UART0: handle_irq_UART0(irq); break;
+	case Irq_UART1: handle_irq_UART1(irq); break;
+	case Irq_GPS:   handle_irq_GPS(irq); break;
+	case Irq_EMAC:  handle_irq_EMAC(irq); break;
+	default:
+		generic_handle_irq(irq);
+		break;
+	}
 }
-#endif
+#endif // CONFIG_IRQSTACKS
 
 asmlinkage __irq_entry int do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index ff63934..cd09376 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -34,6 +34,7 @@
 #ifdef CONFIG_CPU_SH2
 # define TRAP_RESERVED_INST	4
 # define TRAP_ILLEGAL_SLOT_INST	6
+# define TRAP_PC_ADDRESS_ERROR	8 // Aug 20, 2012 ulianov - SEI extension - PC governor
 # define TRAP_ADDRESS_ERROR	9
 # ifdef CONFIG_CPU_SH2A
 #  define TRAP_UBC		12
@@ -458,6 +459,14 @@ int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
 	return ret;
 }
 
+#if defined(CONFIG_CPU_SUBTYPE_0PF)
+asmlinkage void do_pc_address_error(struct pt_regs *regs,
+				 unsigned long writeaccess,
+				 unsigned long address)
+{
+}
+#endif // CONFIG_CPU_SUBTYPE_0PF
+
 /*
  * Handle various address error exceptions:
  *  - instruction address error:
@@ -779,6 +788,9 @@ void __init trap_init(void)
 #endif
 
 #ifdef CONFIG_CPU_SH2
+    #if defined(CONFIG_CPU_SUBTYPE_0PF)
+	set_exception_table_vec(TRAP_PC_ADDRESS_ERROR, address_error_trap_handler);
+    #endif
 	set_exception_table_vec(TRAP_ADDRESS_ERROR, address_error_trap_handler);
 #endif
 #ifdef CONFIG_CPU_SH2A
diff --git a/arch/sh/mm/cache-sh2.c b/arch/sh/mm/cache-sh2.c
index a74259f..438eadb 100644
--- a/arch/sh/mm/cache-sh2.c
+++ b/arch/sh/mm/cache-sh2.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2002 Paul Mundt
  * Copyright (C) 2008 Yoshinori Sato
+ * Copyright (C) 2012 SEI, Inc.
  *
  * Released under the terms of the GNU GPL v2.0.
  */
@@ -16,6 +17,30 @@
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
+#if defined(CONFIG_CPU_SUBTYPE_0PF)
+
+// Just flush the whole thing each time
+static void j2_flush_icache_range(void *fwoosh)
+{
+	__raw_writel(CCR_CACHE_RESET, CCR);
+}
+
+// This should never happen, but...
+static void j2_flush_icache_page(void *fwoosh)
+{
+	__raw_writel(CCR_CACHE_RESET, CCR);
+}
+
+void __init sh2_cache_init(void)
+{
+	local_flush_icache_range = j2_flush_icache_range;
+	local_flush_icache_page = j2_flush_icache_page;
+	boot_cpu_data.dcache.n_aliases = 0;
+
+	__raw_writel(CCR_CACHE_RESET, CCR);
+}
+
+#else
 static void sh2__flush_wback_region(void *start, int size)
 {
 	unsigned long v;
@@ -89,3 +114,4 @@ void __init sh2_cache_init(void)
 	__flush_purge_region		= sh2__flush_purge_region;
 	__flush_invalidate_region	= sh2__flush_invalidate_region;
 }
+#endif
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index f770e39..17908f7 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -258,14 +258,16 @@ static void __init emit_cache_params(void)
 		boot_cpu_data.icache.entry_mask,
 		boot_cpu_data.icache.alias_mask,
 		boot_cpu_data.icache.n_aliases);
-	printk(KERN_NOTICE "D-cache : n_ways=%d n_sets=%d way_incr=%d\n",
-		boot_cpu_data.dcache.ways,
-		boot_cpu_data.dcache.sets,
-		boot_cpu_data.dcache.way_incr);
-	printk(KERN_NOTICE "D-cache : entry_mask=0x%08x alias_mask=0x%08x n_aliases=%d\n",
-		boot_cpu_data.dcache.entry_mask,
-		boot_cpu_data.dcache.alias_mask,
-		boot_cpu_data.dcache.n_aliases);
+	if (boot_cpu_data.dcache.n_aliases) {
+		printk(KERN_NOTICE "D-cache : n_ways=%d n_sets=%d way_incr=%d\n",
+			boot_cpu_data.dcache.ways,
+			boot_cpu_data.dcache.sets,
+			boot_cpu_data.dcache.way_incr);
+		printk(KERN_NOTICE "D-cache : entry_mask=0x%08x alias_mask=0x%08x n_aliases=%d\n",
+			boot_cpu_data.dcache.entry_mask,
+			boot_cpu_data.dcache.alias_mask,
+			boot_cpu_data.dcache.n_aliases);
+	}
 
 	/*
 	 * Emit Secondary Cache parameters if the CPU has a probed L2.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f8120c1b..aae8d72 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -594,7 +594,7 @@ config SERIAL_IMX_CONSOLE
 
 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
-	depends on PPC32 || MICROBLAZE || MFD_TIMBERDALE || ARCH_ZYNQ
+	depends on PPC32 || MICROBLAZE || MFD_TIMBERDALE || ARCH_ZYNQ || CPU_SUBTYPE_0PF
 	select SERIAL_CORE
 	help
 	  Say Y here if you want to use the Xilinx uartlite serial controller.
@@ -611,6 +611,12 @@ config SERIAL_UARTLITE_CONSOLE
 	  console (the system console is the device which receives all kernel
 	  messages and warnings and which allows logins in single user mode).
 
+config SERIAL_UARTLITE_0PF
+       tristate "Support 0PF UARTLITEs"
+       depends on SERIAL_UARTLITE = y && CPU_SUBTYPE_0PF
+       help
+         Say Y here to set up 0PF's UARTLITEs.
+
 config SERIAL_SUNCORE
 	bool
 	depends on SPARC
