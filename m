From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v3 07/10] serial: uartps: Fill struct uart_driver in probe()
Date: Mon,  3 Sep 2018 15:10:55 +0200
Message-ID: <9a2f438e7d7e39b1ce965d09cebd9fb799422479.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This is preparation step for dynamic port allocation without
CDNS_UART_NR_PORTS macro. Fill the structure only once at probe.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- s/,/;/ in filling structure
- get cdns_uart_uart_driver out of PS_UART_CONSOLE ifdefs

Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 54735a7f9960..61087233f411 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1099,6 +1099,8 @@ static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 #endif
 };
 
+static struct uart_driver cdns_uart_uart_driver;
+
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_putchar - write the character to the FIFO buffer
@@ -1239,8 +1241,6 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver cdns_uart_uart_driver;
-
 static struct console cdns_uart_console = {
 	.name	= CDNS_UART_TTY_NAME,
 	.write	= cdns_uart_console_write,
@@ -1252,18 +1252,6 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 };
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
-static struct uart_driver cdns_uart_uart_driver = {
-	.owner		= THIS_MODULE,
-	.driver_name	= CDNS_UART_NAME,
-	.dev_name	= CDNS_UART_TTY_NAME,
-	.major		= CDNS_UART_MAJOR,
-	.minor		= CDNS_UART_MINOR,
-	.nr		= CDNS_UART_NR_PORTS,
-#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-	.cons		= &cdns_uart_console,
-#endif
-};
-
 #ifdef CONFIG_PM_SLEEP
 /**
  * cdns_uart_suspend - suspend event
@@ -1429,6 +1417,16 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 
 	if (!cdns_uart_uart_driver.state) {
+		cdns_uart_uart_driver.owner = THIS_MODULE;
+		cdns_uart_uart_driver.driver_name = CDNS_UART_NAME;
+		cdns_uart_uart_driver.dev_name = CDNS_UART_TTY_NAME;
+		cdns_uart_uart_driver.major = CDNS_UART_MAJOR;
+		cdns_uart_uart_driver.minor = CDNS_UART_MINOR;
+		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+		cdns_uart_uart_driver.cons = &cdns_uart_console;
+#endif
+
 		rc = uart_register_driver(&cdns_uart_uart_driver);
 		if (rc < 0) {
 			dev_err(&pdev->dev, "Failed to register driver\n");
-- 
1.9.1
