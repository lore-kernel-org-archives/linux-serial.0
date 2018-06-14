From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 1/7] tty: serial: imx: correct dma cookie status
Date: Thu, 14 Jun 2018 22:02:56 +0800
Message-ID: <1528984982-5074-2-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de, dan.j.williams@intel.com, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

Correct to check the right rx dma cookie status in spit of it
works because only one cookie is running in the current sdma.
But it will not once sdma driver support multi cookies
running based on virt-dma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c2fc6be..b83bc2c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1051,7 +1051,7 @@ static void imx_uart_dma_rx_callback(void *data)
 	unsigned int r_bytes;
 	unsigned int bd_size;
 
-	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
+	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
 
 	if (status == DMA_ERROR) {
 		imx_uart_clear_rx_errors(sport);
-- 
2.7.4
