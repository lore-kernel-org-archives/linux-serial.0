From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v3 09/10] serial: uartps: Register own uart console and driver structures
Date: Mon,  3 Sep 2018 15:10:57 +0200
Message-ID: <b4d3a7cf706d92fdc665cf751fdbd9862ed2cd0a.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Every instance is registering own struct console and struct uart_driver
with minor number which corresponds to alias ID (or 0 now) and with 1 uart
port. The same alias ID is saved to tty_driver->name_base which is key
field for creating ttyPSX name.

Because name_base and minor number are setup already there is no need to
setup any port->line number because 0 is the right value.

Unfortunately this driver is setting up major number to 0 for using
dynamic assignment and kernel is allocating different major numbers for
every instance instead of using the same major and different minor
number.

~# ls -la /dev/ttyPS*
crw-------    1 root     root      252,   0 Jan  1 03:36 /dev/ttyPS0
crw--w----    1 root     root      253,   1 Jan  1 00:00 /dev/ttyPS1

When major number is not 0. For example 252 then major/minor
combinations are in expected form

~# ls -la /dev/ttyPS*
crw-------    1 root     root      252,   0 Jan  1 04:04 /dev/ttyPS0
crw--w----    1 root     root      252,   1 Jan  1 00:00 /dev/ttyPS1

Driver is not freeing struct cdns_uart_console in case that instance is
not used as console. The reason is that console is incorrectly unregistred
and "console [0] disabled" message will be shown.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- Rebase on the top of previous broken patch
- Change patch subject ("was serial: uartps: Remove CDNS_UART_NR_PORTS
  macro")
- Keep CDNS_UART_NR_PORTS in this patch and remove it in next one and
  align commit message to reflect this
- Allocate struct console dynamically too to be unique for every
  instance
- Cleanup error path

Changes in v2:
- Register one uart_driver with unique minor at probe time

---
 drivers/tty/serial/xilinx_uartps.c | 93 ++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0e578c0a8ce0..d838612eda6f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -30,7 +30,6 @@
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
-#define CDNS_UART_MINOR		0	/* works best with devtmpfs */
 #define CDNS_UART_NR_PORTS	2
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
@@ -1099,8 +1098,6 @@ static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 #endif
 };
 
-static struct uart_driver cdns_uart_uart_driver;
-
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_putchar - write the character to the FIFO buffer
@@ -1240,16 +1237,6 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
-
-static struct console cdns_uart_console = {
-	.name	= CDNS_UART_TTY_NAME,
-	.write	= cdns_uart_console_write,
-	.device	= uart_console_device,
-	.setup	= cdns_uart_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1, /* Specified on the cmdline (e.g. console=ttyPS ) */
-	.data	= &cdns_uart_uart_driver,
-};
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
 #ifdef CONFIG_PM_SLEEP
@@ -1381,9 +1368,6 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 
-/* Temporary variable for storing number of instances */
-static int instances;
-
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1397,6 +1381,11 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct cdns_uart *cdns_uart_data;
 	const struct of_device_id *match;
+	struct uart_driver *cdns_uart_uart_driver;
+	char *driver_name;
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+	struct console *cdns_uart_console;
+#endif
 
 	cdns_uart_data = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_data),
 			GFP_KERNEL);
@@ -1406,6 +1395,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	cdns_uart_uart_driver = devm_kzalloc(&pdev->dev,
+					     sizeof(*cdns_uart_uart_driver),
+					     GFP_KERNEL);
+	if (!cdns_uart_uart_driver)
+		return -ENOMEM;
+
 	/* Look for a serialN alias */
 	id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (id < 0)
@@ -1416,25 +1411,50 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (!cdns_uart_uart_driver.state) {
-		cdns_uart_uart_driver.owner = THIS_MODULE;
-		cdns_uart_uart_driver.driver_name = CDNS_UART_NAME;
-		cdns_uart_uart_driver.dev_name = CDNS_UART_TTY_NAME;
-		cdns_uart_uart_driver.major = CDNS_UART_MAJOR;
-		cdns_uart_uart_driver.minor = CDNS_UART_MINOR;
-		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
+	/* There is a need to use unique driver name */
+	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
+				     CDNS_UART_NAME, id);
+	if (!driver_name)
+		return -ENOMEM;
+
+	cdns_uart_uart_driver->owner = THIS_MODULE;
+	cdns_uart_uart_driver->driver_name = driver_name;
+	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
+	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
+	cdns_uart_uart_driver->minor = id;
+	cdns_uart_uart_driver->nr = 1;
+
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-		cdns_uart_uart_driver.cons = &cdns_uart_console;
+	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
+					 GFP_KERNEL);
+	if (!cdns_uart_console)
+		return -ENOMEM;
+
+	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
+		sizeof(cdns_uart_console->name));
+	cdns_uart_console->index = id;
+	cdns_uart_console->write = cdns_uart_console_write;
+	cdns_uart_console->device = uart_console_device;
+	cdns_uart_console->setup = cdns_uart_console_setup;
+	cdns_uart_console->flags = CON_PRINTBUFFER;
+	cdns_uart_console->data = cdns_uart_uart_driver;
+	cdns_uart_uart_driver->cons = cdns_uart_console;
 #endif
 
-		rc = uart_register_driver(&cdns_uart_uart_driver);
-		if (rc < 0) {
-			dev_err(&pdev->dev, "Failed to register driver\n");
-			return rc;
-		}
+	rc = uart_register_driver(cdns_uart_uart_driver);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Failed to register driver\n");
+		return rc;
 	}
 
-	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
+	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
+
+	/*
+	 * Setting up proper name_base needs to be done after uart
+	 * registration because tty_driver structure is not filled.
+	 * name_base is 0 by default.
+	 */
+	cdns_uart_uart_driver->tty_driver->name_base = id;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
@@ -1505,7 +1525,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &cdns_uart_ops;
 	port->fifosize	= CDNS_UART_FIFO_SIZE;
-	port->line	= id;
 
 	/*
 	 * Register the port.
@@ -1536,7 +1555,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = port;
 #endif
 
-	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
+	rc = uart_add_one_port(cdns_uart_uart_driver, port);
 	if (rc) {
 		dev_err(&pdev->dev,
 			"uart_add_one_port() failed; err=%i\n", rc);
@@ -1546,11 +1565,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
 	if (console_port == port &&
-	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED))
+	    !(cdns_uart_uart_driver->cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
-	instances++;
 	return 0;
 
 err_out_pm_disable:
@@ -1566,8 +1584,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 err_out_clk_dis_pclk:
 	clk_disable_unprepare(cdns_uart_data->pclk);
 err_out_unregister_driver:
-	if (!instances)
-		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
+	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
+
 	return rc;
 }
 
@@ -1601,8 +1619,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
-	if (!--instances)
-		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
+	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
 
-- 
1.9.1
