From: Anup Patel <anup@brainfault.org>
Subject: [PATCH 3/3] RISC-V: Remove EARLY_PRINTK support
Date: Tue,  4 Dec 2018 19:25:07 +0530
Message-ID: <20181204135507.3706-4-anup@brainfault.org>
References: <20181204135507.3706-1-anup@brainfault.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Anup Patel <anup@brainfault.org>
List-Id: linux-serial@vger.kernel.org

The EARLY_PRINTK using SBI console calls is not required
any more because we now have RISC-V SBI support in generic
earlycon framework.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig.debug  |  2 --
 arch/riscv/kernel/setup.c | 28 ----------------------------
 2 files changed, 30 deletions(-)

diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
index c5a72f17c469..e69de29bb2d1 100644
--- a/arch/riscv/Kconfig.debug
+++ b/arch/riscv/Kconfig.debug
@@ -1,2 +0,0 @@
-config EARLY_PRINTK
-	def_bool y
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2c290e6aaa6e..fc8006a042eb 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -35,31 +35,9 @@
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/smp.h>
-#include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 
-#ifdef CONFIG_EARLY_PRINTK
-static void sbi_console_write(struct console *co, const char *buf,
-			      unsigned int n)
-{
-	int i;
-
-	for (i = 0; i < n; ++i) {
-		if (buf[i] == '\n')
-			sbi_console_putchar('\r');
-		sbi_console_putchar(buf[i]);
-	}
-}
-
-struct console riscv_sbi_early_console_dev __initdata = {
-	.name	= "early",
-	.write	= sbi_console_write,
-	.flags	= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
-	.index	= -1
-};
-#endif
-
 #ifdef CONFIG_DUMMY_CONSOLE
 struct screen_info screen_info = {
 	.orig_video_lines	= 30,
@@ -219,12 +197,6 @@ static void __init setup_bootmem(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-#if defined(CONFIG_EARLY_PRINTK)
-       if (likely(early_console == NULL)) {
-               early_console = &riscv_sbi_early_console_dev;
-               register_console(early_console);
-       }
-#endif
 	*cmdline_p = boot_command_line;
 
 	parse_early_param();
-- 
2.17.1
