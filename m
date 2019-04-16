From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: sc16is7xx: fix unused label warning
Date: Tue, 16 Apr 2019 14:33:14 +0200
Message-ID: <20190416123321.3577638-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Phil Elwell <phil@raspberrypi.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Mao Wenan <maowenan@huawei.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

A bugfix introduced a harmless warning:

drivers/tty/serial/sc16is7xx.c:1523:1: error: unused label 'err_spi' [-Werror,-Wunused-label]

Move each label inside the correct #ifdef.

Fixes: ac0cdb3d9901 ("sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/sc16is7xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 09a183dfc526..a31db15cd7c0 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1520,11 +1520,13 @@ static int __init sc16is7xx_init(void)
 #endif
 	return ret;
 
+#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
 err_spi:
+#endif
 #ifdef CONFIG_SERIAL_SC16IS7XX_I2C
 	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
-#endif
 err_i2c:
+#endif
 	uart_unregister_driver(&sc16is7xx_uart);
 	return ret;
 }
-- 
2.20.0
