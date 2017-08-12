From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH] serial: imx: Improve PIO prevention if TX DMA has been started
Date: Sat, 12 Aug 2017 17:12:10 +0200
Message-ID: <20170812151210.10420-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>, Ian Jamison <ian.dev@arkver.com>, =?UTF-8?q?Uwe-Kleine=20K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

The imx_transmit_buffer function should return if TX DMA has already
been started and not just skip over the buffer PIO write loop. (Which
did fix the initial problem, but could have unintentional side-effects)

Tested on an i.MX6Q board with half-duplex RS-485 and with RS-232.

Cc: Ian Jamison <ian.dev@arkver.com>
Cc: Uwe-Kleine König <u.kleine-koenig@pengutronix.de>
Fixes: 514ab34dbad6 ("serial: imx: Prevent TX buffer PIO write when a
DMA has been started")
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 80934e7bd67f..fce538eb8c77 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -452,13 +452,14 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 		if (sport->dma_is_txing) {
 			temp |= UCR1_TDMAEN;
 			writel(temp, sport->port.membase + UCR1);
+			return;
 		} else {
 			writel(temp, sport->port.membase + UCR1);
 			imx_dma_tx(sport);
 		}
 	}
 
-	while (!uart_circ_empty(xmit) && !sport->dma_is_txing &&
+	while (!uart_circ_empty(xmit) &&
 	       !(readl(sport->port.membase + uts_reg(sport)) & UTS_TXFULL)) {
 		/* send xmit->buf[xmit->tail]
 		 * out the port here */
-- 
2.14.1
