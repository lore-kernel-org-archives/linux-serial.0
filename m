From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Date: Fri, 2 Aug 2019 10:04:10 +0000
Message-ID: <20190802100349.8659-2-frieder.schrempf@kontron.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802100349.8659-1-frieder.schrempf@kontron.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, Schrempf Frieder <frieder.schrempf@kontron.de>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

As it is allowed to use the mctrl_gpio_* functions before
initialization (as the 8250 driver does according to 434be0ae7aa7),
it seems appropriate to have a NULL check in all of the functions.
Otherwise the mctrl_gpio_to_gpiod() function is prone to be used
in a context that can lead to a NULL pointer dereference.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v3
=============
* Move the changes in mctrl_gpio_to_gpiod() to a separate patch
---
 drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 2b400189be91..54c43e02e375 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 				      enum mctrl_gpio_idx gidx)
 {
+	if (gpios == NULL)
+		return NULL;
+
 	return gpios->gpio[gidx];
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
-- 
2.17.1
