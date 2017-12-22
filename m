From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH v2] gpio: serial: max310x: Support open-drain configuration
 for GPIOs
Date: Fri, 22 Dec 2017 21:29:44 +0100
Message-ID: <a1e14faa20381cfbe1d6f7b37bfe60ad270551ab.1515514947.git.jan.kundrat@cesnet.cz>
References: <20180109153721.GA17957@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180109153721.GA17957@kroah.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-serial@vger.kernel.org

The push-pull vs. open-drain are the only supported output modes. The
inputs are always unconditionally equipped with weak pull-downs. That's
the only mode, so there's probably no point in exporting that. I wonder
if it's worthwhile to provide a custom dbg_show method to indicate the
current status of the outputs, though.

This patch and [1] for i2c-gpio together make it possible to bit-bang an
I2C bus over GPIOs of an UART which is connected via SPI :). Yes, this
is crazy, but it's fast enough (while on a 26Mhz SPI HW bus with a
dual-core 1.6GHz CPU) to drive an I2C bus at 200kHz, according to my
scope.

[1] https://patchwork.ozlabs.org/patch/852591/

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/max310x.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 97576ff791db..39f635812077 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1159,6 +1159,27 @@ static int max310x_gpio_direction_output(struct gpio_chip *chip,
 
 	return 0;
 }
+
+static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+				   unsigned long config)
+{
+	struct max310x_port *s = gpiochip_get_data(chip);
+	struct uart_port *port = &s->p[offset / 4].port;
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		max310x_port_update(port, MAX310X_GPIOCFG_REG,
+				1 << ((offset % 4) + 4),
+				1 << ((offset % 4) + 4));
+		return 0;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		max310x_port_update(port, MAX310X_GPIOCFG_REG,
+				1 << ((offset % 4) + 4), 0);
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
 #endif
 
 static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
@@ -1302,6 +1323,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;
 	s->gpio.set		= max310x_gpio_set;
+	s->gpio.set_config	= max310x_gpio_set_config;
 	s->gpio.base		= -1;
 	s->gpio.ngpio		= devtype->nr * 4;
 	s->gpio.can_sleep	= 1;
-- 
2.14.3


