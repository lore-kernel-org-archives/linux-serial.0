From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH] serial: samsung: protect NULL dereference of clock name
Date: Wed, 30 May 2012 17:29:55 +0900
Message-ID: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:40184 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab2E3I35 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 May 2012 04:29:57 -0400
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Alan Cox' <alan@linux.intel.com>, 'Kyoungil Kim' <ki0351.kim@samsung.com>, 'KeyYoung Park' <keyyoung.park@samsung.com>, 'Huisung Kang' <hs1218.kang@samsung.com>

From: KeyYoung Park <keyyoung.park@samsung.com>

When priting the serial clock source, if clock source name is null,
kernel reference NULL point.

Signed-off-by: KeyYoung Park <keyyoung.park@samsung.com>
Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 drivers/tty/serial/samsung.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ea76b40..77484e0 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1160,7 +1160,8 @@ static ssize_t s3c24xx_serial_show_clksrc(struct device *dev,
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
-	return snprintf(buf, PAGE_SIZE, "* %s\n", ourport->baudclk->name);
+	return snprintf(buf, PAGE_SIZE, "* %s\n",
+			ourport->baudclk->name ?: "(null)");
 }
 
 static DEVICE_ATTR(clock_source, S_IRUGO, s3c24xx_serial_show_clksrc, NULL);
-- 
1.7.1


