From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [RFC][PATCH] Xilinx uartlite serial driver
Date: Thu, 11 May 2006 16:23:08 +0200
Message-ID: <87ac9o3ak3.fsf@sleipner.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kuu212123311.barco.com ([212.123.3.11]:57435 "HELO
	kuuvir01.barco.com") by vger.kernel.org with SMTP id S1751791AbWEKOXM
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 May 2006 10:23:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Hi,

The following patch adds a driver for the Xilinx uartlite serial
controller used in boards with the PPC405 core in the Xilinx V2P/V4
fpgas.

The hardware is very simple (baudrate/start/stopbits fixed and
no break support). See the datasheet for details:

http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf

Comments and suggestions are welcome. I'm especially wondering about
the fact that I'm hijacking the device nodes used by the mpc52xx_uart
driver ..

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/serial/Kconfig    |   27 ++
 drivers/serial/Makefile   |    1 
 drivers/serial/uartlite.c |  434 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial.h    |    3 
 4 files changed, 464 insertions(+), 1 deletion(-)

Index: linux/drivers/serial/uartlite.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/serial/uartlite.c	2006-05-11 16:08:09.000000000 +0200
@@ -0,0 +1,434 @@
+/*
+ * uartlite.c: Serial driver for Xilinx uartlite serial controller
+ *
+ * Peter Korsgaard <jacmet@sunsite.dk>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/console.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+
+/* We use the ttyPSCx device nodes from the mpc52xx_uart driver as it would be
+   VERY unlikely to see a mpc52xx system with a uartlite. Perhaps we should get
+   a real LANANA range in the future */
+#define SERIAL_PSC_MAJOR	204
+#define SERIAL_PSC_MINOR	148
+
+/* For register details see datasheet:
+   http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
+*/
+#define ULITE_RX		0x00
+#define ULITE_TX		0x04
+#define ULITE_STATUS		0x08
+#define ULITE_CONTROL		0x0c
+
+#define ULITE_STATUS_RXVALID	0x01
+#define ULITE_STATUS_RXFULL	0x02
+#define ULITE_STATUS_TXEMPTY	0x04
+#define ULITE_STATUS_TXFULL	0x08
+#define ULITE_STATUS_IE		0x10
+#define ULITE_STATUS_OVERRUN	0x20
+#define ULITE_STATUS_FRAME	0x40
+#define ULITE_STATUS_PARITY	0x80
+
+#define ULITE_CONTROL_RST_TX	0x01
+#define ULITE_CONTROL_RST_RX	0x02
+#define ULITE_CONTROL_IE	0x10
+
+
+static struct uart_port ports[CONFIG_SERIAL_UARTLITE_NR_UARTS];
+
+
+static inline unsigned int serial_in(struct uart_port *port, int offset)
+{
+	return readb(port->membase + offset);
+}
+
+static inline void serial_out(struct uart_port *port, int offset, int value)
+{
+	writeb(value, port->membase + offset);
+}
+
+static unsigned int ulite_tx_empty(struct uart_port *port)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+	ret = serial_in(port, ULITE_STATUS);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int ulite_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+}
+
+static void ulite_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* N/A */
+}
+
+static void ulite_stop_tx(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static void ulite_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->info->xmit;
+	int stat;
+
+	stat = serial_in(port, ULITE_STATUS);
+	if (!(stat & ULITE_STATUS_TXFULL)) {
+		serial_out(port, ULITE_TX, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+}
+
+static void ulite_stop_rx(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static void ulite_enable_ms(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static void ulite_break_ctl(struct uart_port *port, int ctl)
+{
+	/* N/A */
+}
+
+static irqreturn_t ulite_isr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct uart_port *port = (struct uart_port *)dev_id;
+	struct tty_struct *tty = port->info->tty;
+	struct circ_buf *xmit  = &port->info->xmit;
+	int busy;
+
+	do {
+		int stat = serial_in(port, ULITE_STATUS);
+
+		busy = 0;
+
+		if (stat & (ULITE_STATUS_OVERRUN | ULITE_STATUS_FRAME
+			    | ULITE_STATUS_RXVALID)) {
+			busy = 1;
+
+			if (stat & ULITE_STATUS_OVERRUN) {
+				tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+				port->icount.overrun++;
+			}
+
+			if (stat & ULITE_STATUS_FRAME) {
+				tty_insert_flip_char(tty, 0, TTY_FRAME);
+				port->icount.frame++;
+			}
+
+			if (stat & ULITE_STATUS_RXVALID) {
+				unsigned char flag = TTY_NORMAL;
+
+				if (stat & ULITE_STATUS_PARITY) {
+					flag = TTY_PARITY; /* still received */
+					port->icount.parity++;
+				}
+
+				tty_insert_flip_char(
+					tty, serial_in(port, ULITE_RX), flag);
+				port->icount.rx++;
+			}
+		}
+
+		if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+			continue;
+
+		if (!(stat & ULITE_STATUS_TXFULL)) {
+			busy = 1;
+			serial_out(port, ULITE_TX, xmit->buf[xmit->tail]);
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			port->icount.tx++;
+		}
+
+		/* wake up */
+		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+			uart_write_wakeup(port);
+	} while (busy);
+
+	tty_flip_buffer_push(tty);
+
+	return IRQ_HANDLED;
+}
+
+static int ulite_startup(struct uart_port *port)
+{
+	int ret;
+
+	ret = request_irq(port->irq, ulite_isr,
+			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "uartlite", port);
+	if (ret)
+		return ret;
+
+	serial_out(port, ULITE_CONTROL,
+		   ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
+	serial_out(port, ULITE_CONTROL, ULITE_CONTROL_IE);
+
+	return 0;
+}
+
+static void ulite_shutdown(struct uart_port *port)
+{
+	serial_out(port, ULITE_CONTROL, 0);
+	free_irq(port->irq, port);
+}
+
+static void ulite_set_termios(struct uart_port *port, struct termios *termios,
+			      struct termios *old)
+{
+	/* N/A */
+}
+
+static const char *ulite_type(struct uart_port *port)
+{
+	return port->type == PORT_UARTLITE ? "uartlite" : NULL;
+}
+
+static void ulite_release_port(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static int ulite_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void ulite_config_port(struct uart_port *port, int flags)
+{
+	port->type = PORT_UARTLITE;
+}
+
+static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	/* we don't want the core code to modify any port params */
+	return -EINVAL;
+}
+
+static struct uart_ops ulite_ops = {
+	.tx_empty	= ulite_tx_empty,
+	.set_mctrl	= ulite_set_mctrl,
+	.get_mctrl	= ulite_get_mctrl,
+	.stop_tx	= ulite_stop_tx,
+	.start_tx	= ulite_start_tx,
+	.stop_rx	= ulite_stop_rx,
+	.enable_ms	= ulite_enable_ms,
+	.break_ctl	= ulite_break_ctl,
+	.startup	= ulite_startup,
+	.shutdown	= ulite_shutdown,
+	.set_termios	= ulite_set_termios,
+	.type		= ulite_type,
+	.release_port	= ulite_release_port,
+	.request_port	= ulite_request_port,
+	.config_port	= ulite_config_port,
+	.verify_port	= ulite_verify_port
+};
+
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+
+static void ulite_console_write(struct console *co, const char *s,
+				unsigned int count)
+{
+	struct uart_port *port = &ports[co->index];
+	int i;
+
+	/* disable interrupts */
+	serial_out(port, ULITE_CONTROL, 0);
+
+	for (i = 0; i < count; i++) {
+		/* line return handling */
+		if (*s == '\n')
+			serial_out(port, ULITE_TX, '\r');
+
+		serial_out(port, ULITE_TX, *s++);
+
+		/* wait until it's sent */
+		while (!(serial_in(port, ULITE_STATUS)
+			 & ULITE_STATUS_TXEMPTY)) ;
+	}
+
+	/* restore interrupt state */
+	serial_out(port, ULITE_CONTROL, ULITE_CONTROL_IE);
+}
+
+static int __init ulite_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+
+	if (co->index < 0 || co->index >= CONFIG_SERIAL_UARTLITE_NR_UARTS)
+		return -EINVAL;
+
+	port = &ports[co->index];
+
+	/* not initialized yet? */
+	if (!port->type)
+		return -ENODEV;
+
+	return 0;
+}
+
+static struct uart_driver ulite_uart_driver;
+
+static struct console ulite_console = {
+	.name	= "ttyPSC",
+	.write	= ulite_console_write,
+	.device	= uart_console_device,
+	.setup	= ulite_console_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1, /* Specified on the cmdline (e.g. console=ttyPSC0 ) */
+	.data	= &ulite_uart_driver,
+};
+
+static int __init ulite_console_init(void)
+{
+	register_console(&ulite_console);
+	return 0;
+}
+
+console_initcall(ulite_console_init);
+
+#endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
+
+static struct uart_driver ulite_uart_driver = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "uartlite",
+	.dev_name	= "ttyPSC",
+	.devfs_name	= "ttyPSC",
+	.major		= SERIAL_PSC_MAJOR,
+	.minor		= SERIAL_PSC_MINOR,
+	.nr		= CONFIG_SERIAL_UARTLITE_NR_UARTS,
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	.cons		= &ulite_console,
+#endif
+};
+
+static int __devinit ulite_probe(struct platform_device *pdev)
+{
+	struct resource *res, *res2;
+	struct uart_port *port;
+	int ret;
+
+	if (pdev->id < 0 || pdev->id >= CONFIG_SERIAL_UARTLITE_NR_UARTS)
+		return -EINVAL;
+
+	if (ports[pdev->id].iobase)
+		return -EBUSY;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res2)
+		return -ENODEV;
+
+	port = &ports[pdev->id];
+
+	port->fifosize	= 16;
+	port->regshift	= 2;
+	port->iotype	= UPIO_MEM;
+	port->iobase	= 1; /* mark port in use */
+	port->mapbase	= res->start;
+	port->ops	= &ulite_ops;
+	port->irq	= res2->start;
+	port->flags	= UPF_BOOT_AUTOCONF;
+	port->dev	= &pdev->dev;
+
+	if (!request_mem_region(res->start, res->end - res->start + 1,
+				pdev->name)) {
+		dev_err(&pdev->dev, "Memory region busy\n");
+		ret = -EBUSY;
+		goto request_mem_failed;
+	}
+
+	port->membase = ioremap(res->start, res->end - res->start + 1);
+	if (!port->membase) {
+		dev_err(&pdev->dev, "Unable to map registers\n");
+		ret = -EIO;
+		goto map_failed;
+	}
+
+	uart_add_one_port(&ulite_uart_driver, port);
+	platform_set_drvdata(pdev, port);
+	return 0;
+
+ map_failed:
+	release_mem_region(res->start, res->end - res->start + 1);
+ request_mem_failed:
+
+	return ret;
+}
+
+static int ulite_remove(struct platform_device *pdev)
+{
+	struct uart_port *port = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (port)
+		uart_remove_one_port(&ulite_uart_driver, port);
+
+	port->iobase = 0;
+
+	return 0;
+}
+
+static struct platform_driver ulite_platform_driver = {
+	.probe	= ulite_probe,
+	.remove	= ulite_remove,
+	.driver	= {
+		   .owner = THIS_MODULE,
+		   .name  = "uartlite",
+		   },
+};
+
+int __init ulite_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&ulite_uart_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&ulite_platform_driver);
+	if (ret)
+		uart_unregister_driver(&ulite_uart_driver);
+
+	return ret;
+}
+
+void __exit ulite_exit(void)
+{
+	platform_driver_unregister(&ulite_platform_driver);
+	uart_unregister_driver(&ulite_uart_driver);
+}
+
+module_init(ulite_init);
+module_exit(ulite_exit);
+
+MODULE_AUTHOR("Peter Korsgaard <jacmet@sunsite.dk>");
+MODULE_DESCRIPTION("Xilinx uartlite serial driver");
+MODULE_LICENSE("GPL");
Index: linux/drivers/serial/Kconfig
===================================================================
--- linux.orig/drivers/serial/Kconfig	2006-05-09 16:55:27.000000000 +0200
+++ linux/drivers/serial/Kconfig	2006-05-10 18:02:09.000000000 +0200
@@ -507,6 +507,33 @@
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_UARTLITE
+	tristate "Xilinx uartlite serial port support"
+	depends on PPC32
+	select SERIAL_CORE
+	help
+	  Say Y here if you want to use the Xilinx uartlite serial controller.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called uartlite.ko.
+
+config SERIAL_UARTLITE_NR_UARTS
+	int "Maximum number of Xilinx uartlite serial ports"
+	depends on SERIAL_UARTLITE
+	default "4"
+	help
+	  Set this to the number of serial ports you want the driver
+	  to support.
+
+config SERIAL_UARTLITE_CONSOLE
+	bool "Support for console on Xilinx uartlite serial port"
+	depends on SERIAL_UARTLITE=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say Y here if you wish to use a Xilinx uartlite as the system
+	  console (the system console is the device which receives all kernel
+	  messages and warnings and which allows logins in single user mode).
+
 config SERIAL_SUNCORE
 	bool
 	depends on SPARC
Index: linux/drivers/serial/Makefile
===================================================================
--- linux.orig/drivers/serial/Makefile	2006-05-09 16:55:27.000000000 +0200
+++ linux/drivers/serial/Makefile	2006-05-09 16:56:02.000000000 +0200
@@ -55,3 +55,4 @@
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
 obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
+obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
Index: linux/include/linux/serial.h
===================================================================
--- linux.orig/include/linux/serial.h	2006-05-09 16:55:27.000000000 +0200
+++ linux/include/linux/serial.h	2006-05-09 16:56:02.000000000 +0200
@@ -76,7 +76,8 @@
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13	/* RSA-DV II/S card */
-#define PORT_MAX	13
+#define PORT_UARTLITE	14
+#define PORT_MAX	14
 
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1

-- 
Bye, Peter Korsgaard
