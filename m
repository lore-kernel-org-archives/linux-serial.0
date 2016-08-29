From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 1/6] serial: sa1100: add support for mctrl gpios
Date: Mon, 29 Aug 2016 13:05:51 +0100
Message-ID: <E1beLK3-0001TX-SI@rmk-PC.armlinux.org.uk>
References: <20160829120531.GG1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160829120531.GG1041@n2100.armlinux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Add support for the generic mctrl gpio helper.  This will allow us to
convert several board files to use the gpiod tables to assign GPIOs to
serial ports, rather than needing to have private function callbacks.

If the generic mctrl gpio helper fails, ignore the mctrl gpios rather
than preventing the (possibly console) serial port from being created.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/tty/serial/Kconfig  |  1 +
 drivers/tty/serial/sa1100.c | 42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 518db24a5b36..528d2ea3c7e7 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -464,6 +464,7 @@ config SERIAL_SA1100
 	bool "SA1100 serial port support"
 	depends on ARCH_SA1100
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
 	  If you have a machine based on a SA1100/SA1110 StrongARM(R) CPU you
 	  can enable its onboard serial port by enabling this option.
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index fd3d1329d48c..ce1f9a3fb36d 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -41,6 +41,8 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
+#include "serial_mctrl_gpio.h"
+
 /* We've been assigned a range on the "Low-density serial ports" major */
 #define SERIAL_SA1100_MAJOR	204
 #define MINOR_START		5
@@ -90,6 +92,7 @@ struct sa1100_port {
 	struct uart_port	port;
 	struct timer_list	timer;
 	unsigned int		old_status;
+	struct mctrl_gpios	*gpios;
 };
 
 /*
@@ -187,6 +190,8 @@ static void sa1100_enable_ms(struct uart_port *port)
 		container_of(port, struct sa1100_port, port);
 
 	mod_timer(&sport->timer, jiffies);
+
+	mctrl_gpio_enable_ms(sport->gpios);
 }
 
 static void
@@ -335,11 +340,21 @@ static unsigned int sa1100_tx_empty(struct uart_port *port)
 
 static unsigned int sa1100_get_mctrl(struct uart_port *port)
 {
-	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+	struct sa1100_port *sport =
+		container_of(port, struct sa1100_port, port);
+	int ret = TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+
+	mctrl_gpio_get(sport->gpios, &ret);
+
+	return ret;
 }
 
 static void sa1100_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct sa1100_port *sport =
+		container_of(port, struct sa1100_port, port);
+
+	mctrl_gpio_set(sport->gpios, mctrl);
 }
 
 /*
@@ -857,6 +872,27 @@ static int sa1100_serial_resume(struct platform_device *dev)
 	return 0;
 }
 
+static int sa1100_serial_add_one_port(struct sa1100_port *sport, struct platform_device *dev)
+{
+	sport->port.dev = &dev->dev;
+	sport->gpios = mctrl_gpio_init_noauto(sport->port.dev, 0);
+	if (IS_ERR(sport->gpios)) {
+		int err = PTR_ERR(sport->gpios);
+
+		dev_err(sport->port.dev, "failed to get mctrl gpios: %d\n",
+			err);
+
+		if (err == -EPROBE_DEFER)
+			return err;
+
+		sport->gpios = NULL;
+	}
+
+	platform_set_drvdata(dev, sport);
+
+	return uart_add_one_port(&sa1100_reg, &sport->port);
+}
+
 static int sa1100_serial_probe(struct platform_device *dev)
 {
 	struct resource *res = dev->resource;
@@ -871,9 +907,7 @@ static int sa1100_serial_probe(struct platform_device *dev)
 			if (sa1100_ports[i].port.mapbase != res->start)
 				continue;
 
-			sa1100_ports[i].port.dev = &dev->dev;
-			uart_add_one_port(&sa1100_reg, &sa1100_ports[i].port);
-			platform_set_drvdata(dev, &sa1100_ports[i]);
+			sa1100_serial_add_one_port(&sa1100_ports[i], dev);
 			break;
 		}
 	}
-- 
2.1.0
