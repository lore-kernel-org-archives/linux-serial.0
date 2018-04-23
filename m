From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 1/4] serial: uartps: Remove console_initcall from the driver
Date: Mon, 23 Apr 2018 11:51:00 +0200
Message-ID: <dc341a4527db1cf4589afa1d932fc9dcd5796860.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

register_console() is called from
uart_add_one_port()->uart_configure_port()
that's why register_console() is called twice.

This patch remove console_initcall to call register_console() only from
one location.

Also based on my tests cdns_uart_console_setup() is not called
from the first register_console() call.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
---

I am not quite sure about this because console_initcall is called
early but I can see any difference in usage.
pl011 is not calling this but others are doing it.
---
 drivers/tty/serial/xilinx_uartps.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index bd72dd843338..932210331484 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1293,20 +1293,6 @@ static struct console cdns_uart_console = {
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
2.17.0
