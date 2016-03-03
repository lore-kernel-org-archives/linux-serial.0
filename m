From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] tty: amba-pl011: don't dereference NULL platform data
Date: Thu,  3 Mar 2016 16:35:35 +0000
Message-ID: <597e09d3324e7d901fb0f77ccf6ccf3c07ce1f31.1457022799.git.robin.murphy@arm.com>
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
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

When only a TX DMA channel is specified in DT, pl011_dma_probe() falls
back to looking for the optional RX channel in platform data. What it
doesn't do is check whether that platform data actually exists...

Add the missing check to avoid crashing the kernel.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c0da0cc..a4dd91a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -420,7 +420,7 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 	/* Optionally make use of an RX channel as well */
 	chan = dma_request_slave_channel(dev, "rx");
 
-	if (!chan && plat->dma_rx_param) {
+	if (!chan && plat && plat->dma_rx_param) {
 		chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
 
 		if (!chan) {
-- 
2.7.2.333.g70bd996.dirty
