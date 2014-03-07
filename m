From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] serial: 8250: Clean up the locking for -rt
Date: Fri,  7 Mar 2014 14:58:39 +0100
Message-ID: <1394200719-12601-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37724 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaCGN6u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Mar 2014 08:58:50 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Ingo Molnar <mingo@elte.hu>

In -RT the spin_lock_irqsave() does not spin but sleep if the lock is
taken. Before that, local_irq_save() is invoked which disables
interrupts even on -RT. Therefore local_irq_save() + spin_lock() does not
work.
In the ->sysrq and oops_in_progress case it is save to trylock the lock
i.e. this is what we do now anyway except for ->sysrq where we assume
that the lock is already taken.

The spin_lock_irqsave() grabs the lock and disables the interrupts on
vanilla (the same behavior) and on -RT it won't disable interrupts.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: add a patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 747073b..81f909c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2886,14 +2886,10 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 
 	touch_nmi_watchdog();
 
-	local_irq_save(flags);
-	if (port->sysrq) {
-		/* serial8250_handle_irq() already took the lock */
-		locked = 0;
-	} else if (oops_in_progress) {
-		locked = spin_trylock(&port->lock);
-	} else
-		spin_lock(&port->lock);
+	if (port->sysrq || oops_in_progress)
+		locked = spin_trylock_irqsave(&port->lock, flags);
+	else
+		spin_lock_irqsave(&port->lock, flags);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -2925,8 +2921,7 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 		serial8250_modem_status(up);
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int __init serial8250_console_setup(struct console *co, char *options)
-- 
1.9.0

