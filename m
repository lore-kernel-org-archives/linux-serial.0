From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/3] serial: i.MX: Make console support non optional
Date: Thu, 15 Nov 2012 10:31:05 +0100
Message-ID: <1352971866-540-3-git-send-email-s.hauer@pengutronix.de>
References: <1352971866-540-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352971866-540-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Traditionally console support is optional for serial drivers. This
makes it non optional for the i.MX driver since it's not worth
asking questions for a feature virtually every user of this driver
wants to have.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/tty/serial/Kconfig |   16 +---------------
 drivers/tty/serial/imx.c   |    8 +-------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2a53be5..919b243 100644
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
