From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 2/4] serial: i.MX: Make console support non optional
Date: Wed, 21 Nov 2012 16:57:06 +0100
Message-ID: <1353513428-25697-2-git-send-email-plagnioj@jcrosoft.com>
References: <20121121155312.GX4398@game.jcrosoft.org>
 <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Grant Likely <grant.likely@secretlab.ca>, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Traditionally console support is optional for serial drivers. This
makes it non optional for the i.MX driver since it's not worth
asking questions for a feature virtually every user of this driver
wants to have.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de
Cc: Alan Cox <alan@linux.intel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/Kconfig |   16 +---------------
 drivers/tty/serial/imx.c   |    8 +-------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b176801..10e5eec 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -541,26 +541,12 @@ config SERIAL_IMX
 	bool "IMX serial port support"
 	depends on ARCH_MXC
 	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
 	select RATIONAL
 	help
 	  If you have a machine based on a Motorola IMX CPU you
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
index 5981912..07a8ca1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1192,7 +1192,6 @@ static struct uart_ops imx_pops = {
 
 static struct imx_port *imx_ports[UART_NR];
 
-#ifdef CONFIG_SERIAL_IMX_CONSOLE
 static void imx_console_putchar(struct uart_port *port, int ch)
 {
 	struct imx_port *sport = (struct imx_port *)port;
@@ -1348,11 +1347,6 @@ static struct console imx_console = {
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
@@ -1360,7 +1354,7 @@ static struct uart_driver imx_reg = {
 	.major          = SERIAL_IMX_MAJOR,
 	.minor          = MINOR_START,
 	.nr             = ARRAY_SIZE(imx_ports),
-	.cons           = IMX_CONSOLE,
+	.cons           = &imx_console,
 };
 
 static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
-- 
1.7.10.4
