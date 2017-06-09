From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v6 02/10] gpio-exar/8250-exar: Fix passing in of parent PCI device
Date: Fri,  9 Jun 2017 20:33:10 +0200
Message-ID: <6f2e19cfb8bcb9acf4b042e4db716e93286862d6.1497033197.git.jan.kiszka@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This fixes reloading of the GPIO driver for the same platform device
instance as created by the exar UART driver: First of all, the driver
sets drvdata to its own value during probing and does not restore the
original value on exit. But this won't help anyway as the core clears
drvdata after the driver left.

Set the platform device parent instead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-exar.c            | 2 +-
 drivers/tty/serial/8250/8250_exar.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 006a9a67c2a4..da4550bb9939 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -119,7 +119,7 @@ static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
 
 static int gpio_exar_probe(struct platform_device *pdev)
 {
-	struct pci_dev *pcidev = platform_get_drvdata(pdev);
+	struct pci_dev *pcidev = to_pci_dev(pdev->dev.parent);
 	struct exar_gpio_chip *exar_gpio;
 	void __iomem *p;
 	int index, ret;
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index c29c7e675890..0f4b236d7e68 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -203,7 +203,8 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 	if (!pdev)
 		return NULL;
 
-	platform_set_drvdata(pdev, pcidev);
+	pdev->dev.parent = &pcidev->dev;
+
 	if (platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
-- 
2.12.3
