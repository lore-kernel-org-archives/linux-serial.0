From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] serial: fsl_lpuart: Return proper error on
 lpuart_serial_init error path
Date: Mon, 22 Jul 2013 09:12:36 +0800
Message-ID: <1374455556.8414.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:47610 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab3GVBMs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 Jul 2013 21:12:48 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so6193099pdi.2
        for <linux-serial@vger.kernel.org>; Sun, 21 Jul 2013 18:12:48 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jingchang Lu <b35083@freescale.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 263cfaa..1fe1257 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -858,7 +858,7 @@ static int __init lpuart_serial_init(void)
 	if (ret)
 		uart_unregister_driver(&lpuart_reg);
 
-	return 0;
+	return ret;
 }
 
 static void __exit lpuart_serial_exit(void)
-- 
1.8.1.2



