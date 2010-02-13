From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 08/12] Serial: sc26xx - avoid endless loop with IRQs masked.
Date: Sat, 13 Feb 2010 17:10:21 +0100
Message-ID: <20100213161021.22311.49059.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:50855 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700Ab0BMQKY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:10:24 -0500
Received: by ey-out-2122.google.com with SMTP id d26so857312eyd.19
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:10:23 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de

If hardware is in wierd state it is possible to lock the
system while waiting for the TX flush to complete.

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index 69b7ae7..bc466ac 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -72,6 +72,7 @@ struct uart_sc26xx_port {
 #define SR_FRAME    (1 << 6)
 #define SR_PARITY   (1 << 5)
 #define SR_OVERRUN  (1 << 4)
+#define SR_TXEMT    (1 << 3)
 #define SR_TXRDY    (1 << 2)
 #define SR_RXRDY    (1 << 0)
 
@@ -396,6 +397,22 @@ static void sc26xx_shutdown(struct uart_port *port)
 	WRITE_SC_PORT(port, CR, CR_DIS_TX | CR_DIS_RX);
 }
 
+static int wait_tx_empty(struct uart_port *port)
+{
+	int i;
+	u8 sr;
+	u8 bits = SR_TXEMT | SR_TXRDY;
+
+	for (i = 0; i < 10000; i++) {
+		sr = READ_SC_PORT(port, SR);
+		if  ((sr & bits) == bits)
+			return 0;
+		udelay(2);
+	}
+	dev_warn(port->dev, "Timed out waiting for TX Empty sr=%02X\n", sr);
+	return -1;
+}
+
 /* port->lock is not held.  */
 static void sc26xx_set_termios(struct uart_port *port, struct ktermios *termios,
 			      struct ktermios *old)
@@ -407,8 +424,8 @@ static void sc26xx_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	while ((READ_SC_PORT(port, SR) & ((1 << 3) | (1 << 2))) != 0xc)
-		udelay(2);
+	if (wait_tx_empty(port))
+		goto out;
 
 	WRITE_SC_PORT(port, CR, CR_DIS_TX | CR_DIS_RX);
 
@@ -501,11 +518,11 @@ static void sc26xx_set_termios(struct uart_port *port, struct ktermios *termios,
 	write_cmd_port(port, CR_RES_TX);
 
 	WRITE_SC_PORT(port, CR, CR_ENA_TX | CR_ENA_RX);
-	while ((READ_SC_PORT(port, SR) & ((1 << 3) | (1 << 2))) != 0xc)
-		udelay(2);
+	if (wait_tx_empty(port))
+		goto out;
 
 	uart_update_timeout(port, cflag, baud);
-
+out:
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 

