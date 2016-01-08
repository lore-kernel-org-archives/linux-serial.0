From: Rich Felker <dalias@libc.org>
Subject: [PATCH] serial-uartlite: add earlycon support
Date: Fri, 8 Jan 2016 15:34:05 -0500
Message-ID: <20160108203405.GA24044@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Yasushi SHOJI <yashi@atmark-techno.com>
List-Id: linux-serial@vger.kernel.org

From: Rich Felker <dalias@libc.org>

Microblaze currently uses the old earlyprintk system, rather than the
unified earlycon support, to show boot messages on uartlite. Add
earlycon support so that other archs using uartlite can benefit from
it. The new code in uartlite.c is copied almost verbatim from
arch/microblaze/kernel/early_printk.c.

Signed-off-by: Rich Felker <dalias@libc.org>

---

Possibly also copy over copyright lines from
arch/microblaze/kernel/early_printk.c? I'm not sure whether they're
relevant so I Cc'd the authors. The bulk of the code in that file is
ugly setup for earlyprintk that's not needed for earlycon.

Switching Microblaze to earlycon, if desired, is left as a separate
task since I'm not working on that arch.

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f38beb2..aaf1b33 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -607,6 +607,7 @@ config SERIAL_UARTLITE_CONSOLE
 	bool "Support for console on Xilinx uartlite serial port"
 	depends on SERIAL_UARTLITE=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  Say Y here if you wish to use a Xilinx uartlite as the system
 	  console (the system console is the device which receives all kernel
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b1c6bd3..c249aee 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -519,6 +519,47 @@ static int __init ulite_console_init(void)
 
 console_initcall(ulite_console_init);
 
+static void early_uartlite_putc(struct uart_port *port, int c)
+{
+	/*
+	 * Limit how many times we'll spin waiting for TX FIFO status.
+	 * This will prevent lockups if the base address is incorrectly
+	 * set, or any other issue on the UARTLITE.
+	 * This limit is pretty arbitrary, unless we are at about 10 baud
+	 * we'll never timeout on a working UART.
+	 */
+
+	unsigned retries = 1000000;
+	/* read status bit - 0x8 offset */
+	while (--retries && (readl(port->membase + 8) & (1 << 3)))
+		;
+
+	/* Only attempt the iowrite if we didn't timeout */
+	/* write to TX_FIFO - 0x4 offset */
+	if (retries)
+		writel(c & 0xff, port->membase + 4);
+}
+
+static void early_uartlite_write(struct console *console,
+				 const char *s, unsigned n)
+{
+	struct earlycon_device *device = console->data;
+	uart_console_write(&device->port, s, n, early_uartlite_putc);
+}
+
+static int __init early_uartlite_setup(struct earlycon_device *device,
+				       const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = early_uartlite_write;
+	return 0;
+}
+EARLYCON_DECLARE(uartlite, early_uartlite_setup);
+OF_EARLYCON_DECLARE(uartlite_b, "xlnx,opb-uartlite-1.00.b", early_uartlite_setup);
+OF_EARLYCON_DECLARE(uartlite_a, "xlnx,xps-uartlite-1.00.a", early_uartlite_setup);
+
 #endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
 
 static struct uart_driver ulite_uart_driver = {
