From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 04/11] serial: sh-sci: Add support for GPIO-controlled modem lines
Date: Fri,  3 Jun 2016 12:00:04 +0200
Message-ID: <1464948011-377-5-git-send-email-geert+renesas@glider.be>
References: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Enhance the Renesas SCI UART driver to add support for GPIO-controlled
modem lines (CTS, DSR, DCD, RNG, RTS, DTR), using the serial_mctrl_gpio
helpers.

GPIO-controlled modem lines can be used when dedicated modem lines are
not available. Invalid configurations specifying both GPIO RTS/CTS and
dedicated RTS/CTS are rejected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
Testing for regressions on platforms without DT and/or GPIOLIB support
(SuperH) would be appreciated.
Compile-tested on ecovec24_defconfig(GPIOLIB=y) and se7780_defconfig
(GPIOLIB=n).

v3:
  - Add Reviewed-by,

v2:
  - Drop RFC status.
  - Fix typo s/UART_GPIO_CAR/UART_GPIO_DCD/ (too many different names
    for the same thing: CAR, DCD, CD),
  - Drop OUT[12] from the patch description,
  - Use intermediate variables to avoid breaking long lines,
  - Reject combining GPIO and dedicated RTS/CTS.
---
 drivers/tty/serial/Kconfig  |  1 +
 drivers/tty/serial/sh-sci.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 7e3a58c8bb67cd80..b5c8ad1573f4416d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -736,6 +736,7 @@ config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
 	depends on SUPERH || ARCH_RENESAS || H8300 || COMPILE_TEST
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 
 config SERIAL_SH_SCI_NR_UARTS
 	int "Maximum number of SCI(F) serial ports"
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 135f836642ab1c5a..bf3780a7f700cad8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -57,6 +57,7 @@
 #include <asm/sh_bios.h>
 #endif
 
+#include "serial_mctrl_gpio.h"
 #include "sh-sci.h"
 
 /* Offsets into the sci_port->irqs array */
@@ -111,6 +112,7 @@ struct sci_port {
 	unsigned int		error_clear;
 	unsigned int		sampling_rate_mask;
 	resource_size_t		reg_size;
+	struct mctrl_gpios	*gpios;
 
 	/* Break timer */
 	struct timer_list	break_timer;
@@ -1817,6 +1819,8 @@ static unsigned int sci_tx_empty(struct uart_port *port)
  */
 static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct sci_port *s = to_sci_port(port);
+
 	if (mctrl & TIOCM_LOOP) {
 		const struct plat_sci_reg *reg;
 
@@ -1829,15 +1833,35 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 					serial_port_in(port, SCFCR) |
 					SCFCR_LOOP);
 	}
+
+	mctrl_gpio_set(s->gpios, mctrl);
 }
 
 static unsigned int sci_get_mctrl(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
+	struct mctrl_gpios *gpios = s->gpios;
+	unsigned int mctrl = 0;
+
+	mctrl_gpio_get(gpios, &mctrl);
+
 	/*
 	 * CTS/RTS is handled in hardware when supported, while nothing
 	 * else is wired up. Keep it simple and simply assert CTS/DSR/CAR.
 	 */
-	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS)))
+		mctrl |= TIOCM_CTS;
+	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR)))
+		mctrl |= TIOCM_DSR;
+	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD)))
+		mctrl |= TIOCM_CAR;
+
+	return mctrl;
+}
+
+static void sci_enable_ms(struct uart_port *port)
+{
+	mctrl_gpio_enable_ms(to_sci_port(port)->gpios);
 }
 
 static void sci_break_ctl(struct uart_port *port, int break_state)
@@ -1899,6 +1923,8 @@ static void sci_shutdown(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	mctrl_gpio_disable_ms(to_sci_port(port)->gpios);
+
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
 	sci_stop_tx(port);
@@ -2300,6 +2326,9 @@ done:
 		sci_start_rx(port);
 
 	sci_port_disable(s);
+
+	if (UART_ENABLE_MS(port, termios->c_cflag))
+		sci_enable_ms(port);
 }
 
 static void sci_pm(struct uart_port *port, unsigned int state,
@@ -2425,6 +2454,7 @@ static struct uart_ops sci_uart_ops = {
 	.start_tx	= sci_start_tx,
 	.stop_tx	= sci_stop_tx,
 	.stop_rx	= sci_stop_rx,
+	.enable_ms	= sci_enable_ms,
 	.break_ctl	= sci_break_ctl,
 	.startup	= sci_startup,
 	.shutdown	= sci_shutdown,
@@ -2912,6 +2942,20 @@ static int sci_probe_single(struct platform_device *dev,
 	if (ret)
 		return ret;
 
+	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
+	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
+		return PTR_ERR(sciport->gpios);
+
+	if (p->capabilities & SCIx_HAVE_RTSCTS) {
+		if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
+							UART_GPIO_CTS)) ||
+		    !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
+							UART_GPIO_RTS))) {
+			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
+			return -EINVAL;
+		}
+	}
+
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
 	if (ret) {
 		sci_cleanup_single(sciport);
-- 
1.9.1

