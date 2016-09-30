From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCHv4 1/3] serial: mctrl_gpio: implement mctrl_gpio_use_rtscts
Date: Fri, 30 Sep 2016 10:57:59 +0200
Message-ID: <20160930085801.21497-2-richard.genoud@gmail.com>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160930085801.21497-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-serial@vger.kernel.org

This function returns true if CTS and RTS are used as GPIOs.
Some drivers (like atmel_serial) needs to know if the flow control is
handled by the controller or by GPIOs.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/serial_mctrl_gpio.c |  7 +++++++
 drivers/tty/serial/serial_mctrl_gpio.h | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index d2da6aa7f27d..38e6e784faa2 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -72,6 +72,13 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
 
+bool mctrl_gpio_use_rtscts(struct mctrl_gpios *gpios)
+{
+	return mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS) &&
+		mctrl_gpio_to_gpiod(gpios, UART_GPIO_RTS);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_use_rtscts);
+
 unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
 {
 	enum mctrl_gpio_idx i;
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index fa000bcff217..c34269733c62 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -101,6 +101,11 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
  */
 void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
 
+/*
+ * Return true if both CTS and RTS are used with GPIOs
+ */
+bool mctrl_gpio_use_rtscts(struct mctrl_gpios *gpios);
+
 #else /* GPIOLIB */
 
 static inline
@@ -152,6 +157,11 @@ static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 {
 }
 
+static inline bool mctrl_gpio_use_rtscts(struct mctrl_gpios *gpios)
+{
+	return false;
+}
+
 #endif /* GPIOLIB */
 
 #endif
