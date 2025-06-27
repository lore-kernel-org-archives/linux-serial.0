Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2D2EBDE5;
	Fri, 27 Jun 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048874; cv=none; b=ghmIUQktHO1rLd7lt7nma//f13R9y8e9OvsoHW0AI9hNkhunRVPcDsQZS1vBeLh4xacxsnMejBvxRKMK0Ig0D7BZ1cY7P4Rgc7l+ip+VMWDRfofo+qFS+D22buyOvmq8WeHRzU2kReRByv8jdoThKqpp5p5NhwCpGKqvWZnCpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048874; c=relaxed/simple;
	bh=dNruR8i3nvuH0Ur6TUj/RfC6hHdJRSjk7s5QAvFDO3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXRh3jA4i1Gj9NsZ4UwafWUDOCdNxtlzCSsUfAJYUeAgO/xb9owxKRLJvsdREq+eCx2qM6FiNyKRuV6Jqpu7NSXS7d6mNzeW+Po4UbWHd/DQnibvGKOru6DmxIcPMwFEzJSuENoMGHQKrrDq8qQVDquyNRu8mkS/8h0hR1PqjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epAeo1O0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epAeo1O0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751048873; x=1782584873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dNruR8i3nvuH0Ur6TUj/RfC6hHdJRSjk7s5QAvFDO3c=;
  b=epAeo1O043SLggLgawzNeM7ga73oQzLPeth19c+zde/E7acVJ2vZdNfL
   RtO5EE7T4WwgA48x7ON3jYKL1BgbwJWVnT1HzqFe3jvaV4uV0ayR3E+2R
   74Wqi5CsY3+AjEAOqSlwe2dWTxDGlIsRaRBRQj8wuJcrYz17uwRZR1Whw
   23UpqafcCrvqB/mN6Rmec6X9y6xTWof43xXV8n1qtgwvgjrwfRJ97uWIG
   yM/qLqqu9HgoD1bKDIgXXLYfrisNjaO+TKpGq0sxA/0qbjv12E272Tv1H
   mmyI4OEYDhjI3hfIQ8euZA2FmMAjwPLMC8I1PgiRHh1uVDY3SCpMAQvPz
   w==;
X-CSE-ConnectionGUID: aGXbxI+AReucD7PHornyEA==
X-CSE-MsgGUID: R0Rz0M8yQLam3/xGGyAf4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="52598782"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="52598782"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:27:52 -0700
X-CSE-ConnectionGUID: am8OoBiHQJ6jv78kbrdmew==
X-CSE-MsgGUID: 9W9dLvIRSyKowKwjpbkIYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="152489474"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 27 Jun 2025 11:27:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 21C0C27C; Fri, 27 Jun 2025 21:27:47 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 1/1] serial: 8250: Move CE4100 quirks to a module under 8250 driver
Date: Fri, 27 Jun 2025 21:25:00 +0300
Message-ID: <20250627182743.1273326-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is inconvenient for maintainers and maintainership to have
some quirks under architectural code. Move it to the specific quirk
file like other 8250-compatible drivers do.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

The next step can be considered on how to get rid of
serial8250_set_isa_configurator() ugly hook.

 arch/x86/include/asm/ce4100.h                 |  6 ++
 arch/x86/platform/ce4100/ce4100.c             | 98 -------------------
 .../tty/serial/8250/8250_ce4100.c             | 92 +++--------------
 drivers/tty/serial/8250/Makefile              |  1 +
 4 files changed, 23 insertions(+), 174 deletions(-)
 copy arch/x86/platform/ce4100/ce4100.c => drivers/tty/serial/8250/8250_ce4100.c (51%)

diff --git a/arch/x86/include/asm/ce4100.h b/arch/x86/include/asm/ce4100.h
index 2930f560d7f3..e1f965bb1e31 100644
--- a/arch/x86/include/asm/ce4100.h
+++ b/arch/x86/include/asm/ce4100.h
@@ -4,4 +4,10 @@
 
 int ce4100_pci_init(void);
 
+#ifdef CONFIG_SERIAL_8250
+void __init sdv_serial_fixup(void);
+#else
+static inline void sdv_serial_fixup(void) {};
+#endif
+
 #endif
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index 08492bea9713..aaa7017416f7 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -5,19 +5,12 @@
  * (C) Copyright 2010 Intel Corporation
  */
 #include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/irq.h>
 #include <linux/reboot.h>
-#include <linux/serial_reg.h>
-#include <linux/serial_8250.h>
 
 #include <asm/ce4100.h>
 #include <asm/prom.h>
 #include <asm/setup.h>
-#include <asm/i8259.h>
 #include <asm/io.h>
-#include <asm/io_apic.h>
-#include <asm/emergency-restart.h>
 
 /*
  * The CE4100 platform has an internal 8051 Microcontroller which is
@@ -31,97 +24,6 @@ static void ce4100_power_off(void)
 	outb(0x4, 0xcf9);
 }
 
-#ifdef CONFIG_SERIAL_8250
-
-static unsigned int mem_serial_in(struct uart_port *p, int offset)
-{
-	offset = offset << p->regshift;
-	return readl(p->membase + offset);
-}
-
-/*
- * The UART Tx interrupts are not set under some conditions and therefore serial
- * transmission hangs. This is a silicon issue and has not been root caused. The
- * workaround for this silicon issue checks UART_LSR_THRE bit and UART_LSR_TEMT
- * bit of LSR register in interrupt handler to see whether at least one of these
- * two bits is set, if so then process the transmit request. If this workaround
- * is not applied, then the serial transmission may hang. This workaround is for
- * errata number 9 in Errata - B step.
-*/
-
-static u32 ce4100_mem_serial_in(struct uart_port *p, unsigned int offset)
-{
-	u32 ret, ier, lsr;
-
-	if (offset != UART_IIR)
-		return mem_serial_in(p, offset);
-
-	offset <<= p->regshift;
-
-	ret = readl(p->membase + offset);
-	if (!(ret & UART_IIR_NO_INT))
-		return ret;
-
-	/* see if the TX interrupt should have really set */
-	ier = mem_serial_in(p, UART_IER);
-	/* see if the UART's XMIT interrupt is enabled */
-	if (!(ier & UART_IER_THRI))
-		return ret;
-
-	lsr = mem_serial_in(p, UART_LSR);
-	/* now check to see if the UART should be generating an interrupt (but isn't) */
-	if (lsr & (UART_LSR_THRE | UART_LSR_TEMT))
-		ret &= ~UART_IIR_NO_INT;
-
-	return ret;
-}
-
-static void ce4100_mem_serial_out(struct uart_port *p, unsigned int offset, u32 value)
-{
-	offset <<= p->regshift;
-	writel(value, p->membase + offset);
-}
-
-static void ce4100_serial_fixup(int port, struct uart_port *up,
-	u32 *capabilities)
-{
-#ifdef CONFIG_EARLY_PRINTK
-	/*
-	 * Over ride the legacy port configuration that comes from
-	 * asm/serial.h. Using the ioport driver then switching to the
-	 * PCI memmaped driver hangs the IOAPIC
-	 */
-	if (up->iotype !=  UPIO_MEM32) {
-		up->uartclk  = 14745600;
-		up->mapbase = 0xdffe0200;
-		set_fixmap_nocache(FIX_EARLYCON_MEM_BASE,
-				up->mapbase & PAGE_MASK);
-		up->membase =
-			(void __iomem *)__fix_to_virt(FIX_EARLYCON_MEM_BASE);
-		up->membase += up->mapbase & ~PAGE_MASK;
-		up->mapbase += port * 0x100;
-		up->membase += port * 0x100;
-		up->iotype   = UPIO_MEM32;
-		up->regshift = 2;
-		up->irq = 4;
-	}
-#endif
-	up->iobase = 0;
-	up->serial_in = ce4100_mem_serial_in;
-	up->serial_out = ce4100_mem_serial_out;
-
-	*capabilities |= (1 << 12);
-}
-
-static __init void sdv_serial_fixup(void)
-{
-	serial8250_set_isa_configurator(ce4100_serial_fixup);
-}
-
-#else
-static inline void sdv_serial_fixup(void) {};
-#endif
-
 static void __init sdv_arch_setup(void)
 {
 	sdv_serial_fixup();
diff --git a/arch/x86/platform/ce4100/ce4100.c b/drivers/tty/serial/8250/8250_ce4100.c
similarity index 51%
copy from arch/x86/platform/ce4100/ce4100.c
copy to drivers/tty/serial/8250/8250_ce4100.c
index 08492bea9713..3dd88f372a51 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/drivers/tty/serial/8250/8250_ce4100.c
@@ -4,34 +4,17 @@
  *
  * (C) Copyright 2010 Intel Corporation
  */
+
 #include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/irq.h>
-#include <linux/reboot.h>
-#include <linux/serial_reg.h>
-#include <linux/serial_8250.h>
+#include <linux/io.h>
+#include <linux/types.h>
 
 #include <asm/ce4100.h>
-#include <asm/prom.h>
-#include <asm/setup.h>
-#include <asm/i8259.h>
-#include <asm/io.h>
-#include <asm/io_apic.h>
-#include <asm/emergency-restart.h>
+#include <asm/fixmap.h>
+#include <asm/page.h>
 
-/*
- * The CE4100 platform has an internal 8051 Microcontroller which is
- * responsible for signaling to the external Power Management Unit the
- * intention to reset, reboot or power off the system. This 8051 device has
- * its command register mapped at I/O port 0xcf9 and the value 0x4 is used
- * to power off the system.
- */
-static void ce4100_power_off(void)
-{
-	outb(0x4, 0xcf9);
-}
-
-#ifdef CONFIG_SERIAL_8250
+#include <linux/serial_reg.h>
+#include <linux/serial_8250.h>
 
 static unsigned int mem_serial_in(struct uart_port *p, int offset)
 {
@@ -48,7 +31,6 @@ static unsigned int mem_serial_in(struct uart_port *p, int offset)
  * is not applied, then the serial transmission may hang. This workaround is for
  * errata number 9 in Errata - B step.
 */
-
 static u32 ce4100_mem_serial_in(struct uart_port *p, unsigned int offset)
 {
 	u32 ret, ier, lsr;
@@ -82,26 +64,23 @@ static void ce4100_mem_serial_out(struct uart_port *p, unsigned int offset, u32
 	writel(value, p->membase + offset);
 }
 
-static void ce4100_serial_fixup(int port, struct uart_port *up,
-	u32 *capabilities)
+static void ce4100_serial_fixup(int port, struct uart_port *up, u32 *capabilities)
 {
 #ifdef CONFIG_EARLY_PRINTK
 	/*
-	 * Over ride the legacy port configuration that comes from
+	 * Override the legacy port configuration that comes from
 	 * asm/serial.h. Using the ioport driver then switching to the
-	 * PCI memmaped driver hangs the IOAPIC
+	 * PCI memmaped driver hangs the IOAPIC.
 	 */
-	if (up->iotype !=  UPIO_MEM32) {
-		up->uartclk  = 14745600;
+	if (up->iotype != UPIO_MEM32) {
+		up->uartclk = 14745600;
 		up->mapbase = 0xdffe0200;
-		set_fixmap_nocache(FIX_EARLYCON_MEM_BASE,
-				up->mapbase & PAGE_MASK);
-		up->membase =
-			(void __iomem *)__fix_to_virt(FIX_EARLYCON_MEM_BASE);
+		set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, up->mapbase & PAGE_MASK);
+		up->membase = (void __iomem *)__fix_to_virt(FIX_EARLYCON_MEM_BASE);
 		up->membase += up->mapbase & ~PAGE_MASK;
 		up->mapbase += port * 0x100;
 		up->membase += port * 0x100;
-		up->iotype   = UPIO_MEM32;
+		up->iotype = UPIO_MEM32;
 		up->regshift = 2;
 		up->irq = 4;
 	}
@@ -113,46 +92,7 @@ static void ce4100_serial_fixup(int port, struct uart_port *up,
 	*capabilities |= (1 << 12);
 }
 
-static __init void sdv_serial_fixup(void)
+void __init sdv_serial_fixup(void)
 {
 	serial8250_set_isa_configurator(ce4100_serial_fixup);
 }
-
-#else
-static inline void sdv_serial_fixup(void) {};
-#endif
-
-static void __init sdv_arch_setup(void)
-{
-	sdv_serial_fixup();
-}
-
-static void sdv_pci_init(void)
-{
-	x86_of_pci_init();
-}
-
-/*
- * CE4100 specific x86_init function overrides and early setup
- * calls.
- */
-void __init x86_ce4100_early_setup(void)
-{
-	x86_init.oem.arch_setup			= sdv_arch_setup;
-	x86_init.resources.probe_roms		= x86_init_noop;
-	x86_init.mpparse.find_mptable		= x86_init_noop;
-	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
-	x86_init.pci.init			= ce4100_pci_init;
-	x86_init.pci.init_irq			= sdv_pci_init;
-
-	/*
-	 * By default, the reboot method is ACPI which is supported by the
-	 * CE4100 bootloader CEFDK using FADT.ResetReg Address and ResetValue
-	 * the bootloader will however issue a system power off instead of
-	 * reboot. By using BOOT_KBD we ensure proper system reboot as
-	 * expected.
-	 */
-	reboot_type = BOOT_KBD;
-
-	pm_power_off = ce4100_power_off;
-}
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index b04eeda03b23..e61dc3f4ca50 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
+obj-$(CONFIG_X86_INTEL_CE)		+= 8250_ce4100.o
 obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
-- 
2.47.2

