From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH v6 1/2] serial_core: add pci uart early console support
Date: Mon, 8 Jun 2015 11:17:11 -0700
Message-ID: <20150608181711.GA181146@worksta>
References: <20150529183839.GA13090@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150529183839.GA13090@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, bin.gao@linux.intel.com
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
Changes in v6: None
Changes in v5:
 - updated Documentation/kernel-parameters.txt.
 - moved earlyprintk= to patch 2/2 (requires x86 people's review).
 - rolled back to simple_strto* APIs.
 - seperate pci/pci32 format description.
 - minor error and debug message changes.
 - if/else statements in uart_parse_earlycon() were refactored to avoid
   logic steering locals.
Changes in v4:
 - moved PCI_EARLY definition from arch/x86/Kconfig to drivers/pci/Kconfig
 - made earlycon= for all archs but earlyprintk= only for x86 by changing
   "#ifdef #else #endif" to "#if #endif".
Changes in v3:
 - introduced CONFIG_EARLY_PCI to protect pci codes in serial_core.c.
 - added earlyprintk= as alia to earlycon= to keep x86 compatibility.
changes in v2:
 - added the second patch (2/2) to remove existed pci early console support
   from arch/x86/kernel/early_printk.c.
 Documentation/kernel-parameters.txt |  15 +++++
 arch/x86/Kconfig                    |   1 +
 drivers/pci/Kconfig                 |  11 ++++
 drivers/tty/serial/serial_core.c    | 106 +++++++++++++++++++++++++++++++++++-
 4 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 61ab162..598606e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -969,6 +969,16 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			same format described for "console=ttyS<n>"; if
 			unspecified, the h/w is not initialized.
 
+		uart8250,pci,<bus:dev.func>[,options]
+		uart8250,pci32,<bus:dev.func>[,options]
+			Start an early, polled-mode console on the 8250/16550
+			UART at the specified PCI device (bus:dev.func).
+			The io or memory mmaped register width is either 8-bit
+			(pci) or 32-bit (pci32).
+			'options' are specified in the same format described
+			for "console=ttyS<n>"; if unspecified, the h/w is not
+			initialized.
+
 		pl011,<addr>
 			Start an early, polled-mode console on a pl011 serial
 			port at the specified address. The pl011 serial port
@@ -1009,6 +1019,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
 			earlyprintk=dbgp[debugController#]
+			earlyprintk=uart8250,pci,<bus:dev.fun>[,options]
+			earlyprintk=uart8250,pci32,<bus:dev.func>[,options]
 
 			earlyprintk is useful when the kernel crashes before
 			the normal console is initialized. It is not enabled by
@@ -1037,6 +1049,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 			The xen output can only be used by Xen PV guests.
 
+			The uart8250,pci and uart8250,pci32 output share the
+			same definition that is in earlycon= section.
+
 	edac_report=	[HW,EDAC] Control how to report EDAC event
 			Format: {"on" | "off" | "force"}
 			on: enable EDAC to report H/W event. May be overridden
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 226d569..bdedd61 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -143,6 +143,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
 	select X86_FEATURE_NAMES if PROC_FS
 	select SRCU
+	select PCI_EARLY if PCI
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7a8f1c5..4f0f055 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -114,4 +114,15 @@ config PCI_LABEL
 	def_bool y if (DMI || ACPI)
 	select NLS
 
+config PCI_EARLY
+	bool "Early PCI access"
+	depends on PCI
+	default n
+	help
+	  This option indicates that a group of APIs are available (in
+	  asm/pci-direct.h) so the kernel can access pci config registers
+	  before the PCI subsystem is initialized. Any arch that supports
+	  early pci APIs should enable this option which is required  by
+	  arch independent codes, e.g. uart8250 pci early console driver.
+
 source "drivers/pci/host/Kconfig"
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0b7bb12..5b21999 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -34,10 +34,15 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/pci_regs.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_PCI_EARLY
+#include <asm/pci-direct.h>
+#endif
+
 /*
  * This is used to lock changes in serial line configuration.
  */
@@ -1808,6 +1813,85 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 	return ports + idx;
 }
 
+#ifdef CONFIG_PCI_EARLY
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
+	u64 bar0;
+	u16 cmd;
+	int pci_io = 0;
+
+	if (!early_pci_allowed()) {
+		pr_err("earlycon: early pci not allowed.\n");
+		return -EINVAL;
+	}
+
+	/* We come here with options=B:D.F[,options] */
+	if (*options == 0)
+		goto failed;
+
+	bus = (u8)simple_strtoul(options, &options, 10);
+	if (*options != ':')
+		goto failed;
+
+	dev = (u8)simple_strtoul(options + 1, &options, 10);
+	if (*options != '.')
+		goto failed;
+
+	func = (u8)simple_strtoul(options + 1, NULL, 10);
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
+	pr_debug("Use 8250 uart at PCI 0000:%02u:%02u.%01u as early console\n",
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
+	pr_err("earlycon: pci not supported (requires CONFIG_PCI_EARLY=y)\n");
+	return -EINVAL;
+}
+#endif
+
 /**
  *	uart_parse_earlycon - Parse earlycon options
  *	@p:	  ptr to 2nd field (ie., just beyond '<name>,')
@@ -1817,7 +1901,9 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
  *
  *	Decodes earlycon kernel command line parameters of the form
  *	   earlycon=<name>,io|mmio|mmio32,<addr>,<options>
+ *	   earlycon=<name>,pci|pci32,<bus:dev.func>,<options>
  *	   console=<name>,io|mmio|mmio32,<addr>,<options>
+ *	For pci|pci32, bus, dev and func are in decimal.
  *
  *	The optional form
  *	   earlycon=<name>,0x<addr>,<options>
@@ -1829,22 +1915,40 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 			char **options)
 {
+	int ret;
+	unsigned long phys;
+
 	if (strncmp(p, "mmio,", 5) == 0) {
 		*iotype = UPIO_MEM;
 		p += 5;
+		*addr = simple_strtoul(p, NULL, 0);
 	} else if (strncmp(p, "mmio32,", 7) == 0) {
 		*iotype = UPIO_MEM32;
 		p += 7;
+		*addr = simple_strtoul(p, NULL, 0);
+	} else if (strncmp(p, "pci,", 4) == 0) {
+		p += 4;
+		ret = parse_pci_options(p, &phys);
+		if (ret < 0)
+			return ret;
+		*iotype = (ret > 0) ? UPIO_PORT : UPIO_MEM;
+	} else if (strncmp(p, "pci32,", 6) == 0) {
+		p += 6;
+		ret = parse_pci_options(p, &phys);
+		if (ret < 0)
+			return ret;
+		*iotype = (ret > 0) ? UPIO_PORT : UPIO_MEM32;
 	} else if (strncmp(p, "io,", 3) == 0) {
 		*iotype = UPIO_PORT;
 		p += 3;
+		*addr = simple_strtoul(p, NULL, 0);
 	} else if (strncmp(p, "0x", 2) == 0) {
 		*iotype = UPIO_MEM;
+		*addr = simple_strtoul(p, NULL, 0);
 	} else {
 		return -EINVAL;
 	}
 
-	*addr = simple_strtoul(p, NULL, 0);
 	p = strchr(p, ',');
 	if (p)
 		p++;
-- 
1.9.1
