From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 10/25] serial: sh-sci: Improve bit rate error calculation for HSCIF
Date: Thu, 19 Nov 2015 19:38:49 +0100
Message-ID: <1447958344-836-11-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The algorithm to find the best parameters for the requested bit rate
calculates the relative bit rate error, using "(br * b) / 1000".
For small "br * b", this has two problems:
  - The quotient may be zero, leading to a division by zero error,
  - This may introduce a large rounding error.
Switch from relative to absolute bit rate error calculation to fix this.

The default baud rate generator values can be removed, as there will
always be one set of values that gives the smallest absolute error.

Print the best set of values when debugging.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 97a0f8ef5adc55a2..f35c209afd127c02 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1867,12 +1867,13 @@ static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 }
 
 /* calculate sample rate, BRR, and clock select for HSCIF */
-static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
+static void sci_baud_calc_hscif(struct sci_port *s, unsigned int bps,
+				unsigned long freq, int *brr,
 				unsigned int *srr, unsigned int *cks)
 {
 	unsigned int sr, br, a, b, c;
 	int err, recv_margin;
-	int min_err = 1000; /* 100% */
+	int min_err = INT_MAX;
 	int recv_max_margin = 0;
 
 	/* Find the combination of sample rate and clock select with the
@@ -1887,7 +1888,7 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 			b = a * bps;
 			br = DIV_ROUND_CLOSEST(freq, b);
 			br = clamp(br, 1U, 256U);
-			err = DIV_ROUND_CLOSEST(freq, (br * b) / 1000) - 1000;
+			err = DIV_ROUND_CLOSEST(freq, br * a) - bps;
 			/* Calc recv margin
 			 * M: Receive margin (%)
 			 * N: Ratio of bit rate to clock (N = sampling rate)
@@ -1917,13 +1918,8 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 		}
 	}
 
-	if (min_err == 1000) {
-		WARN_ON(1);
-		/* use defaults */
-		*brr = 255;
-		*srr = 15;
-		*cks = 0;
-	}
+	dev_dbg(s->port.dev, "BRR: %u%+d bps using N %u SR %u cks %u\n", bps,
+		min_err, *brr, *srr + 1, *cks);
 }
 
 static void sci_reset(struct uart_port *port)
@@ -1973,7 +1969,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, max_baud);
 	if (likely(baud && port->uartclk)) {
 		if (s->cfg->type == PORT_HSCIF) {
-			sci_baud_calc_hscif(baud, port->uartclk, &t, &srr,
+			sci_baud_calc_hscif(s, baud, port->uartclk, &t, &srr,
 					    &cks);
 		} else {
 			t = sci_scbrr_calc(s, baud, port->uartclk);
-- 
1.9.1
