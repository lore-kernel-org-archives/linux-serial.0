From: Mao Wenan <maowenan@huawei.com>
Subject: [PATCH serial v2] sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()
Date: Sat, 9 Mar 2019 10:50:37 +0800
Message-ID: <20190309025037.116449-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, vz@mleia.com
List-Id: linux-serial@vger.kernel.org

Add the missing uart_unregister_driver() and i2c_del_driver() before return
from sc16is7xx_init() in the error handling case.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v1->v2: fix compile warning if CONFIG_SERIAL_SC16IS7XX_SPI is not exist.
 drivers/tty/serial/sc16is7xx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 268098681856..b9e5941ce767 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1509,7 +1509,7 @@ static int __init sc16is7xx_init(void)
 	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
-		return ret;
+		goto err_i2c;
 	}
 #endif
 
@@ -1517,10 +1517,20 @@ static int __init sc16is7xx_init(void)
 	ret = spi_register_driver(&sc16is7xx_spi_uart_driver);
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx spi --> %d\n", ret);
-		return ret;
+		goto err_spi;
 	}
 #endif
 	return ret;
+
+#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
+err_spi:
+#endif
+#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
+	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
+err_i2c:
+#endif
+	uart_unregister_driver(&sc16is7xx_uart);
+	return ret;
 }
 module_init(sc16is7xx_init);
 
-- 
2.20.1
