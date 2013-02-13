From: Johan Hovold <jhovold@gmail.com>
Subject: [RFC 1/4] tty: clean up port shutdown
Date: Wed, 13 Feb 2013 18:27:23 +0100
Message-ID: <1360776446-31371-2-git-send-email-jhovold@gmail.com>
References: <20130213142513.GA21078@localhost>
 <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:52650 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760144Ab3BMR3I (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 12:29:08 -0500
In-Reply-To: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Johan Hovold <jhovold@gmail.com>

Untangle port-shutdown logic and make sure the initialised flag is
always cleared for non-console ports.
---
 drivers/tty/tty_port.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index b7ff59d..57a061e 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -199,9 +199,14 @@ EXPORT_SYMBOL(tty_port_tty_set);
 static void tty_port_shutdown(struct tty_port *port)
 {
 	mutex_lock(&port->mutex);
-	if (port->ops->shutdown && !port->console &&
-		test_and_clear_bit(ASYNCB_INITIALIZED, &port->flags))
+	if (port->console)
+		goto out;
+
+	if (test_and_clear_bit(ASYNCB_INITIALIZED, &port->flags)) {
+		if (port->ops->shutdown)
 			port->ops->shutdown(port);
+	}
+out:
 	mutex_unlock(&port->mutex);
 }
 
-- 
1.8.1.1

