From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/5] serial: imx: Use pr_info instead of printk
Date: Mon,  7 Jan 2013 10:25:05 +0530
Message-ID: <1357534506-30206-5-git-send-email-sachin.kamat@linaro.org>
References: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36051 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab3AGFDa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 00:03:30 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so10509058pad.39
        for <linux-serial@vger.kernel.org>; Sun, 06 Jan 2013 21:03:29 -0800 (PST)
In-Reply-To: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, jslaby@suse.cz, shawn.guo@linaro.org, s.hauer@pengutronix.de, sachin.kamat@linaro.org, patches@linaro.org

Silences checkpatch warnings.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/imx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9bec8a2..78f7936 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1301,7 +1301,7 @@ imx_console_get_options(struct imx_port *sport, int *baud,
 		}
 
 		if (*baud != baud_raw)
-			printk(KERN_INFO "Serial: Console IMX rounded baud rate from %d to %d\n",
+			pr_info("Console IMX rounded baud rate from %d to %d\n",
 				baud_raw, *baud);
 	}
 }
@@ -1595,7 +1595,7 @@ static int __init imx_serial_init(void)
 {
 	int ret;
 
-	printk(KERN_INFO "Serial: IMX driver\n");
+	pr_info("Serial: IMX driver\n");
 
 	ret = uart_register_driver(&imx_reg);
 	if (ret)
-- 
1.7.4.1

