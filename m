From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/3] serial: mxs-auart: don't use GPIOF_* with gpiod_get_direction
Date: Sun, 14 Jan 2018 22:07:09 +0100
Message-ID: <20180114210711.13863-3-wsa+renesas@sang-engineering.com>
References: <20180114210711.13863-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180114210711.13863-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The documentation was wrong, gpiod_get_direction() returns 0/1 instead
of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
("gpio: correct docs about return value of gpiod_get_direction"). Now,
fix this user (until a better, system-wide solution is in place). This
also means we can drop the deprecated use of 'linux/gpio.h'. Yay!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Only build tested!

 drivers/tty/serial/mxs-auart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 5b470406bf9d67..079dc47aa142d8 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -40,7 +40,6 @@
 
 #include <asm/cacheflush.h>
 
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/irq.h>
@@ -1597,7 +1596,7 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
 		gpiod = mctrl_gpio_to_gpiod(s->gpios, i);
-		if (gpiod && (gpiod_get_direction(gpiod) == GPIOF_DIR_IN))
+		if (gpiod && (gpiod_get_direction(gpiod) == 1))
 			s->gpio_irq[i] = gpiod_to_irq(gpiod);
 		else
 			s->gpio_irq[i] = -EINVAL;
-- 
2.11.0
