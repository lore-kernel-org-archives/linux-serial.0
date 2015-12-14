From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 15/27] serial: sh-sci: Merge sci_scbrr_calc() and sci_baud_calc_hscif()
Date: Mon, 14 Dec 2015 19:57:24 +0100
Message-ID: <1450119456-964-16-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

For low bit rates, the for-loop that reduces the divider returned by
sci_scbrr_calc() and picks the clock select value may terminate without
finding suitable values, leading to out-of-range divider and clock
select values.
sci_baud_calc_hscif() doesn't suffer from this problem, as it correctly
uses clamp().

Since there are only two relevant differences between HSCIF and other
variants w.r.t. bit rate configuration (fixed vs. variable sample rate,
and an additional factor of two), sci_scbrr_calc() and
sci_baud_calc_hscif() can be merged, fixing the issue with out-of-range
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Acked-by,
  - Rebased.
---
 drivers/tty/serial/sh-sci.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c3a193616484a62c..d89d4b7576cf3a15 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1860,20 +1860,24 @@ static void sci_shutdown(struct uart_port *port)
 	sci_free_irq(s);
 }
 
-static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
-				   unsigned long freq)
+/* calculate sample rate, BRR, and clock select */
+static void sci_scbrr_calc(struct sci_port *s, unsigned int bps,
+			   unsigned long freq, int *brr, unsigned int *srr,
+			   unsigned int *cks)
 {
-	return DIV_ROUND_CLOSEST(freq, s->sampling_rate * bps) - 1;
-}
-
-/* calculate sample rate, BRR, and clock select for HSCIF */
-static void sci_baud_calc_hscif(struct sci_port *s, unsigned int bps,
-				unsigned long freq, int *brr,
-				unsigned int *srr, unsigned int *cks)
-{
-	unsigned int sr, br, prediv, scrate, c;
+	unsigned int min_sr, max_sr, shift, sr, br, prediv, scrate, c;
 	int err, min_err = INT_MAX;
 
+	if (s->sampling_rate) {
+		min_sr = max_sr = s->sampling_rate;
+		shift = 0;
+	} else {
+		/* HSCIF has a variable sample rate */
+		min_sr = 8;
+		max_sr = 32;
+		shift = 1;
+	}
+
 	/*
 	 * Find the combination of sample rate and clock select with the
 	 * smallest deviation from the desired baud rate.
@@ -1889,10 +1893,10 @@ static void sci_baud_calc_hscif(struct sci_port *s, unsigned int bps,
 	 *      (|D - 0.5| / N * (1 + F))|
 	 *  NOTE: Usually, treat D for 0.5, F is 0 by this calculation.
 	 */
-	for (sr = 32; sr >= 8; sr--) {
+	for (sr = max_sr; sr >= min_sr; sr--) {
 		for (c = 0; c <= 3; c++) {
 			/* integerized formulas from HSCIF documentation */
-			prediv = sr * (1 << (2 * c + 1));
+			prediv = sr * (1 << (2 * c + shift));
 
 			/*
 			 * We need to calculate:
@@ -1974,16 +1978,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	max_baud = port->uartclk ? port->uartclk / 16 : 115200;
 
 	baud = uart_get_baud_rate(port, termios, old, 0, max_baud);
-	if (likely(baud && port->uartclk)) {
-		if (s->cfg->type == PORT_HSCIF) {
-			sci_baud_calc_hscif(s, baud, port->uartclk, &t, &srr,
-					    &cks);
-		} else {
-			t = sci_scbrr_calc(s, baud, port->uartclk);
-			for (cks = 0; t >= 256 && cks <= 3; cks++)
-				t >>= 2;
-		}
-	}
+	if (likely(baud && port->uartclk))
+		sci_scbrr_calc(s, baud, port->uartclk, &t, &srr, &cks);
 
 	sci_port_enable(s);
 
-- 
1.9.1

