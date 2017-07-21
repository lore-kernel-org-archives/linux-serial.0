From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC PATCH 1/4] serial: uartps: Remove console_initcall from the driver
Date: Fri, 21 Jul 2017 11:32:24 +0200
Message-ID: <bd75a2ab5838ae1cf44af667e24be2f02c2e9f3c.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

register_console() is called from
uart_add_one_port()->uart_configure_port()
that's why register_console() is called twice.

This patch remove console_initcall to call register_console() only from
one location.

Also based on my tests cdns_uart_console_setup() is not called
from the first register_console() call.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

I am not quite sure about this because console_initcall is called
early but I can see any difference in usage.
pl011 is not calling this but others are doing it.

---
 drivers/tty/serial/xilinx_uartps.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fde55dcdea5a..4614349403c1 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1298,20 +1298,6 @@ static int __init cdns_uart_console_setup(struct console *co, char *options)
 	.index	= -1, /* Specified on the cmdline (e.g. console=ttyPS ) */
 	.data	= &cdns_uart_uart_driver,
 };
-
-/**
- * cdns_uart_console_init - Initialization call
- *
- * Return: 0 on success, negative errno otherwise
- */
-static int __init cdns_uart_console_init(void)
-{
-	register_console(&cdns_uart_console);
-	return 0;
-}
-
-console_initcall(cdns_uart_console_init);
-
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
 static struct uart_driver cdns_uart_uart_driver = {
-- 
1.9.1
