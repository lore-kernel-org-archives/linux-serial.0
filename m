From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/13] serial,mfd: Fix CMSPAR setup
Date: Mon, 21 Nov 2011 17:11:37 -0800
Message-ID: <1321924303-26475-7-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
 <1321924303-26475-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42095 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513Ab1KVBNN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:13:13 -0500
In-Reply-To: <1321924303-26475-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alan Cox <alan@linux.intel.com>

This is referenced the wrong way. Mika Westerberg added some checks to the
tty to support multiple console, but the real problem is simply referencing the
termios object via the wrong path.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/mfd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 286c386..e272d39 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -884,7 +884,6 @@ serial_hsu_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct uart_hsu_port *up =
 			container_of(port, struct uart_hsu_port, port);
-	struct tty_struct *tty = port->state->port.tty;
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
 	unsigned int baud, quot;
@@ -907,8 +906,7 @@ serial_hsu_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* CMSPAR isn't supported by this driver */
-	if (tty)
-		tty->termios->c_cflag &= ~CMSPAR;
+	termios->c_cflag &= ~CMSPAR;
 
 	if (termios->c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-- 
1.7.7.3

