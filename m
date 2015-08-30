From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] serial: sc16is7xx: Remove unnecessary MODULE_ALIAS()
Date: Sun, 30 Aug 2015 23:42:14 +0200
Message-ID: <1440970934-12741-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

The driver has a I2C device id table that is used to create the modaliases
and also "sc16is7xx" is not a supported I2C id, so it's never used.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/tty/serial/sc16is7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 72ffd0dcab78..c4abd7557b35 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1420,7 +1420,6 @@ static struct i2c_driver sc16is7xx_i2c_uart_driver = {
 	.id_table	= sc16is7xx_i2c_id_table,
 };
 
-MODULE_ALIAS("i2c:sc16is7xx");
 #endif
 
 static int __init sc16is7xx_init(void)
-- 
2.4.3
