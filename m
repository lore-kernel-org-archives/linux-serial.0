From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v2 1/3] tty: serial: imx: disable ageing timer interrupt if
 dma in use
Date: Fri, 20 Oct 2017 14:20:19 -0700
Message-ID: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, nandor.han@ge.com
Cc: Troy Kisky <troy.kisky@boundarydevices.com>, linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Since commit 4dec2f119e86 ("imx-serial: RX DMA startup latency")
the interrupt routine no longer will start rx dma.
So, we no longer need to enable this interrupt to start dma.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: split into a series of 2 patches
---
 drivers/tty/serial/imx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dfeff3951f93..bf47b15df2e8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1207,10 +1207,6 @@ static void imx_enable_dma(struct imx_port *sport)
 	temp |= UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN;
 	writel(temp, sport->port.membase + UCR1);
 
-	temp = readl(sport->port.membase + UCR2);
-	temp |= UCR2_ATEN;
-	writel(temp, sport->port.membase + UCR2);
-
 	imx_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
 
 	sport->dma_is_enabled = 1;
-- 
2.11.0
