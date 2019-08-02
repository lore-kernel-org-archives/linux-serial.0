From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: [PATCH v3 4/4] serial: 8250: Don't check for mctrl_gpio_init()
 returning -ENOSYS
Date: Fri, 2 Aug 2019 10:04:11 +0000
Message-ID: <20190802100349.8659-4-frieder.schrempf@kontron.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802100349.8659-1-frieder.schrempf@kontron.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, Schrempf Frieder <frieder.schrempf@kontron.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
if CONFIG_GPIOLIB is disabled, we can safely remove this check.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v3
=============
* Adjust the commit message and subject line

Changes in v2
=============
* Add a patch for the 8250 driver
---
 drivers/tty/serial/8250/8250_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index df3bcc0b2d74..e682390ce0de 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1026,10 +1026,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (!has_acpi_companion(uart->port.dev)) {
 			gpios = mctrl_gpio_init(&uart->port, 0);
 			if (IS_ERR(gpios)) {
-				if (PTR_ERR(gpios) != -ENOSYS) {
-					ret = PTR_ERR(gpios);
-					goto out_unlock;
-				}
+				ret = PTR_ERR(gpios);
+				goto out_unlock;
 			} else {
 				uart->gpios = gpios;
 			}
-- 
2.17.1
