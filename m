From: dean_jenkins@mentor.com
Subject: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer() from
 imx_start_tx()
Date: Fri,  9 May 2014 16:19:44 +0100
Message-ID: <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: dirk.behme@de.bosch.com, s.hauer@pengutronix.de, dean_jenkins@mentor.com, b32955@freescale.com, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com
List-Id: linux-serial@vger.kernel.org

From: Dirk Behme <dirk.behme@de.bosch.com>

Use imx_start_tx() just to enable the TX interrupt. It's the job of the
TX interrupt ISR to fill the transmit buffer, then. If the transmit buffer
is empty, the TX interrupt should be executed as soon as the start_tx()
enables the interrupt, so there is no reason for the extra
imx_transmit_buffer() call, here. Remove it.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Andy Lowe <andy_lowe@mentor.com>
---
 drivers/tty/serial/imx.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3b6c1a2..7b813b3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -600,9 +600,6 @@ static void imx_start_tx(struct uart_port *port)
 		imx_dma_tx(sport);
 		return;
 	}
-
-	if (readl(sport->port.membase + uts_reg(sport)) & UTS_TXEMPTY)
-		imx_transmit_buffer(sport);
 }
 
 static irqreturn_t imx_rtsint(int irq, void *dev_id)
-- 
1.7.9.5
