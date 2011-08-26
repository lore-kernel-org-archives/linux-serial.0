From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/12] omap-serial: Allow IXON and IXOFF to be disabled.
Date: Fri, 26 Aug 2011 13:58:21 -0700
Message-ID: <1314392301-25140-12-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37763 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab1HZU6h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:58:37 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Nick Pelly <npelly@google.com>

Fixes logic bug that software flow control cannot be disabled, because
serial_omap_configure_xonxoff() is not called if both IXON and IXOFF bits
are cleared.

Signed-off-by: Nick Pelly <npelly@google.com>
Acked-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/omap-serial.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c37df8d..5e713d3 100644
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
1.7.6.1

