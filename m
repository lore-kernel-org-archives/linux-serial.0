From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] tty: serial: altera_uart: Simplify altera_uart_init()
Date: Tue,  5 Feb 2013 18:07:42 +0100
Message-ID: <1360084062-14792-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:58461 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755246Ab3BERPM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Feb 2013 12:15:12 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org

No need for two separate return statements, consolidate them.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_uart.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index e133c88..13471dd 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -637,11 +637,9 @@ static int __init altera_uart_init(void)
 	if (rc)
 		return rc;
 	rc = platform_driver_register(&altera_uart_platform_driver);
-	if (rc) {
+	if (rc)
 		uart_unregister_driver(&altera_uart_driver);
-		return rc;
-	}
-	return 0;
+	return rc;
 }
 
 static void __exit altera_uart_exit(void)
-- 
1.7.5.4

