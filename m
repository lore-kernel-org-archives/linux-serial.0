From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5] serial: omap: delete .set_wake callback
Date: Tue, 15 Oct 2013 09:20:08 +0200
Message-ID: <1381821608-19397-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:38578 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab3JOHUX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 03:20:23 -0400
Received: by mail-we0-f182.google.com with SMTP id t61so7967603wes.41
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 00:20:22 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

This callback is unused by the serial core since pre-git days
and is not coming back. Delete it. Enabling wakeup on the
OMAP serial driver is done through other runpaths these days.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/omap-serial.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 816d1a2..86830db 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1060,15 +1060,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->port.line);
 }
 
-static int serial_omap_set_wake(struct uart_port *port, unsigned int state)
-{
-	struct uart_omap_port *up = to_uart_omap_port(port);
-
-	serial_omap_enable_wakeup(up, state);
-
-	return 0;
-}
-
 static void
 serial_omap_pm(struct uart_port *port, unsigned int state,
 	       unsigned int oldstate)
@@ -1401,7 +1392,6 @@ static struct uart_ops serial_omap_pops = {
 	.shutdown	= serial_omap_shutdown,
 	.set_termios	= serial_omap_set_termios,
 	.pm		= serial_omap_pm,
-	.set_wake	= serial_omap_set_wake,
 	.type		= serial_omap_type,
 	.release_port	= serial_omap_release_port,
 	.request_port	= serial_omap_request_port,
-- 
1.8.3.1

