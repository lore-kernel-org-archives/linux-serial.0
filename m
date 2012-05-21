From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH] serial: pxa: add spin lock for console write
Date: Mon, 21 May 2012 10:33:48 +0800
Message-ID: <1337567628-22180-1-git-send-email-chao.xie@marvell.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:33661 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756250Ab2EUCbL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 May 2012 22:31:11 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, haojian.zhuang@marvell.com
Cc: Chao Xie <chao.xie@marvell.com>

at UP mode, when cpu want to print message in kernel, it will invoke
peempt_disable and disable irq. So it is safe for UP mode.
For SMP mode, it is not safe to protect the HW reigsters.
one CPU will run a program which will invoke printf.
another CPU will run a program in kernel that invoke printk.
So when second CPU is trying to printk, it will do
1. save ier register
2. enable uue bit of ier register
3. push buffer to uart fifo
4 .restore ier register
when first CPU want to printf, and it happens between 1 and 4, it will
enable thre bit of ier, and waiting for transmit intterupt. while step 4
will make the ier lost thre bit.
add spin lock here to protect the ier register for console write.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/tty/serial/pxa.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5847a4b..d94387f 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -670,6 +670,16 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_pxa_port *up = serial_pxa_ports[co->index];
 	unsigned int ier;
+	unsigned long flags;
+	int locked = 1;
+
+	local_irq_save(flags);
+	if (up->port.sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&up->port.lock);
+	else
+		spin_lock(&up->port.lock);
 
 	clk_prepare_enable(up->clk);
 
@@ -689,6 +699,11 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	serial_out(up, UART_IER, ier);
 
 	clk_disable_unprepare(up->clk);
+
+	if (locked)
+		spin_unlock(&up->port.lock);
+	local_irq_restore(flags);
+
 }
 
 static int __init
-- 
1.7.0.4

