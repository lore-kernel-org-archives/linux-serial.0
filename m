From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/3] uart: sirf: use PM macro initialize PM functions
Date: Fri,  3 Jan 2014 15:44:06 +0800
Message-ID: <1388735048-16093-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:55478 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaACHo2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Jan 2014 02:44:28 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so14922303pde.6
        for <linux-serial@vger.kernel.org>; Thu, 02 Jan 2014 23:44:26 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

use SET_SYSTEM_SLEEP_PM_OPS to initialize suspend/resume functions
instead of legacy suspend and resume entries of platform_driver.
this will add hibernation support automatically as suspend to disk
entries are also set.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index f186a8f..6fea79b 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1518,32 +1518,37 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int
-sirfsoc_uart_suspend(struct platform_device *pdev, pm_message_t state)
+sirfsoc_uart_suspend(struct device *pdev)
 {
-	struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
+	struct sirfsoc_uart_port *sirfport = dev_get_drvdata(pdev);
 	struct uart_port *port = &sirfport->port;
 	uart_suspend_port(&sirfsoc_uart_drv, port);
 	return 0;
 }
 
-static int sirfsoc_uart_resume(struct platform_device *pdev)
+static int sirfsoc_uart_resume(struct device *pdev)
 {
-	struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
+	struct sirfsoc_uart_port *sirfport = dev_get_drvdata(pdev);
 	struct uart_port *port = &sirfport->port;
 	uart_resume_port(&sirfsoc_uart_drv, port);
 	return 0;
 }
+#endif
+
+static const struct dev_pm_ops sirfsoc_uart_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sirfsoc_uart_suspend, sirfsoc_uart_resume)
+};
 
 static struct platform_driver sirfsoc_uart_driver = {
 	.probe		= sirfsoc_uart_probe,
 	.remove		= sirfsoc_uart_remove,
-	.suspend	= sirfsoc_uart_suspend,
-	.resume		= sirfsoc_uart_resume,
 	.driver		= {
 		.name	= SIRFUART_PORT_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = sirfsoc_uart_ids,
+		.pm	= &sirfsoc_uart_pm_ops,
 	},
 };
 
-- 
1.7.5.4

