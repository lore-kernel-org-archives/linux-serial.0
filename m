From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 08/27] serial: sh-sci: Drop unused frame_len parameter for sci_baud_calc_hscif()
Date: Mon, 14 Dec 2015 19:57:17 +0100
Message-ID: <1450119456-964-9-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

As F is assumed to be zero in the receive margin formula, frame_len is
not used. Remove it, together with the sci_baud_calc_frame_len() helper
function.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Reviewed-by, Acked-by.
---
 drivers/tty/serial/sh-sci.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 36077193f11168f0..05ac15336e4f918d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1866,26 +1866,9 @@ static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 	return DIV_ROUND_CLOSEST(freq, s->sampling_rate * bps) - 1;
 }
 
-/* calculate frame length from SMR */
-static int sci_baud_calc_frame_len(unsigned int smr_val)
-{
-	int len = 10;
-
-	if (smr_val & SCSMR_CHR)
-		len--;
-	if (smr_val & SCSMR_PE)
-		len++;
-	if (smr_val & SCSMR_STOP)
-		len++;
-
-	return len;
-}
-
-
 /* calculate sample rate, BRR, and clock select for HSCIF */
-static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq,
-				int *brr, unsigned int *srr,
-				unsigned int *cks, int frame_len)
+static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
+				unsigned int *srr, unsigned int *cks)
 {
 	int sr, c, br, err, recv_margin;
 	int min_err = 1000; /* 100% */
@@ -1987,9 +1970,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, max_baud);
 	if (likely(baud && port->uartclk)) {
 		if (s->cfg->type == PORT_HSCIF) {
-			int frame_len = sci_baud_calc_frame_len(smr_val);
 			sci_baud_calc_hscif(baud, port->uartclk, &t, &srr,
-					    &cks, frame_len);
+					    &cks);
 		} else {
 			t = sci_scbrr_calc(s, baud, port->uartclk);
 			for (cks = 0; t >= 256 && cks <= 3; cks++)
-- 
1.9.1

