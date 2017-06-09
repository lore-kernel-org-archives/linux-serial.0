From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v6 07/10] serial: exar: Factor out platform hooks
Date: Fri,  9 Jun 2017 20:33:15 +0200
Message-ID: <8baf62a96105a2d8f84a73f887e55f6d86b7cae4.1497033197.git.jan.kiszka@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This prepares the addition of IOT2040 platform support by preparing the
needed setup and rs485_config hooks.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/8250/8250_exar.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ee4b142f3ed0..1106f1f58c77 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -63,6 +63,11 @@
 
 struct exar8250;
 
+struct exar8250_platform {
+	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
+	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
+};
+
 /**
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
@@ -196,7 +201,7 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 }
 
 static void *
-xr17v35x_register_gpio(struct pci_dev *pcidev)
+__xr17v35x_register_gpio(struct pci_dev *pcidev)
 {
 	struct platform_device *pdev;
 
@@ -215,17 +220,36 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 	return pdev;
 }
 
+static int xr17v35x_register_gpio(struct pci_dev *pcidev,
+				  struct uart_8250_port *port)
+{
+	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
+		port->port.private_data =
+			__xr17v35x_register_gpio(pcidev);
+
+	return 0;
+}
+
+static const struct exar8250_platform exar8250_default_platform = {
+	.register_gpio = xr17v35x_register_gpio,
+};
+
 static int
 pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
 {
 	const struct exar8250_board *board = priv->board;
+	const struct exar8250_platform *platform;
 	unsigned int offset = idx * 0x400;
 	unsigned int baud = 7812500;
 	u8 __iomem *p;
 	int ret;
 
+	platform = &exar8250_default_platform;
+
 	port->port.uartclk = baud * 16;
+	port->port.rs485_config = platform->rs485_config;
+
 	/*
 	 * Setup the uart clock for the devices on expansion slot to
 	 * half the clock speed of the main chip (which is 125MHz)
@@ -248,12 +272,10 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(pcidev, p);
 
-		if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
-			port->port.private_data =
-				xr17v35x_register_gpio(pcidev);
+		ret = platform->register_gpio(pcidev, port);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void pci_xr17v35x_exit(struct pci_dev *pcidev)
-- 
2.12.3
