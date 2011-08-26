From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/12] serial: samsung: Fix build error
Date: Fri, 26 Aug 2011 13:58:10 -0700
Message-ID: <1314392301-25140-1-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37806 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab1HZU7M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:59:12 -0400
In-Reply-To: <20110826191143.GC5557@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Kukjin Kim <kgene.kim@samsung.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Kukjin Kim <kgene.kim@samsung.com>

drivers/tty/serial/samsung.c: In function 's3c24xx_serial_init':
drivers/tty/serial/samsung.c:1237: error: lvalue required as unary '&' operand

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/samsung.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index afc6294..6edafb5 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1225,15 +1225,19 @@ static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
 	.suspend = s3c24xx_serial_suspend,
 	.resume = s3c24xx_serial_resume,
 };
+#define SERIAL_SAMSUNG_PM_OPS	(&s3c24xx_serial_pm_ops)
+
 #else /* !CONFIG_PM_SLEEP */
-#define s3c24xx_serial_pm_ops	NULL
+
+#define SERIAL_SAMSUNG_PM_OPS	NULL
 #endif /* CONFIG_PM_SLEEP */
 
 int s3c24xx_serial_init(struct platform_driver *drv,
 			struct s3c24xx_uart_info *info)
 {
 	dbg("s3c24xx_serial_init(%p,%p)\n", drv, info);
-	drv->driver.pm = &s3c24xx_serial_pm_ops;
+
+	drv->driver.pm = SERIAL_SAMSUNG_PM_OPS;
 
 	return platform_driver_register(drv);
 }
-- 
1.7.6.1

