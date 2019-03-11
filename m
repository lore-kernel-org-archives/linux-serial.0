From: Mao Wenan <maowenan@huawei.com>
Subject: [PATCH serial v3] sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()
Date: Mon, 11 Mar 2019 17:39:59 +0800
Message-ID: <20190311093959.86344-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, vz@mleia.com, dan.carpenter@oracle.com
List-Id: linux-serial@vger.kernel.org

Add the missing uart_unregister_driver() and i2c_del_driver() before
return from sc16is7xx_init() in the error handling case.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
---
 v1->v2: fix compile warning if CONFIG_SERIAL_SC16IS7XX_SPI is not exist.
 v2->v3: create functions for i2c and spi to do error handling as dan carpenter
 suggestion.
 drivers/tty/serial/sc16is7xx.c | 53 ++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 268098681856..8be3adaf4782 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1436,6 +1436,19 @@ static struct spi_driver sc16is7xx_spi_uart_driver = {
 };
 
 MODULE_ALIAS("spi:sc16is7xx");
+
+static int __init register_sc16is7xx_spi(void)
+{
+	return spi_register_driver(&sc16is7xx_spi_uart_driver);
+}
+
+static void __exit unregister_sc16is7xx_spi(void)
+{
+	spi_unregister_driver(&sc16is7xx_spi_uart_driver);
+}
+#else
+static int __init register_sc16is7xx_spi(void) { return 0; }
+static void __exit unregister_sc16is7xx_spi(void) {}
 #endif
 
 #ifdef CONFIG_SERIAL_SC16IS7XX_I2C
@@ -1493,6 +1506,18 @@ static struct i2c_driver sc16is7xx_i2c_uart_driver = {
 	.id_table	= sc16is7xx_i2c_id_table,
 };
 
+static int __init register_sc16is7xx_i2c(void)
+{
+	return i2c_add_driver(&sc16is7xx_i2c_uart_driver);
+}
+
+static void __exit del_sc16is7xx_i2c(void)
+{
+	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
+}
+#else
+static int __init register_sc16is7xx_i2c(void) { return 0; }
+static void __exit del_sc16is7xx_i2c(void) {}
 #endif
 
 static int __init sc16is7xx_init(void)
@@ -1505,34 +1530,32 @@ static int __init sc16is7xx_init(void)
 		return ret;
 	}
 
-#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
+	ret = register_sc16is7xx_i2c();
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
-		return ret;
+		goto err_i2c;
 	}
-#endif
 
-#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-	ret = spi_register_driver(&sc16is7xx_spi_uart_driver);
+	ret = register_sc16is7xx_spi();
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx spi --> %d\n", ret);
-		return ret;
+		goto err_spi;
 	}
-#endif
+
+	return ret;
+
+err_spi:
+	del_sc16is7xx_i2c();
+err_i2c:
+	uart_unregister_driver(&sc16is7xx_uart);
 	return ret;
 }
 module_init(sc16is7xx_init);
 
 static void __exit sc16is7xx_exit(void)
 {
-#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
-#endif
-
-#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-	spi_unregister_driver(&sc16is7xx_spi_uart_driver);
-#endif
+	del_sc16is7xx_i2c();
+	unregister_sc16is7xx_spi();
 	uart_unregister_driver(&sc16is7xx_uart);
 }
 module_exit(sc16is7xx_exit);
-- 
2.20.1
