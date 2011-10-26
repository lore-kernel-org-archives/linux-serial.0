From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 73/79] tty/serial: atmel_serial: change platform_data variable name
Date: Wed, 26 Oct 2011 14:13:18 +0200
Message-ID: <1319631204-23262-73-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32876 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932929Ab1JZMOD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:03 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Easier to follow if platform_data name is pdata.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/atmel_serial.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c7232a9..a507daa 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1417,13 +1417,13 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 				      struct platform_device *pdev)
 {
 	struct uart_port *port = &atmel_port->uart;
-	struct atmel_uart_data *data = pdev->dev.platform_data;
+	struct atmel_uart_data *pdata = pdev->dev.platform_data;
 
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF;
 	port->ops		= &atmel_pops;
 	port->fifosize		= 1;
-	port->line		= data->num;
+	port->line		= pdata->num;
 	port->dev		= &pdev->dev;
 	port->mapbase	= pdev->resource[0].start;
 	port->irq	= pdev->resource[1].start;
@@ -1433,9 +1433,9 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
-	if (data->regs)
+	if (pdata->regs)
 		/* Already mapped by setup code */
-		port->membase = data->regs;
+		port->membase = pdata->regs;
 	else {
 		port->flags	|= UPF_IOREMAP;
 		port->membase	= NULL;
@@ -1450,9 +1450,9 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 		/* only enable clock when USART is in use */
 	}
 
-	atmel_port->use_dma_rx = data->use_dma_rx;
-	atmel_port->use_dma_tx = data->use_dma_tx;
-	atmel_port->rs485	= data->rs485;
+	atmel_port->use_dma_rx = pdata->use_dma_rx;
+	atmel_port->use_dma_tx = pdata->use_dma_tx;
+	atmel_port->rs485	= pdata->rs485;
 	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-- 
1.7.7

