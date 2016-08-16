From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] Revert "tty/serial/8250: use mctrl_gpio helpers"
Date: Tue, 16 Aug 2016 15:06:54 +0300
Message-ID: <1471349214-69793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Yegor Yefremov <yegorslists@googlemail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Serial console is broken in v4.8-rcX. Mika and I independently bisected down to
commit 4ef03d328769 ("tty/serial/8250: use mctrl_gpio helpers").

Since neither author nor anyone else didn't propose a solution we better revert
it for now.

This reverts commit 4ef03d328769eddbfeca1f1c958fdb181a69c341.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lkml.kernel.org/r/20160809130229.GN1729@lahna.fi.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/devicetree/bindings/serial/8250.txt | 19 ------------
 drivers/tty/serial/8250/8250.h                    | 35 +----------------------
 drivers/tty/serial/8250/8250_core.c               |  9 ------
 drivers/tty/serial/8250/8250_omap.c               | 31 +++++++++-----------
 drivers/tty/serial/8250/8250_port.c               |  7 +----
 drivers/tty/serial/8250/Kconfig                   |  1 -
 include/linux/serial_8250.h                       |  1 -
 7 files changed, 15 insertions(+), 88 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index f5561ac..936ab5b 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -42,9 +42,6 @@ Optional properties:
 - auto-flow-control: one way to enable automatic flow control support. The
   driver is allowed to detect support for the capability even without this
   property.
-- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
-  line respectively. It will use specified GPIO instead of the peripheral
-  function pin for the UART feature. If unsure, don't specify this property.
 
 Note:
 * fsl,ns16550:
@@ -66,19 +63,3 @@ Example:
 		interrupts = <10>;
 		reg-shift = <2>;
 	};
-
-Example for OMAP UART using GPIO-based modem control signals:
-
-	uart4: serial@49042000 {
-		compatible = "ti,omap3-uart";
-		reg = <0x49042000 0x400>;
-		interrupts = <80>;
-		ti,hwmods = "uart4";
-		clock-frequency = <48000000>;
-		cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
-		rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
-		dtr-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
-		dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
-		dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
-		rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
-	};
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 122e0e4..1a16fea 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -15,8 +15,6 @@
 #include <linux/serial_reg.h>
 #include <linux/dmaengine.h>
 
-#include "../serial_mctrl_gpio.h"
-
 struct uart_8250_dma {
 	int (*tx_dma)(struct uart_8250_port *p);
 	int (*rx_dma)(struct uart_8250_port *p);
@@ -133,43 +131,12 @@ void serial8250_em485_destroy(struct uart_8250_port *p);
 
 static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
 {
-	int mctrl_gpio = 0;
-
 	serial_out(up, UART_MCR, value);
-
-	if (value & UART_MCR_RTS)
-		mctrl_gpio |= TIOCM_RTS;
-	if (value & UART_MCR_DTR)
-		mctrl_gpio |= TIOCM_DTR;
-
-	mctrl_gpio_set(up->gpios, mctrl_gpio);
 }
 
 static inline int serial8250_in_MCR(struct uart_8250_port *up)
 {
-	int mctrl, mctrl_gpio = 0;
-
-	mctrl = serial_in(up, UART_MCR);
-
-	/* save current MCR values */
-	if (mctrl & UART_MCR_RTS)
-		mctrl_gpio |= TIOCM_RTS;
-	if (mctrl & UART_MCR_DTR)
-		mctrl_gpio |= TIOCM_DTR;
-
-	mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
-
-	if (mctrl_gpio & TIOCM_RTS)
-		mctrl |= UART_MCR_RTS;
-	else
-		mctrl &= ~UART_MCR_RTS;
-
-	if (mctrl_gpio & TIOCM_DTR)
-		mctrl |= UART_MCR_DTR;
-	else
-		mctrl &= ~UART_MCR_DTR;
-
-	return mctrl;
+	return serial_in(up, UART_MCR);
 }
 
 #if defined(__alpha__) && !defined(CONFIG_PCI)
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 13ad5c3..dcf43f6 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -974,8 +974,6 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 	uart = serial8250_find_match_or_unused(&up->port);
 	if (uart && uart->port.type != PORT_8250_CIR) {
-		struct mctrl_gpios *gpios;
-
 		if (uart->port.dev)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
 
@@ -1013,13 +1011,6 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (up->port.flags & UPF_FIXED_TYPE)
 			uart->port.type = up->port.type;
 
-		gpios = mctrl_gpio_init(&uart->port, 0);
-		if (IS_ERR(gpios)) {
-			if (PTR_ERR(gpios) != -ENOSYS)
-				return PTR_ERR(gpios);
-		} else
-			uart->gpios = gpios;
-
 		serial8250_set_defaults(uart);
 
 		/* Possibly override default I/O functions.  */
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index e14982f..61ad6c3 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -134,21 +134,18 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	serial8250_do_set_mctrl(port, mctrl);
 
-	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
-						UART_GPIO_RTS))) {
-		/*
-		 * Turn off autoRTS if RTS is lowered and restore autoRTS
-		 * setting if RTS is raised
-		 */
-		lcr = serial_in(up, UART_LCR);
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
-			priv->efr |= UART_EFR_RTS;
-		else
-			priv->efr &= ~UART_EFR_RTS;
-		serial_out(up, UART_EFR, priv->efr);
-		serial_out(up, UART_LCR, lcr);
-	}
+	/*
+	 * Turn off autoRTS if RTS is lowered and restore autoRTS setting
+	 * if RTS is raised
+	 */
+	lcr = serial_in(up, UART_LCR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
+		priv->efr |= UART_EFR_RTS;
+	else
+		priv->efr &= ~UART_EFR_RTS;
+	serial_out(up, UART_EFR, priv->efr);
+	serial_out(up, UART_LCR, lcr);
 }
 
 /*
@@ -449,9 +446,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 	priv->efr = 0;
 	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
-	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW
-		&& IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
-							UART_GPIO_RTS))) {
+	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
 		/* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
 		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		priv->efr |= UART_EFR_CTS;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7481b95..bdfa659 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1618,8 +1618,6 @@ static void serial8250_disable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
-	mctrl_gpio_disable_ms(up->gpios);
-
 	up->ier &= ~UART_IER_MSI;
 	serial_port_out(port, UART_IER, up->ier);
 }
@@ -1632,8 +1630,6 @@ static void serial8250_enable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
-	mctrl_gpio_enable_ms(up->gpios);
-
 	up->ier |= UART_IER_MSI;
 
 	serial8250_rpm_get(up);
@@ -1917,8 +1913,7 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
 		ret |= TIOCM_DSR;
 	if (status & UART_MSR_CTS)
 		ret |= TIOCM_CTS;
-
-	return mctrl_gpio_get(up->gpios, &ret);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(serial8250_do_get_mctrl);
 
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index c9ec839..7c6f7af 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -6,7 +6,6 @@
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
 	select SERIAL_CORE
-	select SERIAL_MCTRL_GPIO if GPIOLIB
 	---help---
 	  This selects whether you want to include the driver for the standard
 	  serial ports.  The standard answer is Y.  People who might say N
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 923266c..48ec765 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -111,7 +111,6 @@ struct uart_8250_port {
 						 *   if no_console_suspend
 						 */
 	unsigned char		probe;
-	struct mctrl_gpios	*gpios;
 #define UART_PROBE_RSA	(1 << 0)
 
 	/*
-- 
2.8.1
