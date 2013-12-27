From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] serial: samsung: Remove hard-coded major/minor numbers
Date: Fri, 27 Dec 2013 10:37:28 +0530
Message-ID: <1388120848-15879-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jslaby@suse.cz, gregkh@linuxfoundation.org, patches@linaro.org
List-Id: linux-serial@vger.kernel.org

The hard-coded values clash with the values set for amba-pl011 serial
driver. Because of this there is no serial output on Samsung boards
if amba-pl011 is enabled alongwith samsung-serial driver.

Remove the hardcoded values and let the framework decide on
appropriate major/minor number. This is required for multi-platform
development work on Exynos platform.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/tty/serial/samsung.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c1af04d..9c20543 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -56,8 +56,6 @@
 /* UART name and device definitions */
 
 #define S3C24XX_SERIAL_NAME	"ttySAC"
-#define S3C24XX_SERIAL_MAJOR	204
-#define S3C24XX_SERIAL_MINOR	64
 
 /* macros to change one thing to another */
 
@@ -951,8 +949,6 @@ static struct uart_driver s3c24xx_uart_drv = {
 	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.dev_name	= S3C24XX_SERIAL_NAME,
-	.major		= S3C24XX_SERIAL_MAJOR,
-	.minor		= S3C24XX_SERIAL_MINOR,
 };
 
 static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
-- 
1.7.9.5
