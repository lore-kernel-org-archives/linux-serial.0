From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/3] OF: Add helper for matching against linux,stdout-path
Date: Fri,  2 Nov 2012 10:48:52 +0100
Message-ID: <1351849734-9836-2-git-send-email-s.hauer@pengutronix.de>
References: <1351849734-9836-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54986 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934501Ab2KBJt1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Nov 2012 05:49:27 -0400
In-Reply-To: <1351849734-9836-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>

devicetrees may have a linux,stdout-path property in the chosen
node describing the console device. This adds a helper function
to match a device against this property so a driver can call
add_preferred_console for a matching device.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/of/Kconfig        |    3 +++
 drivers/of/Makefile       |    1 +
 drivers/of/of_stdout.c    |   27 +++++++++++++++++++++++++++
 include/linux/of_stdout.h |   24 ++++++++++++++++++++++++
 4 files changed, 55 insertions(+)
 create mode 100644 drivers/of/of_stdout.c
 create mode 100644 include/linux/of_stdout.h

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index dfba3e6..8574ebb 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -67,6 +67,9 @@ config OF_MDIO
 	help
 	  OpenFirmware MDIO bus (Ethernet PHY) accessors
 
+config OF_STDOUT
+	def_bool y
+
 config OF_PCI
 	def_tristate PCI
 	depends on PCI
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e027f44..c9f3f2f 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_OF_I2C)	+= of_i2c.o
 obj-$(CONFIG_OF_NET)	+= of_net.o
 obj-$(CONFIG_OF_SELFTEST) += selftest.o
 obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
+obj-$(CONFIG_OF_STDOUT) += of_stdout.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
 obj-$(CONFIG_OF_MTD)	+= of_mtd.o
diff --git a/drivers/of/of_stdout.c b/drivers/of/of_stdout.c
new file mode 100644
index 0000000..c9e370e
--- /dev/null
+++ b/drivers/of/of_stdout.c
@@ -0,0 +1,27 @@
+/*
+ * OF helper for linux,stdoutpath property.
+ *
+ * This file is released under the GPLv2
+ */
+#include <linux/of_stdout.h>
+
+/**
+ * of_device_is_stdout_path - check if a device node matches the
+ *                            linux,stdout-path property
+ *
+ * Check if this device node matches the linux,stdout-path property
+ * in the chosen node. return true if yes, false otherwise.
+ */
+int of_device_is_stdout_path(struct device_node *dn)
+{
+	const char *name;
+
+	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name == NULL)
+		return 0;
+
+	if (dn == of_find_node_by_path(name))
+		return 1;
+
+	return 0;
+}
diff --git a/include/linux/of_stdout.h b/include/linux/of_stdout.h
new file mode 100644
index 0000000..0d80674
--- /dev/null
+++ b/include/linux/of_stdout.h
@@ -0,0 +1,24 @@
+/*
+ * OF helper for linux,stdoutpath property.
+ *
+ * This file is released under the GPLv2
+ */
+
+#ifndef __LINUX_OF_STDOUT_H
+#define __LINUX_OF_STDOUT_H
+
+#ifdef CONFIG_OF_STDOUT
+
+#include <linux/of.h>
+int of_device_is_stdout_path(struct device_node *dn);
+
+#else
+
+static inline int of_device_is_stdout_path(struct device_node *dn)
+{
+	return 0;
+}
+
+#endif
+
+#endif /* __LINUX_OF_STDOUT_H */
-- 
1.7.10.4

