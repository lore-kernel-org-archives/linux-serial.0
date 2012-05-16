From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 4/4] serial: bfin_uart: Make MMR access compatible with 32 bits bf609 style controller.
Date: Wed, 16 May 2012 14:22:26 +0800
Message-ID: <1337149346-5277-4-git-send-email-sonic.adi@gmail.com>
References: <1337149346-5277-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337149346-5277-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-serial@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Simplify serial data width calculation and adapt to bf609 LCR bit mask.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 7924ba6..bd97db2 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -594,7 +594,7 @@ static unsigned int bfin_serial_tx_empty(struct uart_port *port)
 static void bfin_serial_break_ctl(struct uart_port *port, int break_state)
 {
 	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
-	u16 lcr = UART_GET_LCR(uart);
+	u32 lcr = UART_GET_LCR(uart);
 	if (break_state)
 		lcr |= SB;
 	else
@@ -1068,7 +1068,7 @@ bfin_serial_console_get_options(struct bfin_serial_port *uart, int *baud,
 	status = UART_GET_IER(uart) & (ERBFI | ETBEI);
 	if (status == (ERBFI | ETBEI)) {
 		/* ok, the port was enabled */
-		u16 lcr, clk;
+		u32 lcr, clk;
 
 		lcr = UART_GET_LCR(uart);
 
@@ -1079,20 +1079,8 @@ bfin_serial_console_get_options(struct bfin_serial_port *uart, int *baud,
 			else
 				*parity = 'o';
 		}
-		switch (lcr & 0x03) {
-		case 0:
-			*bits = 5;
-			break;
-		case 1:
-			*bits = 6;
-			break;
-		case 2:
-			*bits = 7;
-			break;
-		case 3:
-			*bits = 8;
-			break;
-		}
+		*bits = ((lcr & WLS_MASK) >> WLS_OFFSET) + 5;
+
 		/* Set DLAB in LCR to Access CLK */
 		UART_SET_DLAB(uart);
 
-- 
1.7.0.4
