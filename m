From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/12] TTY: serial, document ignoring of uart->ops->startup error
Date: Fri, 26 Aug 2011 13:58:20 -0700
Message-ID: <1314392301-25140-11-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37758 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab1HZU6e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:58:34 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Russel King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

When a user has SYS_ADMIN capabilities and uart->ops->startup returns
an error in uart_startup, we silently drop the error. We then return 0
and behave as if it didn't fail. (Not quite, since we set TTY_IO_ERROR
bit and leave ASYNC_INITIALIZED bit cleared.)

This all is to allow setserial to work with improperly configured or
unconfigured ports. User can thus set port properties and reconfigure
properly.

This patch only documents this behavior.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russel King <linux@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index db7912c..a3efbea 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -200,6 +200,11 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state, int in
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 	}
 
+	/*
+	 * This is to allow setserial on this port. People may want to set
+	 * port/irq/type and then reconfigure the port properly if it failed
+	 * now.
+	 */
 	if (retval && capable(CAP_SYS_ADMIN))
 		retval = 0;
 
-- 
1.7.6.1

