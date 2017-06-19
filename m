From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v5 08/26] tty: serial: Add Actions Semi Owl UART earlycon
Date: Mon, 19 Jun 2017 03:46:40 +0200
Message-ID: <20170619014640.6829-2-afaerber@suse.de>
References: <7fff8813-cea4-0530-bf7b-3d0ad50d6e93@suse.de>
 <20170619014640.6829-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170619014640.6829-1-afaerber@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com, Thomas Liau <thomas.liau@actions-semi.com>, =?UTF-8?q?=E5=BC=A0=E4=B8=9C=E9=A3=8E?= <zhangdf@actions-semi.com>, =?UTF-8?q?=E5=88=98=E7=82=9C?= <liuwei@actions-semi.com>, =?UTF-8?q?=E5=BC=A0=E5=A4=A9=E7=9B=8A?= <tyzhang@actions-semi.com>, 96boards@ucrobotics.com, support@lemaker.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This implements an earlycon for Actions Semi S500/S900 SoCs.

Based on LeMaker linux-actions tree.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4 -> v5:
 * Squashed documentation (Greg)
 
 v3 -> v4: Unchanged
 
 v2 -> v3:
 * Adopted BIT() macro
 
 v1 -> v2:
 * Extended Kconfig help to mention earlycon (Arnd)
 * Spelled out Actions Semiconductor in Kconfig help
 * Adopted "actions" vendor prefix
 
 Documentation/admin-guide/kernel-parameters.txt |   6 ++
 drivers/tty/serial/Kconfig                      |  19 ++++
 drivers/tty/serial/Makefile                     |   1 +
 drivers/tty/serial/owl-uart.c                   | 135 ++++++++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 drivers/tty/serial/owl-uart.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb311bdccb7b..cc8a6bfcb299 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -961,6 +961,12 @@
 			must already be setup and configured. Options are not
 			yet supported.
 
+		owl,<addr>
+			Start an early, polled-mode console on a serial port
+			of an Actions Semi SoC, such as S500 or S900, at the
+			specified address. The serial port must already be
+			setup and configured. Options are not yet supported.
+
 		smh	Use ARM semihosting calls for early console.
 
 		s3c2410,<addr>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 07812a7ea2a4..1f096e2bb398 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1688,6 +1688,25 @@ config SERIAL_MVEBU_CONSOLE
 	  and warnings and which allows logins in single user mode)
 	  Otherwise, say 'N'.
 
+config SERIAL_OWL
+	bool "Actions Semi Owl serial port support"
+	depends on ARCH_ACTIONS || COMPILE_TEST
+	select SERIAL_CORE
+	help
+	  This driver is for Actions Semiconductor S500/S900 SoC's UART.
+	  Say 'Y' here if you wish to use the on-board serial port.
+	  Otherwise, say 'N'.
+
+config SERIAL_OWL_CONSOLE
+	bool "Console on Actions Semi Owl serial port"
+	depends on SERIAL_OWL=y
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	default y
+	help
+	  Say 'Y' here if you wish to use Actions Semiconductor S500/S900 UART
+	  as the system console. Only earlycon is implemented currently.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 53c03e005132..fe88a75d9a59 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_SERIAL_STM32)	+= stm32-usart.o
 obj-$(CONFIG_SERIAL_MVEBU_UART)	+= mvebu-uart.o
 obj-$(CONFIG_SERIAL_PIC32)	+= pic32_uart.o
 obj-$(CONFIG_SERIAL_MPS2_UART)	+= mps2-uart.o
+obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
new file mode 100644
index 000000000000..1b8008797a1b
--- /dev/null
+++ b/drivers/tty/serial/owl-uart.c
@@ -0,0 +1,135 @@
+/*
+ * Actions Semi Owl family serial console
+ *
+ * Copyright 2013 Actions Semi Inc.
+ * Author: Actions Semi, Inc.
+ *
+ * Copyright (c) 2016-2017 Andreas Färber
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
+#define OWL_UART_CTL	0x000
+#define OWL_UART_TXDAT	0x008
+#define OWL_UART_STAT	0x00c
+
+#define OWL_UART_CTL_TRFS_TX		BIT(14)
+#define OWL_UART_CTL_EN			BIT(15)
+#define OWL_UART_CTL_RXIE		BIT(18)
+#define OWL_UART_CTL_TXIE		BIT(19)
+
+#define OWL_UART_STAT_RIP		BIT(0)
+#define OWL_UART_STAT_TIP		BIT(1)
+#define OWL_UART_STAT_TFFU		BIT(6)
+#define OWL_UART_STAT_TRFL_MASK		(0x1f << 11)
+#define OWL_UART_STAT_UTBB		BIT(17)
+
+static inline void owl_uart_write(struct uart_port *port, u32 val, unsigned int off)
+{
+	writel(val, port->membase + off);
+}
+
+static inline u32 owl_uart_read(struct uart_port *port, unsigned int off)
+{
+	return readl(port->membase + off);
+}
+
+#ifdef CONFIG_SERIAL_OWL_CONSOLE
+
+static void owl_console_putchar(struct uart_port *port, int ch)
+{
+	if (!port->membase)
+		return;
+
+	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
+		cpu_relax();
+
+	owl_uart_write(port, ch, OWL_UART_TXDAT);
+}
+
+static void owl_uart_port_write(struct uart_port *port, const char *s,
+				u_int count)
+{
+	u32 old_ctl, val;
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
+	old_ctl = owl_uart_read(port, OWL_UART_CTL);
+	val = old_ctl | OWL_UART_CTL_TRFS_TX;
+	/* disable IRQ */
+	val &= ~(OWL_UART_CTL_RXIE | OWL_UART_CTL_TXIE);
+	owl_uart_write(port, val, OWL_UART_CTL);
+
+	uart_console_write(port, s, count, owl_console_putchar);
+
+	/* wait until all contents have been sent out */
+	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TRFL_MASK)
+		cpu_relax();
+
+	/* clear IRQ pending */
+	val = owl_uart_read(port, OWL_UART_STAT);
+	val |= OWL_UART_STAT_TIP | OWL_UART_STAT_RIP;
+	owl_uart_write(port, val, OWL_UART_STAT);
+
+	owl_uart_write(port, old_ctl, OWL_UART_CTL);
+
+	if (locked)
+		spin_unlock(&port->lock);
+
+	local_irq_restore(flags);
+}
+
+static void owl_uart_early_console_write(struct console *co,
+					 const char *s,
+					 u_int count)
+{
+	struct earlycon_device *dev = co->data;
+
+	owl_uart_port_write(&dev->port, s, count);
+}
+
+static int __init
+owl_uart_early_console_setup(struct earlycon_device *device, const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = owl_uart_early_console_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(owl, "actions,owl-uart",
+		    owl_uart_early_console_setup);
+
+#endif /* CONFIG_SERIAL_OWL_CONSOLE */
-- 
2.12.3

