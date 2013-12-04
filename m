From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] tty: serial: pch: don't crash if DMA enabled but not loaded
Date: Wed,  4 Dec 2013 20:52:49 +0100
Message-ID: <1386186769-12708-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38785 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933211Ab3LDTwz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Dec 2013 14:52:55 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

if the DMA driver isn't loaded "on time" then we crash in the irq handler:
| pch_uart 0000:02:0a.4: pch_request_dma:dma_request_channel FAILS(Tx)
| BUG: unable to handle kernel NULL pointer dereference at   (null)
| IP: [<c0676ed9>] pch_uart_interrupt+0x739/0x940

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/pch_uart.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 20e4c94..9b7cd40 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1492,10 +1492,14 @@ static int pch_uart_verify_port(struct uart_port *port,
 			__func__);
 		return -EOPNOTSUPP;
 #endif
-		dev_info(priv->port.dev, "PCH UART : Use DMA Mode\n");
-		if (!priv->use_dma)
+		if (!priv->use_dma) {
 			pch_request_dma(port);
-		priv->use_dma = 1;
+			if (priv->chan_rx)
+				priv->use_dma = 1;
+		}
+		dev_info(priv->port.dev, "PCH UART: %s\n",
+				priv->use_dma ?
+				"Use DMA Mode" : "No DMA");
 	}
 
 	return 0;
-- 
1.8.4.4

