From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH v3 1/2] serial_core: add pci uart early console support
Date: Mon, 18 May 2015 14:21:52 -0700
Message-ID: <20150518212152.GA95407@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On some Intel Atom SoCs, the legacy IO port UART(0x3F8) is not available.
Instead, a 8250 compatible PCI uart can be used as early console.
This patch adds pci support to the 8250 early console driver uart8250.
For example, to enable pci uart(00:21.3) as early console on these
platforms, append the following line to the kernel command line
(assume baud rate is 115200):
earlyprintk=uart8250,pci32,0:24.2,115200n8

Signed-off-by: Bin Gao <bin.gao@intel.com>
---
 arch/x86/Kconfig                 |  11 +++
 drivers/tty/serial/earlycon.c    |   9 +++
 drivers/tty/serial/serial_core.c | 145 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 226d569..1283220 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2228,6 +2228,8 @@ config PCI
 	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
 	  VESA. If you have PCI, say Y, otherwise N.
 
+	select HAVE_EARLY_PCI
+
 choice
 	prompt "PCI access mode"
 	depends on X86_32 && PCI
@@ -2265,6 +2267,15 @@ config PCI_GOANY
 
 endchoice
 
+config HAVE_EARLY_PCI
+	def_bool y
+	help
+	  This option indicates that a group of APIs are available (in
+	  asm/pci-direct.h) so the kernel can access pci config registers
+	  before the PCI subsystem is initialized. Any arch that supports
+	  early pci APIs must enable this option which is required  by arch
+	  independent codes, e.g. uart8250 pci early console driver.
+
 config PCI_BIOS
 	def_bool y
 	depends on X86_32 && PCI && (PCI_GOBIOS || PCI_GOANY)
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 6dc471e..63ae60e 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -193,6 +193,15 @@ static int __init param_setup_earlycon(char *buf)
 }
 early_param("earlycon", param_setup_earlycon);
 
+/* x86 uses "earlyprintk=xxx", so we keep the compatibility here */
+#ifdef CONFIG_X86
+static int __init param_setup_earlycon_x86(char *buf)
+{
+	return param_setup_earlycon(buf);
+}
+early_param("earlyprintk", param_setup_earlycon_x86);
+#endif
+
 int __init of_setup_earlycon(unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0b7bb12..06218f5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -34,10 +34,15 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/pci_regs.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_HAVE_EARLY_PCI
+#include <asm/pci-direct.h>
+#endif
+
 /*
  * This is used to lock changes in serial line configuration.
  */
@@ -1808,6 +1813,110 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 	return ports + idx;
 }
 
+static int parse_bdf(char *options, char **endp, char delimiter, u8 *val)
+{
+	char str[4]; /* max 3 chars, plus a NULL terminator */
+	char *p = options;
+	int i = 0;
+
+	while (*p) {
+		if (i >= 4)
+			return -EINVAL;
+
+		if (*p == delimiter) {
+			str[i++] = 0;
+			if (endp)
+				*endp = p + 1;
+			return kstrtou8(str, 10, val); /* decimal, no hex */
+		}
+
+		str[i++] = *p++;
+	}
+
+	return -EINVAL;
+}
+
+#ifdef CONFIG_HAVE_EARLY_PCI
+/*
+ * The whole pci option from the command line is: pci[32],B:D.F[,options]
+ * Examples:
+ *     pci,0:21.3,115200n8
+ *     pci32,0:21.3
+ * Here pci32 means 8250 UART registers are 32-bit width(regshift = 2).
+ * pci means 8250 UART registers are 8-bit width(regshift = 0).
+ * B,D and F are bus, device and function, in decimal(not hex).
+ * The additional options(115200n8) would be parsed by the earlycon framework.
+ *
+ * @options: the pci options
+ * @phys: the pointer to return pci mem or io address
+ * return: <0: error
+ *          0: pci mem
+ *          1: pci io
+ */
+static int parse_pci_options(char *options, unsigned long *phys)
+{
+	u8 bus, dev, func;
+	char *endp;
+	u64 bar0;
+	u16 cmd;
+	int pci_io = 0;
+
+	if (!early_pci_allowed()) {
+		pr_err("earlycon pci not available(early pci not allowed)\n");
+		return -EINVAL;
+	}
+
+	/* We come here with options=B:D.F[,options] */
+	if (parse_bdf(options, &endp, ':', &bus))
+		goto failed;
+
+	if (parse_bdf(endp, &endp, '.', &dev))
+		goto failed;
+
+	if (parse_bdf(endp, &endp, ',', &func))
+		goto failed;
+
+	/*
+	 * On these platforms class code in pci config is broken,
+	 * so skip checking it.
+	 */
+
+	bar0 = read_pci_config(bus, dev, func, PCI_BASE_ADDRESS_0);
+
+	/* The BAR is IO or Memory? */
+	if ((bar0 & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO)
+		pci_io = 1;
+
+	if ((bar0 & PCI_BASE_ADDRESS_MEM_TYPE_MASK) ==
+			PCI_BASE_ADDRESS_MEM_TYPE_64)
+		bar0 |= (u64)read_pci_config(bus, dev, func,
+				PCI_BASE_ADDRESS_0 + 4) << 32;
+
+	*phys = bar0 & (pci_io ? PCI_BASE_ADDRESS_IO_MASK :
+				 PCI_BASE_ADDRESS_MEM_MASK);
+
+	/* Enable address decoding */
+	cmd = read_pci_config_16(bus, dev, func, PCI_COMMAND);
+	write_pci_config_16(bus, dev, func, PCI_COMMAND,
+		cmd | (pci_io ? PCI_COMMAND_IO : PCI_COMMAND_MEMORY));
+
+	pr_info("Use 8250 uart at PCI 0000:%02u:%02u.%01u as early console\n",
+							bus, dev, func);
+	return pci_io;
+
+failed:
+	pr_err("Invalid earlycon pci parameters\n");
+	return -EINVAL;
+}
+
+#else
+static int parse_pci_options(char *options, unsigned long *phys)
+{
+	pr_err("earlycon pci not available(need CONFIG_HAVE_EARLY_PCI)\n");
+	return -EINVAL;
+}
+#endif
+
 /**
  *	uart_parse_earlycon - Parse earlycon options
  *	@p:	  ptr to 2nd field (ie., just beyond '<name>,')
@@ -1816,8 +1925,9 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
  *	@options: ptr for <options> field; NULL if not present (out)
  *
  *	Decodes earlycon kernel command line parameters of the form
- *	   earlycon=<name>,io|mmio|mmio32,<addr>,<options>
+ *	   earlycon=<name>,io|mmio|mmio32|pci|pci32,<addr>,<options>
  *	   console=<name>,io|mmio|mmio32,<addr>,<options>
+ *	For pci/pci32, the <addr> format is B:D.F, e.g. 0:24.2
  *
  *	The optional form
  *	   earlycon=<name>,0x<addr>,<options>
@@ -1829,12 +1939,23 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 			char **options)
 {
+	int pci = 0, ret;
+	unsigned long phys;
+
 	if (strncmp(p, "mmio,", 5) == 0) {
 		*iotype = UPIO_MEM;
 		p += 5;
 	} else if (strncmp(p, "mmio32,", 7) == 0) {
 		*iotype = UPIO_MEM32;
 		p += 7;
+	} else if (strncmp(p, "pci,", 4) == 0) {
+		pci = 1;
+		p += 4;
+		ret = parse_pci_options(p, &phys);
+	} else if (strncmp(p, "pci32,", 6) == 0) {
+		pci = 2;
+		p += 6;
+		ret = parse_pci_options(p, &phys);
 	} else if (strncmp(p, "io,", 3) == 0) {
 		*iotype = UPIO_PORT;
 		p += 3;
@@ -1844,7 +1965,27 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 		return -EINVAL;
 	}
 
-	*addr = simple_strtoul(p, NULL, 0);
+	if (pci) {
+		if (ret < 0) /* error */
+			return ret;
+
+		/*
+		 * Once PCI mem/io is read from PCI BAR, we can reuse
+		 * mmio/mmio32/io type to minimize code change.
+		 */
+		if (ret > 0) /* PCI io */
+			*iotype = UPIO_PORT;
+		else { /* ret = 0: PCI mem */
+			if (pci == 2)
+				*iotype = UPIO_MEM32;
+			else
+				*iotype = UPIO_MEM;
+		}
+
+		*addr = phys;
+	} else
+		*addr = simple_strtoul(p, NULL, 0);
+
 	p = strchr(p, ',');
 	if (p)
 		p++;
-- 
1.9.1
