From: Nick Pelly <npelly@google.com>
Subject: [PATCH] omap-serial: Allow IXON and IXOFF to be disabled.
Date: Fri, 15 Jul 2011 13:53:08 -0700
Message-ID: <1310763188-21248-1-git-send-email-npelly@google.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:15327 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1GOUxW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jul 2011 16:53:22 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Nick Pelly <npelly@google.com>

Fixes logic bug that software flow control cannot be disabled, because
serial_omap_configure_xonxoff() is not called if both IXON and IXOFF bits
are cleared.

Signed-off-by: Nick Pelly <npelly@google.com>
Acked-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/omap-serial.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0275c28..4ca2c5f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -806,8 +806,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial_omap_set_mctrl(&up->port, up->port.mctrl);
 	/* Software Flow Control Configuration */
-	if (termios->c_iflag & (IXON | IXOFF))
-		serial_omap_configure_xonxoff(up, termios);
+	serial_omap_configure_xonxoff(up, termios);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
-- 
1.7.5.2

