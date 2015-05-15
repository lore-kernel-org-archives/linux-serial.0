From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH v2 2/2] arch/x86: remove pci uart early console from
 early_prink.c
Date: Thu, 14 May 2015 21:38:13 -0700
Message-ID: <20150515043813.GA102026@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The arch independent uart8250 early console driver has good
support for memory mapped and io port based 8250 uarts. Since
pci is arch independent so it's natural to extend uart8250 to
support mem, io and pci. Hence pci uart early console in
arch/x86/kernel_printk.c by the following commit:
'commit 5140fda16051 ("Specify PCI based UART for earlyprintk")'
is removed. And its equivalent function will be available from
uart8250 early console driver.

Signed-off-by: Bin Gao <bin.gao@intel.com>
---
 arch/x86/kernel/early_printk.c | 180 ++++-------------------------------------
 1 file changed, 15 insertions(+), 165 deletions(-)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 89427d8..00c2e2a 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -19,7 +19,6 @@
 #include <linux/usb/ehci_def.h>
 #include <linux/efi.h>
 #include <asm/efi.h>
-#include <asm/pci_x86.h>
 
 /* Simple VGA output */
 #define VGABASE		(__ISA_IO_base + 0xb8000)
@@ -77,7 +76,7 @@ static struct console early_vga_console = {
 
 /* Serial functions loosely based on a similar package from Klaus P. Gerlicher */
 
-static unsigned long early_serial_base = 0x3f8;  /* ttyS0 */
+static int early_serial_base = 0x3f8;  /* ttyS0 */
 
 #define XMTRDY          0x20
 
@@ -95,26 +94,13 @@ static unsigned long early_serial_base = 0x3f8;  /* ttyS0 */
 #define DLL             0       /*  Divisor Latch Low         */
 #define DLH             1       /*  Divisor latch High        */
 
-static unsigned int io_serial_in(unsigned long addr, int offset)
-{
-	return inb(addr + offset);
-}
-
-static void io_serial_out(unsigned long addr, int offset, int value)
-{
-	outb(value, addr + offset);
-}
-
-static unsigned int (*serial_in)(unsigned long addr, int offset) = io_serial_in;
-static void (*serial_out)(unsigned long addr, int offset, int value) = io_serial_out;
-
 static int early_serial_putc(unsigned char ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((serial_in(early_serial_base, LSR) & XMTRDY) == 0 && --timeout)
+	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
-	serial_out(early_serial_base, TXR, ch);
+	outb(ch, early_serial_base + TXR);
 	return timeout ? 0 : -1;
 }
 
@@ -128,28 +114,13 @@ static void early_serial_write(struct console *con, const char *s, unsigned n)
 	}
 }
 
-static __init void early_serial_hw_init(unsigned divisor)
-{
-	unsigned char c;
-
-	serial_out(early_serial_base, LCR, 0x3);	/* 8n1 */
-	serial_out(early_serial_base, IER, 0);	/* no interrupt */
-	serial_out(early_serial_base, FCR, 0);	/* no fifo */
-	serial_out(early_serial_base, MCR, 0x3);	/* DTR + RTS */
-
-	c = serial_in(early_serial_base, LCR);
-	serial_out(early_serial_base, LCR, c | DLAB);
-	serial_out(early_serial_base, DLL, divisor & 0xff);
-	serial_out(early_serial_base, DLH, (divisor >> 8) & 0xff);
-	serial_out(early_serial_base, LCR, c & ~DLAB);
-}
-
 #define DEFAULT_BAUD 9600
 
 static __init void early_serial_init(char *s)
 {
+	unsigned char c;
 	unsigned divisor;
-	unsigned long baud = DEFAULT_BAUD;
+	unsigned baud = DEFAULT_BAUD;
 	char *e;
 
 	if (*s == ',')
@@ -174,138 +145,23 @@ static __init void early_serial_init(char *s)
 			s++;
 	}
 
-	if (*s) {
-		if (kstrtoul(s, 0, &baud) < 0 || baud == 0)
-			baud = DEFAULT_BAUD;
-	}
-
-	/* Convert from baud to divisor value */
-	divisor = 115200 / baud;
-
-	/* These will always be IO based ports */
-	serial_in = io_serial_in;
-	serial_out = io_serial_out;
-
-	/* Set up the HW */
-	early_serial_hw_init(divisor);
-}
-
-#ifdef CONFIG_PCI
-static void mem32_serial_out(unsigned long addr, int offset, int value)
-{
-	u32 *vaddr = (u32 *)addr;
-	/* shift implied by pointer type */
-	writel(value, vaddr + offset);
-}
-
-static unsigned int mem32_serial_in(unsigned long addr, int offset)
-{
-	u32 *vaddr = (u32 *)addr;
-	/* shift implied by pointer type */
-	return readl(vaddr + offset);
-}
-
-/*
- * early_pci_serial_init()
- *
- * This function is invoked when the early_printk param starts with "pciserial"
- * The rest of the param should be ",B:D.F,baud" where B, D & F describe the
- * location of a PCI device that must be a UART device.
- */
-static __init void early_pci_serial_init(char *s)
-{
-	unsigned divisor;
-	unsigned long baud = DEFAULT_BAUD;
-	u8 bus, slot, func;
-	u32 classcode, bar0;
-	u16 cmdreg;
-	char *e;
-
-
-	/*
-	 * First, part the param to get the BDF values
-	 */
-	if (*s == ',')
-		++s;
-
-	if (*s == 0)
-		return;
-
-	bus = (u8)simple_strtoul(s, &e, 16);
-	s = e;
-	if (*s != ':')
-		return;
-	++s;
-	slot = (u8)simple_strtoul(s, &e, 16);
-	s = e;
-	if (*s != '.')
-		return;
-	++s;
-	func = (u8)simple_strtoul(s, &e, 16);
-	s = e;
-
-	/* A baud might be following */
-	if (*s == ',')
-		s++;
-
-	/*
-	 * Second, find the device from the BDF
-	 */
-	cmdreg = read_pci_config(bus, slot, func, PCI_COMMAND);
-	classcode = read_pci_config(bus, slot, func, PCI_CLASS_REVISION);
-	bar0 = read_pci_config(bus, slot, func, PCI_BASE_ADDRESS_0);
-
-	/*
-	 * Verify it is a UART type device
-	 */
-	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
-	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
-	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
-		return;
-
-	/*
-	 * Determine if it is IO or memory mapped
-	 */
-	if (bar0 & 0x01) {
-		/* it is IO mapped */
-		serial_in = io_serial_in;
-		serial_out = io_serial_out;
-		early_serial_base = bar0&0xfffffffc;
-		write_pci_config(bus, slot, func, PCI_COMMAND,
-						cmdreg|PCI_COMMAND_IO);
-	} else {
-		/* It is memory mapped - assume 32-bit alignment */
-		serial_in = mem32_serial_in;
-		serial_out = mem32_serial_out;
-		/* WARNING! assuming the address is always in the first 4G */
-		early_serial_base =
-			(unsigned long)early_ioremap(bar0 & 0xfffffff0, 0x10);
-		write_pci_config(bus, slot, func, PCI_COMMAND,
-						cmdreg|PCI_COMMAND_MEMORY);
-	}
+	outb(0x3, early_serial_base + LCR);	/* 8n1 */
+	outb(0, early_serial_base + IER);	/* no interrupt */
+	outb(0, early_serial_base + FCR);	/* no fifo */
+	outb(0x3, early_serial_base + MCR);	/* DTR + RTS */
 
-	/*
-	 * Lastly, initalize the hardware
-	 */
 	if (*s) {
-		if (strcmp(s, "nocfg") == 0)
-			/* Sometimes, we want to leave the UART alone
-			 * and assume the BIOS has set it up correctly.
-			 * "nocfg" tells us this is the case, and we
-			 * should do no more setup.
-			 */
-			return;
 		if (kstrtoul(s, 0, &baud) < 0 || baud == 0)
 			baud = DEFAULT_BAUD;
 	}
 
-	/* Convert from baud to divisor value */
 	divisor = 115200 / baud;
-
-	/* Set up the HW */
-	early_serial_hw_init(divisor);
+	c = inb(early_serial_base + LCR);
+	outb(c | DLAB, early_serial_base + LCR);
+	outb(divisor & 0xff, early_serial_base + DLL);
+	outb((divisor >> 8) & 0xff, early_serial_base + DLH);
+	outb(c & ~DLAB, early_serial_base + LCR);
 }
-#endif
 
 static struct console early_serial_console = {
 	.name =		"earlyser",
@@ -326,6 +182,7 @@ static inline void early_console_register(struct console *con, int keep_early)
 		early_console->flags &= ~CON_BOOT;
 	else
 		early_console->flags |= CON_BOOT;
+
 	register_console(early_console);
 }
 
@@ -353,13 +210,6 @@ static int __init setup_early_printk(char *buf)
 			early_serial_init(buf + 4);
 			early_console_register(&early_serial_console, keep);
 		}
-#ifdef CONFIG_PCI
-		if (!strncmp(buf, "pciserial", 9)) {
-			early_pci_serial_init(buf + 9);
-			early_console_register(&early_serial_console, keep);
-			buf += 9; /* Keep from match the above "serial" */
-		}
-#endif
 		if (!strncmp(buf, "vga", 3) &&
 		    boot_params.screen_info.orig_video_isVGA == 1) {
 			max_xpos = boot_params.screen_info.orig_video_cols;
-- 
1.9.1
