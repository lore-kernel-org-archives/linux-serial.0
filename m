From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 6/7] serial: samsung: Remove casting the return value which is
 a void pointer
Date: Mon, 09 Sep 2013 14:10:30 +0900
Message-ID: <003f01cead1a$e760d180$b6227480$%han@samsung.com>
References: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44201 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab3IIFKb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 01:10:31 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00CBEECXBT30@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 09 Sep 2013 14:10:30 +0900 (KST)
In-reply-to: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/samsung.c |    2 +-
 drivers/tty/serial/samsung.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f3dfa19..81f3dba 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1254,7 +1254,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	ourport->baudclk = ERR_PTR(-EINVAL);
 	ourport->info = ourport->drv_data->info;
 	ourport->cfg = (dev_get_platdata(&pdev->dev)) ?
-			(struct s3c2410_uartcfg *)dev_get_platdata(&pdev->dev) :
+			dev_get_platdata(&pdev->dev) :
 			ourport->drv_data->def_cfg;
 
 	ourport->port.fifosize = (ourport->info->fifosize) ?
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index aaa617a..8827e54 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -63,7 +63,7 @@ struct s3c24xx_uart_port {
 
 /* conversion functions */
 
-#define s3c24xx_dev_to_port(__dev) (struct uart_port *)dev_get_drvdata(__dev)
+#define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
 
 /* register access controls */
 
-- 
1.7.10.4


