From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 25/79] atmel_serial: RS485: receiving enabled when sending data
Date: Wed, 26 Oct 2011 14:12:30 +0200
Message-ID: <1319631204-23262-25-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60975 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932872Ab1JZMNi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:38 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Bernhard Roth <br@pwrnet.de>, Claudio Scordino <claudio@evidence.eu.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Bernhard Roth <br@pwrnet.de>

By default the atmel_serial driver in RS485 mode disables receiving data until
all data in the send buffer has been sent. This flag allows to receive data
even whilst sending data.

Signed-off-by: Bernhard Roth <br@pwrnet.de>
Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/serial/serial-rs485.txt |    3 +++
 drivers/tty/serial/atmel_serial.c     |    9 ++++++---
 include/linux/serial.h                |    1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
index a493238..c8878f8 100644
--- a/Documentation/serial/serial-rs485.txt
+++ b/Documentation/serial/serial-rs485.txt
@@ -104,6 +104,9 @@
 	rs485conf.flags |= SER_RS485_RTS_AFTER_SEND;
 	rs485conf.delay_rts_after_send = ...;
 
+	/* Set this flag if you want to receive data even whilst sending data */
+	rs485conf.flags |= SER_RS485_RX_DURING_TX;
+
 	if (ioctl (fd, TIOCSRS485, &rs485conf) < 0) {
 		/* Error handling. See errno. */
 	}
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index af9b781..c7232a9 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -339,7 +339,8 @@ static void atmel_stop_tx(struct uart_port *port)
 	/* Disable interrupts */
 	UART_PUT_IDR(port, atmel_port->tx_done_mask);
 
-	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
+	if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
 		atmel_start_rx(port);
 }
 
@@ -356,7 +357,8 @@ static void atmel_start_tx(struct uart_port *port)
 			   really need this.*/
 			return;
 
-		if (atmel_port->rs485.flags & SER_RS485_ENABLED)
+		if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
+		    !(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
 			atmel_stop_rx(port);
 
 		/* re-enable PDC transmit */
@@ -680,7 +682,8 @@ static void atmel_tx_dma(struct uart_port *port)
 		/* Enable interrupts */
 		UART_PUT_IER(port, atmel_port->tx_done_mask);
 	} else {
-		if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
+		if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
+		    !(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX)) {
 			/* DMA done, stop TX, start RX for RS485 */
 			atmel_start_rx(port);
 		}
diff --git a/include/linux/serial.h b/include/linux/serial.h
index ef91406..97ff8e2 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -211,6 +211,7 @@ struct serial_rs485 {
 #define SER_RS485_RTS_ON_SEND		(1 << 1)
 #define SER_RS485_RTS_AFTER_SEND	(1 << 2)
 #define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
+#define SER_RS485_RX_DURING_TX		(1 << 4)
 	__u32	delay_rts_before_send;	/* Milliseconds */
 	__u32	delay_rts_after_send;	/* Milliseconds */
 	__u32	padding[5];		/* Memory is cheap, new structs
-- 
1.7.7

