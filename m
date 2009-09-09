From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH-RESEND] uartlite: support shared interrupt lines
Date: Wed,  9 Sep 2009 16:54:04 +0200
Message-ID: <1252508044-20355-1-git-send-email-jacmet@sunsite.dk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:59383 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbZIIOyX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Sep 2009 10:54:23 -0400
Received: by ywh5 with SMTP id 5so5942856ywh.4
        for <linux-serial@vger.kernel.org>; Wed, 09 Sep 2009 07:54:26 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk, gregkh@suse.de, linux-serial@vger.kernel.org
Cc: Peter Korsgaard <jacmet@sunsite.dk>

Adapt isr to work with shared interrupt lines.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/serial/uartlite.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 3317148..beb6632 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -154,17 +154,22 @@ static int ulite_transmit(struct uart_port *port, int stat)
 static irqreturn_t ulite_isr(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	int busy;
+	int busy, n = 0;
 
 	do {
 		int stat = readb(port->membase + ULITE_STATUS);
 		busy  = ulite_receive(port, stat);
 		busy |= ulite_transmit(port, stat);
+		n++;
 	} while (busy);
 
-	tty_flip_buffer_push(port->info->port.tty);
-
-	return IRQ_HANDLED;
+	/* work done? */
+	if (n > 1) {
+		tty_flip_buffer_push(port->info->port.tty);
+		return IRQ_HANDLED;
+	} else {
+		return IRQ_NONE;
+	}
 }
 
 static unsigned int ulite_tx_empty(struct uart_port *port)
@@ -221,7 +226,7 @@ static int ulite_startup(struct uart_port *port)
 	int ret;
 
 	ret = request_irq(port->irq, ulite_isr,
-			  IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "uartlite", port);
+			  IRQF_SHARED | IRQF_SAMPLE_RANDOM, "uartlite", port);
 	if (ret)
 		return ret;
 
-- 
1.6.3.3

