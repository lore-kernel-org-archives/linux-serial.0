From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3] serial: 8250: add gpio support to exar
Date: Sun, 20 Dec 2015 18:54:51 +0530
Message-ID: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, gnomes@lxorguk.ukuu.org.uk
List-Id: linux-serial@vger.kernel.org

Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
can be controlled using gpio interface.
Add support to use these pins and select GPIO_SYSFS also so that these
pins can be used from the userspace through sysfs.

Tested-by: Rob Groner <rgroner@rtd.com>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v3: Alan commented on v2, few things like NULL check, name of the gpio chip,
moving some more code into the gpio code. He also commented on it being
a separate module, but since this will not be needed by someone who is not
using Exar chip, and even those who are using, some of them may not need it.
This is optional for only those who wants to use the gpio capability of that
chip. So kept it as a separate module. Waiting for your comments on that.

v2: v1 had problems with build, reported by 0day bot.

 drivers/tty/serial/8250/8250_gpio.c | 261 ++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c  |  19 ++-
 drivers/tty/serial/8250/Kconfig     |   8 ++
 drivers/tty/serial/8250/Makefile    |   1 +
 include/linux/8250_pci.h            |  15 +++
 5 files changed, 303 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tty/serial/8250/8250_gpio.c

diff --git a/drivers/tty/serial/8250/8250_gpio.c b/drivers/tty/serial/8250/8250_gpio.c
new file mode 100644
index 0000000..948236e
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_gpio.c
@@ -0,0 +1,261 @@
+/*
+ * GPIO driver for Exar XR17V35X chip
+ *
+ * Copyright (C) 2015 Sudip Mukherjee <sudipm.mukherjee@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/gpio.h>
+#include "8250.h"
+
+#define EXAR_OFFSET_MPIOLVL_LO 0x90
+#define EXAR_OFFSET_MPIOSEL_LO 0x93
+#define EXAR_OFFSET_MPIOLVL_HI 0x96
+#define EXAR_OFFSET_MPIOSEL_HI 0x99
+
+static LIST_HEAD(exar_list);
+static DEFINE_MUTEX(exar_mtx); /* lock while manipulating the list */
+
+struct exar_gpio_chip {
+	struct gpio_chip gpio_chip;
+	struct mutex lock;
+	struct uart_8250_port *port;
+	struct list_head list;
+	int index;
+	void __iomem *regs;
+	char name[16];
+};
+
+#define to_exar_chip(n) container_of(n, struct exar_gpio_chip, gpio_chip)
+
+static inline unsigned int read_exar_reg(struct exar_gpio_chip *chip,
+					 int offset)
+{
+	pr_debug("%s regs=%p offset=%x\n", __func__, chip->regs, offset);
+	return readb(chip->regs + offset);
+}
+
+static inline void write_exar_reg(struct exar_gpio_chip *chip, int offset,
+				  int value)
+{
+	pr_debug("%s regs=%p value=%x offset=%x\n", __func__, chip->regs,
+		 value, offset);
+	writeb(value, chip->regs + offset);
+}
+
+void xr17v35x_gpio_exit(struct uart_8250_port *port)
+{
+	struct exar_gpio_chip *exar_gpio, *exar_temp1, *exar_temp2;
+
+	if (!port)
+		return;
+
+	exar_gpio = port->port.private_data;
+	if (!exar_gpio)
+		return;
+
+	mutex_lock(&exar_mtx);
+	list_for_each_entry_safe(exar_temp1, exar_temp2, &exar_list, list) {
+		if (exar_temp1->index == exar_gpio->index) {
+			list_del(&exar_temp1->list);
+			break;
+		}
+	}
+	mutex_unlock(&exar_mtx);
+
+	gpiochip_remove(&exar_gpio->gpio_chip);
+	mutex_destroy(&exar_gpio->lock);
+	iounmap(exar_gpio->regs);
+}
+EXPORT_SYMBOL(xr17v35x_gpio_exit);
+
+static void exar_set(struct gpio_chip *chip, unsigned int reg, int val,
+		     unsigned int offset)
+{
+	struct exar_gpio_chip *exar_gpio = to_exar_chip(chip);
+	int temp;
+
+	mutex_lock(&exar_gpio->lock);
+	temp = read_exar_reg(exar_gpio, reg);
+	temp &= ~(1 << offset);
+	temp |= val << offset;
+	write_exar_reg(exar_gpio, reg, temp);
+	mutex_unlock(&exar_gpio->lock);
+}
+
+static int exar_direction_output(struct gpio_chip *chip, unsigned int offset,
+				 int value)
+{
+	if (offset < 8)
+		exar_set(chip, EXAR_OFFSET_MPIOSEL_LO, 0, offset);
+	else
+		exar_set(chip, EXAR_OFFSET_MPIOSEL_HI, 0, offset - 8);
+	return 0;
+}
+
+static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	if (offset < 8)
+		exar_set(chip, EXAR_OFFSET_MPIOSEL_LO, 1, offset);
+	else
+		exar_set(chip, EXAR_OFFSET_MPIOSEL_HI, 1, offset - 8);
+	return 0;
+}
+
+static int exar_get(struct gpio_chip *chip, unsigned int reg)
+{
+	int value;
+	struct exar_gpio_chip *exar_gpio = to_exar_chip(chip);
+
+	if (!exar_gpio) {
+		pr_err("%s exar_gpio is NULL\n", __func__);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&exar_gpio->lock);
+	value = read_exar_reg(exar_gpio, reg);
+	mutex_unlock(&exar_gpio->lock);
+
+	return value;
+}
+
+static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	int val;
+
+	if (offset < 8) {
+		val = exar_get(chip, EXAR_OFFSET_MPIOSEL_LO);
+	} else {
+		val = exar_get(chip, EXAR_OFFSET_MPIOSEL_HI);
+		offset -= 8;
+	}
+
+	if (val > 0) {
+		val >>= offset;
+		val &= 0x01;
+	}
+
+	return val;
+}
+
+static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
+{
+	int val;
+
+	if (offset < 8) {
+		val = exar_get(chip, EXAR_OFFSET_MPIOLVL_LO);
+	} else {
+		val = exar_get(chip, EXAR_OFFSET_MPIOLVL_HI);
+		offset -= 8;
+	}
+	val >>= offset;
+	val &= 0x01;
+
+	return val;
+}
+
+static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
+			   int value)
+{
+	if (offset < 8)
+		exar_set(chip, EXAR_OFFSET_MPIOLVL_LO, value, offset);
+	else
+		exar_set(chip, EXAR_OFFSET_MPIOLVL_HI, value, offset - 8);
+}
+
+int xr17v35x_gpio_init(struct pci_dev *dev, struct uart_8250_port *port,
+		       int idx)
+{
+	struct exar_gpio_chip *exar_gpio, *exar_temp;
+	int ret;
+	void __iomem *p;
+	int index = 1;
+
+	if (idx != 0)
+		return 0;
+
+	if (dev->vendor != PCI_VENDOR_ID_EXAR)
+		return 0;
+
+	p = pci_ioremap_bar(dev, 0);
+	if (!p)
+		return -ENOMEM;
+
+	exar_gpio = devm_kzalloc(&dev->dev, sizeof(*exar_gpio), GFP_KERNEL);
+	if (!exar_gpio) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	mutex_init(&exar_gpio->lock);
+	INIT_LIST_HEAD(&exar_gpio->list);
+
+	mutex_lock(&exar_mtx);
+	/* find the first unused index */
+	list_for_each_entry(exar_temp, &exar_list, list) {
+		if (exar_temp->index == index) {
+			index++;
+			continue;
+		}
+	}
+
+	sprintf(exar_gpio->name, "exar_gpio%d", index);
+	exar_gpio->gpio_chip.label = exar_gpio->name;
+	exar_gpio->gpio_chip.dev = &dev->dev;
+	exar_gpio->gpio_chip.direction_output = exar_direction_output;
+	exar_gpio->gpio_chip.direction_input = exar_direction_input;
+	exar_gpio->gpio_chip.get_direction = exar_get_direction;
+	exar_gpio->gpio_chip.get = exar_get_value;
+	exar_gpio->gpio_chip.set = exar_set_value;
+	exar_gpio->gpio_chip.base = -1;
+	exar_gpio->gpio_chip.ngpio = 16;
+	exar_gpio->gpio_chip.owner = THIS_MODULE;
+	exar_gpio->regs = p;
+	exar_gpio->index = index;
+
+	ret = gpiochip_add(&exar_gpio->gpio_chip);
+	if (ret)
+		goto err_destroy;
+
+	exar_gpio->port = port;
+	port->port.private_data = exar_gpio;
+
+	list_add_tail(&exar_gpio->list, &exar_list);
+	mutex_unlock(&exar_mtx);
+
+	return 0;
+
+err_destroy:
+	mutex_unlock(&exar_mtx);
+	mutex_destroy(&exar_gpio->lock);
+err_unmap:
+	iounmap(p);
+	return ret;
+}
+EXPORT_SYMBOL(xr17v35x_gpio_init);
+
+static void __exit exar_gpio_exit(void)
+{
+}
+
+module_exit(exar_gpio_exit);
+
+static int __init exar_gpio_init(void)
+{
+	return 0;
+}
+
+module_init(exar_gpio_init);
+
+MODULE_DESCRIPTION("Exar GPIO driver");
+MODULE_AUTHOR("Sudip Mukherjee <sudipm.mukherjee@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4097f3f..2a73c47 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1764,12 +1764,20 @@ xr17v35x_has_slave(struct serial_private *priv)
 	        (dev_id == PCI_DEVICE_ID_EXAR_XR17V8358));
 }
 
+static void pci_xr17v35x_exit(struct pci_dev *dev)
+{
+	struct serial_private *priv = pci_get_drvdata(dev);
+
+	xr17v35x_gpio_exit(serial8250_get_port(priv->line[0]));
+}
+
 static int
 pci_xr17v35x_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
 {
 	u8 __iomem *p;
+	int ret;
 
 	p = pci_ioremap_bar(priv->dev, 0);
 	if (p == NULL)
@@ -1807,7 +1815,11 @@ pci_xr17v35x_setup(struct serial_private *priv,
 	writeb(128, p + UART_EXAR_RXTRG);
 	iounmap(p);
 
-	return pci_default_setup(priv, board, port, idx);
+	ret = pci_default_setup(priv, board, port, idx);
+	if (ret)
+		return ret;
+
+	return xr17v35x_gpio_init(priv->dev, port, idx);
 }
 
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
@@ -2407,6 +2419,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	{
 		.vendor = PCI_VENDOR_ID_EXAR,
@@ -2414,6 +2427,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	{
 		.vendor = PCI_VENDOR_ID_EXAR,
@@ -2421,6 +2435,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	{
 		.vendor = PCI_VENDOR_ID_EXAR,
@@ -2428,6 +2443,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	{
 		.vendor = PCI_VENDOR_ID_EXAR,
@@ -2435,6 +2451,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	/*
 	 * Xircom cards
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index b03cb517..852f1d2 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -386,3 +386,11 @@ config SERIAL_OF_PLATFORM
 	  are probed through devicetree, including Open Firmware based
 	  PowerPC systems and embedded systems on architectures using the
 	  flattened device tree format.
+
+config SERIAL_8250_EXAR_GPIO
+	tristate "Support for GPIO pins on XR17V352/354/358"
+	depends on SERIAL_8250_PCI && GPIOLIB
+	select GPIO_SYSFS
+	help
+	  Selecting this option will enable handling of GPIO pins present
+	  on Exar XR17V352/354/358 chips.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 4ecb80d..bcf5f14 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_OF)		+= 8250_of.o
+obj-$(CONFIG_SERIAL_8250_EXAR_GPIO)	+= 8250_gpio.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
diff --git a/include/linux/8250_pci.h b/include/linux/8250_pci.h
index b24ff08..803e55c 100644
--- a/include/linux/8250_pci.h
+++ b/include/linux/8250_pci.h
@@ -35,3 +35,18 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board);
 void pciserial_remove_ports(struct serial_private *priv);
 void pciserial_suspend_ports(struct serial_private *priv);
 void pciserial_resume_ports(struct serial_private *priv);
+
+struct uart_8250_port;
+
+#ifdef CONFIG_SERIAL_8250_EXAR_GPIO
+int xr17v35x_gpio_init(struct pci_dev *, struct uart_8250_port *, int);
+void xr17v35x_gpio_exit(struct uart_8250_port *);
+#else /* CONFIG_SERIAL_8250_EXAR_GPIO */
+static inline int xr17v35x_gpio_init(struct pci_dev *dev,
+				     struct uart_8250_port *port, int idx)
+{
+		return 0;
+}
+
+static inline void xr17v35x_gpio_exit(struct uart_8250_port *port) { }
+#endif /* CONFIG_SERIAL_8250_EXAR_GPIO */
-- 
1.9.1
