From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3 01/10] serial: exar: Leave MPIOs as output for Commtech adapters
Date: Fri, 26 May 2017 18:02:28 +0200
Message-ID: <75735f97cf0d453207831effb5bc284704f2a554.1495814557.git.jan.kiszka@siemens.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1495814557.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1495814557.git.jan.kiszka@siemens.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

Commtech adapters apparently need the original setting as outputs, see
https://marc.info/?l=linux-gpio&m=149557425201323&w=2. Account for that.

Fixes: 7dea8165f1d6 ("serial: exar: Preconfigure xr17v35x MPIOs as output")

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index b4fa585156c7..8984e8b2d524 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -171,19 +171,26 @@ pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	return default_setup(priv, pcidev, idx, offset, port);
 }
 
-static void setup_gpio(u8 __iomem *p)
+static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 {
+	/*
+	 * The Commtech adapters required the MPIOs to be driven low. The Exar
+	 * devices will export them as GPIOs, so we pre-configure them safely
+	 * as inputs.
+	 */
+	u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
+
 	writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
 	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
-	writeb(0xff, p + UART_EXAR_MPIOSEL_7_0);
+	writeb(dir,  p + UART_EXAR_MPIOSEL_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
 	writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
-	writeb(0xff, p + UART_EXAR_MPIOSEL_15_8);
+	writeb(dir,  p + UART_EXAR_MPIOSEL_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
 }
 
@@ -236,7 +243,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 
 	if (idx == 0) {
 		/* Setup Multipurpose Input/Output pins. */
-		setup_gpio(p);
+		setup_gpio(pcidev, p);
 
 		port->port.private_data = xr17v35x_register_gpio(pcidev);
 	}
-- 
2.12.0

