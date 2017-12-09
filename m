From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] serial: fsl_lpuart: Delete an error message for a failed
 memory allocation in lpuart_start_rx_dma()
Date: Sat, 9 Dec 2017 21:41:37 +0100
Message-ID: <47b4cd2b-9372-9fec-d594-eed10d1cf515@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 9 Dec 2017 21:34:23 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/fsl_lpuart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c84e6f0db54e..694751ebabf4 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -998,10 +998,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 		sport->rx_dma_rng_buf_len = 16;
 
 	ring->buf = kmalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
-	if (!ring->buf) {
-		dev_err(sport->port.dev, "Ring buf alloc failed\n");
+	if (!ring->buf)
 		return -ENOMEM;
-	}
 
 	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
 	sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
-- 
2.15.1
