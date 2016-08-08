From: dirk.eibach@gdsys.cc
Subject: [PATCH 1/2] sc16is7xx: Do not handle irqs in endless loop
Date: Mon,  8 Aug 2016 15:32:15 +0200
Message-ID: <1470663136-26269-1-git-send-email-dirk.eibach@gdsys.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, gregkh@linuxfoundation.org, jringle@gridpoint.com
Cc: Dirk Eibach <dirk.eibach@gdsys.cc>
List-Id: linux-serial@vger.kernel.org

From: Dirk Eibach <dirk.eibach@gdsys.cc>

sc16is7xx_port_irq() is laid out as an endless loop. It will exit only
when there is no more interrupt left to service. This not common
practice.
In our case it lead to some strange hangup situation when there was an
unexpected XOFF-interrupt that could not be handled.
So let's service interrupts only once and report XOFF-interrupts that
should never happen since they are never enabled.

Signed-off-by: Dirk Eibach <dirk.eibach@gdsys.cc>

Conflicts:
	drivers/tty/serial/sc16is7xx.c
---
 drivers/tty/serial/sc16is7xx.c | 48 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index f36e6df..098c6dc 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -664,35 +664,31 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 	struct uart_port *port = &s->p[portno].port;
+	unsigned int iir, ier, msr, rxlen;
 
-	do {
-		unsigned int iir, rxlen;
-
-		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
-		if (iir & SC16IS7XX_IIR_NO_INT_BIT)
-			break;
+	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
+	if (iir & SC16IS7XX_IIR_NO_INT_BIT)
+		return;
 
-		iir &= SC16IS7XX_IIR_ID_MASK;
+	iir &= SC16IS7XX_IIR_ID_MASK;
 
-		switch (iir) {
-		case SC16IS7XX_IIR_RDI_SRC:
-		case SC16IS7XX_IIR_RLSE_SRC:
-		case SC16IS7XX_IIR_RTOI_SRC:
-		case SC16IS7XX_IIR_XOFFI_SRC:
-			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
-			if (rxlen)
-				sc16is7xx_handle_rx(port, rxlen, iir);
-			break;
-		case SC16IS7XX_IIR_THRI_SRC:
-			sc16is7xx_handle_tx(port);
-			break;
-		default:
-			dev_err_ratelimited(port->dev,
-					    "ttySC%i: Unexpected interrupt: %x",
-					    port->line, iir);
-			break;
-		}
-	} while (1);
+	switch (iir) {
+	case SC16IS7XX_IIR_RDI_SRC:
+	case SC16IS7XX_IIR_RLSE_SRC:
+	case SC16IS7XX_IIR_RTOI_SRC:
+		rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+		if (rxlen)
+			sc16is7xx_handle_rx(port, rxlen, iir);
+		break;
+	case SC16IS7XX_IIR_THRI_SRC:
+		sc16is7xx_handle_tx(port);
+		break;
+	default:
+		dev_err_ratelimited(port->dev,
+				    "Port %i: Unexpected interrupt: iir %02x, ier %02x",
+				    port->line, iir, ier);
+		break;
+	}
 }
 
 static void sc16is7xx_ist(struct kthread_work *ws)
-- 
2.1.3
