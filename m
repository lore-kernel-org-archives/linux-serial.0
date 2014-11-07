From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: [PATCH 2/5] serial: pl011: Avoid assumptions about buffer size when
 refilling TX DMA
Date: Fri, 07 Nov 2014 14:14:39 +0000
Message-ID: <545CD3CF.4070901@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


The existing code assumed that PL011_DMA_BUFFER_SIZE == UART_XMIT_SIZE,
which may not always be the case.  This allows for these two being
different sizes and not copying too much data.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index a285196..d8d067a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -501,7 +501,11 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 		memcpy(&dmatx->buf[0], &xmit->buf[xmit->tail], count);
 	else {
 		size_t first = UART_XMIT_SIZE - xmit->tail;
-		size_t second = xmit->head;
+		size_t second;
+
+		if (first > count)
+			first = count;
+		second = count - first;
 
 		memcpy(&dmatx->buf[0], &xmit->buf[xmit->tail], first);
 		if (second)
-- 
1.7.1
