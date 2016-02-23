From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V4 2/4] gpio: gpio-f81504: Add Fintek F81504/508/512 PCIE-to-UART/GPIO GPIOLIB support
Date: Tue, 23 Feb 2016 14:30:01 +0800
Message-ID: <1456209003-22396-3-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1456209003-22396-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456209003-22396-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

This driver is GPIOLIB driver for F81504/508/512, it'll handle the
GPIOLIB operation of this device. This module will depend on
MFD_FINTEK_F81504_CORE.

IC function list:
    F81504: Max 2x8 GPIOs and max 4 serial ports
        port2/3 are multi-function
    F81508: Max 6x8 GPIOs and max 8 serial ports
        port2/3 are multi-function, port8/9/10/11 are gpio only
    F81512: Max 6x8 GPIOs and max 12 serial ports
        port2/3/8/9/10/11 are multi-function

GPIO register:
PCI Configuration space:
    F0h: bit0~5: Enable GPIO0~5
         bit6~7: Reserve
    F3h: bit0~5: Multi-Functional Flag (0:GPIO/1:UART)
         bit0: UART2 pin out for UART2 / GPIO0
         bit1: UART3 pin out for UART3 / GPIO1
         bit2: UART8 pin out for UART8 / GPIO2
         bit3: UART9 pin out for UART9 / GPIO3
         bit4: UART10 pin out for UART10 / GPIO4
         bit5: UART11 pin out for UART11 / GPIO5
         bit6~7: Reserve
    F1h: IO address (LSB)
    F2h: IO address (MSB)
    F8h + 8 * set: Direction control (bitwise)
         bitx: 0 - Input mode
         bitx: 1 - Output mode
    F9h + 8 * set: Drive ability control (bitwise)
         bitx: 0 - Open drain (default)
         bitx: 1 - Push Pull
         In this driver, we only implements open drain mode.

IO space:
    (IO base + 0~5): GPIO-0x~5x in/out value (bitwise)

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/gpio/Kconfig       |  10 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-f81504.c | 241 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 drivers/gpio/gpio-f81504.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2b80903..c9e1cf8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -912,6 +912,16 @@ config GPIO_WM8994
 	  Say yes here to access the GPIO signals of WM8994 audio hub
 	  CODECs from Wolfson Microelectronics.
 
+config GPIO_F81504
+        tristate "Fintek F81504/508/512 PCIE-to-UART/GPIO support"
+        depends on MFD_FINTEK_F81504_CORE
+        select MFD_CORE
+        help
+          Say yes here to support the GPIO functionality of Fintek
+          F81504/508/512 PCIE-to-UART/GPIO.
+
+          If unsure, say N.
+
 endmenu
 
 menu "PCI GPIO expanders"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c759190..f277089 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_GPIO_VX855)	+= gpio-vx855.o
 obj-$(CONFIG_GPIO_WM831X)	+= gpio-wm831x.o
 obj-$(CONFIG_GPIO_WM8350)	+= gpio-wm8350.o
 obj-$(CONFIG_GPIO_WM8994)	+= gpio-wm8994.o
+obj-$(CONFIG_GPIO_F81504)       += gpio-f81504.o
 obj-$(CONFIG_GPIO_XGENE)	+= gpio-xgene.o
 obj-$(CONFIG_GPIO_XGENE_SB)	+= gpio-xgene-sb.o
 obj-$(CONFIG_GPIO_XILINX)	+= gpio-xilinx.o
diff --git a/drivers/gpio/gpio-f81504.c b/drivers/gpio/gpio-f81504.c
new file mode 100644
index 0000000..25a535c
--- /dev/null
+++ b/drivers/gpio/gpio-f81504.c
@@ -0,0 +1,241 @@
+/*
+ * Copyright (C) 2016 Fintek Corporation
+ * Based on gpio-mpc8xxx.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/platform_device.h>
+#include <linux/gpio/driver.h>
+#include <linux/pci.h>
+#include <linux/mfd/f81504.h>
+
+struct f81504_gpio_chip {
+	struct gpio_chip chip;
+	struct mutex locker;
+	u8 idx;
+	u8 save_out_en;
+	u8 save_drive_en;
+	u8 save_value;
+};
+
+static int f81504_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
+{
+	struct f81504_gpio_chip *gc = gpiochip_get_data(chip);
+	struct platform_device *pdev = to_platform_device(chip->parent);
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	u8 tmp;
+
+	mutex_lock(&gc->locker);
+
+	/* Set input mode */
+	pci_read_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			     F81504_GPIO_SET_OFFSET +
+			     F81504_GPIO_OUT_EN_OFFSET, &tmp);
+	pci_write_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			      F81504_GPIO_SET_OFFSET +
+			      F81504_GPIO_OUT_EN_OFFSET, tmp & ~BIT(offset));
+
+	mutex_unlock(&gc->locker);
+	return 0;
+}
+
+static int f81504_gpio_direction_out(struct gpio_chip *chip, unsigned offset,
+		int value)
+{
+	struct f81504_gpio_chip *gc = gpiochip_get_data(chip);
+	struct platform_device *pdev = to_platform_device(chip->parent);
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	struct f81504_pci_private *priv = pci_get_drvdata(pci_dev);
+	u8 tmp;
+
+	mutex_lock(&gc->locker);
+
+	/* Set output mode */
+	pci_read_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			     F81504_GPIO_SET_OFFSET +
+			     F81504_GPIO_OUT_EN_OFFSET, &tmp);
+	pci_write_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			      F81504_GPIO_SET_OFFSET +
+			      F81504_GPIO_OUT_EN_OFFSET, tmp | BIT(offset));
+
+	/*
+	 * The GPIO default driven mode for this device is open-drain. The
+	 * GPIOLIB had no change GPIO mode API currently. So we leave the
+	 * Push-Pull code below.
+	 *
+	 * pci_read_config_byte(dev, GPIO_START_ADDR + idx * GPIO_SET_OFFSET +
+	 *			GPIO_DRIVE_EN_OFFSET, &tmp);
+	 * pci_write_config_byte(dev, GPIO_START_ADDR + idx * GPIO_SET_OFFSET +
+	 *			GPIO_DRIVE_EN_OFFSET, tmp | BIT(gpio_num));
+	 */
+
+	/* Set output data */
+	tmp = inb(priv->gpio_ioaddr + gc->idx);
+
+	if (value)
+		outb(tmp | BIT(offset), priv->gpio_ioaddr + gc->idx);
+	else
+		outb(tmp & ~BIT(offset), priv->gpio_ioaddr + gc->idx);
+
+	mutex_unlock(&gc->locker);
+	return 0;
+}
+
+static int f81504_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct f81504_gpio_chip *gc = gpiochip_get_data(chip);
+	struct platform_device *pdev = to_platform_device(chip->parent);
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	u8 tmp;
+
+	mutex_lock(&gc->locker);
+	pci_read_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			     F81504_GPIO_SET_OFFSET, &tmp);
+	mutex_unlock(&gc->locker);
+
+	if (tmp & BIT(offset))
+		return 0;
+
+	return 1;
+}
+
+static int f81504_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct f81504_gpio_chip *gc = gpiochip_get_data(chip);
+	struct platform_device *pdev = to_platform_device(chip->parent);
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	struct f81504_pci_private *priv = pci_get_drvdata(pci_dev);
+	int tmp;
+
+	mutex_lock(&gc->locker);
+	tmp = inb(priv->gpio_ioaddr + gc->idx);
+	mutex_unlock(&gc->locker);
+
+	return !!(tmp & BIT(offset));
+}
+
+static void f81504_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	f81504_gpio_direction_out(chip, offset, value);
+}
+
+static int f81504_gpio_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	struct f81504_pci_private *priv = pci_get_drvdata(pci_dev);
+	struct f81504_gpio_chip *gc = platform_get_drvdata(pdev);
+
+	mutex_lock(&gc->locker);
+	pci_read_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			     F81504_GPIO_SET_OFFSET +
+			     F81504_GPIO_OUT_EN_OFFSET, &gc->save_out_en);
+
+	pci_read_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			     F81504_GPIO_SET_OFFSET +
+			     F81504_GPIO_DRIVE_EN_OFFSET, &gc->save_drive_en);
+
+	gc->save_value = inb(priv->gpio_ioaddr + gc->idx);
+	mutex_unlock(&gc->locker);
+	return 0;
+}
+
+static int f81504_gpio_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	struct f81504_pci_private *priv = pci_get_drvdata(pci_dev);
+	struct f81504_gpio_chip *gc = platform_get_drvdata(pdev);
+
+	mutex_lock(&gc->locker);
+	pci_write_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			      F81504_GPIO_SET_OFFSET +
+			      F81504_GPIO_OUT_EN_OFFSET, gc->save_out_en);
+
+	pci_write_config_byte(pci_dev, F81504_GPIO_START_ADDR + gc->idx *
+			      F81504_GPIO_SET_OFFSET +
+			      F81504_GPIO_DRIVE_EN_OFFSET, gc->save_drive_en);
+
+	outb(gc->save_value, priv->gpio_ioaddr + gc->idx);
+	mutex_unlock(&gc->locker);
+	return 0;
+}
+
+static int f81504_gpio_probe(struct platform_device *pdev)
+{
+	unsigned int gpio_idx = *(unsigned int *)dev_get_platdata(&pdev->dev);
+	struct f81504_gpio_chip *gc;
+	char *name;
+
+	if (gpio_idx >= ARRAY_SIZE(fintek_gpio_mapping)) {
+		dev_err(&pdev->dev, "%s: gpio_idx:%d out of range.\n",
+			__func__, gpio_idx);
+		return -ENODEV;
+	}
+
+	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	mutex_init(&gc->locker);
+	platform_set_drvdata(pdev, gc);
+
+	name = devm_kzalloc(&pdev->dev, FINTEK_GPIO_NAME_LEN, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	/* This will display like as GPIO-1x */
+	sprintf(name, "%s-%dx", FINTEK_GPIO_DISPLAY, gpio_idx);
+
+	gc->chip.owner = THIS_MODULE;
+	gc->chip.parent = &pdev->dev;
+	gc->chip.label = name;
+	gc->chip.ngpio = 8;
+	gc->chip.get = f81504_gpio_get;
+	gc->chip.set = f81504_gpio_set;
+	gc->chip.direction_input = f81504_gpio_direction_in;
+	gc->chip.direction_output = f81504_gpio_direction_out;
+	gc->chip.get_direction = f81504_gpio_get_direction;
+	gc->chip.can_sleep = 1;
+	gc->chip.base = -1;
+	gc->idx = gpio_idx;
+
+	return gpiochip_add_data(&gc->chip, gc);
+}
+
+static int f81504_gpio_remove(struct platform_device *pdev)
+{
+	struct f81504_gpio_chip *gc = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&gc->chip);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(f81504_gpio_pm_ops, f81504_gpio_suspend,
+		f81504_gpio_resume);
+
+static struct platform_driver f81504_gpio_driver = {
+	.driver = {
+		.name	= F81504_GPIO_NAME,
+		.pm     = &f81504_gpio_pm_ops,
+	},
+	.probe		= f81504_gpio_probe,
+	.remove		= f81504_gpio_remove,
+};
+
+module_platform_driver(f81504_gpio_driver);
+
+MODULE_AUTHOR("Peter Hong <Peter_Hong@fintek.com.tw>");
+MODULE_DESCRIPTION("Fintek F81504/508/512 PCIE GPIOLIB driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
