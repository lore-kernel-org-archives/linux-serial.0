From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: mctrl-gpio: fix build warning
Date: Wed, 11 Mar 2015 11:25:41 +0100
Message-ID: <2661449.5Eht12RCUu@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

A recent fix to the error handling in this driver introduced a
harmless warning:

serial/serial_mctrl_gpio.c: In function 'mctrl_gpio_init':
serial/serial_mctrl_gpio.c:110:4: warning: return makes pointer from integer without a cast
serial/serial_mctrl_gpio.c:90:6: warning: unused variable 'err' [-Wunused-variable]

This removes the unused variable and uses the ERR_CAST helper
to return the error value as the correct type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1d267ea6539f2 ("serial: mctrl-gpio: simplify init routine")

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 5027db7b5814..0ec756c62bcf 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -87,7 +87,6 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
 {
 	struct mctrl_gpios *gpios;
 	enum mctrl_gpio_idx i;
-	int err;
 
 	gpios = devm_kzalloc(dev, sizeof(*gpios), GFP_KERNEL);
 	if (!gpios)
@@ -107,7 +106,7 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
 						      idx, flags);
 
 		if (IS_ERR(gpios->gpio[i]))
-			return PTR_ERR(gpios->gpio[i]);
+			return ERR_CAST(gpios->gpio[i]);
 	}
 
 	return gpios;
