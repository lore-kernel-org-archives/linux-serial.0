From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 3/7] serial: imx: init dma_is_{rx|tx}ing variables
Date: Fri, 30 Jun 2017 14:04:42 +0200
Message-ID: <20170630120446.13994-4-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170630120446.13994-1-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>
List-Id: linux-serial@vger.kernel.org

From: Nandor Han <nandor.han@ge.com>

Initialize both dma_is_{rx|tx}ing variables when DMA is enabled to avoid
checking uninitialized variables if port shutdown is requested before
DMA channels get a chance to start.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 188063d..81fb413 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1225,6 +1225,9 @@ static void imx_enable_dma(struct imx_port *sport)
 
 	imx_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
 
+	sport->dma_is_rxing = 0;
+	sport->dma_is_txing = 0;
+
 	sport->dma_is_enabled = 1;
 }
 
-- 
1.8.3.1
