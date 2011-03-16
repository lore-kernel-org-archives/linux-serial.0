From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 67/76] Staging: generic_serial: fix double locking bug
Date: Wed, 16 Mar 2011 14:12:37 -0700
Message-ID: <1300309966-5745-67-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32839 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754856Ab1CPVPb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:31 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Dan Carpenter <error27@gmail.com>

spin_lock_irqsave() is not nestable.  The second time that it gets
called it overwrites the "flags" variable and so IRQs can't be restored
properly.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/generic_serial/generic_serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/generic_serial/generic_serial.c b/drivers/staging/generic_serial/generic_serial.c
index 5954ee1..466988d 100644
--- a/drivers/staging/generic_serial/generic_serial.c
+++ b/drivers/staging/generic_serial/generic_serial.c
@@ -566,9 +566,9 @@ void gs_close(struct tty_struct * tty, struct file * filp)
 	 * line status register.
 	 */
 
-	spin_lock_irqsave(&port->driver_lock, flags);
+	spin_lock(&port->driver_lock);
 	port->rd->disable_rx_interrupts (port);
-	spin_unlock_irqrestore(&port->driver_lock, flags);
+	spin_unlock(&port->driver_lock);
 	spin_unlock_irqrestore(&port->port.lock, flags);
 
 	/* close has no way of returning "EINTR", so discard return value */
-- 
1.7.4.1

