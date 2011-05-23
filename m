From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/48] TTY: serial_core, remove unused variable
Date: Mon, 23 May 2011 12:10:11 -0700
Message-ID: <1306177854-18172-5-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42014 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573Ab1EWTKF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:05 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 880BA939FD
	for <linux-serial@vger.kernel.org>; Mon, 23 May 2011 21:10:04 +0200 (CEST)
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
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

