From: Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH 3/4] serial: imx: adapt rx buffer and dma periods
Date: Wed, 11 Sep 2019 16:49:42 +0200
Message-ID: <20190911144943.21554-4-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, gregkh@linuxfoundation.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, festevam@gmail.com, Philipp Puschmann <philipp.puschmann@emlix.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Using only 4 DMA periods for UART RX is very few if we have a high
frequency of small transfers - like in our case using Bluetooth with many
small packets via UART - causing many dma transfers but in each only
filling a fraction of a single buffer. Such a case may lead to the
situation that DMA RX transfer is triggered but no buffer is available.
While we have addressed the dma handling already we still want to avoid
UART RX FIFO overrun. So we decrease the size of the buffers and increase
their number and the total buffer size.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 drivers/tty/serial/imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 57d6e6ba556e..cdc51569237c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1028,8 +1028,6 @@ static void imx_uart_timeout(struct timer_list *t)
 	}
 }
 
-#define RX_BUF_SIZE	(PAGE_SIZE)
-
 /*
  * There are two kinds of RX DMA interrupts(such as in the MX6Q):
  *   [1] the RX DMA buffer is full.
@@ -1112,7 +1110,8 @@ static void imx_uart_dma_rx_callback(void *data)
 }
 
 /* RX DMA buffer periods */
-#define RX_DMA_PERIODS 4
+#define RX_DMA_PERIODS	16
+#define RX_BUF_SIZE	(PAGE_SIZE / 4)
 
 static int imx_uart_start_rx_dma(struct imx_port *sport)
 {
-- 
2.23.0
