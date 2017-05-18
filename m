From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 6/6] serial: exar: Add support for IOT2040 device
Date: Thu, 18 May 2017 19:23:22 +0200
Message-ID: <0f51a8dd-1a28-a5c1-7004-292fcde7c3d4@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
 <f0d2245527bc5700be7a4ac707a81db798cb5519.1495119548.git.jan.kiszka@siemens.com>
 <CAHp75VewiaiYq6esGTiTV8kG30krhuXLQgLFGn10jmjkooXGPA@mail.gmail.com>
 <65189e05-e300-bbe3-660d-4fdd6d4ec8c1@siemens.com>
 <f3959f33-b82a-e64a-c04d-bfa7ab486402@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <f3959f33-b82a-e64a-c04d-bfa7ab486402@siemens.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-18 18:58, Jan Kiszka wrote:
> On 2017-05-18 18:39, Jan Kiszka wrote:
>> On 2017-05-18 18:33, Andy Shevchenko wrote:
>>> On Thu, May 18, 2017 at 5:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>> This implements the setup of RS232 and the switch-over to RS485 or RS422
>>>> for the Siemens IOT2040. That uses an EXAR XR17V352 with external logic
>>>> to switch between the different modes. The external logic is controlled
>>>> via MPIO pins of the EXAR controller.
>>>>
>>>> Only pin 10 can be exported as GPIO on the IOT2040. It is connected to
>>>> an LED.
>>>>
>>>> As the XR17V352 used on the IOT2040 is not equipped with an external
>>>> EEPROM, it cannot present itself as IOT2040-variant via subvendor/
>>>> subdevice IDs. Thus, we have to check via DMI for the target platform.
>>>>
>>>> Co-developed with Sascha Weisenberger.
>>>
>>> Few nits below and one comment that should be addressed.
>>>
>>>> +#define UART_EXAR_RS485_DLY(x) (x << 4)
>>>
>>> ((x) << 4)
>>
>> Yep.
>>
>>>
>>>> +static bool is_iot2040;
>>>
>>> No, please, use driver data of DMI and hide this in corresponding structure.
>>> Or even assign  port->port.rs485_config in the callback function.
>>>
>>> Moreover, can't you use port->port.rs485_config != NULL instead?
>>
>> There are two cases to be handled on IOT2040: the setting of the
>> rs485_config and the different setup of the GPIOs, but the latter at a
>> specific point in the initialization only. So I don't see yet how
>> driver_data could come into play and help.
>>
> 
> OK, got - hacking...

It looks like this now (will resent as part of v3, just waiting for
further comments):

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index d9c52288d6c9..01826c094515 100644
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
@@ -61,8 +62,50 @@
 #define UART_EXAR_MPIOSEL_15_8	0x99	/* MPIOSEL[15:8] */
 #define UART_EXAR_MPIOOD_15_8	0x9a	/* MPIOOD[15:8] */
 
+#define UART_EXAR_RS485_DLY(x)	((x) << 4)
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
 struct exar8250;
 
+struct exar8250_platform {
+	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
+	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
+};
+
 /**
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
@@ -189,7 +232,7 @@ static void setup_gpio(u8 __iomem *p)
 }
 
 static void *
-xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_gpio,
+__xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_gpio,
 		       unsigned int ngpio)
 {
 	struct platform_device *pdev;
@@ -212,17 +255,113 @@ xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_gpio,
 	return pdev;
 }
 
+static int xr17v35x_register_gpio(struct pci_dev *pcidev,
+				  struct uart_8250_port *port)
+{
+	port->port.private_data = __xr17v35x_register_gpio(pcidev, 0, 16);
+
+	return 0;
+}
+
+static int iot2040_rs485_config(struct uart_port *port,
+				struct serial_rs485 *rs485)
+{
+	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
+	u8 __iomem *p = port->membase;
+	u8 mask = IOT2040_UART1_MASK;
+	u8 mode, value;
+
+	if (is_rs485) {
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
+static int iot2040_register_gpio(struct pci_dev *pcidev,
+			      struct uart_8250_port *port)
+{
+	u8 __iomem *p = port->port.membase;
+
+	writeb(IOT2040_UARTS_DEFAULT_MODE, p + UART_EXAR_MPIOLVL_7_0);
+	writeb(IOT2040_UARTS_GPIO_LO_MODE, p + UART_EXAR_MPIOSEL_7_0);
+	writeb(IOT2040_UARTS_ENABLE, p + UART_EXAR_MPIOLVL_15_8);
+	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
+
+	port->port.private_data = __xr17v35x_register_gpio(pcidev, 10, 1);
+
+	return 0;
+}
+
+static const struct exar8250_platform exar8250_default_platform = {
+	.register_gpio = xr17v35x_register_gpio,
+};
+
+static const struct exar8250_platform iot2040_platform = {
+	.rs485_config = iot2040_rs485_config,
+	.register_gpio = iot2040_register_gpio,
+};
+
+static const struct dmi_system_id exar_platforms[] = {
+	{
+		.ident = "IOT2040",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
+			DMI_MATCH(DMI_BOARD_ASSET_TAG, "6ES7647-0AA00-1YA2"),
+		},
+		.driver_data = (void *)&iot2040_platform,
+	}
+};
+
 static int
 pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
 {
 	const struct exar8250_board *board = priv->board;
+	const struct exar8250_platform *platform;
+	const struct dmi_system_id *dmi_match;
 	unsigned int offset = idx * 0x400;
 	unsigned int baud = 7812500;
 	u8 __iomem *p;
 	int ret;
 
+	dmi_match = dmi_first_match(exar_platforms);
+	if (dmi_match)
+		platform = dmi_match->driver_data;
+	else
+		platform = &exar8250_default_platform;
+
 	port->port.uartclk = baud * 16;
+	port->port.rs485_config = platform->rs485_config;
+
 	/*
 	 * Setup the uart clock for the devices on expansion slot to
 	 * half the clock speed of the main chip (which is 125MHz)
@@ -245,10 +384,10 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(p);
 
-		port->port.private_data = xr17v35x_register_gpio(pcidev, 0, 16);
+		ret = platform->register_gpio(pcidev, port);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void pci_xr17v35x_exit(struct pci_dev *pcidev)
-- 
2.12.
