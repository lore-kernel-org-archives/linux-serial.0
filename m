From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v5 10/11] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Fri,  2 Jun 2017 09:28:53 +0200
Message-ID: <f8b03cad4ea23bf64f9e1fe29f38a1998b458293.1496388533.git.jan.kiszka@siemens.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1496388533.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1496388533.git.jan.kiszka@siemens.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
rest is required to operate the UART. To allow modeling this case,
expand the platform device data structure to specify a (consecutive) pin
subset for exporting by the gpio-exar driver.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpio-exar.c            | 52 +++++++++++++++++++++----------------
 drivers/tty/serial/8250/8250_exar.c | 15 ++++++++---
 2 files changed, 41 insertions(+), 26 deletions(-)

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
index 1106f1f58c77..bd0e40e869b8 100644
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
@@ -201,7 +202,8 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 }
 
 static void *
-__xr17v35x_register_gpio(struct pci_dev *pcidev)
+__xr17v35x_register_gpio(struct pci_dev *pcidev,
+			 const struct property_entry *properties)
 {
 	struct platform_device *pdev;
 
@@ -212,7 +214,8 @@ __xr17v35x_register_gpio(struct pci_dev *pcidev)
 	pdev->dev.parent = &pcidev->dev;
 	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
 
-	if (platform_device_add(pdev) < 0) {
+	if (platform_device_add_properties(pdev, properties) < 0 ||
+	    platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
 	}
@@ -220,12 +223,18 @@ __xr17v35x_register_gpio(struct pci_dev *pcidev)
 	return pdev;
 }
 
+static const struct property_entry exar_gpio_properties[] = {
+	PROPERTY_ENTRY_U32("gpio-exar,first-pin", 0),
+	PROPERTY_ENTRY_U32("ngpios", 16),
+	{ }
+};
+
 static int xr17v35x_register_gpio(struct pci_dev *pcidev,
 				  struct uart_8250_port *port)
 {
 	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
 		port->port.private_data =
-			__xr17v35x_register_gpio(pcidev);
+			__xr17v35x_register_gpio(pcidev, exar_gpio_properties);
 
 	return 0;
 }
-- 
2.12.3
