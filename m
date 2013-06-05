From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] serial: omap: fix potential NULL pointer dereference in serial_omap_runtime_suspend()
Date: Wed, 5 Jun 2013 10:04:49 +0800
Message-ID: <CAPgLHd-N6jTD_WvT2KgsG8vOtKCtpJET8ddyQBWUMp=qG_3G+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:46658 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab3FECEv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jun 2013 22:04:51 -0400
Received: by mail-we0-f178.google.com with SMTP id u53so813758wes.23
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2013 19:04:50 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com, sourav.poddar@ti.com
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The dereference to 'up' should be moved below the NULL test.
Introduced by commit ddd85e225c8885b5e4419b0499ab27100e7c366a
(serial: omap: prevent runtime PM for "no_console_suspend")

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/omap-serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1aaeca8..156b5aa 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1613,6 +1613,9 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 	struct omap_uart_port_info *pdata = dev->platform_data;
 
+	if (!up)
+		return -EINVAL;
+
 	/*
 	* When using 'no_console_suspend', the console UART must not be
 	* suspended. Since driver suspend is managed by runtime suspend,
@@ -1623,9 +1626,6 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	    uart_console(&up->port))
 		return -EBUSY;
 
-	if (!up)
-		return -EINVAL;
-
 	if (!pdata)
 		return 0;
 

