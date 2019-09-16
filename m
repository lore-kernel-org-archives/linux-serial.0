From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] serial: uartlite: fix exit path null pointer
Date: Mon, 16 Sep 2019 16:12:23 -0700
Message-ID: <9c8e6581-6fcc-a595-0897-4d90f5d710df@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Korsgaard <jacmet@sunsite.dk>
List-Id: linux-serial@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Call uart_unregister_driver() conditionally instead of
unconditionally, only if it has been previously registered.

This uses driver.state, just as the sh-sci.c driver does.

Fixes this null pointer dereference in tty_unregister_driver(),
since the 'driver' argument is null:

  general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
  RIP: 0010:tty_unregister_driver+0x25/0x1d0

Fixes: 238b8721a554 ("serial uartlite driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/tty/serial/uartlite.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lnx-53.orig/drivers/tty/serial/uartlite.c
+++ lnx-53/drivers/tty/serial/uartlite.c
@@ -897,7 +897,8 @@ static int __init ulite_init(void)
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	uart_unregister_driver(&ulite_uart_driver);
+	if (ulite_uart_driver.state)
+		uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
