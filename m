From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 5/6] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Thu, 18 May 2017 16:59:08 +0200
Message-ID: <357209721396d57cb871ae69d72308b1a7c9cbd7.1495119548.git.jan.kiszka@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495119548.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1495119548.git.jan.kiszka@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
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
 drivers/gpio/gpio-exar.c                | 28 +++++++++++++++++++---------
 drivers/tty/serial/8250/8250_exar.c     |  7 +++++--
 include/linux/platform_data/gpio-exar.h |  3 +++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index d8b6296c11de..e0698a1ae012 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -32,6 +32,7 @@ struct exar_gpio_chip {
 	int index;
 	void __iomem *regs;
 	char name[20];
+	unsigned int first_gpio;
 };
 
 static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
@@ -52,9 +53,11 @@ static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
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
@@ -74,10 +77,12 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 
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
 	val = exar_get(chip, addr) & BIT(offset % 8);
 
@@ -86,10 +91,12 @@ static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 
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
 	val = exar_get(chip, addr) & BIT(offset % 8);
 
@@ -99,9 +106,11 @@ static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
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
@@ -154,9 +163,10 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	exar_gpio->gpio_chip.get = exar_get_value;
 	exar_gpio->gpio_chip.set = exar_set_value;
 	exar_gpio->gpio_chip.base = -1;
-	exar_gpio->gpio_chip.ngpio = 16;
+	exar_gpio->gpio_chip.ngpio = pdata->ngpio;
 	exar_gpio->regs = p;
 	exar_gpio->index = index;
+	exar_gpio->first_gpio = pdata->first_gpio;
 
 	ret = devm_gpiochip_add_data(&pdev->dev,
 				     &exar_gpio->gpio_chip, exar_gpio);
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 0a806daaff8b..d9c52288d6c9 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -189,7 +189,8 @@ static void setup_gpio(u8 __iomem *p)
 }
 
 static void *
-xr17v35x_register_gpio(struct pci_dev *pcidev)
+xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_gpio,
+		       unsigned int ngpio)
 {
 	struct platform_device *pdev;
 	struct gpio_exar_pdata pdata;
@@ -199,6 +200,8 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 		return NULL;
 
 	pdata.parent = pcidev;
+	pdata.first_gpio = first_gpio;
+	pdata.ngpio = ngpio;
 
 	if (platform_device_add_data(pdev, &pdata, sizeof(pdata)) < 0 ||
 	    platform_device_add(pdev) < 0) {
@@ -242,7 +245,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(p);
 
-		port->port.private_data = xr17v35x_register_gpio(pcidev);
+		port->port.private_data = xr17v35x_register_gpio(pcidev, 0, 16);
 	}
 
 	return 0;
diff --git a/include/linux/platform_data/gpio-exar.h b/include/linux/platform_data/gpio-exar.h
index 1a13e9ddaf7d..1754f5a2842d 100644
--- a/include/linux/platform_data/gpio-exar.h
+++ b/include/linux/platform_data/gpio-exar.h
@@ -17,6 +17,9 @@ struct pci_dev;
 
 struct gpio_exar_pdata {
 	struct pci_dev *parent;
+
+	unsigned int first_gpio;
+	unsigned int ngpio;
 };
 
 #endif /* __GPIO_EXAR_PDATA_H */
-- 
2.12.0
