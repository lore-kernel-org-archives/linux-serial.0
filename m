From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/3] serial: sirf: fix the typo for rts/cts gpio
Date: Mon, 19 Aug 2013 11:47:51 +0800
Message-ID: <1376884073-22375-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43092 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab3HSDsH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Aug 2013 23:48:07 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so4454998pbc.31
        for <linux-serial@vger.kernel.org>; Sun, 18 Aug 2013 20:48:06 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

fix the typo in commit 2eb5618de87927e54 which uses two
gpios for rts/cts.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index ed3b890..10718c0 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -915,20 +915,20 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 			 !gpio_is_valid(sirfport->rts_gpio))) {
 			ret = -EINVAL;
 			dev_err(&pdev->dev,
-				"Usp flow control must have rfs and tfs gpio");
+				"Usp flow control must have cts and rts gpio");
 			goto err;
 		}
 		ret = devm_gpio_request(&pdev->dev, sirfport->cts_gpio,
-				"usp-rfs-gpio");
+				"usp-cts-gpio");
 		if (ret) {
-			dev_err(&pdev->dev, "Unable request rfs gpio");
+			dev_err(&pdev->dev, "Unable request cts gpio");
 			goto err;
 		}
 		gpio_direction_input(sirfport->cts_gpio);
 		ret = devm_gpio_request(&pdev->dev, sirfport->rts_gpio,
-				"usp-tfs-gpio");
+				"usp-rts-gpio");
 		if (ret) {
-			dev_err(&pdev->dev, "Unable request tfs gpio");
+			dev_err(&pdev->dev, "Unable request rts gpio");
 			goto err;
 		}
 		gpio_direction_output(sirfport->rts_gpio, 1);
-- 
1.8.2.3

