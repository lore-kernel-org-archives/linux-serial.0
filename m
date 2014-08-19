From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH v2] serial: clps711x: Use mctrl_gpio helpers for handling modem signals
Date: Tue, 19 Aug 2014 10:14:22 +0400
Message-ID: <1408428862-29573-1-git-send-email-shc_work@mail.ru>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

CLPS711X serial driver uses the system wide registers to control the
modem signals. Now gpio-syscon driver can be used for this purposes.
mctrl_gpio helpers allow us to create GPIO bindings for any of modem/tty
control signals that extends the functionality of the driver.
This patch makes such change.

This change does not break any current DT bindings, since DT support
for this platform is not introduced yet.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 .../bindings/serial/cirrus,clps711x-uart.txt       |  7 +++--
 drivers/tty/serial/Kconfig                         |  1 +
 drivers/tty/serial/clps711x.c                      | 32 +++++++---------------
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
index 12f3cf8..caaeb25 100644
--- a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
+++ b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
@@ -8,7 +8,8 @@ Required properties:
 - syscon: Phandle to SYSCON node, which contain UART control bits.
 
 Optional properties:
-- uart-use-ms: Indicate the UART has modem signal (DCD, DSR, CTS).
+- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
+  line respectively.
 
 Note: Each UART port should have an alias correctly numbered
 in "aliases" node.
@@ -24,5 +25,7 @@ Example:
 		interrupts = <12 13>;
 		clocks = <&clks 11>;
 		syscon = <&syscon1>;
-		uart-use-ms;
+		cts-gpios = <&sysgpio 0 GPIO_ACTIVE_LOW>;
+		dsr-gpios = <&sysgpio 1 GPIO_ACTIVE_LOW>;
+		dcd-gpios = <&sysgpio 2 GPIO_ACTIVE_LOW>;
 	};
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 26cec64..75cc59f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -204,6 +204,7 @@ config SERIAL_CLPS711X
 	tristate "CLPS711X serial port support"
 	depends on ARCH_CLPS711X || COMPILE_TEST
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO
 	help
 	  This enables the driver for the on-chip UARTs of the Cirrus
 	  Logic EP711x/EP721x/EP731x processors.
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index f5b4c3d..acfe317 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -33,6 +33,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/clps711x.h>
 
+#include "serial_mctrl_gpio.h"
+
 #define UART_CLPS711X_DEVNAME	"ttyCL"
 #define UART_CLPS711X_NR	2
 #define UART_CLPS711X_MAJOR	204
@@ -62,7 +64,7 @@ struct clps711x_port {
 	unsigned int		tx_enabled;
 	int			rx_irq;
 	struct regmap		*syscon;
-	bool			use_ms;
+	struct mctrl_gpios	*gpios;
 };
 
 static struct uart_driver clps711x_uart = {
@@ -198,28 +200,17 @@ static unsigned int uart_clps711x_tx_empty(struct uart_port *port)
 
 static unsigned int uart_clps711x_get_mctrl(struct uart_port *port)
 {
+	unsigned int result = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	unsigned int result = 0;
-
-	if (s->use_ms) {
-		u32 sysflg = 0;
-
-		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
-		if (sysflg & SYSFLG1_DCD)
-			result |= TIOCM_CAR;
-		if (sysflg & SYSFLG1_DSR)
-			result |= TIOCM_DSR;
-		if (sysflg & SYSFLG1_CTS)
-			result |= TIOCM_CTS;
-	} else
-		result = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
 
-	return result;
+	return mctrl_gpio_get(s->gpios, &result);
 }
 
 static void uart_clps711x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	/* Do nothing */
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+
+	mctrl_gpio_set(s->gpios, mctrl);
 }
 
 static void uart_clps711x_break_ctl(struct uart_port *port, int break_state)
@@ -490,15 +481,10 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 		s->syscon = syscon_regmap_lookup_by_pdevname(syscon_name);
 		if (IS_ERR(s->syscon))
 			return PTR_ERR(s->syscon);
-
-		s->use_ms = !index;
 	} else {
 		s->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
 		if (IS_ERR(s->syscon))
 			return PTR_ERR(s->syscon);
-
-		if (!index)
-			s->use_ms = of_property_read_bool(np, "uart-use-ms");
 	}
 
 	s->port.line		= index;
@@ -513,6 +499,8 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, s);
 
+	s->gpios = mctrl_gpio_init(&pdev->dev, 0);
+
 	ret = uart_add_one_port(&clps711x_uart, &s->port);
 	if (ret)
 		return ret;
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
