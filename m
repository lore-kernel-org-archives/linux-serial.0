From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 74/79] tty/serial: atmel_serial: whitespace and braces modifications
Date: Wed, 26 Oct 2011 14:13:19 +0200
Message-ID: <1319631204-23262-74-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32877 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932967Ab1JZMOE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:04 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/atmel_serial.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a507daa..bb72354 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1433,10 +1433,10 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
-	if (pdata->regs)
+	if (pdata->regs) {
 		/* Already mapped by setup code */
 		port->membase = pdata->regs;
-	else {
+	} else {
 		port->flags	|= UPF_IOREMAP;
 		port->membase	= NULL;
 	}
@@ -1450,9 +1450,10 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 		/* only enable clock when USART is in use */
 	}
 
-	atmel_port->use_dma_rx = pdata->use_dma_rx;
-	atmel_port->use_dma_tx = pdata->use_dma_tx;
+	atmel_port->use_dma_rx	= pdata->use_dma_rx;
+	atmel_port->use_dma_tx	= pdata->use_dma_tx;
 	atmel_port->rs485	= pdata->rs485;
+
 	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-- 
1.7.7

