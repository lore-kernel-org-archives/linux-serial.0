From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 163/258] serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure
Date: Mon, 28 Jan 2019 10:57:49 -0500
Message-ID: <20190128155924.51521-163-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 71ab1c0336c71ace5725740f200beca9667a339f ]

On (H)SCIF, sci_submit_rx() is called in the receive interrupt handler.
Hence if DMA submission fails, the interrupt handler should resume
handling reception using PIO, else no more data is received.

Make sci_submit_rx() return an error indicator, so the receive interrupt
handler can act appropriately.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sh-sci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5fdd7944b73b..c6e8ca2e5f7d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1331,7 +1331,7 @@ static void sci_tx_dma_release(struct sci_port *s)
 	dma_release_channel(chan);
 }
 
-static void sci_submit_rx(struct sci_port *s, bool port_lock_held)
+static int sci_submit_rx(struct sci_port *s, bool port_lock_held)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
@@ -1359,7 +1359,7 @@ static void sci_submit_rx(struct sci_port *s, bool port_lock_held)
 	s->active_rx = s->cookie_rx[0];
 
 	dma_async_issue_pending(chan);
-	return;
+	return 0;
 
 fail:
 	/* Switch to PIO */
@@ -1374,6 +1374,7 @@ static void sci_submit_rx(struct sci_port *s, bool port_lock_held)
 	sci_start_rx(port);
 	if (!port_lock_held)
 		spin_unlock_irqrestore(&port->lock, flags);
+	return -EAGAIN;
 }
 
 static void work_fn_tx(struct work_struct *work)
@@ -1668,8 +1669,10 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 			disable_irq_nosync(irq);
 			scr |= SCSCR_RDRQE;
 		} else {
+			if (sci_submit_rx(s, false) < 0)
+				goto handle_pio;
+
 			scr &= ~SCSCR_RIE;
-			sci_submit_rx(s, false);
 		}
 		serial_port_out(port, SCSCR, scr);
 		/* Clear current interrupt */
@@ -1681,6 +1684,8 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 
 		return IRQ_HANDLED;
 	}
+
+handle_pio:
 #endif
 
 	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0) {
-- 
2.19.1
