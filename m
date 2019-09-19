From: Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH v3] serial: imx: adapt rx buffer and dma periods
Date: Thu, 19 Sep 2019 16:51:14 +0200
Message-ID: <20190919145114.13006-1-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org, yibin.gong@nxp.com, fugang.duan@nxp.com, l.stach@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Philipp Puschmann <philipp.puschmann@emlix.com>
List-Id: linux-serial@vger.kernel.org

Using only 4 DMA periods for UART RX is very few if we have a high
frequency of small transfers - like in our case using Bluetooth with
many small packets via UART - causing many dma transfers but in each
only filling a fraction of a single buffer. Such a case may lead to
the situation that DMA RX transfer is triggered but no free buffer is
available. When this happens dma channel ist stopped - with the patch
"dmaengine: imx-sdma: fix dma freezes" temporarily only - with the
possible consequences that:
with disabled hw flow control:
  If enough data is incoming on UART port the RX FIFO runs over and
  characters will be lost. What then happens depends on upper layer.

with enabled hw flow control:
  If enough data is incoming on UART port the RX FIFO reaches a level
  where CTS is deasserted and remote device sending the data stops.
  If it fails to stop timely the i.MX' RX FIFO may run over and data
  get lost. Otherwise it's internal TX buffer may getting filled to
  a point where it runs over and data is again lost. It depends on
  the remote device how this case is handled and if it is recoverable.

Obviously we want to avoid having no free buffers available. So we
decrease the size of the buffers and increase their number and the
total buffer size.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

Changelog v3:
 - enhance description

Changelog v2:
 - split this patch from series "Fix UART DMA freezes for iMX6"
 - add Reviewed-by tag

 drivers/tty/serial/imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 87c58f9f6390..51dc19833eab 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1034,8 +1034,6 @@ static void imx_uart_timeout(struct timer_list *t)
 	}
 }
 
-#define RX_BUF_SIZE	(PAGE_SIZE)
-
 /*
  * There are two kinds of RX DMA interrupts(such as in the MX6Q):
  *   [1] the RX DMA buffer is full.
@@ -1118,7 +1116,8 @@ static void imx_uart_dma_rx_callback(void *data)
 }
 
 /* RX DMA buffer periods */
-#define RX_DMA_PERIODS 4
+#define RX_DMA_PERIODS	16
+#define RX_BUF_SIZE	(PAGE_SIZE / 4)
 
 static int imx_uart_start_rx_dma(struct imx_port *sport)
 {
-- 
2.23.0
