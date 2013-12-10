From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] serial: pl011: (cosmetic) remove superfluous register
 write
Date: Tue, 10 Dec 2013 14:54:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1312101449501.30411@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60917 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab3LJNyw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Dec 2013 08:54:52 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>

In pl011_rx_chars() if pl011_dma_rx_trigger_dma() succeeds it will disable
the receive interrupt, no need to do this again.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/amba-pl011.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index baecdfa..0efa9d5 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1213,8 +1213,8 @@ __acquires(&uap->port.lock)
 			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
 				"fall back to interrupt mode again\n");
 			uap->im |= UART011_RXIM;
+			writew(uap->im, uap->port.membase + UART011_IMSC);
 		} else {
-			uap->im &= ~UART011_RXIM;
 #ifdef CONFIG_DMA_ENGINE
 			/* Start Rx DMA poll */
 			if (uap->dmarx.poll_rate) {
@@ -1226,8 +1226,6 @@ __acquires(&uap->port.lock)
 			}
 #endif
 		}
-
-		writew(uap->im, uap->port.membase + UART011_IMSC);
 	}
 	spin_lock(&uap->port.lock);
 }
-- 
1.7.2.5

