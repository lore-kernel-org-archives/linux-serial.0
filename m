From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tty: serial: 8250_mtk: Fix potential NULL pointer dereference
Date: Tue, 22 Jan 2019 13:57:19 -0600
Message-ID: <20190122195719.GA21846@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-serial@vger.kernel.org

There is a potential NULL pointer dereference in case devm_kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on data->dma

This bug was detected with the help of Coccinelle.

Fixes: 85b5c1dd0456 ("serial: 8250-mtk: add uart DMA support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index e2c407656fa6..c1fdbc0b6840 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -357,6 +357,9 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	if (dmacnt == 2) {
 		data->dma = devm_kzalloc(&pdev->dev, sizeof(*data->dma),
 					 GFP_KERNEL);
+		if (!data->dma)
+			return -ENOMEM;
+
 		data->dma->fn = mtk8250_dma_filter;
 		data->dma->rx_size = MTK_UART_RX_SIZE;
 		data->dma->rxconf.src_maxburst = MTK_UART_RX_TRIGGER;
-- 
2.20.1
