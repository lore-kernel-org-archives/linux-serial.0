From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: [PATCH 7/7] pch_uart: Fix duplicate memory release issue
Date: Mon, 26 Mar 2012 14:43:06 +0900
Message-ID: <1332740586-28496-7-git-send-email-tomoya.rohm@gmail.com>
References: <1332740586-28496-1-git-send-email-tomoya.rohm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332740586-28496-1-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, Tomoya MORINAGA <tomoya.rohm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Add initialize variable to prevent duplicate free memory.

Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
---
 drivers/tty/serial/pch_uart.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6e7f0ac..803847b 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -660,10 +660,13 @@ static void pch_free_dma(struct uart_port *port)
 		dma_release_channel(priv->chan_rx);
 		priv->chan_rx = NULL;
 	}
-	if (sg_dma_address(&priv->sg_rx))
-		dma_free_coherent(port->dev, port->fifosize,
-				  sg_virt(&priv->sg_rx),
-				  sg_dma_address(&priv->sg_rx));
+
+	if (priv->rx_buf_dma) {
+		dma_free_coherent(port->dev, port->fifosize, priv->rx_buf_virt,
+				  priv->rx_buf_dma);
+		priv->rx_buf_virt = NULL;
+		priv->rx_buf_dma = 0;
+	}
 
 	return;
 }
-- 
1.7.7.6
