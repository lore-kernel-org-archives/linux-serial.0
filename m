From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/13] pch_uart: Fix DMA resource leak issue
Date: Mon, 21 Nov 2011 17:11:38 -0800
Message-ID: <1321924303-26475-8-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
 <1321924303-26475-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42117 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757874Ab1KVBNR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:13:17 -0500
In-Reply-To: <1321924303-26475-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya.rohm@gmail.com>

Changing UART mode PIO->DMA->PIO->DMA like below, pch_uart driver can't get
DMA channel resource.

setserial /dev/ttyPCH0 ^low_latency
setserial /dev/ttyPCH0 low_latency

CAUSE:
Changing mode using setserial command, ".startup" function which gets DMA
channel is called before ".verify_port" function which sets
dma-flag(use_dma/use_dma_flag) as 1.

PIO->DMA
  .startup: Since dma-flag is 0, DMA channel is not requested.
  .verify_port: dma-flag is set as 1.
  .shutdown: N/A

DMA->PIO
  .startup: Since dma-flag is 1, DMA channel is requested.
  .verify_port: dma-flag is set as 0.
  .shutdown: Since dma-flag is 0, DMA channel is not released.

This means DMA channel resource leak occurs.
Next time, this driver can't get DMA channel resource forever.

MODIFICATION:
  Currently, when release DMA channel resource, this driver checks dma-flag.
  However, this specification occurs the above issue.
  This driver must check whether dma_request_channel is executed or not.
  The values are saved in private data variable "chan_tx/chan_tx".
  These variables mean if the value is NULL, DMA channel is not requested,
  if not NULL, DMA channel is requested.

This patch fixes the issue.

Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pch_uart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index ac852b5..d6aba8c 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -632,6 +632,7 @@ static void pch_request_dma(struct uart_port *port)
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Rx)\n",
 			__func__);
 		dma_release_channel(priv->chan_tx);
+		priv->chan_tx = NULL;
 		return;
 	}
 
@@ -1219,8 +1220,7 @@ static void pch_uart_shutdown(struct uart_port *port)
 		dev_err(priv->port.dev,
 			"pch_uart_hal_set_fifo Failed(ret=%d)\n", ret);
 
-	if (priv->use_dma_flag)
-		pch_free_dma(port);
+	pch_free_dma(port);
 
 	free_irq(priv->port.irq, priv);
 }
-- 
1.7.7.3

