From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH] serial: samsung: Register cpufreq notifier only on
 S3C24xx
Date: Fri, 19 Aug 2016 09:12:17 +0200
Message-ID: <1471590737-18620-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-serial@vger.kernel.org

The Samsung serial driver registered for CPU frequency transitions to
recalculate its clock when ARM clock frequency changes.  Driver is used
on all Samsung SoCs (old S3C and new Exynos) however this is needed only
on S3C24xx platform so limit the ifdef to respective cpufreq driver.

On S3C24xx the ratio between frequencies of UART's parent clock (pclk)
and ARM's parent clock (fclk) remains fixed.  Therefore when ARM clock
frequency goes down, the serial is also affected.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 2 +-
 drivers/tty/serial/samsung.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ae2095a66708..f44615fa474d 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1577,7 +1577,7 @@ static void s3c24xx_serial_resetport(struct uart_port *port,
 }
 
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ
 
 static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
 					     unsigned long val, void *data)
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 2ae4fcee1814..a04acef1cb20 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -102,7 +102,7 @@ struct s3c24xx_uart_port {
 
 	struct s3c24xx_uart_dma		*dma;
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ
 	struct notifier_block		freq_transition;
 #endif
 };
-- 
1.9.1
