From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v5] serial: 8250: add gpio support to exar
Date: Tue, 19 Jan 2016 11:36:35 +0530
Message-ID: <1453183595-17996-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, gnomes@lxorguk.ukuu.org.uk, andy.shevchenko@gmail.com, Rob Groner <rgroner@rtd.com>
List-Id: linux-serial@vger.kernel.org

Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
can be controlled using gpio interface.
Add support to use these pins.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v5: I messed up v4 while sending.

v4: Alan's suggestion won, used platform device to bind to the gpio
driver. Looks like that is the best option among all the alternatives.
GPIO driver is totally separate now and doesnot loads if the
hardware is not connected. Cc-ing GPIO people also for their comments,
previous versions didnot have Cc to GPIO.

v3: Alan commented on v2, few things like NULL check, name of the gpio
chip, moving some more code into the gpio code. He also commented on it
being a separate module, but since this will not be needed by someone who
is not using Exar chip, and even those who are using, some of them may
not need it. This is optional for only those who wants to use the gpio
capability of that chip. So kept it as a separate module.

v2: v1 had problems with build, reported by 0day bot.

 drivers/gpio/Kconfig               |   7 +
 drivers/gpio/Makefile              |   1 +
 drivers/gpio/gpio-exar.c           | 255 +++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c |  41 +++++-
 4 files changed, 303 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-exar.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index c88dd24..d45f16e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -986,6 +986,13 @@ config GPIO_SODAVILLE
 	help
 	  Say Y here to support Intel Sodaville GPIO.
 
+config GPIO_EXAR
+	tristate "Support for GPIO pins on XR17V352/354/358"
+	depends on SERIAL_8250_PCI
+	help
+	  Selecting this option will enable handling of GPIO pins present
+	  on Exar XR17V352/354/358 chips.
+
 endmenu
 
 menu "SPI GPIO expanders"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ece7d7c..3c7c849 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_GPIO_DWAPB)	+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EM)		+= gpio-em.o
 obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_ETRAXFS)	+= gpio-etraxfs.o
+obj-$(CONFIG_GPIO_EXAR)		+= gpio-exar.o
 obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
 obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
new file mode 100644
index 0000000..494405d
--- /dev/null
+++ b/drivers/gpio/gpio-exar.c
@@ -0,0 +1,255 @@
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
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/gpio.h>
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
+static int gpio_exar_probe(struct platform_device *pdev)
+{
+	struct pci_dev *dev = platform_get_drvdata(pdev);
+	struct exar_gpio_chip *exar_gpio, *exar_temp;
+	void __iomem *p;
+	int index = 1;
+	int ret;
+
+	if (dev->vendor != PCI_VENDOR_ID_EXAR)
+		return -ENODEV;
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
+	exar_gpio->gpio_chip.parent = &dev->dev;
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
+	list_add_tail(&exar_gpio->list, &exar_list);
+	mutex_unlock(&exar_mtx);
+
+	platform_set_drvdata(pdev, exar_gpio);
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
+
+static int gpio_exar_remove(struct platform_device *pdev)
+{
+	struct exar_gpio_chip *exar_gpio, *exar_temp1, *exar_temp2;
+
+	exar_gpio = platform_get_drvdata(pdev);
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
+
+	return 0;
+}
+
+static struct platform_driver gpio_exar_driver = {
+	.probe	= gpio_exar_probe,
+	.remove	= gpio_exar_remove,
+	.driver	= {
+		.name = "gpio_exar",
+	},
+};
+
+static const struct platform_device_id gpio_exar_id[] = {
+	{ "gpio_exar", 0},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(platform, gpio_exar_id);
+
+module_platform_driver(gpio_exar_driver)
+
+MODULE_DESCRIPTION("Exar GPIO driver");
+MODULE_AUTHOR("Sudip Mukherjee <sudipm.mukherjee@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4097f3f..5c03d5c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1764,12 +1764,25 @@ xr17v35x_has_slave(struct serial_private *priv)
 	        (dev_id == PCI_DEVICE_ID_EXAR_XR17V8358));
 }
 
+static void pci_xr17v35x_exit(struct pci_dev *dev)
+{
+	struct serial_private *priv = pci_get_drvdata(dev);
+	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
+	struct platform_device *pdev = port->port.private_data;
+
+	if (pdev) {
+		platform_device_unregister(pdev);
+		port->port.private_data = NULL;
+	}
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
@@ -1807,7 +1820,28 @@ pci_xr17v35x_setup(struct serial_private *priv,
 	writeb(128, p + UART_EXAR_RXTRG);
 	iounmap(p);
 
-	return pci_default_setup(priv, board, port, idx);
+	ret = pci_default_setup(priv, board, port, idx);
+	if (ret)
+		return ret;
+
+	if (idx == 0) {
+		struct platform_device *device;
+
+		device = platform_device_alloc("gpio_exar",
+					       PLATFORM_DEVID_AUTO);
+		if (!device)
+			return -ENOMEM;
+
+		if (platform_device_add(device) < 0) {
+			platform_device_put(device);
+			return -ENODEV;
+		}
+
+		port->port.private_data = device;
+		platform_set_drvdata(device, priv->dev);
+	}
+
+	return 0;
 }
 
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
@@ -2407,6 +2441,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	{
 		.vendor = PCI_VENDOR_ID_EXAR,
@@ -2414,6 +2449,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	{
 		.vendor = PCI_VENDOR_ID_EXAR,
@@ -2421,6 +2457,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	{
 		.vendor = PCI_VENDOR_ID_EXAR,
@@ -2428,6 +2465,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	{
 		.vendor = PCI_VENDOR_ID_EXAR,
@@ -2435,6 +2473,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_xr17v35x_setup,
+		.exit		= pci_xr17v35x_exit,
 	},
 	/*
 	 * Xircom cards
-- 
1.9.1

