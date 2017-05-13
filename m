From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 7/8] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Sat, 13 May 2017 09:29:05 +0200
Message-ID: <49df8cbd7204a5f145834715ab353f03f417e1f8.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
rest is required to operate the UART. To allow modeling this case,
use device properties to specify a (consecutive) pin subset for
exporting by the gpio-exar driver.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-exar.c            | 31 ++++++++++++++++++++++---------
 drivers/tty/serial/8250/8250_exar.c | 16 ++++++++++++----
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 98bd3eb1290e..e2cb1d83e4b0 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -31,6 +31,7 @@ struct exar_gpio_chip {
 	int index;
 	void __iomem *regs;
 	char name[20];
+	unsigned int first_gpio;
 };
 
 static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
@@ -51,9 +52,11 @@ static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
 static int exar_set_direction(struct gpio_chip *chip, int direction,
 			      unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int bank, addr;
 
+	offset += exar_gpio->first_gpio;
+	bank = offset / 8;
 	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
 	exar_update(chip, addr, direction, offset % 8);
 	return 0;
@@ -73,10 +76,12 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int bank, addr;
 	int val;
 
+	offset += exar_gpio->first_gpio;
+	bank = offset / 8;
 	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
 	val = exar_get(chip, addr) >> (offset % 8);
 
@@ -85,10 +90,12 @@ static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int bank, addr;
 	int val;
 
+	offset += exar_gpio->first_gpio;
+	bank = offset / 8;
 	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
 	val = exar_get(chip, addr) >> (offset % 8);
 
@@ -98,9 +105,11 @@ static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
 			   int value)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int bank, addr;
 
+	offset += exar_gpio->first_gpio;
+	bank = offset / 8;
 	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
 	exar_update(chip, addr, value, offset % 8);
 }
@@ -123,6 +132,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	struct exar_gpio_chip *exar_gpio;
 	void __iomem *p;
 	int index, ret;
+	u32 val;
 
 	if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
 		return -ENODEV;
@@ -152,9 +162,12 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	exar_gpio->gpio_chip.get = exar_get_value;
 	exar_gpio->gpio_chip.set = exar_set_value;
 	exar_gpio->gpio_chip.base = -1;
-	exar_gpio->gpio_chip.ngpio = 16;
+	device_property_read_u32(&pdev->dev, "ngpio", &val);
+	exar_gpio->gpio_chip.ngpio = val;
 	exar_gpio->regs = p;
 	exar_gpio->index = index;
+	device_property_read_u32(&pdev->dev, "first_gpio", &val);
+	exar_gpio->first_gpio = val;
 
 	ret = devm_gpiochip_add_data(&pdev->dev,
 				     &exar_gpio->gpio_chip, exar_gpio);
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 2d056d1eeca3..8e9c0e9495f5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/tty.h>
 #include <linux/8250_pci.h>
+#include <linux/property.h>
 
 #include <asm/byteorder.h>
 
@@ -188,8 +189,14 @@ static void setup_gpio(u8 __iomem *p)
 }
 
 static void *
-xr17v35x_register_gpio(struct pci_dev *pcidev)
+xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_gpio,
+		       unsigned int ngpio)
 {
+	struct property_entry properties[] = {
+		PROPERTY_ENTRY_U32("first_gpio", first_gpio),
+		PROPERTY_ENTRY_U32("ngpio", ngpio),
+		{ }
+	};
 	struct platform_device *pdev;
 
 	pdev = platform_device_alloc("gpio_exar", PLATFORM_DEVID_AUTO);
@@ -197,10 +204,11 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 		return NULL;
 
 	/*
-	 * platform_device_add_data kmemdups the data, therefore we can safely
-	 * pass a stack reference.
+	 * platform_device_add_data and platform_device_add_properties copy
+	 * the data, therefore we can safely pass a stack references.
 	 */
 	if (platform_device_add_data(pdev, &pcidev, sizeof(pcidev)) < 0 ||
+	    platform_device_add_properties(pdev, properties) < 0 ||
 	    platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
@@ -242,7 +250,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(p);
 
-		port->port.private_data = xr17v35x_register_gpio(pcidev);
+		port->port.private_data = xr17v35x_register_gpio(pcidev, 0, 16);
 	}
 
 	return 0;
-- 
2.12.0
