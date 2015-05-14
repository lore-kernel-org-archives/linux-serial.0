From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH 1/2] serial_core: add pci uart early console support
Date: Thu, 14 May 2015 16:43:23 -0700
Message-ID: <20150514234323.GA91174@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

>From 0d02240f022c8aca593c42a7220699dbbe37f292 Mon Sep 17 00:00:00 2001
From: Bin Gao <bin.gao@intel.com>
Date: Tue, 12 May 2015 16:40:27 -0700
Subject: [PATCH] serial_core: add pci uart early console support

On some Intel Atom SoCs, the legacy IO port UART(0x3F8) is not available.
Instead, a 8250 compatible PCI uart can be used as early console.
This patch adds pci support to the 8250 early console driver uart8250.
For example, to enable pci uart(00:21.3) as early console on these
platforms, append the following line to the kernel command line
(assume baud rate is 115200):
earlyprintk=uart8250,pci32,0:24.2,115200n8

Signed-off-by: Bin Gao <bin.gao@intel.com>
---
 drivers/tty/serial/earlycon.c    |   6 ++
 drivers/tty/serial/serial_core.c | 140 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 5fdc9f3..586d84b 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -196,7 +196,13 @@ static int __init param_setup_earlycon(char *buf)
 	}
 	return err;
 }
+
+/* x86 uses "earlyprintk=xxx", so we keep the compatibility here */
+#ifdef CONFIG_X86
+early_param("earlyprintk", param_setup_earlycon);
+#else
 early_param("earlycon", param_setup_earlycon);
+#endif
 
 int __init of_setup_earlycon(unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *))
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0b7bb12..221143c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -34,10 +34,16 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/pci_regs.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
+/* Only x86 has early pci access APIs */
+#if defined(CONFIG_PCI) && defined(CONFIG_X86)
+#include <asm/pci-direct.h>
+#endif
+
 /*
  * This is used to lock changes in serial line configuration.
  */
@@ -1808,6 +1814,98 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 	return ports + idx;
 }
 
+#if defined(CONFIG_PCI) && defined(CONFIG_X86)
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
+#endif
+
 /**
  *	uart_parse_earlycon - Parse earlycon options
  *	@p:	  ptr to 2nd field (ie., just beyond '<name>,')
@@ -1816,8 +1914,9 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
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
@@ -1829,12 +1928,27 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
 int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 			char **options)
 {
+#if defined(CONFIG_PCI) && defined(CONFIG_X86)
+	int pci = 0, ret;
+	unsigned long phys;
+#endif
+
 	if (strncmp(p, "mmio,", 5) == 0) {
 		*iotype = UPIO_MEM;
 		p += 5;
 	} else if (strncmp(p, "mmio32,", 7) == 0) {
 		*iotype = UPIO_MEM32;
 		p += 7;
+#if defined(CONFIG_PCI) && defined(CONFIG_X86)
+	} else if (strncmp(p, "pci,", 4) == 0) {
+		pci = 1;
+		p += 4;
+		ret = parse_pci_options(p, &phys);
+	} else if (strncmp(p, "pci32,", 6) == 0) {
+		pci = 2;
+		p += 6;
+		ret = parse_pci_options(p, &phys);
+#endif
 	} else if (strncmp(p, "io,", 3) == 0) {
 		*iotype = UPIO_PORT;
 		p += 3;
@@ -1844,7 +1958,29 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
 		return -EINVAL;
 	}
 
-	*addr = simple_strtoul(p, NULL, 0);
+#if defined(CONFIG_PCI) && defined(CONFIG_X86)
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
+#endif
+		*addr = simple_strtoul(p, NULL, 0);
+
 	p = strchr(p, ',');
 	if (p)
 		p++;
-- 
1.9.1
