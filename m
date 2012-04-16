From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 5/7] UART: OMAP: Prevent cutting of clocks if put_sync immediately follows
Date: Mon, 16 Apr 2012 20:36:59 +0530
Message-ID: <1334588821-5224-6-git-send-email-shubhrajyoti@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48409 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab2DPPHM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Apr 2012 11:07:12 -0400
In-Reply-To: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

In serial_omap_stop_tx in the dma case. We do a autosuspend and
immediately a put_sync. Prevent the call of auto suspend. The else
case is left as is.

Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7c69b21..1593986 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -149,11 +149,10 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		omap_stop_dma(up->uart_dma.tx_dma_channel);
 		omap_free_dma(up->uart_dma.tx_dma_channel);
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
-		pm_runtime_mark_last_busy(&up->pdev->dev);
-		pm_runtime_put_autosuspend(&up->pdev->dev);
+	} else {
+		pm_runtime_get_sync(&up->pdev->dev);
 	}
 
-	pm_runtime_get_sync(&up->pdev->dev);
 	if (up->ier & UART_IER_THRI) {
 		up->ier &= ~UART_IER_THRI;
 		serial_out(up, UART_IER, up->ier);
-- 
1.7.4.1

