From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/48] TTY: serial_core, remove unused variable
Date: Mon, 23 May 2011 12:06:22 -0700
Message-ID: <1306177625-17885-5-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177625-17885-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56686 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932726Ab1EWTQU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:16:20 -0400
In-Reply-To: <1306177625-17885-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

drivers/tty/serial/serial_core.c:1980:2: warning: Value stored to 'tty' is never read
        tty = port->tty;
        ^     ~~~~~~~~~

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 733fe8e..d6e7240 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1972,13 +1972,9 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	struct tty_port *port = &state->port;
 	struct device *tty_dev;
 	struct uart_match match = {uport, drv};
-	struct tty_struct *tty;
 
 	mutex_lock(&port->mutex);
 
-	/* Must be inside the mutex lock until we convert to tty_port */
-	tty = port->tty;
-
 	tty_dev = device_find_child(uport->dev, &match, serial_match_port);
 	if (device_may_wakeup(tty_dev)) {
 		if (!enable_irq_wake(uport->irq))
-- 
1.7.4.2

