From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 1/2] serial: imx: Remove SERIAL_IMX_CONSOLE
Date: Tue, 4 Jun 2013 14:08:37 -0300
Message-ID: <1370365718-23474-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:59454
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758095Ab3FDRI7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jun 2013 13:08:59 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, b35083@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

When CONFIG_SERIAL_IMX_CONSOLE is not selected the following build warnings
appear:

drivers/tty/serial/imx.c:274:13: warning: 'imx_port_ucrs_save' defined but not used [-Wunused-function]
drivers/tty/serial/imx.c:283:13: warning: 'imx_port_ucrs_restore' defined but not used [-Wunused-function]

Instead of fixing the warning by protecting mx_port_ucrs_save() and 
imx_port_ucrs_restore() with an "ifdef", let's get rid of the SERIAL_IMX_CONSOLE
option and make the console support always present.

While at it, change the CPU vendor name to Freescale. 

Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix the warning by removing SERIAL_IMX_CONSOLE

 drivers/tty/serial/Kconfig | 18 ++----------------
 drivers/tty/serial/imx.c   | 10 ++--------
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 7e7006f..a9ae1cd 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -554,26 +554,12 @@ config SERIAL_IMX
 	bool "IMX serial port support"
 	depends on ARCH_MXC
 	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
 	select RATIONAL
 	help
-	  If you have a machine based on a Motorola IMX CPU you
+	  If you have a machine based on a Freescale IMX CPU you
 	  can enable its onboard serial port by enabling this option.
 
-config SERIAL_IMX_CONSOLE
-	bool "Console on IMX serial port"
-	depends on SERIAL_IMX
-	select SERIAL_CORE_CONSOLE
-	help
-	  If you have enabled the serial port on the Motorola IMX
-	  CPU you can make it the console by answering Y to this option.
-
-	  Even if you say Y here, the currently visible virtual console
-	  (/dev/tty0) will still be used as the system console by default, but
-	  you can alter that using a kernel command line option such as
-	  "console=ttySA0". (Try "man bootparam" or see the documentation of
-	  your boot loader (lilo or loadlin) about how to pass options to the
-	  kernel at boot time.)
-
 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
 	depends on PPC32 || MICROBLAZE || MFD_TIMBERDALE
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a07e94f..d0fcd5e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -27,7 +27,7 @@
  * Added hardware handshake
  */
 
-#if defined(CONFIG_SERIAL_IMX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#if defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
 
@@ -1211,7 +1211,6 @@ static struct uart_ops imx_pops = {
 
 static struct imx_port *imx_ports[UART_NR];
 
-#ifdef CONFIG_SERIAL_IMX_CONSOLE
 static void imx_console_putchar(struct uart_port *port, int ch)
 {
 	struct imx_port *sport = (struct imx_port *)port;
@@ -1374,11 +1373,6 @@ static struct console imx_console = {
 	.data		= &imx_reg,
 };
 
-#define IMX_CONSOLE	&imx_console
-#else
-#define IMX_CONSOLE	NULL
-#endif
-
 static struct uart_driver imx_reg = {
 	.owner          = THIS_MODULE,
 	.driver_name    = DRIVER_NAME,
@@ -1386,7 +1380,7 @@ static struct uart_driver imx_reg = {
 	.major          = SERIAL_IMX_MAJOR,
 	.minor          = MINOR_START,
 	.nr             = ARRAY_SIZE(imx_ports),
-	.cons           = IMX_CONSOLE,
+	.cons           = &imx_console,
 };
 
 static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
-- 
1.8.1.2


