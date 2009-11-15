From: Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] bcm63xx_uart: Fix serial driver compile breakage.
Date: Sun, 15 Nov 2009 05:42:18 +0100
Message-ID: <1258260138.2422.3.camel@kero>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:55686 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbZKOEmW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Nov 2009 23:42:22 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-serial@vger.kernel.org


Hi Greg,

The recently merged bcm63xx uart driver does not compile on current
linus' tree, could you please apply the attached patch and send it to
linus ? Thanks !



The driver missed a small API change while sitting in Ralf's tree, this
patch makes it compile again.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/serial/bcm63xx_uart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
index beddaa6..37ad0c4 100644
--- a/drivers/serial/bcm63xx_uart.c
+++ b/drivers/serial/bcm63xx_uart.c
@@ -242,7 +242,7 @@ static void bcm_uart_do_rx(struct uart_port *port)
 	 * higher than fifo size anyway since we're much faster than
 	 * serial port */
 	max_count = 32;
-	tty = port->info->port.tty;
+	tty = port->state->port.tty;
 	do {
 		unsigned int iestat, c, cstat;
 		char flag;
@@ -318,7 +318,7 @@ static void bcm_uart_do_tx(struct uart_port *port)
 		return;
 	}
 
-	xmit = &port->info->xmit;
+	xmit = &port->state->xmit;
 	if (uart_circ_empty(xmit))
 		goto txq_empty;
 
-- 
1.6.3.3




-- 
Maxime






