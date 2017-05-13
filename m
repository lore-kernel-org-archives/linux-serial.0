From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/8] gpio: exar: Fix passing in of parent PCI device
Date: Sat, 13 May 2017 09:29:00 +0200
Message-ID: <20f1d241d134f9f4932a26e4bd873ffc250affce.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This fixes reloading of the driver for the same device: First of all,
the driver sets drvdata to its own value during probing and does not
restore the original value on exit. But this won't help anyway as the
core clears drvdata after the driver left.

Use stable platform_data instead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-exar.c            | 2 +-
 drivers/tty/serial/8250/8250_exar.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 081076771217..0a2085faf271 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -119,7 +119,7 @@ static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
 
 static int gpio_exar_probe(struct platform_device *pdev)
 {
-	struct pci_dev *pcidev = platform_get_drvdata(pdev);
+	struct pci_dev *pcidev = *(struct pci_dev **)pdev->dev.platform_data;
 	struct exar_gpio_chip *exar_gpio;
 	void __iomem *p;
 	int index, ret;
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index b4fa585156c7..2d056d1eeca3 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -196,8 +196,12 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 	if (!pdev)
 		return NULL;
 
-	platform_set_drvdata(pdev, pcidev);
-	if (platform_device_add(pdev) < 0) {
+	/*
+	 * platform_device_add_data kmemdups the data, therefore we can safely
+	 * pass a stack reference.
+	 */
+	if (platform_device_add_data(pdev, &pcidev, sizeof(pcidev)) < 0 ||
+	    platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
 	}
-- 
2.12.0
