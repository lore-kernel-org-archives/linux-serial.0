From: DengChao <chao.deng@linaro.org>
Subject: [PATCH] serial:bfin-uart:Remove 'struct timeval'
Date: Sun, 13 Dec 2015 18:14:57 +0800
Message-ID: <1450001697-5015-1-git-send-email-chao.deng@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sonic.zhang@analog.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chao.deng@linaro.org
List-Id: linux-serial@vger.kernel.org

The bfin-uart code uses real time with struct timeval. This will
cause problems on 32-bit architectures in 2038 when time_t
overflows.
Since the code just needs delta value of time, it is not
necessary to record them in real time.
This patch changes the code to use the monotonic time instead,
replaces struct timeval and do_gettimeofday() with u64 and
ktime_get_ns().

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: DengChao <chao.deng@linaro.org>
---
 drivers/tty/serial/bfin_uart.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index ae3cf94..1270cc4 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -213,7 +213,7 @@ static void bfin_serial_stop_rx(struct uart_port *port)
 static void bfin_serial_rx_chars(struct bfin_serial_port *uart)
 {
 	unsigned int status, ch, flg;
-	static struct timeval anomaly_start = { .tv_sec = 0 };
+	static u64 anomaly_start;
 
 	status = UART_GET_LSR(uart);
 	UART_CLEAR_LSR(uart);
@@ -246,27 +246,24 @@ static void bfin_serial_rx_chars(struct bfin_serial_port *uart)
 		 * character time +/- some percent.  So 1.5 sounds good.  All other
 		 * Blackfin families operate properly.  Woo.
 		 */
-		if (anomaly_start.tv_sec) {
-			struct timeval curr;
-			suseconds_t usecs;
+		if (anomaly_start > 0) {
+			u64 curr, nsecs, threshold_ns;
 
 			if ((~ch & (~ch + 1)) & 0xff)
 				goto known_good_char;
 
-			do_gettimeofday(&curr);
-			if (curr.tv_sec - anomaly_start.tv_sec > 1)
+			curr = ktime_get_ns();
+			nsecs = curr - anomaly_start;
+			if (nsecs >> 32)
 				goto known_good_char;
-
-			usecs = 0;
-			if (curr.tv_sec != anomaly_start.tv_sec)
-				usecs += USEC_PER_SEC;
-			usecs += curr.tv_usec - anomaly_start.tv_usec;
-
-			if (usecs > UART_GET_ANOMALY_THRESHOLD(uart))
+
+			threshold_ns = UART_GET_ANOMALY_THRESHOLD(uart)
+							* NSEC_PER_USEC;
+			if (nsecs > threshold_ns)
 				goto known_good_char;
 
 			if (ch)
-				anomaly_start.tv_sec = 0;
+				anomaly_start = 0;
 			else
 				anomaly_start = curr;
 
@@ -274,14 +271,14 @@ static void bfin_serial_rx_chars(struct bfin_serial_port *uart)
 
  known_good_char:
 			status &= ~BI;
-			anomaly_start.tv_sec = 0;
+			anomaly_start = 0;
 		}
 	}
 
 	if (status & BI) {
 		if (ANOMALY_05000363)
 			if (bfin_revid() < 5)
-				do_gettimeofday(&anomaly_start);
+				anomaly_start = ktime_get_ns();
 		uart->port.icount.brk++;
 		if (uart_handle_break(&uart->port))
 			goto ignore_char;
-- 
1.9.1
