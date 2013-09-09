From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/7] serial: bfin_uart: Remove casting the return value which
 is a void pointer
Date: Mon, 09 Sep 2013 14:08:43 +0900
Message-ID: <003c01cead1a$a8052ef0$f80f8cd0$%han@samsung.com>
References: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38592 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab3IIFIp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 01:08:45 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00LY8E90ESM0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 09 Sep 2013 14:08:44 +0900 (KST)
In-reply-to: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Sonic Zhang' <sonic.zhang@analog.com>, 'Jingoo Han' <jg1.han@samsung.com>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/bfin_uart.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 3c75e8e..74749a6 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -1240,7 +1240,7 @@ static int bfin_serial_probe(struct platform_device *pdev)
 			 */
 #endif
 		ret = peripheral_request_list(
-			(unsigned short *)dev_get_platdata(&pdev->dev),
+			dev_get_platdata(&pdev->dev),
 			DRIVER_NAME);
 		if (ret) {
 			dev_err(&pdev->dev,
@@ -1358,8 +1358,7 @@ static int bfin_serial_probe(struct platform_device *pdev)
 out_error_unmap:
 		iounmap(uart->port.membase);
 out_error_free_peripherals:
-		peripheral_free_list(
-			(unsigned short *)dev_get_platdata(&pdev->dev));
+		peripheral_free_list(dev_get_platdata(&pdev->dev));
 out_error_free_mem:
 		kfree(uart);
 		bfin_serial_ports[pdev->id] = NULL;
@@ -1377,8 +1376,7 @@ static int bfin_serial_remove(struct platform_device *pdev)
 	if (uart) {
 		uart_remove_one_port(&bfin_serial_reg, &uart->port);
 		iounmap(uart->port.membase);
-		peripheral_free_list(
-			(unsigned short *)dev_get_platdata(&pdev->dev));
+		peripheral_free_list(dev_get_platdata(&pdev->dev));
 		kfree(uart);
 		bfin_serial_ports[pdev->id] = NULL;
 	}
@@ -1432,8 +1430,8 @@ static int bfin_earlyprintk_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	ret = peripheral_request_list(
-		(unsigned short *)dev_get_platdata(&pdev->dev), DRIVER_NAME);
+	ret = peripheral_request_list(dev_get_platdata(&pdev->dev),
+					DRIVER_NAME);
 	if (ret) {
 		dev_err(&pdev->dev,
 				"fail to request bfin serial peripherals\n");
@@ -1463,8 +1461,7 @@ static int bfin_earlyprintk_probe(struct platform_device *pdev)
 	return 0;
 
 out_error_free_peripherals:
-	peripheral_free_list(
-		(unsigned short *)dev_get_platdata(&pdev->dev));
+	peripheral_free_list(dev_get_platdata(&pdev->dev));
 
 	return ret;
 }
-- 
1.7.10.4


