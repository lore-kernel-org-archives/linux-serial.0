From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] serial: samsung: Fix compiler error when !CONFIG_PM_SLEEP
Date: Wed, 27 Jul 2011 12:46:32 +0900
Message-ID: <20110727034632.GA31896@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27577 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab1G0Dqk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Jul 2011 23:46:40 -0400
Content-disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kyungmin Park <kyungmin.park@samsung.com>

drivers/tty/serial/samsung.c: In function 's3c24xx_serial_init':
drivers/tty/serial/samsung.c:1237: error: lvalue required as unary '&' operand

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index afc6294..318ab90 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1225,15 +1225,15 @@ static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
 	.suspend = s3c24xx_serial_suspend,
 	.resume = s3c24xx_serial_resume,
 };
-#else /* !CONFIG_PM_SLEEP */
-#define s3c24xx_serial_pm_ops	NULL
 #endif /* CONFIG_PM_SLEEP */
 
 int s3c24xx_serial_init(struct platform_driver *drv,
 			struct s3c24xx_uart_info *info)
 {
 	dbg("s3c24xx_serial_init(%p,%p)\n", drv, info);
+#ifdef CONFIG_PM_SLEEP
 	drv->driver.pm = &s3c24xx_serial_pm_ops;
+#endif
 
 	return platform_driver_register(drv);
 }
