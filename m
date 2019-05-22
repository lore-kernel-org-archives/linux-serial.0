From: Stefan Roese <sr@denx.de>
Subject: [PATCH 1/2] serial: mctrl_gpio: Check if GPIO property exisits before requesting it
Date: Wed, 22 May 2019 14:11:16 +0200
Message-ID: <20190522121117.14347-1-sr@denx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

This patch adds a check for the GPIOs property existence, before the
GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
support is added (2nd patch in this patch series) on x86 platforms using
ACPI. Please find a details problem description here:

https://lkml.org/lkml/2016/8/9/357

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 39ed56214cd3..cac50b20a119 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -116,6 +116,13 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
 		enum gpiod_flags flags;
+		char *gpio_str;
+
+		/* Check if GPIO property exists and continue if not */
+		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
+				     mctrl_gpios_desc[i].name);
+		if (!device_property_present(dev, gpio_str))
+			continue;
 
 		if (mctrl_gpios_desc[i].dir_out)
 			flags = GPIOD_OUT_LOW;
-- 
2.21.0
