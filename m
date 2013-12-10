From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2] serial: pl011: fix fall back from DMA to interrupt mode
Date: Tue, 10 Dec 2013 14:54:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1312101451390.30411@axis700.grange>
References: <Pine.LNX.4.64.1312101449501.30411@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57031 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab3LJNyx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Dec 2013 08:54:53 -0500
In-Reply-To: <Pine.LNX.4.64.1312101449501.30411@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>

When falling back from DMA to interrupt mode the receive interrupt has to
be re-enabled to catch new incoming data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/amba-pl011.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0efa9d5..3d16973 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -966,6 +966,8 @@ static void pl011_dma_rx_poll(unsigned long args)
 
 		spin_lock_irqsave(&uap->port.lock, flags);
 		pl011_dma_rx_stop(uap);
+		uap->im |= UART011_RXIM;
+		writew(uap->im, uap->port.membase + UART011_IMSC);
 		spin_unlock_irqrestore(&uap->port.lock, flags);
 
 		uap->dmarx.running = false;
-- 
1.7.2.5

