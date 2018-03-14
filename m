From: YOUNGKEUN OH <y.k.oh@samsung.com>
Subject: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
Date: Wed, 14 Mar 2018 11:17:05 +0900
Message-ID: <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, YOUNGKEUN OH <y.k.oh@samsung.com>
List-Id: linux-serial@vger.kernel.org

Cleanup checkpatch error:
ERROR: Macros with complex values should be enclosed in parentheses

Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
---
 drivers/tty/serial/samsung.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 3f2f8c1..da9bddb1 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
 }
 console_initcall(s3c24xx_serial_console_init);

-#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
+#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)
 #else
 #define S3C24XX_SERIAL_CONSOLE NULL
 #endif
@@ -2198,7 +2198,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S3C2410_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2410_serial_drv_data)
 #else
-#define S3C2410_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2410_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 #ifdef CONFIG_CPU_S3C2412
@@ -2226,7 +2226,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S3C2412_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2412_serial_drv_data)
 #else
-#define S3C2412_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2412_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
@@ -2255,7 +2255,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S3C2440_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2440_serial_drv_data)
 #else
-#define S3C2440_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2440_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
@@ -2283,7 +2283,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c6400_serial_drv_data)
 #else
-#define S3C6400_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 #ifdef CONFIG_CPU_S5PV210
@@ -2311,7 +2311,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
 #else
-#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
+#define S5PV210_SERIAL_DRV_DATA	((kernel_ulong_t)NULL)
 #endif

 #if defined(CONFIG_ARCH_EXYNOS)
@@ -2350,8 +2350,8 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 #define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
 #else
-#define EXYNOS4210_SERIAL_DRV_DATA (kernel_ulong_t)NULL
-#define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
--
1.9.1
