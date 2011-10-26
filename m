From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 31/79] TTY: serial, move locking in uart_close
Date: Wed, 26 Oct 2011 14:12:36 +0200
Message-ID: <1319631204-23262-31-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60992 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1JZMNl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:41 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D128F8FA98
	for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2011 14:13:40 +0200 (CEST)
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

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
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 849bd0d..0464360 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1253,7 +1253,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 	pr_debug("uart_close(%d) called\n", uport->line);
 
-	mutex_lock(&port->mutex);
 	spin_lock_irqsave(&port->lock, flags);
 
 	if (tty_hung_up_p(filp)) {
@@ -1312,6 +1311,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 		uart_wait_until_sent(tty, uport->timeout);
 	}
 
+	mutex_lock(&port->mutex);
 	uart_shutdown(tty, state);
 	uart_flush_buffer(tty);
 
-- 
1.7.7

