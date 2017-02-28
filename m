From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] serial: 8250_dw: Honor clk_round_rate errors in dw8250_set_termios
Date: Tue, 28 Feb 2017 04:17:57 +0100
Message-ID: <20170228031757.4231-1-heiko@sntech.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
List-Id: linux-serial@vger.kernel.org

clk_round_rate returns a signed long and may possibly return errors
in it, for example if there is no possible rate.

Till now dw8250_set_termios ignored any error, the signednes and would
just use the value as input to clk_set_rate. This of course falls apart
if there is an actual error, so check for errors and only try to set
a rate if the value is actually valid.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/tty/serial/8250/8250_dw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 6ee55a2d47bb..223ac234ddb2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -257,7 +257,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 {
 	unsigned int baud = tty_termios_baud_rate(termios);
 	struct dw8250_data *d = p->private_data;
-	unsigned int rate;
+	long rate;
 	int ret;
 
 	if (IS_ERR(d->clk) || !old)
@@ -265,7 +265,10 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 
 	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, baud * 16);
-	ret = clk_set_rate(d->clk, rate);
+	if (rate < 0)
+		ret = rate;
+	else
+		ret = clk_set_rate(d->clk, rate);
 	clk_prepare_enable(d->clk);
 
 	if (!ret)
-- 
2.11.0
