From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] serial: mxs-auart: fix baud rate range
Date: Tue, 11 Aug 2015 11:46:01 +0000
Message-ID: <1439293561-7994-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, =?UTF-8?q?Janusz=20U=C5=BCycki?= <j.uzycki@elpromaelectronics.com>, Fabio Estevam <fabio.estevam@freescale.com>, jbe@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
List-Id: linux-serial@vger.kernel.org

Currently mxs-auart doesn't care correctly about the baud rate divisor.
According to reference manual the baud rate divisor must be between
0x000000EC and 0x003FFFC0. So calculate the possible baud rate range
and use it for uart_get_baud_rate().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/tty/serial/mxs-auart.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Changes since RFC:
- use defines for baud rate divisor range suggested by Fabio Estevam
- fix rounding issue with baud_min found by Janusz Uzycki

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 13cf773..9074a0b 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -100,6 +100,8 @@
 #define AUART_CTRL2_TXE				(1 << 8)
 #define AUART_CTRL2_UARTEN			(1 << 0)
 
+#define AUART_LINECTRL_BAUD_DIV_MAX		0x003fffc0
+#define AUART_LINECTRL_BAUD_DIV_MIN		0x000000ec
 #define AUART_LINECTRL_BAUD_DIVINT_SHIFT	16
 #define AUART_LINECTRL_BAUD_DIVINT_MASK		0xffff0000
 #define AUART_LINECTRL_BAUD_DIVINT(v)		(((v) & 0xffff) << 16)
@@ -659,7 +661,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 {
 	struct mxs_auart_port *s = to_auart_port(u);
 	u32 bm, ctrl, ctrl2, div;
-	unsigned int cflag, baud;
+	unsigned int cflag, baud, baud_min, baud_max;
 
 	cflag = termios->c_cflag;
 
@@ -752,7 +754,9 @@ static void mxs_auart_settermios(struct uart_port *u,
 	}
 
 	/* set baud rate */
-	baud = uart_get_baud_rate(u, termios, old, 0, u->uartclk);
+	baud_min = DIV_ROUND_UP(u->uartclk * 32, AUART_LINECTRL_BAUD_DIV_MAX);
+	baud_max = u->uartclk * 32 / AUART_LINECTRL_BAUD_DIV_MIN;
+	baud = uart_get_baud_rate(u, termios, old, baud_min, baud_max);
 	div = u->uartclk * 32 / baud;
 	ctrl |= AUART_LINECTRL_BAUD_DIVFRAC(div & 0x3F);
 	ctrl |= AUART_LINECTRL_BAUD_DIVINT(div >> 6);
-- 
1.7.9.5
