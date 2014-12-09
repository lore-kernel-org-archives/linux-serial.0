From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 08/15] Revert "serial: imx: always wake up the processes in the TX callback"
Date: Tue, 9 Dec 2014 18:11:29 +0900
Message-ID: <1418116296-12082-9-git-send-email-jiada_wang@mentor.com>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jiada_wang@mentor.com, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

This reverts commit 2ad28e3efee21a5bbf940c83d1f0395b76bd3efb.

Instead of always wake up write_wait process in TX callback,
TX callback should call imx_dma_tx() again, and let imx_dma_tx
transfer the remaining data in circle buffer.

The issue with commit 2ad28e3 is, in case there is remaining
data in circle buffer, but no process is waiting on write_wait
queue, then as no following uart_write() will be called after
uart_write_wakeup(), thus cause data loss.

Moreover according to Documentation/serial/driver, uart_write_wakeup()
should be called in case the transmit buffer have dropped below
a threshold.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3db6a5b..3d86851 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -516,7 +516,8 @@ static void dma_tx_callback(void *data)
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	uart_write_wakeup(&sport->port);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&sport->port);
 
 	if (waitqueue_active(&sport->dma_wait)) {
 		wake_up(&sport->dma_wait);
-- 
1.9.3
