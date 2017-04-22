From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] tty/serial: atmel: use offset_in_page() macro
Date: Sat, 22 Apr 2017 09:21:12 +0800
Message-ID: <5faae8a0740a804663c1066b23e2d5e7e9ebcbd3.1492758735.git.geliangtang@gmail.com>
References: <4dbc77ccaaed98b183cf4dba58a4fa325fd65048.1492758503.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4dbc77ccaaed98b183cf4dba58a4fa325fd65048.1492758503.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use offset_in_page() macro instead of open-coding.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c355ac9..f398db8 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -959,7 +959,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	sg_set_page(&atmel_port->sg_tx,
 			virt_to_page(port->state->xmit.buf),
 			UART_XMIT_SIZE,
-			(unsigned long)port->state->xmit.buf & ~PAGE_MASK);
+			offset_in_page(port->state->xmit.buf));
 	nent = dma_map_sg(port->dev,
 				&atmel_port->sg_tx,
 				1,
@@ -1141,7 +1141,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	sg_set_page(&atmel_port->sg_rx,
 		    virt_to_page(ring->buf),
 		    sizeof(struct atmel_uart_char) * ATMEL_SERIAL_RINGSIZE,
-		    (unsigned long)ring->buf & ~PAGE_MASK);
+		    offset_in_page(ring->buf));
 	nent = dma_map_sg(port->dev,
 			  &atmel_port->sg_rx,
 			  1,
-- 
2.9.3
