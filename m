From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 5/6] tty: serial: Add RDA Micro UART driver
Date: Tue, 27 Jun 2017 02:55:19 +0200
Message-ID: <20170627005520.23731-6-afaerber@suse.de>
References: <20170627005520.23731-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170627005520.23731-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, service@rdamicro.com, zhao_steven@263.net, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add "rda" earlycon driver for RDA8810PL UART.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt |   6 ++
 drivers/tty/serial/Kconfig                      |  19 ++++
 drivers/tty/serial/Makefile                     |   1 +
 drivers/tty/serial/rda-uart.c                   | 117 ++++++++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 drivers/tty/serial/rda-uart.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0e2091c6fa6b..c97f8b64b3f1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -967,6 +967,12 @@
 			specified address. The serial port must already be
 			setup and configured. Options are not yet supported.
 
+		rda,<addr>
+			Start an early, polled-mode console on a serial port
+			of an RDA Micro SoC, such as RDA8810PL, at the
+			specified address. The serial port must already be
+			setup and configured. Options are not yet supported.
+
 		smh	Use ARM semihosting calls for early console.
 
 		s3c2410,<addr>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1f096e2bb398..25e106a62e06 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1707,6 +1707,25 @@ config SERIAL_OWL_CONSOLE
 	  Say 'Y' here if you wish to use Actions Semiconductor S500/S900 UART
 	  as the system console. Only earlycon is implemented currently.
 
+config SERIAL_RDA
+	bool "RDA Micro serial port support"
+	depends on ARCH_RDA || COMPILE_TEST
+	select SERIAL_CORE
+	help
+	  This driver is for RDA8810PL SoC's UART.
+	  Say 'Y' here if you wish to use the on-board serial port.
+	  Otherwise, say 'N'.
+
+config SERIAL_RDA_CONSOLE
+	bool "Console on RDA Micro serial port"
+	depends on SERIAL_RDA=y
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	default y
+	help
+	  Say 'Y' here if you wish to use the RDA8810PL UART as the system
+	  console. Only earlycon is implemented currently.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index fe88a75d9a59..87f5a6e1e2d4 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_SERIAL_MVEBU_UART)	+= mvebu-uart.o
 obj-$(CONFIG_SERIAL_PIC32)	+= pic32_uart.o
 obj-$(CONFIG_SERIAL_MPS2_UART)	+= mps2-uart.o
 obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
+obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
new file mode 100644
index 000000000000..c3c9cf1df015
--- /dev/null
+++ b/drivers/tty/serial/rda-uart.c
@@ -0,0 +1,117 @@
+/*
+ * RDA8810PL serial console
+ *
+ * Copyright RDA Microelectronics Company Limited
+ * Copyright (c) 2017 Andreas Färber
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#define RDA_UART_CTRL		0x00
+#define RDA_UART_STATUS		0x04
+#define RDA_UART_RXTX_BUFFER	0x08
+#define RDA_UART_IRQ_MASK	0x0c
+
+#define RDA_UART_STATUS_TX_FIFO_SPACE_MASK	(0x1f << 8)
+
+static inline void rda_uart_write(struct uart_port *port, u32 val, unsigned int off)
+{
+	writel(val, port->membase + off);
+}
+
+static inline u32 rda_uart_read(struct uart_port *port, unsigned int off)
+{
+	return readl(port->membase + off);
+}
+
+#ifdef CONFIG_SERIAL_RDA_CONSOLE
+
+static void rda_console_putchar(struct uart_port *port, int ch)
+{
+	if (!port->membase)
+		return;
+
+	while (!(rda_uart_read(port, RDA_UART_STATUS) & RDA_UART_STATUS_TX_FIFO_SPACE_MASK))
+		cpu_relax();
+
+	rda_uart_write(port, ch, RDA_UART_RXTX_BUFFER);
+}
+
+static void rda_uart_port_write(struct uart_port *port, const char *s,
+				u_int count)
+{
+	u32 old_irq_mask;
+	unsigned long flags;
+	int locked;
+
+	local_irq_save(flags);
+
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&port->lock);
+	else {
+		spin_lock(&port->lock);
+		locked = 1;
+	}
+
+	old_irq_mask = rda_uart_read(port, RDA_UART_IRQ_MASK);
+	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
+
+	uart_console_write(port, s, count, rda_console_putchar);
+
+	/* wait until all contents have been sent out */
+	while (!(rda_uart_read(port, RDA_UART_STATUS) & RDA_UART_STATUS_TX_FIFO_SPACE_MASK))
+		cpu_relax();
+
+	rda_uart_write(port, old_irq_mask, RDA_UART_IRQ_MASK);
+
+	if (locked)
+		spin_unlock(&port->lock);
+
+	local_irq_restore(flags);
+}
+
+static void rda_uart_early_console_write(struct console *co,
+					 const char *s,
+					 u_int count)
+{
+	struct earlycon_device *dev = co->data;
+
+	rda_uart_port_write(&dev->port, s, count);
+}
+
+static int __init
+rda_uart_early_console_setup(struct earlycon_device *device, const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = rda_uart_early_console_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(rda, "rda,8810pl-uart",
+		    rda_uart_early_console_setup);
+
+#endif /* CONFIG_SERIAL_RDA_CONSOLE */
-- 
2.12.3
