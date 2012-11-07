From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH 09/10] serial: sh-sci: add locking to console write function to
 avoid SMP lockup
Date: Wed, 07 Nov 2012 16:00:46 +0900
Message-ID: <509A071E.7070206@renesas.com>
References: <509A0658.1010503@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:55070 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab2KGHAt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 02:00:49 -0500
In-reply-to: <509A0658.1010503@renesas.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: rjw@sisk.pl, takashi.yoshii.zj@renesas.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org

Symptom:

When entering the suspend with Android logcat running, printk() call
gets stuck and never returns.  The issue can be observed at printk()s
on nonboot CPUs when going to offline with their interrupts disabled,
and never seen at boot CPU (core0 in our case).

Details:

serial_console_write() lacks of appropriate spinlock handling.

In SMP systems, as long as sci_transmit_chars() is being processed
at one CPU core, serial_console_write() can stuck at the other CPU
core(s), when it tries to access to the same serial port _without_
a proper locking.  serial_console_write() waits for the transmit FIFO
getting empty, while sci_transmit_chars() writes data to the FIFO.

In general, peripheral interrupts are routed to boot CPU (core0) by
Linux ARM standard affinity settings.  SCI(F) interrupts are handled
by core0, so sci_transmit_chars() is processed on core0 as well.

When logcat is running, it writes enormous log data to the kernel at
every moment, forever.  So core0 can repeatedly continue to process
sci_transmit_chars() in its interrupt handler, which eventually makes
the other CPU core(s) stuck at serial_console_write().

Looking at serial/8250.c, this is a known console write lockup issue
with SMP kernels.  Fix the sh-sci driver in the same way 8250.c does.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

|commit ef605fdb33883d687cff5ba75095a91b313b4966
|Author: Rabin Vincent <rabin.vincent@stericsson.com>
|Date:   Tue Jan 17 11:52:28 2012 +0100
|
|    serial: amba-pl011: lock console writes against interrupts

|commit 9ec1882df244c4ee1baa692676fef5e8b0f5487d
|Author: Xinyu Chen <xinyu.chen@freescale.com>
|Date:   Mon Aug 27 09:36:51 2012 +0200
|
|    tty: serial: imx: console write routing is unsafe on SMP
---
 drivers/tty/serial/sh-sci.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 502fa47..0b8d029 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2202,7 +2202,21 @@ static void serial_console_write(struct console *co, const char *s,
 {
 	struct sci_port *sci_port = &sci_ports[co->index];
 	struct uart_port *port = &sci_port->port;
-	unsigned short bits;
+	unsigned short bits, ctrl;
+	unsigned long flags;
+	int locked = 1;
+
+	local_irq_save(flags);
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&port->lock);
+	else
+		spin_lock(&port->lock);
+
+	/* first save the SCSCR then disable the interrupts */
+	ctrl = serial_port_in(port, SCSCR);
+	serial_port_out(port, SCSCR, sci_port->cfg->scscr);
 
 	uart_console_write(port, s, count, serial_console_putchar);
 
@@ -2210,6 +2224,13 @@ static void serial_console_write(struct console *co, const char *s,
 	bits = SCxSR_TDxE(port) | SCxSR_TEND(port);
 	while ((serial_port_in(port, SCxSR) & bits) != bits)
 		cpu_relax();
+
+	/* restore the SCSCR */
+	serial_port_out(port, SCSCR, ctrl);
+
+	if (locked)
+		spin_unlock(&port->lock);
+	local_irq_restore(flags);
 }
 
 static int __devinit serial_console_setup(struct console *co, char *options)
-- 
1.7.12.4

