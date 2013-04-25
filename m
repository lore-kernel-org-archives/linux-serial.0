From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] serial: mcf: missing uart_unregister_driver() on error in mcf_init()
Date: Thu, 25 Apr 2013 09:17:23 +0800
Message-ID: <CAPgLHd8dt1hCYhkC1DYMXNBNbmyDqQyfYucDZSTijtruvvKG6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:35813 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758658Ab3DYBRY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Apr 2013 21:17:24 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf3so993062bkc.7
        for <linux-serial@vger.kernel.org>; Wed, 24 Apr 2013 18:17:23 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing uart_unregister_driver() before return
from mcf_init() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/mcf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index e956377..65be0c0 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -707,8 +707,10 @@ static int __init mcf_init(void)
 	if (rc)
 		return rc;
 	rc = platform_driver_register(&mcf_platform_driver);
-	if (rc)
+	if (rc) {
+		uart_unregister_driver(&mcf_driver);
 		return rc;
+	}
 	return 0;
 }
 

