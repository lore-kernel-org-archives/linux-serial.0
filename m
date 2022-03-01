Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D5BC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 05:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiCAFjW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 00:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiCAFjV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 00:39:21 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA614B1D9;
        Mon, 28 Feb 2022 21:38:37 -0800 (PST)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 1 Mar 2022
 13:38:35 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] tty: serial: meson: Fixed an issue where pclk was turned on on probe but should be turned off on subsequent errors.
Date:   Tue, 1 Mar 2022 13:37:38 +0800
Message-ID: <20220301053738.21163-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Call clk_prepare_enable in the probe function to enable pclk. If you
exit the probe function later in an error, call clk_disable_unprepare
to disable pclk.

Fixes: 44023b8e1f14 ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 37 +++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index bf6be5468aaf..972f210f3492 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -780,28 +780,37 @@ static int meson_uart_probe(struct platform_device *pdev)
 		return ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_out_clk_disable;
+	}
 
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
 
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err_out_clk_disable;
 	}
 
 	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
-	if (!port)
-		return -ENOMEM;
+	if (!port) {
+		ret = -ENOMEM;
+		goto err_out_clk_disable;
+	}
 
 	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
-	if (IS_ERR(port->membase))
-		return PTR_ERR(port->membase);
+	if (IS_ERR(port->membase)) {
+		ret = PTR_ERR(port->membase);
+		goto err_out_clk_disable;
+	}
 
 	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
 				    GFP_KERNEL);
-	if (!private_data)
-		return -ENOMEM;
+	if (!private_data) {
+		ret = -ENOMEM;
+		goto err_out_clk_disable;
+	}
 
 	if (device_get_match_data(&pdev->dev))
 		private_data->use_xtal_clk = true;
@@ -822,7 +831,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 
 	ret = meson_uart_probe_clocks(port);
 	if (ret)
-		return ret;
+		goto err_out_clk_disable;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
@@ -831,9 +840,15 @@ static int meson_uart_probe(struct platform_device *pdev)
 	meson_uart_reset(port);
 
 	ret = uart_add_one_port(&meson_uart_driver, port);
-	if (ret)
+	if (ret) {
 		meson_ports[pdev->id] = NULL;
+		goto err_out_clk_disable;
+	}
+
+	return 0;
 
+err_out_clk_disable:
+	clk_disable_unprepare(pclk);
 	return ret;
 }
 

base-commit: d4ab5487cc77a4053dc9070c5761ad94bf397825
-- 
2.33.1

