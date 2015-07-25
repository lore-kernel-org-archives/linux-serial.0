From: Niklas Cassel <nks@flawful.org>
Subject: [PATCH] serial: etraxfs-uart: remove empty functions
Date: Sat, 25 Jul 2015 02:00:40 +0200
Message-ID: <1437782440-11414-1-git-send-email-nks@flawful.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Niklas Cassel <nks@flawful.org>
List-Id: linux-serial@vger.kernel.org

Implementing enable_ms is optional by serial_core.
check_modem_status is just an empty local function.

Signed-off-by: Niklas Cassel <nks@flawful.org>
---
 drivers/tty/serial/etraxfs-uart.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/etraxfs-uart.c
index 679709f..a647605 100644
--- a/drivers/tty/serial/etraxfs-uart.c
+++ b/drivers/tty/serial/etraxfs-uart.c
@@ -373,14 +373,6 @@ static void etraxfs_uart_stop_rx(struct uart_port *port)
 	REG_WR(ser, regi_ser, rw_rec_ctrl, rec_ctrl);
 }
 
-static void etraxfs_uart_enable_ms(struct uart_port *port)
-{
-}
-
-static void check_modem_status(struct uart_cris_port *up)
-{
-}
-
 static unsigned int etraxfs_uart_tx_empty(struct uart_port *port)
 {
 	struct uart_cris_port *up = (struct uart_cris_port *)port;
@@ -598,7 +590,6 @@ ser_interrupt(int irq, void *dev_id)
 			receive_chars_no_dma(up);
 			handled = 1;
 		}
-		check_modem_status(up);
 
 		if (masked_intr.tr_rdy) {
 			transmit_chars_no_dma(up);
@@ -862,7 +853,6 @@ static const struct uart_ops etraxfs_uart_pops = {
 	.start_tx = etraxfs_uart_start_tx,
 	.send_xchar = etraxfs_uart_send_xchar,
 	.stop_rx = etraxfs_uart_stop_rx,
-	.enable_ms = etraxfs_uart_enable_ms,
 	.break_ctl = etraxfs_uart_break_ctl,
 	.startup = etraxfs_uart_startup,
 	.shutdown = etraxfs_uart_shutdown,
-- 
2.4.6
