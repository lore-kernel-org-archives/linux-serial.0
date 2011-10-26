From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 45/79] serial: pxa: work around for errata #20
Date: Wed, 26 Oct 2011 14:12:50 +0200
Message-ID: <1319631204-23262-45-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32793 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932910Ab1JZMNt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:49 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Marcus Folkesson <marcus.folkesson@gmail.com>

Errata E20: UART: Character Timeout interrupt remains set under certain
software conditions.

Implication: The software servicing the UART can be trapped in an infinite loop.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pxa.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 531931c..5c8e3bb 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -100,6 +100,16 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 	int max_count = 256;
 
 	do {
+		/* work around Errata #20 according to
+		 * Intel(R) PXA27x Processor Family
+		 * Specification Update (May 2005)
+		 *
+		 * Step 2
+		 * Disable the Reciever Time Out Interrupt via IER[RTOEI]
+		 */
+		up->ier &= ~UART_IER_RTOIE;
+		serial_out(up, UART_IER, up->ier);
+
 		ch = serial_in(up, UART_RX);
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
@@ -156,6 +166,16 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 		*status = serial_in(up, UART_LSR);
 	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
 	tty_flip_buffer_push(tty);
+
+	/* work around Errata #20 according to
+	 * Intel(R) PXA27x Processor Family
+	 * Specification Update (May 2005)
+	 *
+	 * Step 6:
+	 * No more data in FIFO: Re-enable RTO interrupt via IER[RTOIE]
+	 */
+	up->ier |= UART_IER_RTOIE;
+	serial_out(up, UART_IER, up->ier);
 }
 
 static void transmit_chars(struct uart_pxa_port *up)
-- 
1.7.7

