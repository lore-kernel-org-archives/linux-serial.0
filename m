From: Michael Moese <michael.moese@men.de>
Subject: [PATCH v2 2/2] Introduce 8250_men_mcb
Date: Wed, 2 Aug 2017 09:58:53 +0200
Message-ID: <20170802075853.18911-2-michael.moese@men.de>
References: <20170802075853.18911-1-michael.moese@men.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802075853.18911-1-michael.moese@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: michael.moese@men.de, johannes.thumshirn@suse.de
List-Id: linux-serial@vger.kernel.org

This patch introduces the 8250_men_mcb driver for the MEN 16Z125
IP-Core. This is a 16550-type UART with a 60 byte FIFO.
Due to strange old hardware, every board using this IP core requires
different values for uartclk. A reasonable default is included in
addition to the support of three boards. Additional values for other
boards will be added later.

This v2 has some whitespace fixes, I screwed this up yesterday.

Signed-off-by: Michael Moese <michael.moese@men.de>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 118 +++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig        |  11 +++
 drivers/tty/serial/8250/Makefile       |   1 +
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_men_mcb.c

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
new file mode 100644
index 000000000000..308977807994
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -0,0 +1,118 @@
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mcb.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+#include <uapi/linux/serial_core.h>
+
+struct serial_8250_men_mcb_data {
+	struct uart_8250_port uart;
+	int line;
+};
+
+/*
+ * The Z125 16550-compatible UART has no fixed base clock assigned
+ * So, depending on the board we're on, we need to adjust the
+ * parameter in order to really set the correct baudrate, and
+ * do so if possible without user interaction
+ */
+static u32 men_z125_lookup_uartclk(struct mcb_device *mdev)
+{
+	/* use default value if board is not available below */
+	u32 clkval = 1041666;
+
+	dev_info(&mdev->dev, "%s on board %s\n",
+		dev_name(&mdev->dev),
+		mdev->bus->name);
+	if  (strncmp(mdev->bus->name, "F075", 4) == 0)
+		clkval = 1041666;
+	else if  (strncmp(mdev->bus->name, "F216", 4) == 0)
+		clkval = 1843200;
+	else if (strncmp(mdev->bus->name, "G215", 4) == 0)
+		clkval = 1843200;
+	else
+		dev_info(&mdev->dev,
+			 "board not detected, using default uartclk\n");
+
+	clkval = clkval  << 4;
+
+	return clkval;
+}
+
+static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
+				     const struct mcb_device_id *id)
+{
+	struct serial_8250_men_mcb_data *data;
+	struct resource *mem;
+
+	data = devm_kzalloc(&mdev->dev,
+			    sizeof(struct serial_8250_men_mcb_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mcb_set_drvdata(mdev, data);
+	data->uart.port.dev = mdev->dma_dev;
+	spin_lock_init(&data->uart.port.lock);
+
+	data->uart.port.type = PORT_16550;
+	data->uart.port.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	data->uart.port.iotype = UPIO_MEM;
+	data->uart.port.uartclk = men_z125_lookup_uartclk(mdev);
+	data->uart.port.regshift = 0;
+	data->uart.port.fifosize = 60;
+
+	mem = mcb_get_resource(mdev, IORESOURCE_MEM);
+	if (mem == NULL)
+		return -ENXIO;
+
+	data->uart.port.irq = mcb_get_irq(mdev);
+
+	data->uart.port.membase = devm_ioremap_resource(&mdev->dev, mem);
+	if (IS_ERR(data->uart.port.membase))
+		return PTR_ERR_OR_ZERO(data->uart.port.membase);
+
+	data->uart.port.mapbase = (unsigned long) mem->start;
+	data->uart.port.iobase = data->uart.port.mapbase;
+
+	/* ok, register the port */
+	data->line = serial8250_register_8250_port(&data->uart);
+	if (data->line < 0)
+		return data->line;
+
+	dev_info(&mdev->dev, "found 16Z125 UART: ttyS%d\n", data->line);
+
+	return 0;
+}
+
+static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
+{
+	struct serial_8250_men_mcb_data *data = mcb_get_drvdata(mdev);
+
+	if (data)
+		serial8250_unregister_port(data->line);
+}
+
+static const struct mcb_device_id serial_8250_men_mcb_ids[] = {
+	{ .device = 0x7d },
+	{ }
+};
+MODULE_DEVICE_TABLE(mcb, serial_8250_men_mcb_ids);
+
+static struct mcb_driver mcb_driver = {
+	.driver = {
+		.name = "8250_men_mcb",
+		.owner = THIS_MODULE,
+	},
+	.probe = serial_8250_men_mcb_probe,
+	.remove = serial_8250_men_mcb_remove,
+	.id_table = serial_8250_men_mcb_ids,
+};
+module_mcb_driver(mcb_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MEN 16z125 8250 UART driver");
+MODULE_AUTHOR("Michael Moese <michael.moese@men.de");
+MODULE_ALIAS("mcb:16z125");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index a1161ec0256f..a5c0ef1e7695 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -155,6 +155,17 @@ config SERIAL_8250_CS
 
 	  If unsure, say N.
 
+config SERIAL_8250_MEN_MCB
+	tristate "MEN Z125 UART device support"
+	depends on MCB && SERIAL_8250
+	help
+	  This enables support for FPGA based UARTs found on many MEN
+	  boards. This driver enables support for the Z125 UARTs.
+
+	  To compile this driver as a module, chose M here: the
+	  module will be called 8250_men_mcb.
+
+
 config SERIAL_8250_NR_UARTS
 	int "Maximum number of 8250/16550 serial ports"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index a44a99a3e623..6a18d2d768fe 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
+obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
 obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
-- 
2.12.3
