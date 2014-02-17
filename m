From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v3 1/7] tty/serial: Add GPIOLIB helpers for controlling modem lines
Date: Mon, 17 Feb 2014 17:57:21 +0100
Message-ID: <1392656247-3351-2-git-send-email-richard.genoud@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36064 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbaBQQ6B (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Feb 2014 11:58:01 -0500
Received: by mail-wi0-f176.google.com with SMTP id hi5so2619284wib.3
        for <linux-serial@vger.kernel.org>; Mon, 17 Feb 2014 08:58:00 -0800 (PST)
In-Reply-To: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
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
 Documentation/serial/driver            |  21 +++++++
 drivers/tty/serial/Kconfig             |   3 +
 drivers/tty/serial/Makefile            |   3 +
 drivers/tty/serial/serial_mctrl_gpio.c | 112 +++++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_mctrl_gpio.h |  92 +++++++++++++++++++++++++++
 5 files changed, 231 insertions(+)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index c3a7689a90e6..23aa32667d68 100644
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
+	present and request them, set direction etc. devm_* functions are
+	used, so there's no need to call mctrl_gpio_free().
+
+mctrl_gpio_free(dev, gpios):
+	This will free the requested gpios in mctrl_gpio_init().
+	As devm_* function are used, there's generally no need to call
+	this function.
+
+mctrl_gpio_set(gpios, mctrl):
+	This will sets the gpios according to the mctrl state.
+
+mctrl_gpio_get(gpios, mctrl):
+	This will update mctrl with the gpios values.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a3815eaed421..4fe8ca16f492 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1509,4 +1509,7 @@ config SERIAL_ST_ASC_CONSOLE
 
 endmenu
 
+config SERIAL_MCTRL_GPIO
+	tristate
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
index 000000000000..bd8e4a7c981c
--- /dev/null
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -0,0 +1,112 @@
+/*
+ * Helpers for controlling modem lines via GPIO
+ *
+ * Copyright (C) 2014 Paratronic S.A.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <uapi/asm-generic/termios.h>
+
+#include "serial_mctrl_gpio.h"
+
+static const struct {
+	const char *name;
+	unsigned int mctrl;
+	bool dir_out;
+} mctrl_gpios_desc[] = {
+	{ "cts", TIOCM_CTS, false, },
+	{ "dsr", TIOCM_DSR, false, },
+	{ "dcd", TIOCM_CD, false, },
+	{ "ri", TIOCM_RI, false, },
+	{ "rts", TIOCM_RTS, true, },
+	{ "dtr", TIOCM_DTR, true, },
+	{ "out1", TIOCM_OUT1, true, },
+	{ "out2", TIOCM_OUT2, true, },
+};
+
+void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
+{
+	enum mctrl_gpio_idx i;
+
+	for (i = 0; i < UART_GPIO_MAX; i++)
+		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
+		    mctrl_gpios_desc[i].dir_out)
+			gpiod_set_value(gpios->gpio[i],
+					!!(mctrl & mctrl_gpios_desc[i].mctrl));
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_set);
+
+unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
+{
+	enum mctrl_gpio_idx i;
+
+	for (i = 0; i < UART_GPIO_MAX; i++) {
+		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
+		    !mctrl_gpios_desc[i].dir_out) {
+			if (gpiod_get_value(gpios->gpio[i]))
+				*mctrl |= mctrl_gpios_desc[i].mctrl;
+			else
+				*mctrl &= ~mctrl_gpios_desc[i].mctrl;
+		}
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
+	for (i = 0; i < UART_GPIO_MAX; i++) {
+		gpios->gpio[i] = devm_gpiod_get(dev, mctrl_gpios_desc[i].name);
+
+		/*
+		 * The GPIOs are maybe not all filled,
+		 * this is not an error.
+		 */
+		if (IS_ERR_OR_NULL(gpios->gpio[i]))
+			continue;
+
+		if (mctrl_gpios_desc[i].dir_out)
+			err = gpiod_direction_output(gpios->gpio[i], 0);
+		else
+			err = gpiod_direction_input(gpios->gpio[i]);
+		if (err) {
+			dev_err(dev, "Unable to set direction for %s GPIO",
+				mctrl_gpios_desc[i].name);
+			devm_gpiod_put(dev, gpios->gpio[i]);
+			gpios->gpio[i] = NULL;
+			ret--;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_init);
+
+void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+
+	for (i = 0; i < UART_GPIO_MAX; i++)
+		if (!IS_ERR_OR_NULL(gpios->gpio[i])) {
+			devm_gpiod_put(dev, gpios->gpio[i]);
+			gpios->gpio[i] = NULL;
+		}
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_free);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
new file mode 100644
index 000000000000..e9797323d531
--- /dev/null
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -0,0 +1,92 @@
+/*
+ * Helpers for controlling modem lines via GPIO
+ *
+ * Copyright (C) 2014 Paratronic S.A.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __SERIAL_MCTRL_GPIO__
+#define __SERIAL_MCTRL_GPIO__
+
+#include <linux/gpio/consumer.h>
+
+enum mctrl_gpio_idx {
+	UART_GPIO_CTS,
+	UART_GPIO_DSR,
+	UART_GPIO_DCD,
+	UART_GPIO_RI,
+	UART_GPIO_RTS,
+	UART_GPIO_DTR,
+	UART_GPIO_OUT1,
+	UART_GPIO_OUT2,
+	UART_GPIO_MAX,
+};
+
+struct mctrl_gpios {
+	struct gpio_desc *gpio[UART_GPIO_MAX];
+};
+
+#ifdef CONFIG_GPIOLIB
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
+ * devm_* functions are used, so there's no need to call mctrl_gpio_free().
+ * Returns 0 if ok, -nb_err if setting direction failed.
+ */
+int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios);
+
+/*
+ * Free all modem control lines GPIOs.
+ * Normally, this function will not be called, as the GPIOs will
+ * be disposed of by the resource management code.
+ */
+void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios);
+
+#else /* GPIOLIB */
+
+static inline
+void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
+{
+}
+
+static inline
+unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
+{
+	return 0;
+}
+
+static inline
+int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
+{
+	return -UART_GPIO_MAX;
+}
+
+static inline
+void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
+{
+}
+
+#endif /* GPIOLIB */
+
+#endif
-- 
1.8.5

