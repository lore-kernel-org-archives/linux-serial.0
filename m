From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 11/25] serial: sh-sci: Avoid calculating the receive margin for HSCIF
Date: Thu, 19 Nov 2015 19:38:50 +0100
Message-ID: <1447958344-836-12-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

When assuming D = 0.5 and F = 0, maximizing the receive margin M is
equivalent to maximizing the sample rate N.

Hence there's no need to calculate the receive margin, as we can obtain
the same result by iterating over all possible sample rates in reverse
order, and skipping parameter sets that don't provide a lower bit rate
error.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 47 +++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f35c209afd127c02..c2ab29ddedbc26a2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1872,13 +1872,24 @@ static void sci_baud_calc_hscif(struct sci_port *s, unsigned int bps,
 				unsigned int *srr, unsigned int *cks)
 {
 	unsigned int sr, br, a, b, c;
-	int err, recv_margin;
-	int min_err = INT_MAX;
-	int recv_max_margin = 0;
+	int err, min_err = INT_MAX;
 
-	/* Find the combination of sample rate and clock select with the
-	   smallest deviation from the desired baud rate. */
-	for (sr = 8; sr <= 32; sr++) {
+	/*
+	 * Find the combination of sample rate and clock select with the
+	 * smallest deviation from the desired baud rate.
+	 * Prefer high sample rates to maximise the receive margin.
+	 *
+	 * M: Receive margin (%)
+	 * N: Ratio of bit rate to clock (N = sampling rate)
+	 * D: Clock duty (D = 0 to 1.0)
+	 * L: Frame length (L = 9 to 12)
+	 * F: Absolute value of clock frequency deviation
+	 *
+	 *  M = |(0.5 - 1 / 2 * N) - ((L - 0.5) * F) -
+	 *      (|D - 0.5| / N * (1 + F))|
+	 *  NOTE: Usually, treat D for 0.5, F is 0 by this calculation.
+	 */
+	for (sr = 32; sr >= 8; sr--) {
 		for (c = 0; c <= 3; c++) {
 			/* integerized formulas from HSCIF documentation */
 			a = sr * (1 << (2 * c + 1));
@@ -1888,30 +1899,12 @@ static void sci_baud_calc_hscif(struct sci_port *s, unsigned int bps,
 			b = a * bps;
 			br = DIV_ROUND_CLOSEST(freq, b);
 			br = clamp(br, 1U, 256U);
+
 			err = DIV_ROUND_CLOSEST(freq, br * a) - bps;
-			/* Calc recv margin
-			 * M: Receive margin (%)
-			 * N: Ratio of bit rate to clock (N = sampling rate)
-			 * D: Clock duty (D = 0 to 1.0)
-			 * L: Frame length (L = 9 to 12)
-			 * F: Absolute value of clock frequency deviation
-			 *
-			 *  M = |(0.5 - 1 / 2 * N) - ((L - 0.5) * F) -
-			 *      (|D - 0.5| / N * (1 + F))|
-			 *  NOTE: Usually, treat D for 0.5, F is 0 by this
-			 *        calculation.
-			 */
-			recv_margin = abs((500 -
-					DIV_ROUND_CLOSEST(1000, sr << 1)) / 10);
-			if (abs(min_err) > abs(err)) {
-				min_err = err;
-				recv_max_margin = recv_margin;
-			} else if ((min_err == err) &&
-				   (recv_margin > recv_max_margin))
-				recv_max_margin = recv_margin;
-			else
+			if (abs(err) >= abs(min_err))
 				continue;
 
+			min_err = err;
 			*brr = br - 1;
 			*srr = sr - 1;
 			*cks = c;
-- 
1.9.1
