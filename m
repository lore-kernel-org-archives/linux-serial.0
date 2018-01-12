From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH] serial: 8250_dw: Avoid overflow in dw8250_set_termios
Date: Fri, 12 Jan 2018 13:45:07 +0000
Message-ID: <20180112134507.9030-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, nunojpg@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ed Blake <ed.blake@sondrel.com>
List-Id: linux-serial@vger.kernel.org

When searching for an achievable input clock rate that is within
+/-1.6% of an integer multiple of the target baudx16 rate, there is the
potential to overflow the i * rate calculations.

For example, on a 32-bit system with a baud rate of 4000000, the
i * max_rate calculation will overflow if i reaches 67 without finding
an acceptable rate.

Fix this by setting the upper boundary of the loop appropriately to
avoid overflow.

Reported-by: Nuno Goncalves <nunojpg@gmail.com>
Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5bb0c42c88dd..04b44829f0e3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -252,7 +252,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 			       struct ktermios *old)
 {
 	unsigned int baud = tty_termios_baud_rate(termios);
-	unsigned int target_rate, min_rate, max_rate;
+	unsigned int target_rate, min_rate, max_rate, div_max;
 	struct dw8250_data *d = p->private_data;
 	long rate;
 	int i, ret;
@@ -265,12 +265,14 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	min_rate = target_rate - (target_rate >> 6);
 	max_rate = target_rate + (target_rate >> 6);
 
-	for (i = 1; i <= UART_DIV_MAX; i++) {
+	/* Avoid overflow */
+	div_max = min(UINT_MAX / max_rate, (unsigned int)UART_DIV_MAX);
+	for (i = 1; i <= div_max; i++) {
 		rate = clk_round_rate(d->clk, i * target_rate);
 		if (rate >= i * min_rate && rate <= i * max_rate)
 			break;
 	}
-	if (i <= UART_DIV_MAX) {
+	if (i <= div_max) {
 		clk_disable_unprepare(d->clk);
 		ret = clk_set_rate(d->clk, rate);
 		clk_prepare_enable(d->clk);
-- 
2.11.0
