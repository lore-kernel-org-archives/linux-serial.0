From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: [PATCH 1/5] serial: pl011: Allocate TX DMA buffer from DMA capable
 memory
Date: Fri, 07 Nov 2014 14:14:35 +0000
Message-ID: <545CD3CB.7090909@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


Allocating with __GFP_DMA avoids the need for bounce buffers

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8572f2a..a285196 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -987,7 +987,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 	if (!uap->dmatx.chan)
 		return;
 
-	uap->dmatx.buf = kmalloc(PL011_DMA_BUFFER_SIZE, GFP_KERNEL);
+	uap->dmatx.buf = kmalloc(PL011_DMA_BUFFER_SIZE, GFP_KERNEL | __GFP_DMA);
 	if (!uap->dmatx.buf) {
 		dev_err(uap->port.dev, "no memory for DMA TX buffer\n");
 		uap->port.fifosize = uap->fifosize;
-- 
1.7.1
