From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v3 04/10] serial: samsung: select Exynos specific driver data if ARCH_EXYNOS is defined
Date: Mon, 17 Jun 2013 16:30:29 +0530
Message-ID: <1371466836-4111-5-git-send-email-chander.kashyap@linaro.org>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36384 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643Ab3FQLBL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 07:01:11 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so2667474pdj.12
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2013 04:01:10 -0700 (PDT)
In-Reply-To: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>

All Exynos4/5 SoCs share a common driver data in the samsung serial
driver. Hence, let the driver data inclusion be based on ARCH_EXYNOS
instead of SOC specific definition.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 drivers/tty/serial/samsung.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 2552c7f..e70d19a 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1703,9 +1703,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
 #endif
 
-#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
-	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250) || \
-	defined(CONFIG_SOC_EXYNOS5440)
+#if defined(CONFIG_ARCH_EXYNOS)
 static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung Exynos4 UART",
-- 
1.7.9.5

