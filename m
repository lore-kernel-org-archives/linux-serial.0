From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/5] TTY: serial, move locking in uart_close
Date: Thu, 25 Aug 2011 15:12:05 +0200
Message-ID: <1314277928-13388-2-git-send-email-jslaby@suse.cz>
References: <4E556CB7.2010102@suse.cz>
 <1314277928-13388-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.pripojeni.net ([178.22.112.14]:49567 "EHLO
	smtp.pripojeni.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab1HYNMR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Aug 2011 09:12:17 -0400
In-Reply-To: <1314277928-13388-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: Arnd Bergmann <arnd@arndb.de>, alan@linux.intel.com, linux-serial@vger.kernel.org, jirislaby@gmail.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

So now, when we handle CLOSING flag, there is no point to hold
port->mutex over the start of uart_close.

Yes, there are still several things to reason about:
* port->count etc is and always was protected by a spinlock
* ->stop_rx is protected by a spinlock. Otherwise it would
  race with interrupts.
* uart_wait_until_sent -- that one is already called without
  port->mutex from set_termios and tty_set_ldisc. Should anything
  be protected there, it would be tx_empty. And by a spinlock.
  8250 does this internally...

This step is needed to fix system stalls. To not create an AB-BA lock
dependency (see next patches).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/serial_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index cd7a0bb..e1bff1b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1258,7 +1258,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 	pr_debug("uart_close(%d) called\n", uport->line);
 
-	mutex_lock(&port->mutex);
 	spin_lock_irqsave(&port->lock, flags);
 
 	if (tty_hung_up_p(filp)) {
@@ -1317,6 +1316,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 		uart_wait_until_sent(tty, uport->timeout);
 	}
 
+	mutex_lock(&port->mutex);
 	uart_shutdown(tty, state);
 	uart_flush_buffer(tty);
 
-- 
1.7.6


