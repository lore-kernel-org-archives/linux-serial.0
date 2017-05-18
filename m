From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 6/6] serial: exar: Add support for IOT2040 device
Date: Thu, 18 May 2017 16:59:09 +0200
Message-ID: <f0d2245527bc5700be7a4ac707a81db798cb5519.1495119548.git.jan.kiszka@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1495119548.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1495119548.git.jan.kiszka@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This implements the setup of RS232 and the switch-over to RS485 or RS422
for the Siemens IOT2040. That uses an EXAR XR17V352 with external logic
to switch between the different modes. The external logic is controlled
via MPIO pins of the EXAR controller.

Only pin 10 can be exported as GPIO on the IOT2040. It is connected to
an LED.

As the XR17V352 used on the IOT2040 is not equipped with an external
EEPROM, it cannot present itself as IOT2040-variant via subvendor/
subdevice IDs. Thus, we have to check via DMI for the target platform.

Co-developed with Sascha Weisenberger.

Signed-off-by: Sascha Weisenberger <sascha.weisenberger@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c | 136 ++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index d9c52288d6c9..5da6f1c27b50 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -9,6 +9,7 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License.
  */
+#include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -61,6 +62,45 @@
 #define UART_EXAR_MPIOSEL_15_8	0x99	/* MPIOSEL[15:8] */
 #define UART_EXAR_MPIOOD_15_8	0x9a	/* MPIOOD[15:8] */
 
+#define UART_EXAR_RS485_DLY(x)	(x << 4)
+
+/*
+ * IOT2040 MPIO wiring semantics:
+ *
+ * MPIO		Port	Function
+ * ----		----	--------
+ * 0		2 	Mode bit 0
+ * 1		2	Mode bit 1
+ * 2		2	Terminate bus
+ * 3		-	<reserved>
+ * 4		3	Mode bit 0
+ * 5		3	Mode bit 1
+ * 6		3	Terminate bus
+ * 7		-	<reserved>
+ * 8		2	Enable
+ * 9		3	Enable
+ * 10		-	Red LED
+ * 11..15	-	<unused>
+ */
+
+/* IOT2040 MPIOs 0..7 */
+#define IOT2040_UART_MODE_RS232		0x01
+#define IOT2040_UART_MODE_RS485		0x02
+#define IOT2040_UART_MODE_RS422		0x03
+#define IOT2040_UART_TERMINATE_BUS	0x04
+
+#define IOT2040_UART1_MASK		0x0f
+#define IOT2040_UART2_SHIFT		4
+
+#define IOT2040_UARTS_DEFAULT_MODE	0x11	/* both RS232 */
+#define IOT2040_UARTS_GPIO_LO_MODE	0x88	/* reserved pins as input */
+
+/* IOT2040 MPIOs 8..15 */
+#define IOT2040_UARTS_ENABLE		0x03
+#define IOT2040_UARTS_GPIO_HI_MODE	0xF8	/* enable & LED as outputs */
+
+static bool is_iot2040;
+
 struct exar8250;
 
 /**
@@ -212,6 +252,82 @@ xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_gpio,
 	return pdev;
 }
 
+static int iot2040_rs485_config(struct uart_port *port,
+				struct serial_rs485 *rs485)
+{
+	u8 __iomem *p = port->membase;
+	u8 mask = IOT2040_UART1_MASK;
+	u8 mode, value;
+	bool is_rs485 = false;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		is_rs485 = true;
+		if (rs485->flags & SER_RS485_RX_DURING_TX)
+			mode = IOT2040_UART_MODE_RS422;
+		else
+			mode = IOT2040_UART_MODE_RS485;
+
+		if (rs485->flags & SER_RS485_TERMINATE_BUS)
+			mode |= IOT2040_UART_TERMINATE_BUS;
+	} else {
+		mode = IOT2040_UART_MODE_RS232;
+	}
+
+	if (port->line == 3) {
+		mask <<= IOT2040_UART2_SHIFT;
+		mode <<= IOT2040_UART2_SHIFT;
+	}
+
+	value = readb(p + UART_EXAR_MPIOLVL_7_0);
+	value &= ~mask;
+	value |= mode;
+	writeb(value, p + UART_EXAR_MPIOLVL_7_0);
+
+	value = readb(p + UART_EXAR_FCTR);
+	if (is_rs485)
+		value |= UART_FCTR_EXAR_485;
+	else
+		value &= ~UART_FCTR_EXAR_485;
+	writeb(value, p + UART_EXAR_FCTR);
+
+	if (is_rs485)
+		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
+
+	return 0;
+}
+
+static int iot2040_setup_gpio(struct pci_dev *pcidev,
+			      struct uart_8250_port *port)
+{
+	u8 __iomem *p = port->port.membase;
+
+	writeb(IOT2040_UARTS_DEFAULT_MODE, p + UART_EXAR_MPIOLVL_7_0);
+	writeb(IOT2040_UARTS_GPIO_LO_MODE, p + UART_EXAR_MPIOSEL_7_0);
+	writeb(IOT2040_UARTS_ENABLE, p + UART_EXAR_MPIOLVL_15_8);
+	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
+
+	port->port.private_data = xr17v35x_register_gpio(pcidev, 10, 1);
+
+	return 0;
+}
+
+static int iot2040_match(const struct dmi_system_id *dmi)
+{
+	is_iot2040 = true;
+	return 1;
+}
+
+static const struct dmi_system_id exar_platforms[] = {
+	{
+		.callback = iot2040_match,
+		.ident = "IOT2040",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
+			DMI_MATCH(DMI_BOARD_ASSET_TAG, "6ES7647-0AA00-1YA2"),
+		},
+	}
+};
+
 static int
 pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
@@ -222,7 +338,13 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	u8 __iomem *p;
 	int ret;
 
+	dmi_check_system(exar_platforms);
+
 	port->port.uartclk = baud * 16;
+
+	if (is_iot2040)
+		port->port.rs485_config = iot2040_rs485_config;
+
 	/*
 	 * Setup the uart clock for the devices on expansion slot to
 	 * half the clock speed of the main chip (which is 125MHz)
@@ -241,14 +363,18 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	writeb(128, p + UART_EXAR_TXTRG);
 	writeb(128, p + UART_EXAR_RXTRG);
 
-	if (idx == 0) {
-		/* Setup Multipurpose Input/Output pins. */
-		setup_gpio(p);
+	if (idx != 0)
+		return 0;
+
+	/* Setup Multipurpose Input/Output pins. */
+	setup_gpio(p);
 
+	if (is_iot2040)
+		ret = iot2040_setup_gpio(pcidev, port);
+	else
 		port->port.private_data = xr17v35x_register_gpio(pcidev, 0, 16);
-	}
 
-	return 0;
+	return ret;
 }
 
 static void pci_xr17v35x_exit(struct pci_dev *pcidev)
-- 
2.12.0

