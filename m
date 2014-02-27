From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] serial: sirf: Use SIMPLE_DEV_PM_OPS macro
Date: Thu, 27 Feb 2014 20:45:09 +0900
Message-ID: <001501cf33b1$5dfc0860$19f41920$%han@samsung.com>
References: <000f01cf33b1$32c234d0$98469e70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10117 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbaB0LpK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Feb 2014 06:45:10 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N006XLKN9E3A0@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 27 Feb 2014 20:45:09 +0900 (KST)
In-reply-to: <000f01cf33b1$32c234d0$98469e70$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Qipan Li' <Qipan.Li@csr.com>, 'Barry Song' <Baohua.Song@csr.com>

Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/sirfsoc_uart.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 68b0fd4..da96502 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1480,9 +1480,8 @@ static int sirfsoc_uart_resume(struct device *pdev)
 }
 #endif
 
-static const struct dev_pm_ops sirfsoc_uart_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sirfsoc_uart_suspend, sirfsoc_uart_resume)
-};
+static SIMPLE_DEV_PM_OPS(sirfsoc_uart_pm_ops, sirfsoc_uart_suspend,
+			 sirfsoc_uart_resume);
 
 static struct platform_driver sirfsoc_uart_driver = {
 	.probe		= sirfsoc_uart_probe,
-- 
1.7.10.4


