From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 4/7] serial: bfin_sport_uart: Remove casting the return value
 which is a void pointer
Date: Mon, 09 Sep 2013 14:09:20 +0900
Message-ID: <003d01cead1a$bd9beab0$38d3c010$%han@samsung.com>
References: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38109 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3IIFJW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 01:09:22 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00J0SEATD5M0@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 09 Sep 2013 14:09:20 +0900 (KST)
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
 drivers/tty/serial/bfin_sport_uart.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 87636cc..4f22970 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -766,9 +766,8 @@ static int sport_uart_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
-		ret = peripheral_request_list(
-			(unsigned short *)dev_get_platdata(&pdev->dev),
-			DRV_NAME);
+		ret = peripheral_request_list(dev_get_platdata(&pdev->dev),
+						DRV_NAME);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Fail to request SPORT peripherals\n");
@@ -844,8 +843,7 @@ static int sport_uart_probe(struct platform_device *pdev)
 out_error_unmap:
 		iounmap(sport->port.membase);
 out_error_free_peripherals:
-		peripheral_free_list(
-			(unsigned short *)dev_get_platdata(&pdev->dev));
+		peripheral_free_list(dev_get_platdata(&pdev->dev));
 out_error_free_mem:
 		kfree(sport);
 		bfin_sport_uart_ports[pdev->id] = NULL;
@@ -864,8 +862,7 @@ static int sport_uart_remove(struct platform_device *pdev)
 	if (sport) {
 		uart_remove_one_port(&sport_uart_reg, &sport->port);
 		iounmap(sport->port.membase);
-		peripheral_free_list(
-			(unsigned short *)dev_get_platdata(&pdev->dev));
+		peripheral_free_list(dev_get_platdata(&pdev->dev));
 		kfree(sport);
 		bfin_sport_uart_ports[pdev->id] = NULL;
 	}
-- 
1.7.10.4


