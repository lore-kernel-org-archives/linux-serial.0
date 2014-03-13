From: Dimitris Lampridis <dlampridis@logikonlabs.com>
Subject: [PATCH 1/2] tty/serial: omap: fix RX interrupt enable/disable in half-duplex TX
Date: Thu, 13 Mar 2014 15:11:46 +0200
Message-ID: <1394716307-11248-2-git-send-email-dlampridis@logikonlabs.com>
References: <1394716307-11248-1-git-send-email-dlampridis@logikonlabs.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from promitheas2.multiserver.gr ([144.76.157.92]:55133 "EHLO
	promitheas2.multiserver.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154AbaCMNfs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Mar 2014 09:35:48 -0400
In-Reply-To: <1394716307-11248-1-git-send-email-dlampridis@logikonlabs.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Dimitris Lampridis <dlampridis@logikonlabs.com>

Make sure that serial_omap_stop_rx() also disables RDI (Receiver Data Interrupt),
otherwise the interrupt handler will call serial_omap_rdi() to read the new data,
resulting in the transmission being echoed back.

When the half-duplex transmission is complete, in order to reverse the effects of
serial_omap_stop_rx(), we should re-enable:

  * the RX interrupts _without_ overwriting up->ier

  * the UART_LSR_DR bit of the up->port.read_status_mask

Signed-off-by: Dimitris Lampridis <dlampridis@logikonlabs.com>
---
 drivers/tty/serial/omap-serial.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 77f0351..65abea2 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -342,7 +342,8 @@ static void serial_omap_stop_tx(struct uart_port *port)
 
 	if ((up->rs485.flags & SER_RS485_ENABLED) &&
 	    !(up->rs485.flags & SER_RS485_RX_DURING_TX)) {
-		up->ier = UART_IER_RLSI | UART_IER_RDI;
+		up->ier |= UART_IER_RLSI | UART_IER_RDI;
+		up->port.read_status_mask |= UART_LSR_DR;
 		serial_out(up, UART_IER, up->ier);
 	}
 
@@ -355,7 +356,7 @@ static void serial_omap_stop_rx(struct uart_port *port)
 	struct uart_omap_port *up = to_uart_omap_port(port);
 
 	pm_runtime_get_sync(up->dev);
-	up->ier &= ~UART_IER_RLSI;
+	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	up->port.read_status_mask &= ~UART_LSR_DR;
 	serial_out(up, UART_IER, up->ier);
 	pm_runtime_mark_last_busy(up->dev);
-- 
1.7.10.4

