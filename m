From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] serial: 8250_port: Disable DMA operations for kernel console
Date: Tue, 15 May 2018 21:34:09 +0300
Message-ID: <20180515183409.78046-4-andriy.shevchenko@linux.intel.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

It will be too tricky and error prone to allow DMA operations on kernel
console.

Disable any kind of DMA operations in such case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index db97222a1bf4..9a4696ea728b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2371,7 +2371,10 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Request DMA channels for both RX and TX.
 	 */
 	if (up->dma) {
-		retval = serial8250_request_dma(up);
+		if (uart_console(port))
+			retval = -ENXIO;
+		else
+			retval = serial8250_request_dma(up);
 		if (retval)
 			pr_warn_ratelimited("ttyS%d - failed to request DMA\n",
 					    serial_index(port));
-- 
2.17.0
