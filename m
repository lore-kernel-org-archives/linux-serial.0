From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH 14/14] tty/serial: samsung: add support for exynos7
Date: Wed, 27 Aug 2014 15:16:35 +0530
Message-ID: <1409132795-1991-1-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, cpgs@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

From: Alim Akhtar <alim.akhtar@samsung.com>

This patch enables upcoming exynos7 SoCs serial driver.
This also modifies various dependencies for Kconfig

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig   |    6 +++---
 drivers/tty/serial/samsung.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 26cec64..f858d57 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -220,7 +220,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG
+	depends on PLAT_SAMSUNG || ARCH_EXYNOS7
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
@@ -230,14 +230,14 @@ config SERIAL_SAMSUNG
 
 config SERIAL_SAMSUNG_UARTS_4
 	bool
-	depends on PLAT_SAMSUNG
+	depends on SERIAL_SAMSUNG
 	default y if !(CPU_S3C2410 || CPU_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
 	help
 	  Internal node for the common case of 4 Samsung compatible UARTs
 
 config SERIAL_SAMSUNG_UARTS
 	int
-	depends on PLAT_SAMSUNG
+	depends on SERIAL_SAMSUNG
 	default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
 	default 3
 	help
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c78f43a..31be983 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1770,7 +1770,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
 #endif
 
-#if defined(CONFIG_ARCH_EXYNOS)
+#if defined(CONFIG_ARCH_EXYNOS) || defined(CONFIG_ARCH_EXYNOS7)
 static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung Exynos4 UART",
-- 
1.7.9.5
