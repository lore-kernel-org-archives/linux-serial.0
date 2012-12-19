From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 5/6] tty: of_serial: Add pinctrl support
Date: Wed, 19 Dec 2012 21:18:14 +0100
Message-ID: <1355948295-19680-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Alejandro Mery <amery@geeks.cl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Stefan Roese <sr@denx.de>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Use pinctrl to configure the SoCs pins directly from the driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/of_serial.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index df443b9..f66bdab 100644
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
@@ -54,6 +55,7 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 					int type, struct uart_port *port)
 {
 	struct resource resource;
+	struct pinctrl *pinctrl;
 	struct device_node *np = ofdev->dev.of_node;
 	u32 clk, spd, prop;
 	int ret;
@@ -73,6 +75,11 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 		return ret;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&ofdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&ofdev->dev,
+			"pins are not configured from the driver\n");
+
 	spin_lock_init(&port->lock);
 	port->mapbase = resource.start;
 
-- 
1.7.9.5
