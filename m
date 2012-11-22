From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 2/2] serial: mxs-auart: unmap the scatter list before we copy the data
Date: Thu, 22 Nov 2012 15:06:30 +0800
Message-ID: <1353567990-19907-2-git-send-email-b32955@freescale.com>
References: <1353567990-19907-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353567990-19907-1-git-send-email-b32955@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, lauri.hintsala@bluegiga.com, Huang Shijie <b32955@freescale.com>
List-Id: linux-serial@vger.kernel.org

We should first unmap the DMA scatter list for receiving data, and
then copy the data from the DMA buffer.

The old code misses unmap the scatter list for RX. This patch fixes it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
Tested-by: Lauri Hintsala <lauri.hintsala@bluegiga.com> 
---
 drivers/tty/serial/mxs-auart.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 2342b0d..6b51448 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -461,6 +461,8 @@ static void dma_rx_callback(void *arg)
 	int count;
 	u32 stat;
 
+	dma_unmap_sg(s->dev, &s->rx_sgl, 1, DMA_FROM_DEVICE);
+
 	stat = readl(s->port.membase + AUART_STAT);
 	stat &= ~(AUART_STAT_OERR | AUART_STAT_BERR |
 			AUART_STAT_PERR | AUART_STAT_FERR);
-- 
1.7.0.4
