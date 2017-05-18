From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 1/6] gpio: exar: Fix passing in of parent PCI device
Date: Thu, 18 May 2017 16:59:04 +0200
Message-ID: <62280d24a7cf7c0be849c1186c909c850f4d2cc6.1495119548.git.jan.kiszka@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495119548.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1495119548.git.jan.kiszka@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This fixes reloading of the GPIO driver for the same platform device
instance as created by the exar UART driver: First of all, the driver
sets drvdata to its own value during probing and does not restore the
original value on exit. But this won't help anyway as the core clears
drvdata after the driver left.

Use stable platform_data instead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-exar.c                |  4 +++-
 drivers/tty/serial/8250/8250_exar.c     |  8 ++++++--
 include/linux/platform_data/gpio-exar.h | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/platform_data/gpio-exar.h

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 081076771217..d62e57513144 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/gpio-exar.h>
 #include <linux/platform_device.h>
 
 #define EXAR_OFFSET_MPIOLVL_LO 0x90
@@ -119,7 +120,8 @@ static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
 
 static int gpio_exar_probe(struct platform_device *pdev)
 {
-	struct pci_dev *pcidev = platform_get_drvdata(pdev);
+	struct gpio_exar_pdata *pdata = pdev->dev.platform_data;
+	struct pci_dev *pcidev = pdata->parent;
 	struct exar_gpio_chip *exar_gpio;
 	void __iomem *p;
 	int index, ret;
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index b4fa585156c7..0a806daaff8b 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/gpio-exar.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/slab.h>
@@ -191,13 +192,16 @@ static void *
 xr17v35x_register_gpio(struct pci_dev *pcidev)
 {
 	struct platform_device *pdev;
+	struct gpio_exar_pdata pdata;
 
 	pdev = platform_device_alloc("gpio_exar", PLATFORM_DEVID_AUTO);
 	if (!pdev)
 		return NULL;
 
-	platform_set_drvdata(pdev, pcidev);
-	if (platform_device_add(pdev) < 0) {
+	pdata.parent = pcidev;
+
+	if (platform_device_add_data(pdev, &pdata, sizeof(pdata)) < 0 ||
+	    platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
 	}
diff --git a/include/linux/platform_data/gpio-exar.h b/include/linux/platform_data/gpio-exar.h
new file mode 100644
index 000000000000..1a13e9ddaf7d
--- /dev/null
+++ b/include/linux/platform_data/gpio-exar.h
@@ -0,0 +1,22 @@
+/*
+ * GPIO handling for Exar XR17V35X chip
+ *
+ * Copyright (c) 2017 Siemens AG
+ *
+ * Written by Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __GPIO_EXAR_PDATA_H
+#define __GPIO_EXAR_PDATA_H
+
+struct pci_dev;
+
+struct gpio_exar_pdata {
+	struct pci_dev *parent;
+};
+
+#endif /* __GPIO_EXAR_PDATA_H */
-- 
2.12.0
