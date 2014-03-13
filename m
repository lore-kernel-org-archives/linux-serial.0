From: Dimitris Lampridis <dlampridis@logikonlabs.com>
Subject: [PATCH 2/2] tty/serial: omap: empty the RX FIFO at the end of half-duplex TX
Date: Thu, 13 Mar 2014 15:11:47 +0200
Message-ID: <1394716307-11248-3-git-send-email-dlampridis@logikonlabs.com>
References: <1394716307-11248-1-git-send-email-dlampridis@logikonlabs.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from promitheas2.multiserver.gr ([144.76.157.92]:55131 "EHLO
	promitheas2.multiserver.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154AbaCMNfr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Mar 2014 09:35:47 -0400
In-Reply-To: <1394716307-11248-1-git-send-email-dlampridis@logikonlabs.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Dimitris Lampridis <dlampridis@logikonlabs.com>

Provided that the SER_RS485_RX_DURING_TX flag is not set, empty the
RX FIFO to prevent reading back the transmitted data.

Signed-off-by: Dimitris Lampridis <dlampridis@logikonlabs.com>
---
 drivers/tty/serial/omap-serial.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 65abea2..dd8b1a5 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -342,6 +342,12 @@ static void serial_omap_stop_tx(struct uart_port *port)
 
 	if ((up->rs485.flags & SER_RS485_ENABLED) &&
 	    !(up->rs485.flags & SER_RS485_RX_DURING_TX)) {
+		/*
+		 * Empty the RX FIFO, we are not interested in anything
+		 * received during the half-duplex transmission.
+		 */
+		serial_out(up, UART_FCR, up->fcr | UART_FCR_CLEAR_RCVR);
+		/* Re-enable RX interrupts */
 		up->ier |= UART_IER_RLSI | UART_IER_RDI;
 		up->port.read_status_mask |= UART_LSR_DR;
 		serial_out(up, UART_IER, up->ier);
-- 
1.7.10.4

