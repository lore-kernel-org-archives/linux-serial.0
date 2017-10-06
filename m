From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] serial-uartlite: pr_err() strings should end with newlines
Date: Fri,  6 Oct 2017 17:04:18 +0530
Message-ID: <5ab8cb1cbd4c6ea75e5f39cc0f1ea3ec01759bb0.1507288681.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jacmet@sunsite.dk, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/uartlite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index c9b8d70..1de9942 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -739,7 +739,7 @@ static int __init ulite_init(void)
 err_plat:
 	uart_unregister_driver(&ulite_uart_driver);
 err_uart:
-	pr_err("registering uartlite driver failed: err=%i", ret);
+	pr_err("registering uartlite driver failed: err=%i\n", ret);
 	return ret;
 }
 
-- 
1.9.1
