From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC] serial: mxs-auart: fix baud rate range
Date: Mon, 10 Aug 2015 12:12:47 +0000
Message-ID: <1439208767-29152-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Janusz Uzycki <j.uzycki@elproma.com.pl>, Fabio Estevam <fabio.estevam@freescale.com>, jbe@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
List-Id: linux-serial@vger.kernel.org

Currently mxs-auart doesn't care correctly about the baud rate divisor.
According to reference manual the baud rate divisor must be between
0x000000EC and 0x003FFFC0. So calculate the possible baud rate range
and use it for uart_get_baud_rate().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/tty/serial/mxs-auart.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Here is a userspace application to test the new baud rate range:

https://gist.github.com/lategoodbye/f2d76134aa6c404cd92c

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 13cf773..afe617c 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -659,7 +659,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 {
 	struct mxs_auart_port *s = to_auart_port(u);
 	u32 bm, ctrl, ctrl2, div;
-	unsigned int cflag, baud;
+	unsigned int cflag, baud, baud_min, baud_max;
 
 	cflag = termios->c_cflag;
 
@@ -752,7 +752,9 @@ static void mxs_auart_settermios(struct uart_port *u,
 	}
 
 	/* set baud rate */
-	baud = uart_get_baud_rate(u, termios, old, 0, u->uartclk);
+	baud_min = u->uartclk * 32 / 0x3fffc0;
+	baud_max = u->uartclk * 32 / 0xec;
+	baud = uart_get_baud_rate(u, termios, old, baud_min, baud_max);
 	div = u->uartclk * 32 / baud;
 	ctrl |= AUART_LINECTRL_BAUD_DIVFRAC(div & 0x3F);
 	ctrl |= AUART_LINECTRL_BAUD_DIVINT(div >> 6);
-- 
1.7.9.5
