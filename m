From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Subject: [PATCH v1] tty: serial: max310x: Add optional reset gpio
Date: Fri, 14 Jun 2019 16:11:12 +0200
Message-ID: <20190614141112.29962-1-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com, thomas.petazzoni@bootlin.com
List-Id: linux-serial@vger.kernel.org

Add the possibility to use a gpio as reset.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 Documentation/devicetree/bindings/serial/maxim,max310x.txt | 1 +
 drivers/tty/serial/max310x.c                               | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.txt b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
index 79e10a05a96a..1d7d8a0b4260 100644
--- a/Documentation/devicetree/bindings/serial/maxim,max310x.txt
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
@@ -15,6 +15,7 @@ Required properties:
   "osc" if an external clock source is used.
 
 Optional properties:
+- reset-gpios: Gpio to use for reset.
 - gpio-controller: Marks the device node as a GPIO controller.
 - #gpio-cells: Should be two. The first cell is the GPIO number and
   the second cell is used to specify the GPIO polarity:
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e5aebbf5f302..d056fa2eed1b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -1413,12 +1414,18 @@ static int max310x_spi_probe(struct spi_device *spi)
 		return ret;
 
 	if (spi->dev.of_node) {
+		struct gpio_desc *reset_gpio;
 		const struct of_device_id *of_id =
 			of_match_device(max310x_dt_ids, &spi->dev);
 		if (!of_id)
 			return -ENODEV;
 
 		devtype = (struct max310x_devtype *)of_id->data;
+		reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+						     GPIOD_OUT_HIGH);
+		if (IS_ERR(reset_gpio))
+			return PTR_ERR(reset_gpio);
+		gpiod_set_value_cansleep(reset_gpio, 0);
 	} else {
 		const struct spi_device_id *id_entry = spi_get_device_id(spi);
 
-- 
2.11.0
