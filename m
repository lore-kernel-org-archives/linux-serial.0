From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/2] serial: pl011: delete dangling bug flag
Date: Fri, 7 Sep 2012 10:02:36 +0200
Message-ID: <1347004956-15294-1-git-send-email-linus.walleij@stericsson.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Anmar Oueja <anmar.oueja@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

The bug flag .interrupt_may_hang is not used since commit
4fd0690bb0c3955983560bb2767ee82e2b197f9b
"serial: pl011: implement workaround for CTS clear event issue"
so delete it.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 05c15ec..cede938 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -77,7 +77,6 @@ struct vendor_data {
 	unsigned int		lcrh_tx;
 	unsigned int		lcrh_rx;
 	bool			oversampling;
-	bool			interrupt_may_hang;   /* vendor-specific */
 	bool			dma_threshold;
 	bool			cts_event_workaround;
 };
@@ -98,7 +97,6 @@ static struct vendor_data vendor_st = {
 	.lcrh_tx		= ST_UART011_LCRH_TX,
 	.lcrh_rx		= ST_UART011_LCRH_RX,
 	.oversampling		= true,
-	.interrupt_may_hang	= true,
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
 };
@@ -149,7 +147,6 @@ struct uart_amba_port {
 	unsigned int		old_cr;		/* state during shutdown */
 	bool			autorts;
 	char			type[12];
-	bool			interrupt_may_hang; /* vendor-specific */
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	bool			using_tx_dma;
@@ -1952,7 +1949,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->lcrh_tx = vendor->lcrh_tx;
 	uap->old_cr = 0;
 	uap->fifosize = vendor->fifosize;
-	uap->interrupt_may_hang = vendor->interrupt_may_hang;
 	uap->port.dev = &dev->dev;
 	uap->port.mapbase = dev->res.start;
 	uap->port.membase = base;
-- 
1.7.11.3
