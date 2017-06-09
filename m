From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v6 01/10] gpio-exar/8250-exar: Do not even instantiate a GPIO device for Commtech cards
Date: Fri,  9 Jun 2017 20:33:09 +0200
Message-ID: <4c5f5a761255c584e57fb96e35021104367616e5.1497033197.git.jan.kiszka@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

Commtech adapters need the MPIOs for internal purposes, and the
gpio-exar driver already refused to pick them up. But there is actually
no point in even creating the underlying platform device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-exar.c            | 3 ---
 drivers/tty/serial/8250/8250_exar.c | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 081076771217..006a9a67c2a4 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -124,9 +124,6 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	void __iomem *p;
 	int index, ret;
 
-	if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
-		return -ENODEV;
-
 	/*
 	 * Map the pci device to get the register addresses.
 	 * We will need to read and write those registers to control
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 8984e8b2d524..c29c7e675890 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -245,7 +245,9 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(pcidev, p);
 
-		port->port.private_data = xr17v35x_register_gpio(pcidev);
+		if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
+			port->port.private_data =
+				xr17v35x_register_gpio(pcidev);
 	}
 
 	return 0;
-- 
2.12.3
