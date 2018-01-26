From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH] gpio: serial: max310x: Use HW type for gpio_chip's label
Date: Fri, 26 Jan 2018 20:02:00 +0100
Message-ID: <b2421132df00569baa90af8f2d19ad75242e8c48.1516996724.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>
List-Id: linux-serial@vger.kernel.org

Some debugging tools (/sys/kernel/debug/gpio, `lsgpio`) use the
gpio_chip's label for displaying an additional context. Right now, the
information duplicates stuff which is already available from the
parent's device. This is how e.g. `lsgpio`'s output looks like:

  GPIO chip: gpiochip2, "spi1.2", 16 GPIO lines

Comparing the output of other GPIO expanders that I have available:

  gpiochip4: GPIOs 464-479, parent: spi/spi1.1, mcp23s17, can sleep:
  gpiochip5: GPIOs 448-463, parent: i2c/0-0020, pca9555, can sleep:
  gpiochip2: GPIOs 496-511, parent: spi/spi1.2, spi1.2, can sleep:

This patch ensures that the type of the real HW device is shown instead
of duplicating the SPI path:

  gpiochip2: GPIOs 496-511, parent: spi/spi1.2, MAX14830, can sleep:

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 39f635812077..efe55a1a0615 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1318,7 +1318,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	/* Setup GPIO cotroller */
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
-	s->gpio.label		= dev_name(dev);
+	s->gpio.label		= devtype->name;
 	s->gpio.direction_input	= max310x_gpio_direction_input;
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;
-- 
2.14.3


