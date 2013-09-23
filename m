From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] serial: sccnxp: missing uart_unregister_driver() on error in sccnxp_probe()
Date: Mon, 23 Sep 2013 21:54:20 +0800
Message-ID: <CAPgLHd_cK2aBwJ6FWEEEGBXBzZ9CbtY2ARGyFMUYJDn2YUn+Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:46972 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab3IWNyV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Sep 2013 09:54:21 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so1193249bkb.31
        for <linux-serial@vger.kernel.org>; Mon, 23 Sep 2013 06:54:20 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing uart_unregister_driver() before return
from sccnxp_probe() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/sccnxp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 49e9bbf..a447f71 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -986,6 +986,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 		return 0;
 	}
 
+	uart_unregister_driver(&s->uart);
 err_out:
 	if (!IS_ERR(s->regulator))
 		return regulator_disable(s->regulator);

