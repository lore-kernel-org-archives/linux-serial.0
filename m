From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] uartlite: support shared interrupt lines
Date: Tue, 26 May 2009 14:09:10 +0200
Message-ID: <1243339750-29757-1-git-send-email-jacmet@sunsite.dk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:52535 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbZEZMJR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 May 2009 08:09:17 -0400
Received: by bwz22 with SMTP id 22so3740413bwz.37
        for <linux-serial@vger.kernel.org>; Tue, 26 May 2009 05:09:17 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk
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
1.6.2

