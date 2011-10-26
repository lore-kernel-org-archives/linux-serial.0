From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 30/79] TTY: serial, use ASYNCB_CLOSING in uart_close
Date: Wed, 26 Oct 2011 14:12:35 +0200
Message-ID: <1319631204-23262-30-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60991 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932852Ab1JZMNl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:41 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 6BA338F71C
	for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2011 14:13:40 +0200 (CEST)
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

We need to move port->mutex locking after wait_until_sent in
uart_close (for rationale see next patches). But if we did it now, we
would introduce a race between close and open. This is exactly why
port->mutex is locked at the top of uart_close.

To avoid the race, we add ASYNCB_CLOSING to uart_close. Like every
other sane TTY driver. Thanks to tty_port_block_til_ready used in
uart_open we will have this for free. Then we can move the port->mutex
lock.

Also note that this will make the conversion to tty_port helpers
easier. They are currently handling ASYNC_CLOSING flag correctly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3844980..849bd0d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1288,6 +1288,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	 * the line discipline to only process XON/XOFF characters by
 	 * setting tty->closing.
 	 */
+	set_bit(ASYNCB_CLOSING, &port->flags);
 	tty->closing = 1;
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -1335,8 +1336,10 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	 * Wake up anyone trying to open this port.
 	 */
 	clear_bit(ASYNCB_NORMAL_ACTIVE, &port->flags);
+	clear_bit(ASYNCB_CLOSING, &port->flags);
 	spin_unlock_irqrestore(&port->lock, flags);
 	wake_up_interruptible(&port->open_wait);
+	wake_up_interruptible(&port->close_wait);
 
 done:
 	mutex_unlock(&port->mutex);
-- 
1.7.7

