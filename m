From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 04/12] Serial: sc26xx - add accessor function for driver data.
Date: Sat, 13 Feb 2010 17:10:04 +0100
Message-ID: <20100213161004.22311.41112.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0BMQKH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:10:07 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:10:06 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de

Extract container_of and port -= line to a helper function
to avoid slightly opaque modification of port pointer.

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index ca74bf6..dc47d4f 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -95,6 +95,12 @@ struct uart_sc26xx_port {
 #define IMR_RXRDY   (1 << 1)
 #define IMR_TXRDY   (1 << 0)
 
+static struct uart_sc26xx_port *driver_info(struct uart_port *port)
+{
+	port -= port->line;
+	return container_of(port, struct uart_sc26xx_port, port[0]);
+}
+
 /* access port register */
 static inline u8 read_sc_port(struct uart_port *p, u8 reg)
 {
@@ -111,25 +117,17 @@ static inline void write_sc_port(struct uart_port *p, u8 reg, u8 val)
 
 static void sc26xx_enable_irq(struct uart_port *port, int mask)
 {
-	struct uart_sc26xx_port *up;
-	int line = port->line;
-
-	port -= line;
-	up = container_of(port, struct uart_sc26xx_port, port[0]);
+	struct uart_sc26xx_port *up = driver_info(port);
 
-	up->imr |= mask << (line * 4);
+	up->imr |= mask << (port->line * 4);
 	WRITE_SC(port, IMR, up->imr);
 }
 
 static void sc26xx_disable_irq(struct uart_port *port, int mask)
 {
-	struct uart_sc26xx_port *up;
-	int line = port->line;
-
-	port -= line;
-	up = container_of(port, struct uart_sc26xx_port, port[0]);
+	struct uart_sc26xx_port *up = driver_info(port);
 
-	up->imr &= ~(mask << (line * 4));
+	up->imr &= ~(mask << (port->line * 4));
 	WRITE_SC(port, IMR, up->imr);
 }
 
@@ -257,12 +255,9 @@ static unsigned int sc26xx_tx_empty(struct uart_port *port)
 /* port->lock held by caller.  */
 static void sc26xx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct uart_sc26xx_port *up;
+	struct uart_sc26xx_port *up = driver_info(port);
 	int line = port->line;
 
-	port -= line;
-	up = container_of(port, struct uart_sc26xx_port, port[0]);
-
 	if (up->dtr_mask[line]) {
 		if (mctrl & TIOCM_DTR)
 			WRITE_SC(port, OPR_SET, up->dtr_mask[line]);
@@ -280,13 +275,11 @@ static void sc26xx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 /* port->lock is held by caller and interrupts are disabled.  */
 static unsigned int sc26xx_get_mctrl(struct uart_port *port)
 {
-	struct uart_sc26xx_port *up;
+	struct uart_sc26xx_port *up = driver_info(port);
 	int line = port->line;
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
 	u8 ipr;
 
-	port -= line;
-	up = container_of(port, struct uart_sc26xx_port, port[0]);
 	ipr = READ_SC(port, IPR) ^ 0xff;
 
 	if (up->dsr_mask[line]) {

