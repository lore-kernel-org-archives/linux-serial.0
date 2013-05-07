From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 05/15] serial: clps711x: remove unnecessary
 platform_set_drvdata()
Date: Tue, 07 May 2013 17:01:09 +0900
Message-ID: <008a01ce4af9$08e21730$1aa64590$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46002 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758068Ab3EGIBN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:01:13 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00E224V3ZIK0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:01:09 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Alexander Shiyan' <shc_work@mail.ru>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/clps711x.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index bfb1796..7e4e408 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -438,8 +438,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	s->uart_clk = devm_clk_get(&pdev->dev, "uart");
 	if (IS_ERR(s->uart_clk)) {
 		dev_err(&pdev->dev, "Can't get UART clocks\n");
-		ret = PTR_ERR(s->uart_clk);
-		goto err_out;
+		return PTR_ERR(s->uart_clk);
 	}
 
 	s->uart.owner		= THIS_MODULE;
@@ -461,7 +460,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Registering UART driver failed\n");
 		devm_clk_put(&pdev->dev, s->uart_clk);
-		goto err_out;
+		return ret;
 	}
 
 	for (i = 0; i < UART_CLPS711X_NR; i++) {
@@ -478,11 +477,6 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_out:
-	platform_set_drvdata(pdev, NULL);
-
-	return ret;
 }
 
 static int uart_clps711x_remove(struct platform_device *pdev)
@@ -495,7 +489,6 @@ static int uart_clps711x_remove(struct platform_device *pdev)
 
 	devm_clk_put(&pdev->dev, s->uart_clk);
 	uart_unregister_driver(&s->uart);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.2.5


