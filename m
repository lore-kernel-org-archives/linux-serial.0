From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] dmaengine: at_hdmac: fix module unloading
Date: Tue, 27 Nov 2018 17:06:35 +0100
Message-ID: <20181127160635.11836-2-richard.genoud@gmail.com>
References: <20181127160635.11836-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127160635.11836-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Mario Forner <m.forner@be4energy.com>, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

of_dma_controller_free() was not called on module onloading.
This lead to a soft lockup:
watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
Modules linked in: at_hdmac [last unloaded: at_hdmac]
when of_dma_request_slave_channel() tried to call ofdma->of_dma_xlate().

Cc: stable@vger.kernel.org
Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/dma/at_hdmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 1b7f0ca0d5cd..01d936c9fe89 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2006,6 +2006,8 @@ static int at_dma_remove(struct platform_device *pdev)
 	struct resource		*io;
 
 	at_dma_off(atdma);
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atdma->dma_common);
 
 	dma_pool_destroy(atdma->memset_pool);
