From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/2] serial: arc_uart: Use uart_circ_empty() for open-coded comparison
Date: Sun,  6 Jul 2014 11:29:53 -0400
Message-ID: <1404660593-12172-3-git-send-email-peter@hurleysoftware.com>
References: <20140609205917.GA913@drone.musicnaut.iki.fi>
 <1404660593-12172-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404660593-12172-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Replace open-coded test for empty tx ring buffer with equivalent
helper function, uart_circ_empty(). No functional change.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/arc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index c9f5c9d..008c223 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -177,7 +177,7 @@ static void arc_serial_tx_chars(struct arc_uart_port *uart)
 		uart->port.icount.tx++;
 		uart->port.x_char = 0;
 		sent = 1;
-	} else if (xmit->tail != xmit->head) {	/* TODO: uart_circ_empty */
+	} else if (!uart_circ_empty(xmit)) {
 		ch = xmit->buf[xmit->tail];
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		uart->port.icount.tx++;
-- 
2.0.0
