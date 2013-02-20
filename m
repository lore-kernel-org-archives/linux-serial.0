From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 1/4] TTY: clean up port shutdown
Date: Wed, 20 Feb 2013 17:02:49 +0100
Message-ID: <1361376172-31860-2-git-send-email-jhovold@gmail.com>
References: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
 <1361376172-31860-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:44925 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935719Ab3BTQDs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Feb 2013 11:03:48 -0500
In-Reply-To: <1361376172-31860-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Johan Hovold <jhovold@gmail.com>

Untangle port-shutdown logic and make sure the initialised flag is
always cleared for non-console ports.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
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

