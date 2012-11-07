From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH 10/10] serial: sh-sci: fix possible race cases on SCSCR
 register accesses
Date: Wed, 07 Nov 2012 16:01:05 +0900
Message-ID: <509A0731.6020908@renesas.com>
References: <509A0658.1010503@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <509A0658.1010503@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: rjw@sisk.pl, takashi.yoshii.zj@renesas.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In the previous commit, console write function (serial_console_write)
is changed to disable SCI interrupts while printing console strings.
This introduces possible race cases in the serial startup / shutdown
functions on SMP systems.

This patch fixes the sh-sci in the same way as commit 9ec1882df2
(tty: serial: imx: console write routing is unsafe on SMP, from
Xinyu Chen <xinyu.chen@freescale.com>, 2012-08-27) did.

There could be several consumers of the console,
* the kernel printk
* the init process using /dev/kmsg to call printk to show log
* shell, which opens /dev/console and writes with sys_write()

The shell goes into the normal UART open() and write() system calls,
while the other two go into the console operations.  The open() call
invokes serial startup function (sci_startup), which will write to
the SCSCR register (to enable or disable SCI interrupts) without any
locking.  This will conflict with the console serial function.

Add spinlock protections in sci_startup() and sci_shutdown() properly.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0b8d029..8e3c7f7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1742,6 +1742,7 @@ static inline void sci_free_dma(struct uart_port *port)
 static int sci_startup(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
+	unsigned long flags;
 	int ret;
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
@@ -1752,8 +1753,10 @@ static int sci_startup(struct uart_port *port)
 
 	sci_request_dma(port);
 
+	spin_lock_irqsave(&port->lock, flags);
 	sci_start_tx(port);
 	sci_start_rx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return 0;
 }
@@ -1761,11 +1764,14 @@ static int sci_startup(struct uart_port *port)
 static void sci_shutdown(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
+	unsigned long flags;
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
 	sci_stop_tx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	sci_free_dma(port);
 	sci_free_irq(s);
-- 
1.7.12.4

