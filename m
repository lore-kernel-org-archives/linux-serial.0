From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH] serial: samsung: remove redundant interrupt enabling
Date: Wed, 28 Jan 2015 14:44:23 +0100
Message-ID: <1422452663-24113-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, akpm@linux-foundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Function s3c24xx_serial_start_tx_pio() enables interrupts if needed,
so we don't have to (or even we shouldn't) enable them before.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 024e5ec..a07fe4f 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -358,15 +358,8 @@ void s3c24xx_serial_start_tx(struct uart_port *port)
 			s3c24xx_serial_rx_disable(port);
 
 		tx_enabled(port) = 1;
-		if (!ourport->dma || !ourport->dma->tx_chan) {
-			if (s3c24xx_serial_has_interrupt_mask(port))
-				__clear_bit(S3C64XX_UINTM_TXD,
-						portaddrl(port, S3C64XX_UINTM));
-			else
-				enable_irq(ourport->tx_irq);
-
+		if (!ourport->dma || !ourport->dma->tx_chan)
 			s3c24xx_serial_start_tx_pio(ourport);
-		}
 	}
 
 	if (ourport->dma && ourport->dma->tx_chan) {
-- 
1.9.1
