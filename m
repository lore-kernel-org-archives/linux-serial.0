From: Wills Wang <wills.wang@live.com>
Subject: [PATCH] sc16is7xx: don't need "uart_handle_cts_change"
Date: Tue, 22 Dec 2015 17:19:56 +0800
Message-ID: <BLU436-SMTP55A9A43327DDAAAAA42012FFE50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jringle@gridpoint.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Wills Wang <wills.wang@live.com>
List-Id: linux-serial@vger.kernel.org

SC16is7xx has feature for auto hardware flow control using RTS/CTS,
so we don't need "uart_handle_cts_change" to invoke "start_tx/stop_tx"
for flow control.

In addition, for software CTS, interrupt "SC16IS7XX_IIR_CTSRTS_SRC"
just report the nCTS change of state from active(low) to inactive(high),
driver don't know when the state of nCTS change from incactive to active,
so can't resume the transmission when a peer device is again ready and
re-assert nRTS signal.
---
 drivers/tty/serial/sc16is7xx.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 9d18c24..d19a7ba 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -653,7 +653,7 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 	struct uart_port *port = &s->p[portno].port;
 
 	do {
-		unsigned int iir, msr, rxlen;
+		unsigned int iir, rxlen;
 
 		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
 		if (iir & SC16IS7XX_IIR_NO_INT_BIT)
@@ -670,12 +670,6 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 			if (rxlen)
 				sc16is7xx_handle_rx(port, rxlen, iir);
 			break;
-
-		case SC16IS7XX_IIR_CTSRTS_SRC:
-			msr = sc16is7xx_port_read(port, SC16IS7XX_MSR_REG);
-			uart_handle_cts_change(port,
-					       !!(msr & SC16IS7XX_MSR_DCTS_BIT));
-			break;
 		case SC16IS7XX_IIR_THRI_SRC:
 			sc16is7xx_handle_tx(port);
 			break;
@@ -993,9 +987,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			      SC16IS7XX_EFCR_TXDISABLE_BIT,
 			      0);
 
-	/* Enable RX, TX, CTS change interrupts */
-	val = SC16IS7XX_IER_RDI_BIT | SC16IS7XX_IER_THRI_BIT |
-	      SC16IS7XX_IER_CTSI_BIT;
+	/* Enable RX, TX interrupts */
+	val = SC16IS7XX_IER_RDI_BIT | SC16IS7XX_IER_THRI_BIT;
 	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, val);
 
 	return 0;
-- 
1.9.1
