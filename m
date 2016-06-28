From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v2 8/9] tty: serial: fsl-lpuart: Update suspend/resume for DMA mode
Date: Tue, 28 Jun 2016 11:02:34 +0530
Message-ID: <20160628053235.5114-9-bhuvanchandra.dv@toradex.com>
References: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Sender: linux-clk-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: stefan@agner.ch, shawnguo@kernel.org, kernel@pengutronix.de, mturquette@baylibre.com, sboyd@codeaurora.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

When DMA mode is enabled one need to make sure the DMA channels are idle before
entering suspend mode especially when UART ports which are set as wakeup source
and console port with no_console_suspend is set. This patch takes care of
gracefully releasing DMA channels for the above two cases and start the DMA at
resume.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/tty/serial/fsl_lpuart.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 27687d5..134090a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1943,6 +1943,30 @@ static int lpuart_suspend(struct device *dev)
 	}
 
 	uart_suspend_port(&lpuart_reg, &sport->port);
+
+	if (sport->lpuart_dma_rx_use) {
+		/*
+		 * EDMA driver during suspend will forcefully release any
+		 * non-idle DMA channels. If port wakeup is enabled or if port
+		 * is console port or 'no_console_suspend' is set the Rx DMA
+		 * cannot resume as as expected, hence gracefully release the
+		 * Rx DMA path before suspend and start Rx DMA path on resume.
+		 */
+		if (sport->port.irq_wake) {
+			del_timer_sync(&sport->lpuart_timer);
+			lpuart_dma_rx_free(&sport->port);
+		}
+
+		/* Disable Rx DMA to use UART port as wakeup source */
+		writeb(readb(sport->port.membase + UARTCR5) & ~UARTCR5_RDMAS,
+					sport->port.membase + UARTCR5);
+	}
+
+	if (sport->lpuart_dma_tx_use) {
+		sport->dma_tx_in_progress = false;
+		dmaengine_terminate_all(sport->dma_tx_chan);
+	}
+
 	if (sport->port.suspended && !sport->port.irq_wake)
 		clk_disable_unprepare(sport->clk);
 
@@ -1970,6 +1994,26 @@ static int lpuart_resume(struct device *dev)
 		writeb(temp, sport->port.membase + UARTCR2);
 	}
 
+	if (sport->lpuart_dma_rx_use) {
+		if (sport->port.irq_wake) {
+			if (!lpuart_start_rx_dma(sport)) {
+				sport->lpuart_dma_rx_use = true;
+				rx_dma_timer_init(sport);
+			} else {
+				sport->lpuart_dma_rx_use = false;
+			}
+		}
+	}
+
+	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
+			init_waitqueue_head(&sport->dma_wait);
+			sport->lpuart_dma_tx_use = true;
+			writeb(readb(sport->port.membase + UARTCR5) |
+				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
+	} else {
+		sport->lpuart_dma_tx_use = false;
+	}
+
 	uart_resume_port(&lpuart_reg, &sport->port);
 
 	return 0;
-- 
2.9.0

