From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 3/3] serial: samsung: Remove useless spinlock
Date: Mon, 03 Apr 2017 08:21:01 +0200
Message-ID: <1491200468-28463-3-git-send-email-m.szyprowski@samsung.com>
References: <1491200468-28463-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170403062120eucas1p1369bcd47ca09d99c955baa551cdb1e06@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1491200468-28463-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-serial@vger.kernel.org

Spinlock taken only for dma_map_single() for TX buffer is completely
useless and doesn't protect anything, so remove it to simplify the code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ca0bcd7fd61f..8aca18c4cdea 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -906,13 +906,9 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 		goto err_free_rx;
 	}
 
-	spin_lock_irqsave(&p->port.lock, flags);
-
 	/* TX buffer */
 	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
-
-	spin_unlock_irqrestore(&p->port.lock, flags);
 	if (dma_mapping_error(p->port.dev, dma->tx_addr)) {
 		ret = -EIO;
 		goto err_unmap_rx;
-- 
1.9.1
