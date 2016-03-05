From: Youngmin Nam <ym0914@gmail.com>
Subject: [PATCH] serial: samsung: optimize UART rx fifo access routine
Date: Sat,  5 Mar 2016 19:36:32 +0900
Message-ID: <1457174192-20956-1-git-send-email-ym0914@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, k.kozlowski@samsung.com
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Youngmin Nam <ym0914@gmail.com>
List-Id: linux-serial@vger.kernel.org

This patch optimizes UART rx fifo access routine by reading UART SFR
when necessary. At first, the "fifocnt" variable will be initialized
as Rx FIFO count. So we don't need to access UFSTAT(FIFO status) register
every time to check FIFO count because we know that count with "fifocnt".
After all data were read out from Rx FIFO, the "fifocnt" will be set as 0.
Lastly, UFSTAT will be accessed again to check whether the data remains
by any chance.

Signed-off-by: Youngmin Nam <ym0914@gmail.com>
Reviewed-by: Jung-Ick Guack <ji.guack@samsung.com>
---
 drivers/tty/serial/samsung.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index d72cd73..1fd09c0 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -601,14 +601,21 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
 	unsigned int ufcon, ch, flag, ufstat, uerstat;
+	unsigned int fifocnt = 0;
 	int max_count = port->fifosize;
 
 	while (max_count-- > 0) {
-		ufcon = rd_regl(port, S3C2410_UFCON);
-		ufstat = rd_regl(port, S3C2410_UFSTAT);
-
-		if (s3c24xx_serial_rx_fifocnt(ourport, ufstat) == 0)
-			break;
+		/*
+		 * Receive all characters known to be in FIFO
+		 * before reading FIFO level again
+		 */
+		if (fifocnt == 0) {
+			ufstat = rd_regl(port, S3C2410_UFSTAT);
+			fifocnt = s3c24xx_serial_rx_fifocnt(ourport, ufstat);
+			if (fifocnt == 0)
+				break;
+		}
+		fifocnt--;
 
 		uerstat = rd_regl(port, S3C2410_UERSTAT);
 		ch = rd_regb(port, S3C2410_URXH);
@@ -623,6 +630,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 				}
 			} else {
 				if (txe) {
+					ufcon = rd_regl(port, S3C2410_UFCON);
 					ufcon |= S3C2410_UFCON_RESETRX;
 					wr_regl(port, S3C2410_UFCON, ufcon);
 					rx_enabled(port) = 1;
-- 
2.7.1
