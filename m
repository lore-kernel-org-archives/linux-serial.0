From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/30] tty: serial/samsung: prepare for common clock API
Date: Thu, 11 Apr 2013 02:04:47 +0200
Message-ID: <1365638712-1028578-6-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

With the common clock interface, there is no way to provide the
"clock_source" sysfs attribute for the samsung serial ports. Given that
this file was purely informational and had fixed contents, we have reason
to believe that no user space programs were relying on it.

The sysfs file is not documented in the ABI docs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 2769a38..603f3f3 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1179,6 +1179,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	return 0;
 }
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 static ssize_t s3c24xx_serial_show_clksrc(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -1194,7 +1195,7 @@ static ssize_t s3c24xx_serial_show_clksrc(struct device *dev,
 }
 
 static DEVICE_ATTR(clock_source, S_IRUGO, s3c24xx_serial_show_clksrc, NULL);
-
+#endif
 
 /* Device driver serial port probe */
 
@@ -1252,9 +1253,11 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
 	platform_set_drvdata(pdev, &ourport->port);
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 	ret = device_create_file(&pdev->dev, &dev_attr_clock_source);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add clock source attr.\n");
+#endif
 
 	ret = s3c24xx_serial_cpufreq_register(ourport);
 	if (ret < 0)
@@ -1272,7 +1275,9 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
 
 	if (port) {
 		s3c24xx_serial_cpufreq_deregister(to_ourport(port));
+#ifdef CONFIG_SAMSUNG_CLOCK
 		device_remove_file(&dev->dev, &dev_attr_clock_source);
+#endif
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
 	}
 
-- 
1.8.1.2
