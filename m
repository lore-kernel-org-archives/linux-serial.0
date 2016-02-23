From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V4 3/4] 8250: 8250_f81504: Add Fintek F81504/508/512 PCIE-to-UART/GPIO UART support
Date: Tue, 23 Feb 2016 14:30:02 +0800
Message-ID: <1456209003-22396-4-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1456209003-22396-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1456209003-22396-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

This driver is 8250 driver for F81504/508/512, it'll handle the serial
port operation of this device. This module will depend on
MFD_FINTEK_F81504_CORE.

The serial ports support from 50bps to 1.5Mbps with Linux baudrate
define excluding 1.0Mbps due to not support 16MHz clock source.

PCI Configuration Space Registers, set:0~11(Max):
    40h + 8 * set:
                   bit7~6: Clock source selector
                       00: 1.8432MHz
                       01: 18.432MHz
                       10: 24MHz
                       11: 14.769MHz
                   bit0: UART enable
    41h + 8 * set:
                   bit5~4: RX trigger multiple
                       00: 1x * trigger level
                       01: 2x * trigger level
                       10: 4x * trigger level
                       11: 8x * trigger level
                   bit1~0: FIFO Size
                       11: 128Bytes
    44h + 8 * set: UART IO address (LSB)
    45h + 8 * set: UART IO address (MSB)
    47h + 8 * set:
                   bit5: RTS invert (bit4 must enable)
                   bit4: RTS auto direction enable
                         0: RTS control by MCR
                         1: RTS driven high when TX, otherwise low

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_f81504.c | 250 ++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig       |  10 ++
 drivers/tty/serial/8250/Makefile      |   1 +
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_f81504.c

diff --git a/drivers/tty/serial/8250/8250_f81504.c b/drivers/tty/serial/8250/8250_f81504.c
new file mode 100644
index 0000000..2b6c3d3
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_f81504.c
@@ -0,0 +1,250 @@
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/mfd/f81504.h>
+
+#include "8250.h"
+
+static u32 baudrate_table[] = { 1500000, 1152000, 921600 };
+static u8 clock_table[] = { F81504_CLKSEL_24_MHZ, F81504_CLKSEL_18_46_MHZ,
+				F81504_CLKSEL_14_77_MHZ };
+
+/* We should do proper H/W transceiver setting before change to RS485 mode */
+static int f81504_rs485_config(struct uart_port *port,
+			       struct serial_rs485 *rs485)
+{
+	u8 setting;
+	u8 *index = port->private_data;
+	struct platform_device *pdev = container_of(port->dev,
+					struct platform_device, dev);
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+
+	pci_read_config_byte(pci_dev, F81504_UART_START_ADDR +
+			F81504_UART_OFFSET * *index + F81504_UART_MODE_OFFSET,
+			&setting);
+
+	if (!rs485)
+		rs485 = &port->rs485;
+	else if (rs485->flags & SER_RS485_ENABLED)
+		memset(rs485->padding, 0, sizeof(rs485->padding));
+	else
+		memset(rs485, 0, sizeof(*rs485));
+
+	/* F81504/508/512 not support RTS delay before or after send */
+	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Enable RTS H/W control mode */
+		setting |= F81504_RTS_CONTROL_BY_HW;
+
+		if (rs485->flags & SER_RS485_RTS_ON_SEND) {
+			/* RTS driving high on TX */
+			setting &= ~F81504_RTS_INVERT;
+		} else {
+			/* RTS driving low on TX */
+			setting |= F81504_RTS_INVERT;
+		}
+
+		rs485->delay_rts_after_send = 0;
+		rs485->delay_rts_before_send = 0;
+	} else {
+		/* Disable RTS H/W control mode */
+		setting &= ~(F81504_RTS_CONTROL_BY_HW | F81504_RTS_INVERT);
+	}
+
+	pci_write_config_byte(pci_dev, F81504_UART_START_ADDR +
+			F81504_UART_OFFSET * *index + F81504_UART_MODE_OFFSET,
+			setting);
+
+	if (rs485 != &port->rs485)
+		port->rs485 = *rs485;
+
+	return 0;
+}
+
+static int f81504_check_baudrate(u32 baud, size_t *idx)
+{
+	size_t index;
+
+	for (index = 0; index < ARRAY_SIZE(baudrate_table); ++index) {
+		/* Clock source must larger than desire baud rate */
+		if (baud > baudrate_table[index])
+			continue;
+
+		/* Find divisible clock source */
+		if (!(baudrate_table[index] % baud)) {
+			if (idx)
+				*idx = index;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static void f81504_set_termios(struct uart_port *port,
+		struct ktermios *termios, struct ktermios *old)
+{
+	struct platform_device *pdev = container_of(port->dev,
+					struct platform_device, dev);
+	struct pci_dev *dev = to_pci_dev(pdev->dev.parent);
+	unsigned int baud = tty_termios_baud_rate(termios);
+	u8 tmp, *offset = port->private_data;
+	size_t i;
+
+	/* Not support for B1000000 due to haven't 16MHz clock source */
+	do {
+		/* Read current clock source (masked with CLOCK_RATE_MASK) */
+		pci_read_config_byte(dev, F81504_UART_START_ADDR + *offset *
+				F81504_UART_OFFSET, &tmp);
+
+		if (baud <= 115200) {
+			/*
+			 * Direct use 1.8432MHz when baud rate smaller then or
+			 * equal 115200bps.
+			 */
+			port->uartclk = 115200 * 16;
+			pci_write_config_byte(dev, F81504_UART_START_ADDR +
+					*offset * F81504_UART_OFFSET,
+					tmp & ~F81504_CLOCK_RATE_MASK);
+			break;
+		}
+
+		if (!f81504_check_baudrate(baud, &i)) {
+			/* Had optimize value */
+			port->uartclk = baudrate_table[i] * 16;
+			tmp = (tmp & ~F81504_CLOCK_RATE_MASK) | clock_table[i];
+			pci_write_config_byte(dev, F81504_UART_START_ADDR +
+					*offset * F81504_UART_OFFSET, tmp);
+			break;
+		}
+
+		if (old && !f81504_check_baudrate(tty_termios_baud_rate(old),
+				NULL)) {
+			/*
+			 * If it can't found suitable clock source but had old
+			 * acceptable baud rate, we'll use it.
+			 */
+			baud = tty_termios_baud_rate(old);
+		} else {
+			/*
+			 * If it can't found suitable clock source and not old
+			 * config, we'll direct set 115200bps for future use.
+			 */
+			baud = 115200;
+		}
+
+		if (tty_termios_baud_rate(termios))
+			tty_termios_encode_baud_rate(termios, baud, baud);
+	} while (1);
+
+	serial8250_do_set_termios(port, termios, old);
+}
+
+static int f81504_register_port(struct platform_device *dev,
+		unsigned long address, int idx)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev.parent);
+	struct uart_8250_port port;
+	u8 *data;
+
+	memset(&port, 0, sizeof(port));
+	data = devm_kzalloc(&dev->dev, sizeof(u8), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	*data = idx;
+	port.port.iotype = UPIO_PORT;
+	port.port.irq = pci_dev->irq;
+	port.port.flags = UPF_SKIP_TEST | UPF_FIXED_TYPE | UPF_BOOT_AUTOCONF |
+			UPF_SHARE_IRQ;
+	port.port.uartclk = 1843200;
+	port.port.dev = &dev->dev;
+	port.port.iobase = address;
+	port.port.type = PORT_16550A;
+	port.port.fifosize = 128;
+	port.port.rs485_config = f81504_rs485_config;
+	port.port.set_termios = f81504_set_termios;
+	port.tx_loadsz = 32;
+	port.port.private_data = data;	/* Save current idx */
+
+	return serial8250_register_8250_port(&port);
+}
+
+static int f81504_serial_probe(struct platform_device *pdev)
+{
+	int line;
+	size_t *index = (size_t *)dev_get_platdata(&pdev->dev);
+	struct resource *io = platform_get_resource(pdev, IORESOURCE_IO, 0);
+
+	line = f81504_register_port(pdev, io->start, *index);
+	if (line < 0)
+		return line;
+
+	/*
+	 * Re-assign line to replace old port PCIE configuration space idx,
+	 * port idx is saved in per-port private data.
+	 */
+	*index = line;
+	return 0;
+}
+
+static int f81504_serial_remove(struct platform_device *pdev)
+{
+	size_t *line = (size_t *)dev_get_platdata(&pdev->dev);
+
+	serial8250_unregister_port(*line);
+	return 0;
+}
+
+
+#ifdef CONFIG_PM_SLEEP
+static int f81504_serial_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	size_t *line = (size_t *)dev_get_platdata(&pdev->dev);
+
+	serial8250_suspend_port(*line);
+	return 0;
+}
+
+static int f81504_serial_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	size_t *line = (size_t *)dev_get_platdata(&pdev->dev);
+	struct uart_8250_port *port = serial8250_get_port(*line);
+
+	f81504_rs485_config(&port->port, NULL);
+	serial8250_resume_port(*line);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(f81504_serial_pm_ops, f81504_serial_suspend,
+		f81504_serial_resume);
+
+static struct platform_driver f81504_serial_driver = {
+	.driver = {
+		.name	= F81504_SERIAL_NAME,
+		.pm     = &f81504_serial_pm_ops,
+	},
+	.probe		= f81504_serial_probe,
+	.remove		= f81504_serial_remove,
+};
+
+static int __init f81504_serial_init(void)
+{
+	return platform_driver_register(&f81504_serial_driver);
+}
+subsys_initcall(f81504_serial_init);
+
+static void __exit f81504_serial_exit(void)
+{
+	platform_driver_unregister(&f81504_serial_driver);
+}
+module_exit(f81504_serial_exit);
+
+MODULE_AUTHOR("Peter Hong <Peter_Hong@fintek.com.tw>");
+MODULE_DESCRIPTION("Fintek F81504/508/512 PCIE 16550A serial port driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index b03cb517..03586af 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -116,6 +116,16 @@ config SERIAL_8250_PCI
 	  Note that serial ports on NetMos 9835 Multi-I/O cards are handled
 	  by the parport_serial driver, enabled with CONFIG_PARPORT_SERIAL.
 
+config SERIAL_8250_F81504
+        tristate "Fintek F81504/508/512 16550 PCIE device support" if EXPERT
+        depends on SERIAL_8250 && MFD_FINTEK_F81504_CORE
+        default SERIAL_8250
+        help
+          This builds Fintek F81504/508/512 PCIE serial ports support.
+          You may be able to enable GPIO_F81504 to get GPIOLIB support if
+          the devices supported. Please enable MFD_FINTEK_F81504_CORE &
+          this with Y if you need a early console.
+
 config SERIAL_8250_HP300
 	tristate
 	depends on SERIAL_8250 && HP300
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index b9b9bca..c84245e 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
 obj-$(CONFIG_SERIAL_8250_GSC)		+= 8250_gsc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
+obj-$(CONFIG_SERIAL_8250_F81504)	+= 8250_f81504.o
 obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
 obj-$(CONFIG_SERIAL_8250_CS)		+= serial_cs.o
 obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
-- 
1.9.1

