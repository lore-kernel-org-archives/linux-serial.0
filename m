From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Tue, 16 May 2006 11:48:00 +0200
Message-ID: <87slnapagf.fsf@LKG7F3A44.lan>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<20060511222001.GC28693@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adicia.telenet-ops.be ([195.130.132.56]:54169 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1750729AbWEPL42 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 May 2006 07:56:28 -0400
In-Reply-To: <20060511222001.GC28693@flint.arm.linux.org.uk> (Russell King's
	message of "Thu, 11 May 2006 23:20:01 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, tnt@246tNt.com
Cc: linux-serial@vger.kernel.org

>>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:

Hi,

Sorry for the slow reply, I've been away all weekend...

 >> Comments and suggestions are welcome. I'm especially wondering about
 >> the fact that I'm hijacking the device nodes used by the mpc52xx_uart
 >> driver ..

 Russell> That's for the mpc52xx folk to comment about.  I personally
 Russel>  don't like> it.

What do you say Sylvain? Reusing device nodes seems pretty common
(pxa.c, at91_serial.c, ..), and I cannot imagine anyone making a
system with uartlite and mpc52xx UARTs ..

 >> +static inline void serial_out(struct uart_port *port, int offset, int

 Russell> Since there's no additional complication here, do you need separate
 Russell> serial_in/serial_out inline functions?

No, removed in updated patch.

 >> +static void ulite_stop_rx(struct uart_port *port)
 >> +{
 >> +	/* N/A */

 Russell> It would probably be a good idea to set a flag so that your interrupt
 Russell> handler can discard any input received after this function is called,
 Russell> rather than adding it into the ldisc queue regardless.

Done in updated patch.

 >> +			if (stat & ULITE_STATUS_OVERRUN) {
 >> +				tty_insert_flip_char(tty, 0, TTY_OVERRUN);
 >> +				port->icount.overrun++;
 >> +			}
 >> +
 >> +			if (stat & ULITE_STATUS_FRAME) {
 >> +				tty_insert_flip_char(tty, 0, TTY_FRAME);
 >> +				port->icount.frame++;
 >> +			}

 Russell> No proper handling of these special conditions - drivers are expected
 Russell> to take note of the termios settings and do the expected thing.  You
 Russell> can't rely on the tty layer to discard overrun, parity or frame
 Russell> conditions if they're not required.

Sorry, for some reason I completely missed
Documentation/serial/driver. Fixed in updated patch.

Talking about driver, the following seems wrong (or atleast doesn't
match 8250.c)

The interaction of the iflag bits is as follows (parity error
given as an example):
Parity error      INPCK   IGNPAR
None              n/a     n/a     character received
Yes               n/a     0       character discarded
Yes               0       1       character received, marked as
                                  TTY_NORMAL
Yes               1       1       character received, marked as
                                  TTY_PARITY

The actual behaviour of the code is the inverse of the IGNPAR column
(chars with parity gets discarded if IGNPAR is 1, and sent as
TTY_NORMAL / TTY_PARITY if it's 0).

Looking closer at it, there seems to be a bug in 8250.c if INPCK=0 and
IGNPAR=1. Characters with parity error should get discarded, but they
are forwarded as TTY_NORMAL because the parity bit is masked away
before the ignore_mask check in uart_insert_char.

 >> +static void ulite_console_write(struct console *co, const char *s,

 Russell> Should be using uart_console_write().

The updated patch does.

 >> +static int __devinit ulite_probe(struct platform_device *pdev)
 >> +{
 >> +	struct resource *res, *res2;
 >> +	struct uart_port *port;
 >> +	int ret;
 >> +
 >> +	if (pdev->id < 0 || pdev->id >= CONFIG_SERIAL_UARTLITE_NR_UARTS)
 >> +		return -EINVAL;
 >> +
 >> +	if (ports[pdev->id].iobase)
 >> +		return -EBUSY;
 >> +
 >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 >> +	if (!res)
 >> +		return -ENODEV;
 >> +
 >> +	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 >> +	if (!res2)
 >> +		return -ENODEV;
 >> +
 >> +	port = &ports[pdev->id];
 >> +
 >> +	port->fifosize	= 16;
 >> +	port->regshift	= 2;
 >> +	port->iotype	= UPIO_MEM;
 >> +	port->iobase	= 1; /* mark port in use */

 Russell> No.  If iobase isn't used, set it to zero.

Ok, the updated patch uses membase != 0 to track in use/free.

 >> +++ linux/include/linux/serial.h	2006-05-09 16:56:02.000000000 +0200
 >> @@ -76,7 +76,8 @@
 >> #define PORT_16654	11
 >> #define PORT_16850	12
 >> #define PORT_RSA	13	/* RSA-DV II/S card */
 >> -#define PORT_MAX	13
 >> +#define PORT_UARTLITE	14
 >> +#define PORT_MAX	14

 Russell> The first set of numbers are reserved for the 8250 driver.
 Russell> Please add to the _end_ of the port number list.  Also, use
 Russell> serial_core.h rather than serial.h please.

Updated patch uses serial_core.h

Thanks for the comments!

Updated patch:

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

---
 drivers/serial/Kconfig      |   27 ++
 drivers/serial/Makefile     |    1 
 drivers/serial/uartlite.c   |  497 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h |    3 
 4 files changed, 528 insertions(+)

Index: linux/drivers/serial/uartlite.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/serial/uartlite.c	2006-05-16 12:39:51.000000000 +0200
@@ -0,0 +1,497 @@
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
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/console.h>
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
+#define ULITE_REGION		16
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
+static int ulite_receive(struct uart_port *port, int stat)
+{
+	struct tty_struct *tty = port->info->tty;
+	unsigned char ch = 0;
+	char flag = TTY_NORMAL;
+
+	if ((stat & (ULITE_STATUS_RXVALID | ULITE_STATUS_OVERRUN
+		     | ULITE_STATUS_FRAME)) == 0)
+		return 0;
+
+	/* stats */
+	if (stat & ULITE_STATUS_RXVALID) {
+		port->icount.rx++;
+		ch = readb(port->membase + ULITE_RX);
+
+		if (stat & ULITE_STATUS_PARITY)
+			port->icount.parity++;
+	}
+
+	if (stat & ULITE_STATUS_OVERRUN)
+		port->icount.overrun++;
+
+	if (stat & ULITE_STATUS_FRAME)
+		port->icount.frame++;
+
+
+	/* drop byte with parity error if IGNPAR specificed */
+	if (stat & port->ignore_status_mask & ULITE_STATUS_PARITY)
+		stat &= ~ULITE_STATUS_RXVALID;
+
+	stat &= port->read_status_mask;
+
+	if (stat & ULITE_STATUS_PARITY)
+		flag = TTY_PARITY;
+
+
+	stat &= ~port->ignore_status_mask;
+
+	if (stat & ULITE_STATUS_RXVALID)
+		tty_insert_flip_char(tty, ch, flag);
+
+	if (stat & ULITE_STATUS_FRAME)
+		tty_insert_flip_char(tty, 0, TTY_FRAME);
+
+	if (stat & ULITE_STATUS_OVERRUN)
+		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+
+	return 1;
+}
+
+
+static int ulite_transmit(struct uart_port *port, int stat)
+{
+	struct circ_buf *xmit  = &port->info->xmit;
+
+	if (stat & ULITE_STATUS_TXFULL)
+		return 0;
+
+	if (port->x_char) {
+		writeb(port->x_char, port->membase + ULITE_TX);
+		port->x_char = 0;
+		port->icount.tx++;
+		return 1;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+		return 0;
+
+	writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX);
+	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
+	port->icount.tx++;
+
+	/* wake up */
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	return 1;
+}
+
+
+static irqreturn_t ulite_isr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct uart_port *port = (struct uart_port *)dev_id;
+	int busy;
+
+	do {
+		int stat = readb(port->membase + ULITE_STATUS);
+		busy  = ulite_receive(port, stat);
+		busy |= ulite_transmit(port, stat);
+	} while (busy);
+
+	tty_flip_buffer_push(port->info->tty);
+
+	return IRQ_HANDLED;
+}
+
+static unsigned int ulite_tx_empty(struct uart_port *port)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+	ret = readb(port->membase + ULITE_STATUS);
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
+	ulite_transmit(port, readb(port->membase + ULITE_STATUS));
+}
+
+static void ulite_stop_rx(struct uart_port *port)
+{
+	/* don't forward any more data (like !CREAD) */
+	port->ignore_status_mask = ULITE_STATUS_RXVALID | ULITE_STATUS_PARITY
+		| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
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
+static int ulite_startup(struct uart_port *port)
+{
+	int ret;
+
+	ret = request_irq(port->irq, ulite_isr,
+			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "uartlite", port);
+	if (ret)
+		return ret;
+
+	writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
+	       port->membase + ULITE_CONTROL);
+	writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+
+	return 0;
+}
+
+static void ulite_shutdown(struct uart_port *port)
+{
+	writeb(0, port->membase + ULITE_CONTROL);
+	free_irq(port->irq, port);
+}
+
+static void ulite_set_termios(struct uart_port *port, struct termios *termios,
+			      struct termios *old)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	port->read_status_mask = ULITE_STATUS_RXVALID | ULITE_STATUS_OVERRUN
+		| ULITE_STATUS_TXFULL;
+
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |=
+			ULITE_STATUS_PARITY | ULITE_STATUS_FRAME;
+
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= ULITE_STATUS_PARITY
+			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
+
+	/* ignore all characters if CREAD is not set */
+	if ((termios->c_cflag & CREAD) == 0)
+		port->ignore_status_mask |=
+			ULITE_STATUS_RXVALID | ULITE_STATUS_PARITY
+			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *ulite_type(struct uart_port *port)
+{
+	return port->type == PORT_UARTLITE ? "uartlite" : NULL;
+}
+
+static void ulite_release_port(struct uart_port *port)
+{
+	release_mem_region(port->mapbase, ULITE_REGION);
+	iounmap(port->membase);
+	port->membase = 0;
+}
+
+static int ulite_request_port(struct uart_port *port)
+{
+	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
+		dev_err(port->dev, "Memory region busy\n");
+		return -EBUSY;
+	}
+
+	port->membase = ioremap(port->mapbase, ULITE_REGION);
+	if (!port->membase) {
+		dev_err(port->dev, "Unable to map registers\n");
+		release_mem_region(port->mapbase, ULITE_REGION);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void ulite_config_port(struct uart_port *port, int flags)
+{
+	ulite_request_port(port);
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
+static void ulite_console_wait_tx(struct uart_port *port)
+{
+	int i;
+
+	/* wait up to 10ms for the character(s) to be sent */
+	for (i=0; i<10000; i++) {
+		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
+			break;
+		udelay(1);
+	}
+}
+
+static void ulite_console_putchar(struct uart_port *port, int ch)
+{
+	ulite_console_wait_tx(port);
+	writeb(ch, port->membase + ULITE_TX);
+}
+
+static void ulite_console_write(struct console *co, const char *s,
+				unsigned int count)
+{
+	struct uart_port *port = &ports[co->index];
+	unsigned long flags;
+	unsigned int ier;
+	int locked = 1;
+
+	if (oops_in_progress) {
+		locked = spin_trylock_irqsave(&port->lock, flags);
+	} else
+		spin_lock_irqsave(&port->lock, flags);
+
+	/* save and disable interrupt */
+	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
+	writeb(0, port->membase + ULITE_CONTROL);
+
+	uart_console_write(port, s, count, ulite_console_putchar);
+
+	ulite_console_wait_tx(port);
+
+	/* restore interrupt state */
+	if (ier)
+		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+
+	if (locked)
+		spin_unlock_irqrestore(&port->lock, flags);
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
+	if (!port->membase)
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
+	if (ports[pdev->id].membase)
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
+	port->mapbase	= res->start;
+	port->membase	= 0;
+	port->ops	= &ulite_ops;
+	port->irq	= res2->start;
+	port->flags	= UPF_BOOT_AUTOCONF;
+	port->dev	= &pdev->dev;
+	port->type	= PORT_UNKNOWN;
+
+	uart_add_one_port(&ulite_uart_driver, port);
+	platform_set_drvdata(pdev, port);
+	return 0;
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
+	/* mark port as free */
+	port->membase = 0;
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
--- linux.orig/drivers/serial/Kconfig	2006-05-12 14:21:50.000000000 +0200
+++ linux/drivers/serial/Kconfig	2006-05-16 12:53:04.000000000 +0200
@@ -507,6 +507,33 @@
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_UARTLITE
+	tristate "Xilinx uartlite serial port support"
+	depends on XILINX_VIRTEX
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
--- linux.orig/drivers/serial/Makefile	2006-05-12 14:21:50.000000000 +0200
+++ linux/drivers/serial/Makefile	2006-05-12 14:22:18.000000000 +0200
@@ -55,3 +55,4 @@
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
 obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
+obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
Index: linux/include/linux/serial_core.h
===================================================================
--- linux.orig/include/linux/serial_core.h	2006-05-12 14:23:30.000000000 +0200
+++ linux/include/linux/serial_core.h	2006-05-12 14:24:11.000000000 +0200
@@ -130,6 +130,9 @@
 /* SUN4V Hypervisor Console */
 #define PORT_SUNHV	72
 
+/* Xilinx uartlite */
+#define PORT_UARTLITE	73
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>

--
Bye, Peter Korsgaard
