From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] serial: 8250: Fix UART_BUG_TXEN workaround
Date: Mon,  2 Feb 2015 15:47:07 -0500
Message-ID: <1422910027-16197-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Dick Hollenbeck <dick@softplc.com>
List-Id: linux-serial@vger.kernel.org

UARTs which do not trigger THRE interrupt if the fifo is already
empty when the interrupt is enabled need tx primed manually. These
UARTs are identified by the UART_BUG_TXEN flag to enable the
required workaround.

However, the current workaround is broken; if the fifo is already
empty but the shifter is still transmitting, then serial8250_tx_chars()
will not be called but no further THRE interrupt will occur, and
tx will stall. The appropriate check is for fifo empty (THRE), not
transmitter empty (TEMT).

Signed-off-by: Dick Hollenbeck <dick@softplc.com>
[pjh: rewrote commit log]
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 285694b..0c61a9b 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1365,7 +1365,7 @@ static void serial8250_start_tx(struct uart_port *port)
 			unsigned char lsr;
 			lsr = serial_in(up, UART_LSR);
 			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-			if (lsr & UART_LSR_TEMT)
+			if (lsr & UART_LSR_THRE)
 				serial8250_tx_chars(up);
 		}
 	}
-- 
2.2.2
