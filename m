From: Leilei Zhao <leilei.zhao@atmel.com>
Subject: [PATCH v2 1/5] tty/serial: at91: correct check of buf used in DMA
Date: Fri, 27 Feb 2015 16:07:14 +0800
Message-ID: <1425024438-31355-2-git-send-email-leilei.zhao@atmel.com>
References: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Leilei Zhao <leilei.zhao@atmel.com>
List-Id: linux-serial@vger.kernel.org

We only use buf of ring In DMA rx function while using buf of xmit
in DMA tx function. So in DMA rx we need definitively to check the
buf of ring which is corresponding to DMA rx function. And use macro
PAGE_ALIGNED to simplify the expression.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 846552b..bac9e67 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -848,7 +848,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	spin_lock_init(&atmel_port->lock_tx);
 	sg_init_table(&atmel_port->sg_tx, 1);
 	/* UART circular tx buffer is an aligned page. */
-	BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
+	BUG_ON(!PAGE_ALIGNED(port->state->xmit.buf));
 	sg_set_page(&atmel_port->sg_tx,
 			virt_to_page(port->state->xmit.buf),
 			UART_XMIT_SIZE,
@@ -1027,7 +1027,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	spin_lock_init(&atmel_port->lock_rx);
 	sg_init_table(&atmel_port->sg_rx, 1);
 	/* UART circular rx buffer is an aligned page. */
-	BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
+	BUG_ON(!PAGE_ALIGNED(ring->buf));
 	sg_set_page(&atmel_port->sg_rx,
 		    virt_to_page(ring->buf),
 		    ATMEL_SERIAL_RINGSIZE,
-- 
1.7.9.5
