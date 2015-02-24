From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Subject: [PATCH] tty: serial: xilinx_uartps: Use Macro for ttyPS0
Date: Tue, 24 Feb 2015 15:13:57 -0800
Message-ID: <1424819637-23863-1-git-send-email-peter.crosthwaite@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: soren.brinkmann@xilinx.com, michal.simek@xilinx.com, gregkh@linuxfoundation.org, Peter Crosthwaite <peter.crosthwaite@xilinx.com>
List-Id: linux-serial@vger.kernel.org

All instances of "ttyPS" use this macro except for this one. Convert
it.

Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index cff531a..8f9c543 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1154,7 +1154,8 @@ static int __init cdns_uart_console_setup(struct console *co, char *options)
 		return -EINVAL;
 
 	if (!port->mapbase) {
-		pr_debug("console on ttyPS%i not present\n", co->index);
+		pr_debug("console on " CDNS_UART_TTY_NAME "%i not present\n",
+			 co->index);
 		return -ENODEV;
 	}
 
-- 
2.3.0.1.g27a12f1
