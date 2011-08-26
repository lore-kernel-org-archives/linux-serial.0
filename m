From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/12] pch_uart: Set PCIe bus number using probe parameter
Date: Fri, 26 Aug 2011 13:58:11 -0700
Message-ID: <1314392301-25140-2-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37767 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab1HZU6l (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:58:41 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Currently, PCIe bus number is set as fixed value "2".
However, PCIe bus number is not always "2".
This patch sets bus number using probe() parameter.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pch_uart.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 846dfcd..b46218d 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -598,7 +598,8 @@ static void pch_request_dma(struct uart_port *port)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	dma_dev = pci_get_bus_and_slot(2, PCI_DEVFN(0xa, 0)); /* Get DMA's dev
+	dma_dev = pci_get_bus_and_slot(priv->pdev->bus->number,
+				       PCI_DEVFN(0xa, 0)); /* Get DMA's dev
 								information */
 	/* Set Tx DMA */
 	param = &priv->param_tx;
-- 
1.7.6.1

