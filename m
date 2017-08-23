From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] tty: xilinx_uartps: move to arch_initcall for earlier console
Date: Wed, 23 Aug 2017 16:50:21 +0530
Message-ID: <1503487221-17950-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ff1b115..a239343 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1647,7 +1647,7 @@ static void __exit cdns_uart_exit(void)
 	uart_unregister_driver(&cdns_uart_uart_driver);
 }
 
-module_init(cdns_uart_init);
+arch_initcall(cdns_uart_init);
 module_exit(cdns_uart_exit);
 
 MODULE_DESCRIPTION("Driver for Cadence UART");
-- 
2.1.1
