From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/3] serial: sirf: drop redundant pinctrl_get_select_default as pinctrl core does it
Date: Tue, 13 Aug 2013 19:18:15 +0800
Message-ID: <1376392697-20664-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:49394 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab3HMLSa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Aug 2013 07:18:30 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4727764pdj.36
        for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2013 04:18:29 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>, Linus Walleij <linus.walleij@linaro.org>

pinctrl core will get default pinmux, so drop it in the sirfsoc serial driver.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 12 ------------
 drivers/tty/serial/sirfsoc_uart.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 3b9382b..64d0192 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
-#include <linux/pinctrl/consumer.h>
 
 #include "sirfsoc_uart.h"
 
@@ -893,13 +892,6 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	}
 	port->irq = res->start;
 
-	if (sirfport->hw_flow_ctrl) {
-		sirfport->p = pinctrl_get_select_default(&pdev->dev);
-		ret = IS_ERR(sirfport->p);
-		if (ret)
-			goto err;
-	}
-
 	sirfport->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sirfport->clk)) {
 		ret = PTR_ERR(sirfport->clk);
@@ -925,8 +917,6 @@ port_err:
 	clk_put(sirfport->clk);
 clk_err:
 	platform_set_drvdata(pdev, NULL);
-	if (sirfport->hw_flow_ctrl)
-		pinctrl_put(sirfport->p);
 err:
 	return ret;
 }
@@ -936,8 +926,6 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 	struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
 	struct uart_port *port = &sirfport->port;
 	platform_set_drvdata(pdev, NULL);
-	if (sirfport->hw_flow_ctrl)
-		pinctrl_put(sirfport->p);
 	clk_disable_unprepare(sirfport->clk);
 	clk_put(sirfport->clk);
 	uart_remove_one_port(&sirfsoc_uart_drv, port);
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 6f6d275..2b41b06 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -367,7 +367,6 @@ struct sirfsoc_uart_port {
 	unsigned char			ms_enabled;
 
 	struct uart_port		port;
-	struct pinctrl			*p;
 	struct clk			*clk;
 	/* for SiRFmarco, there are SET/CLR for UART_INT_EN */
 	bool				is_marco;
-- 
1.8.2.3

