From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH] serial: lpc32xx: Fix fallout from tty_port conversion
Date: Fri, 18 Jan 2013 08:25:51 +0100
Message-ID: <1358493951-5349-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58605 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab3ARHZz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2013 02:25:55 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

A duplicate definition of the port variable was introduced in the
interrupt handler, which causes the build to break. The fix is to
rename the variable to tport, which is already properly used in
subsequent code.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/tty/serial/lpc32xx_hs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index c01b58f..dffea6b 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -322,7 +322,7 @@ exit_tx:
 static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	struct tty_port *port = &port->state->port;
+	struct tty_port *tport = &port->state->port;
 	u32 status;
 
 	spin_lock(&port->lock);
-- 
1.8.1.1

