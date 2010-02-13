From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 06/12] Serial: sc26xx simplify timeout calculation
Date: Sat, 13 Feb 2010 17:10:13 +0100
Message-ID: <20100213161012.22311.18214.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab0BMQKQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:10:16 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:10:15 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de

We already have the baud rate - no need to calculate it again.

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index 1b47443..316d110 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -401,7 +401,6 @@ static void sc26xx_set_termios(struct uart_port *port, struct ktermios *termios,
 			      struct ktermios *old)
 {
 	unsigned int baud = uart_get_baud_rate(port, termios, old, 0, 4000000);
-	unsigned int quot = uart_get_divisor(port, baud);
 	unsigned int iflag, cflag;
 	unsigned long flags;
 	u8 mr1, mr2, csr;
@@ -505,9 +504,7 @@ static void sc26xx_set_termios(struct uart_port *port, struct ktermios *termios,
 	while ((READ_SC_PORT(port, SR) & ((1 << 3) | (1 << 2))) != 0xc)
 		udelay(2);
 
-	/* XXX */
-	uart_update_timeout(port, cflag,
-			    (port->uartclk / (16 * quot)));
+	uart_update_timeout(port, cflag, baud);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }

