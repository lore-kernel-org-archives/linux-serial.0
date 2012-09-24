From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/3] serial: sccnxp: Report actual baudrate back to core
Date: Mon, 24 Sep 2012 21:12:00 +0400
Message-ID: <1348506722-17457-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp24.mail.ru ([94.100.176.177]:35586 "EHLO smtp24.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757231Ab2IXRIR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Sep 2012 13:08:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 29dda9b..478630b 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -213,7 +213,7 @@ const struct baud_table baud_std[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static void sccnxp_set_baud(struct uart_port *port, int baud)
+static int sccnxp_set_baud(struct uart_port *port, int baud)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
 	int div_std, tmp_baud, bestbaud = baud, besterr = -1;
@@ -244,8 +244,11 @@ static void sccnxp_set_baud(struct uart_port *port, int baud)
 	sccnxp_port_write(port, SCCNXP_ACR_REG, acr | ACR_TIMER_MODE);
 	sccnxp_port_write(port, SCCNXP_CSR_REG, (csr << 4) | csr);
 
-	dev_dbg(port->dev, "Baudrate desired: %i, calculated: %i\n",
-		baud, bestbaud);
+	if (baud != bestbaud)
+		dev_dbg(port->dev, "Baudrate desired: %i, calculated: %i\n",
+			baud, bestbaud);
+
+	return bestbaud;
 }
 
 static void sccnxp_enable_irq(struct uart_port *port, int mask)
@@ -587,11 +590,14 @@ static void sccnxp_set_termios(struct uart_port *port,
 	baud = uart_get_baud_rate(port, termios, old, 50,
 				  (s->flags & SCCNXP_HAVE_MR0) ?
 				  230400 : 38400);
-	sccnxp_set_baud(port, baud);
+	baud = sccnxp_set_baud(port, baud);
 
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	if (tty_termios_baud_rate(termios))
+		tty_termios_encode_baud_rate(termios, baud, baud);
+
 	/* Enable RX & TX */
 	sccnxp_port_write(port, SCCNXP_CR_REG, CR_RX_ENABLE | CR_TX_ENABLE);
 
-- 
1.7.8.6

