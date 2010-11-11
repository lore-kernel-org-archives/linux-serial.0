From: Baurzhan Ismagulov <ibr@radix50.net>
Subject: [PATCH] reducing CPM serial latency
Date: Thu, 11 Nov 2010 10:53:03 +0100
Message-ID: <20101111095303.GA4948@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:18105 "EHLO david.siemens.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab0KKMD3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Nov 2010 07:03:29 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, michael@gandalf.sssup.it, bruno@evidence.eu.com

Hello,

Setting Rx FIFO size to 1 reduces reader process wakeup latency up to
20x for baud rates <= 9600. This patch sets the Rx FIFO size to 1 for
baud rates <= 9600 or if low latency has been requested for the tty.

Signed-off-by: Michael Trimarchi <michael@gandalf.sssup.it>
Signed-off-by: Bruno Morelli <bruno@evidence.eu.com>
Signed-off-by: Baurzhan Ismagulov <ibr@radix50.net>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index ff44c65..fcca358 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -72,6 +72,8 @@ static void cpm_uart_initbd(struct uart_cpm_port *pinfo);
 
 /**************************************************************/
 
+#define HW_BUF_SPD_THRESHOLD    9600
+
 /*
  * Check, if transmit buffers are processed
 */
@@ -517,6 +519,11 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	pr_debug("CPM uart[%d]:set_termios\n", port->line);
 
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
+	if (baud <= HW_BUF_SPD_THRESHOLD ||
+	    (pinfo->port.state && pinfo->port.state->port.tty->low_latency))
+		pinfo->rx_fifosize = 1;
+	else
+		pinfo->rx_fifosize = RX_BUF_SIZE;
 
 	/* Character length programmed into the mode register is the
 	 * sum of: 1 start bit, number of data bits, 0 or 1 parity bit,
@@ -608,6 +615,17 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	 */
 	bits++;
 	if (IS_SMC(pinfo)) {
+		/*
+		 * MRBLR can be changed while an SMC/SCC is operating only
+		 * if it is done in a single bus cycle with one 16-bit move
+		 * (not two 8-bit bus cycles back-to-back). This occurs when
+		 * the cp shifts control to the next RxBD, so the change does
+		 * not take effect immediately. To guarantee the exact RxBD
+		 * on which the change occurs, change MRBLR only while the
+		 * SMC/SCC receiver is disabled.
+		 */
+		out_be16(&pinfo->smcup->smc_mrblr, pinfo->rx_fifosize);
+
 		/* Set the mode register.  We want to keep a copy of the
 		 * enables, because we want to put them back if they were
 		 * present.
@@ -618,6 +636,7 @@ static void cpm_uart_set_termios(struct uart_port *port,
 		out_be16(&smcp->smc_smcmr, smcr_mk_clen(bits) | cval |
 		    SMCMR_SM_UART | prev_mode);
 	} else {
+		out_be16(&pinfo->sccup->scc_genscc.scc_mrblr, pinfo->rx_fifosize);
 		out_be16(&sccp->scc_psmr, (sbits << 12) | scval);
 	}
 
-- 
1.7.1
