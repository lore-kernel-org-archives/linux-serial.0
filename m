From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be renamed to /dev/ttyBCM*
Date: Sun,  9 Nov 2014 00:55:48 -0800
Message-ID: <1415523348-4631-2-git-send-email-cernekee@gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

By default, bcm63xx_uart.c uses the standard 8250 device naming and
major/minor numbers.  There are at least two situations where this could
be a problem:

1) Multiplatform kernels that need to support some chips that have 8250
UARTs and other chips that have bcm63xx UARTs.

2) Some older chips like BCM7125 have a mix of both UART types.

Add a new Kconfig option to tell the driver whether to register itself
as ttyS or ttyBCM.  By default it will retain the existing "ttyS"
behavior to avoid surprises.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/Kconfig        | 11 +++++++++++
 drivers/tty/serial/bcm63xx_uart.c |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fdd851e..c82cfd2 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1302,6 +1302,17 @@ config SERIAL_BCM63XX_CONSOLE
 	  If you have enabled the serial port on the BCM63xx CPU
 	  you can make it the console by answering Y to this option.
 
+config SERIAL_BCM63XX_TTYS
+	bool "Use ttyS[01] device nodes for bcm63xx_uart"
+	depends on SERIAL_BCM63XX
+	default y
+	help
+	  Say Y to name the serial ports /dev/ttyS0, ttyS1, ...
+	  This conflicts with the 8250 driver but may avoid breaking
+	  compatibility with existing init scripts.
+
+	  Say N to name the serial ports /dev/ttyBCM0, ttyBCM1, ...
+
 config SERIAL_GRLIB_GAISLER_APBUART
 	tristate "GRLIB APBUART serial support"
 	depends on OF && SPARC
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index e04e580..9f3dcc8 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -751,7 +751,11 @@ static int bcm_console_setup(struct console *co, char *options)
 static struct uart_driver bcm_uart_driver;
 
 static struct console bcm63xx_console = {
+#ifdef CONFIG_SERIAL_BCM63XX_TTYS
 	.name		= "ttyS",
+#else
+	.name		= "ttyBCM",
+#endif
 	.write		= bcm_console_write,
 	.device		= uart_console_device,
 	.setup		= bcm_console_setup,
@@ -796,9 +800,13 @@ OF_EARLYCON_DECLARE(bcm63xx_uart, "brcm,bcm6345-uart", bcm_early_console_setup);
 static struct uart_driver bcm_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "bcm63xx_uart",
+#ifdef CONFIG_SERIAL_BCM63XX_TTYS
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
+#else
+	.dev_name	= "ttyBCM",
+#endif
 	.nr		= BCM63XX_NR_UARTS,
 	.cons		= BCM63XX_CONSOLE,
 };
-- 
2.1.1
