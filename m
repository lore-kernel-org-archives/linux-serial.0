From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH v3] serial: pxa: add spin lock for console write
Date: Thu, 14 Jun 2012 12:18:46 +0800
Message-ID: <1339647526-24702-1-git-send-email-haojian.zhuang@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47551 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab2FNESg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Jun 2012 00:18:36 -0400
Received: by pbbrp8 with SMTP id rp8so3225891pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 13 Jun 2012 21:18:35 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

From: Chao Xie <chao.xie@marvell.com>

v3:
Remove empty line

v2:
Move local_irq_save() after clk_prepare_enable()

v1:
At UP mode, when cpu want to print message in kernel, it will invoke
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
Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/tty/serial/pxa.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5847a4b..9033fc6 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -670,9 +670,19 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_pxa_port *up = serial_pxa_ports[co->index];
 	unsigned int ier;
+	unsigned long flags;
+	int locked = 1;
 
 	clk_prepare_enable(up->clk);
 
+	local_irq_save(flags);
+	if (up->port.sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&up->port.lock);
+	else
+		spin_lock(&up->port.lock);
+
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
@@ -688,6 +698,10 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	wait_for_xmitr(up);
 	serial_out(up, UART_IER, ier);
 
+	if (locked)
+		spin_unlock(&up->port.lock);
+	local_irq_restore(flags);
+
 	clk_disable_unprepare(up->clk);
 }
 
-- 
1.7.5.4

