From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v2 1/4] tty/serial: Add GPIOLIB helpers for controlling modem lines
Date: Tue, 11 Feb 2014 18:45:12 +0100
Message-ID: <1392140715-15295-2-git-send-email-richard.genoud@gmail.com>
References: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:38856 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbaBKRpr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Feb 2014 12:45:47 -0500
Received: by mail-ea0-f173.google.com with SMTP id d10so3881694eaj.4
        for <linux-serial@vger.kernel.org>; Tue, 11 Feb 2014 09:45:45 -0800 (PST)
In-Reply-To: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
GPIO.
This will be useful for many boards which have a serial controller that
only handle CTS/RTS pins (or even just RX/TX).

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 Documentation/serial/driver            |  21 ++++++
 drivers/tty/serial/Kconfig             |   4 ++
 drivers/tty/serial/Makefile            |   3 +
 drivers/tty/serial/serial_mctrl_gpio.c | 113 +++++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_mctrl_gpio.h |  56 ++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index c3a7689a90e6..b33f0f9e1b8e 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -429,3 +429,24 @@ thus:
 		struct uart_port	port;
 		int			my_stuff;
 	};
+
+Modem control lines via GPIO
+----------------------------
+
+Some helpers are provided in order to set/get modem control lines via GPIO.
+
+mctrl_gpio_init(dev, gpios):
+	This will get the {cts,rts,...}-gpios from device tree if they are
+	present and request them, set direction etc.
+
+mctrl_gpio_free(gpios):
+	This will free the requested gpios in mctrl_gpio_init().
+
+mctrl_gpio_set(gpios, mctrl):
+	This will sets the gpios according to the mctrl state.
+
+mctrl_gpio_get(gpios, mctrl):
+	This will update mctrl with the gpios values.
+
+get_mctrl_gpio_name(mctrl_gpio_idx):
+	Returns a name associated to the GPIO modem line.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a3815eaed421..58c54d7eae53 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1509,4 +1509,8 @@ config SERIAL_ST_ASC_CONSOLE
 
 endmenu
 
+config SERIAL_MCTRL_GPIO
+	def_bool y
+	depends on GPIOLIB
+
 endif # TTY
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 3680854fef41..bcf31da267dd 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -87,3 +87,6 @@ obj-$(CONFIG_SERIAL_EFM32_UART) += efm32-uart.o
 obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
 obj-$(CONFIG_SERIAL_RP2)	+= rp2.o
 obj-$(CONFIG_SERIAL_FSL_LPUART)	+= fsl_lpuart.o
+
+# GPIOLIB helpers for modem control lines
+obj-$(CONFIG_SERIAL_MCTRL_GPIO) += serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
new file mode 100644
index 000000000000..ddcc7538f487
--- /dev/null
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -0,0 +1,113 @@
+/*
+ *  Helpers for controlling modem lines via GPIO
+ *
+ *  Copyright (C) 2014 Paratronic S.A.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <uapi/asm-generic/termios.h>
+
+#include "serial_mctrl_gpio.h"
+
+static const char *mctrl_gpio_of_names[UART_GPIO_MAX] = {
+	"cts", "dsr", "dcd", "ri", "rts", "dtr"
+};
+
+const char *get_mctrl_gpio_name(enum mctrl_gpio_idx idx)
+{
+	return mctrl_gpio_of_names[idx];
+}
+EXPORT_SYMBOL_GPL(get_mctrl_gpio_name);
+
+void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
+{
+	if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_RTS]))
+		gpiod_set_value(gpios->gpio[UART_GPIO_RTS],
+				!!(mctrl & TIOCM_RTS));
+
+	if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DTR]))
+		gpiod_set_value(gpios->gpio[UART_GPIO_DTR],
+				!!(mctrl & TIOCM_DTR));
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_set);
+
+unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
+{
+	if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_CTS])) {
+		if (gpiod_get_value(gpios->gpio[UART_GPIO_CTS]))
+			*mctrl |= TIOCM_CTS;
+		else
+			*mctrl &= ~TIOCM_CTS;
+	}
+
+	if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DSR])) {
+		if (gpiod_get_value(gpios->gpio[UART_GPIO_DSR]))
+			*mctrl |= TIOCM_DSR;
+		else
+			*mctrl &= ~TIOCM_DSR;
+	}
+
+	if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_RI])) {
+		if (gpiod_get_value(gpios->gpio[UART_GPIO_RI]))
+			*mctrl |= TIOCM_RI;
+		else
+			*mctrl &= ~TIOCM_RI;
+	}
+
+	if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DCD])) {
+		if (gpiod_get_value(gpios->gpio[UART_GPIO_DCD]))
+			*mctrl |= TIOCM_CD;
+		else
+			*mctrl &= ~TIOCM_CD;
+	}
+
+	return *mctrl;
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_get);
+
+int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+	int err = 0;
+	int ret = 0;
+
+	for (i = UART_GPIO_MIN; i < UART_GPIO_MAX; i++) {
+		gpios->gpio[i] = gpiod_get(dev, mctrl_gpio_of_names[i]);
+
+		/*
+		 * The GPIOs are maybe not all filled,
+		 * this is not an error.
+		 */
+		if (IS_ERR_OR_NULL(gpios->gpio[i]))
+			continue;
+
+		if (i < UART_GPIO_MAX_INPUT)
+			err = gpiod_direction_input(gpios->gpio[i]);
+		else
+			err = gpiod_direction_output(gpios->gpio[i], 0);
+		if (err) {
+			dev_err(dev, "Unable to set direction for %s GPIO",
+				mctrl_gpio_of_names[i]);
+			gpiod_put(gpios->gpio[i]);
+			gpios->gpio[i] = NULL;
+			ret--;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_init);
+
+void mctrl_gpio_free(struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+
+	for (i = UART_GPIO_MIN; i < UART_GPIO_MAX; i++)
+		if (!IS_ERR_OR_NULL(gpios->gpio[i])) {
+			gpiod_put(gpios->gpio[i]);
+			gpios->gpio[i] = NULL;
+		}
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_free);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
new file mode 100644
index 000000000000..5b8be48f6442
--- /dev/null
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -0,0 +1,56 @@
+/*
+ *  Helpers for controlling modem lines via GPIO
+ *
+ *  Copyright (C) 2014 Paratronic S.A.
+ *
+ */
+
+#ifndef __SERIAL_MCTRL_GPIO__
+#define __SERIAL_MCTRL_GPIO__
+
+#include <linux/gpio/consumer.h>
+
+enum mctrl_gpio_idx {
+	UART_GPIO_MIN = 0,
+	UART_GPIO_CTS = 0,
+	UART_GPIO_DSR = 1,
+	UART_GPIO_DCD = 2,
+	UART_GPIO_RI = 3,
+	UART_GPIO_MAX_INPUT = 4,
+	UART_GPIO_RTS = 4,
+	UART_GPIO_DTR = 5,
+	UART_GPIO_MAX,
+};
+
+struct mctrl_gpios {
+	struct gpio_desc *gpio[UART_GPIO_MAX];
+};
+
+/*
+ * Names of the modem lines (cts, dsr, dcd...)
+ */
+const char *get_mctrl_gpio_name(enum mctrl_gpio_idx idx);
+
+/*
+ * Set state of the modem control output lines via GPIOs.
+ */
+void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl);
+
+/*
+ * Get state of the modem control output lines from GPIOs.
+ * The mctrl flags are updated and returned.
+ */
+unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl);
+
+/*
+ * Request and set direction of modem control lines GPIOs.
+ * Returns 0 if ok, -nb_err if setting direction failed.
+ */
+int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios);
+
+/*
+ * Free all modem control lines GPIOs
+ */
+void mctrl_gpio_free(struct mctrl_gpios *gpios);
+
+#endif
-- 
1.8.5

