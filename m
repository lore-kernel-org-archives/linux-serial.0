From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v4 8/9] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Tue, 30 May 2017 09:01:23 +0200
Message-ID: <0dc397840e180777e412158f8e7057c313e75b34.1496127684.git.jan.kiszka@siemens.com>
References: <cover.1496127684.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1496127684.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1496127684.git.jan.kiszka@siemens.com>
References: <cover.1496127684.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
rest is required to operate the UART. To allow modeling this case,
expand the platform device data structure to specify a (consecutive) pin
subset for exporting by the gpio-exar driver.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-exar.c            | 52 +++++++++++++++++++++----------------
 drivers/tty/serial/8250/8250_exar.c | 14 +++++++---
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 1a629831d45b..220e93ed9111 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -31,6 +31,7 @@ struct exar_gpio_chip {
 	int index;
 	void __iomem *regs;
 	char name[20];
+	unsigned int first_pin;
 };
 
 static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
@@ -51,11 +52,12 @@ static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
 static int exar_set_direction(struct gpio_chip *chip, int direction,
 			      unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
+		EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
+	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
 
-	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	exar_update(chip, addr, direction, offset % 8);
+	exar_update(chip, addr, direction, bit);
 	return 0;
 }
 
@@ -73,36 +75,33 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
-	int val;
-
-	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	val = exar_get(chip, addr) & BIT(offset % 8);
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
+		EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
+	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
 
-	return !!val;
+	return !!(exar_get(chip, addr) & BIT(bit));
 }
 
 static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
-	int val;
-
-	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
-	val = exar_get(chip, addr) & BIT(offset % 8);
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
+		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
 
-	return !!val;
+	return !!(exar_get(chip, addr) & BIT(bit));
 }
 
 static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
 			   int value)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
+		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
 
-	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
-	exar_update(chip, addr, value, offset % 8);
+	exar_update(chip, addr, value, bit);
 }
 
 static int exar_direction_output(struct gpio_chip *chip, unsigned int offset,
@@ -121,6 +120,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 {
 	struct pci_dev *pcidev = to_pci_dev(pdev->dev.parent);
 	struct exar_gpio_chip *exar_gpio;
+	u32 first_pin, ngpios;
 	void __iomem *p;
 	int index, ret;
 
@@ -132,6 +132,11 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (!p)
 		return -ENOMEM;
 
+	if (device_property_read_u32(&pdev->dev, "gpio-exar,first-pin",
+				     &first_pin) < 0 ||
+	    device_property_read_u32(&pdev->dev, "ngpios", &ngpios) < 0)
+		return -EINVAL;
+
 	exar_gpio = devm_kzalloc(&pdev->dev, sizeof(*exar_gpio), GFP_KERNEL);
 	if (!exar_gpio)
 		return -ENOMEM;
@@ -149,9 +154,10 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	exar_gpio->gpio_chip.get = exar_get_value;
 	exar_gpio->gpio_chip.set = exar_set_value;
 	exar_gpio->gpio_chip.base = -1;
-	exar_gpio->gpio_chip.ngpio = 16;
+	exar_gpio->gpio_chip.ngpio = ngpios;
 	exar_gpio->regs = p;
 	exar_gpio->index = index;
+	exar_gpio->first_pin = first_pin;
 
 	ret = devm_gpiochip_add_data(&pdev->dev,
 				     &exar_gpio->gpio_chip, exar_gpio);
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ee4b142f3ed0..1cdf125ffe30 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/slab.h>
@@ -196,8 +197,14 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 }
 
 static void *
-xr17v35x_register_gpio(struct pci_dev *pcidev)
+xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_pin,
+		       unsigned int ngpios)
 {
+	struct property_entry properties[] = {
+		PROPERTY_ENTRY_U32("gpio-exar,first-pin", first_pin),
+		PROPERTY_ENTRY_U32("ngpios", ngpios),
+		{ }
+	};
 	struct platform_device *pdev;
 
 	pdev = platform_device_alloc("gpio_exar", PLATFORM_DEVID_AUTO);
@@ -207,7 +214,8 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 	pdev->dev.parent = &pcidev->dev;
 	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
 
-	if (platform_device_add(pdev) < 0) {
+	if (platform_device_add_properties(pdev, properties) < 0 ||
+	    platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
 	}
@@ -250,7 +258,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 
 		if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
 			port->port.private_data =
-				xr17v35x_register_gpio(pcidev);
+				xr17v35x_register_gpio(pcidev, 0, 16);
 	}
 
 	return 0;
-- 
2.12.3
