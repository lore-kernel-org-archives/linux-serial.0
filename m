From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] serial: mpc52xx: make printout for type more generic
Date: Fri, 12 Nov 2010 19:47:47 +0100
Message-ID: <1289587667-7341-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51144 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab0KLSr4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Nov 2010 13:47:56 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>

The printout for the type should be just "5xxx", so 512x users won't
wonder why they have a mpc52xx-type UART.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---

At least I got confused and thought the wrong type was detected.

 drivers/serial/mpc52xx_uart.c |    6 +++++-
 include/linux/serial_core.h   |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index c4399e2..126ec7f 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -838,7 +838,11 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 static const char *
 mpc52xx_uart_type(struct uart_port *port)
 {
-	return port->type == PORT_MPC52xx ? "MPC52xx PSC" : NULL;
+	/*
+	 * We keep using PORT_MPC52xx for historic reasons although it applies
+	 * for MPC512x, too, but print "MPC5xxx" to not irritate users
+	 */
+	return port->type == PORT_MPC52xx ? "MPC5xxx PSC" : NULL;
 }
 
 static void
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 212eb4c..3b354bf 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -95,7 +95,7 @@
 /* PPC CPM type number */
 #define PORT_CPM        58
 
-/* MPC52xx type numbers */
+/* MPC52xx (and MPC512x) type numbers */
 #define PORT_MPC52xx	59
 
 /* IBM icom */
-- 
1.7.2.3

