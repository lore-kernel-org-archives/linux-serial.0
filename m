From: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
Subject: [PATCH] serial: omap: free the wakeup settings in remove
Date: Fri, 21 Mar 2014 13:55:10 +0530
Message-ID: <1395390310-21602-1-git-send-email-sanjay.rawat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:54402 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbaCUIZ0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Mar 2014 04:25:26 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so2130032pbc.27
        for <linux-serial@vger.kernel.org>; Fri, 21 Mar 2014 01:25:26 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sanjay Singh Rawat <sanjay.rawat@linaro.org>

Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
---
 drivers/tty/serial/omap-serial.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 77f0351..56b61d4 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1782,6 +1782,7 @@ static int serial_omap_remove(struct platform_device *dev)
 	pm_runtime_disable(up->dev);
 	uart_remove_one_port(&serial_omap_reg, &up->port);
 	pm_qos_remove_request(&up->pm_qos_request);
+	device_init_wakeup(&dev->dev, false);
 
 	return 0;
 }
-- 
1.7.10.4

