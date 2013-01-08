From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 6/7] tty: of_serial: Add pinctrl support
Date: Tue,  8 Jan 2013 22:43:17 +0100
Message-ID: <1357681398-23956-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1357681398-23956-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357681398-23956-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, Stefan Roese <sr@denx.de>, Alejandro Mery <amery@geeks.cl>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use pinctrl to configure the SoCs pins directly from the driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/tty/serial/of_serial.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index e7cae1c..e9f3289 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
@@ -57,6 +58,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			struct of_serial_info *info)
 {
 	struct resource resource;
+	struct pinctrl *pinctrl;
 	struct device_node *np = ofdev->dev.of_node;
 	u32 clk, spd, prop;
 	int ret;
@@ -85,6 +87,11 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		goto out;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&ofdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&ofdev->dev,
+			"pins are not configured from the driver\n");
+
 	spin_lock_init(&port->lock);
 	port->mapbase = resource.start;
 
-- 
1.7.10.4
