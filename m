From: Richard Genoud <noreply.rgenoud@gmail.com>
Subject: [PATCH v5 1/3] tty/serial: Add GPIOLIB helpers for controlling modem lines
Date: Mon,  3 Mar 2014 12:11:58 +0100
Message-ID: <1393845120-6340-2-git-send-email-richard.genoud@gmail.com>
References: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38857 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbaCCLM0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Mar 2014 06:12:26 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so2969488wgh.15
        for <linux-serial@vger.kernel.org>; Mon, 03 Mar 2014 03:12:25 -0800 (PST)
In-Reply-To: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
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
 Documentation/serial/driver            |  25 ++++++
 drivers/tty/serial/Kconfig             |   3 +
 drivers/tty/serial/Makefile            |   3 +
 drivers/tty/serial/serial_mctrl_gpio.c | 146 +++++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_mctrl_gpio.h | 109 ++++++++++++++++++++++++
 5 files changed, 286 insertions(+)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index c3a7689a90e6..3bba1aeb799c 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -429,3 +429,28 @@ thus:
 		struct uart_port	port;
 		int			my_stuff;
 	};
+
+Modem control lines via GPIO
+----------------------------
+
+Some helpers are provided in order to set/get modem control lines via GPIO.
+
+mctrl_gpio_init(dev, idx):
+	This will get the {cts,rts,...}-gpios from device tree if they are
+	present and request them, set direction etc, and return an
+	allocated structure. devm_* functions are used, so there's no need
+	to call mctrl_gpio_free().
+
+mctrl_gpio_free(dev, gpios):
+	This will free the requested gpios in mctrl_gpio_init().
+	As devm_* function are used, there's generally no need to call
+	this function.
+
+mctrl_gpio_to_gpiod(gpios, gidx)
+	This returns the gpio structure associated to the modem line index.
+
+mctrl_gpio_set(gpios, mctrl):
+	This will sets the gpios according to the mctrl state.
+
+mctrl_gpio_get(gpios, mctrl):
+	This will update mctrl with the gpios values.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2e6d8ddc4425..7e8f15cfb8d0 100644
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
index 000000000000..c88611608403
--- /dev/null
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -0,0 +1,146 @@
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
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <uapi/asm-generic/termios.h>
+
+#include "serial_mctrl_gpio.h"
+
+struct mctrl_gpios {
+	struct gpio_desc *gpio[UART_GPIO_MAX];
+};
+
+static const struct {
+	const char *name;
+	unsigned int mctrl;
+	bool dir_out;
+} mctrl_gpios_desc[UART_GPIO_MAX] = {
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
+	if (!gpios)
+		return;
+
+	for (i = 0; i < UART_GPIO_MAX; i++)
+		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
+		    mctrl_gpios_desc[i].dir_out)
+			gpiod_set_value(gpios->gpio[i],
+					!!(mctrl & mctrl_gpios_desc[i].mctrl));
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_set);
+
+struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
+				      enum mctrl_gpio_idx gidx)
+{
+	if (gpios && !IS_ERR_OR_NULL(gpios->gpio[gidx]))
+		return gpios->gpio[gidx];
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
+
+unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
+{
+	enum mctrl_gpio_idx i;
+
+	/*
+	 * return it unchanged if the structure is not allocated
+	 */
+	if (!gpios)
+		return *mctrl;
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
+struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
+{
+	struct mctrl_gpios *gpios;
+	enum mctrl_gpio_idx i;
+	int err;
+
+	gpios = devm_kzalloc(dev, sizeof(*gpios), GFP_KERNEL);
+	if (!gpios)
+		goto out;
+
+	for (i = 0; i < UART_GPIO_MAX; i++) {
+		gpios->gpio[i] = devm_gpiod_get_index(dev,
+						      mctrl_gpios_desc[i].name,
+						      idx);
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
+			dev_warn(dev, "Unable to set direction for %s GPIO",
+				 mctrl_gpios_desc[i].name);
+			devm_gpiod_put(dev, gpios->gpio[i]);
+			gpios->gpio[i] = NULL;
+		}
+	}
+
+out:
+	return gpios;
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_init);
+
+void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+
+	if (!gpios)
+		return;
+
+	for (i = 0; i < UART_GPIO_MAX; i++)
+		if (!IS_ERR_OR_NULL(gpios->gpio[i])) {
+			devm_gpiod_put(dev, gpios->gpio[i]);
+			gpios->gpio[i] = NULL;
+		}
+	devm_kfree(dev, gpios);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_free);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
new file mode 100644
index 000000000000..4ed2f814028b
--- /dev/null
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -0,0 +1,109 @@
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
+#include <linux/err.h>
+#include <linux/device.h>
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
+/*
+ * Opaque descriptor for modem lines controlled by GPIOs
+ */
+struct mctrl_gpios;
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
+ * Returns the associated struct gpio_desc to the modem line gidx
+ */
+struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
+				      enum mctrl_gpio_idx gidx);
+
+/*
+ * Request and set direction of modem control lines GPIOs.
+ * devm_* functions are used, so there's no need to call mctrl_gpio_free().
+ * Returns a pointer to the allocated mctrl structure if ok,
+ * or an error from devm_kzalloc().
+ */
+struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx);
+
+/*
+ * Free the mctrl_gpios structure.
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
+	return *mctrl;
+}
+
+static inline
+struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
+				      enum mctrl_gpio_idx gidx)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline
+struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
+{
+	return ERR_PTR(-ENOSYS);
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
1.8.5.5

