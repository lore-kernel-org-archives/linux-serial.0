From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 12/27] serial: sh-sci: Avoid overflow in sci_baud_calc_hscif()
Date: Mon, 14 Dec 2015 19:57:21 +0100
Message-ID: <1450119456-964-13-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

If bps >= 1048576, the multiplication of the predivider and "bps" will
overflow, and both br and err will contain bogus values.
Skip the current and all higher clock select predividers when overflow
is detected.  Simplify the calculations using intermediates while we're
at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Acked-by,
  - Rename intermediates to "prediv" and "scrate",
  - Add a comment explaining the calculation and possible overflow.
---
 drivers/tty/serial/sh-sci.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 77e0a582da44947f..c490c51d6032786b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1870,7 +1870,7 @@ static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 				unsigned int *srr, unsigned int *cks)
 {
-	unsigned int sr, br, c;
+	unsigned int sr, br, prediv, scrate, c;
 	int err, recv_margin;
 	int min_err = 1000; /* 100% */
 	int recv_max_margin = 0;
@@ -1880,12 +1880,25 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 	for (sr = 8; sr <= 32; sr++) {
 		for (c = 0; c <= 3; c++) {
 			/* integerized formulas from HSCIF documentation */
-			br = DIV_ROUND_CLOSEST(freq, (sr *
-					      (1 << (2 * c + 1)) * bps));
+			prediv = sr * (1 << (2 * c + 1));
+
+			/*
+			 * We need to calculate:
+			 *
+			 *     br = freq / (prediv * bps) clamped to [1..256]
+			 *     err = (freq / (br * prediv * bps / 1000)) - 1000
+			 *
+			 * Watch out for overflow when calculating the desired
+			 * sampling clock rate!
+			 */
+			if (bps > UINT_MAX / prediv)
+				break;
+
+			scrate = prediv * bps;
+			br = DIV_ROUND_CLOSEST(freq, scrate);
 			br = clamp(br, 1U, 256U);
-			err = DIV_ROUND_CLOSEST(freq, (br * bps * sr *
-					       (1 << (2 * c + 1)) / 1000)) -
-					       1000;
+			err = DIV_ROUND_CLOSEST(freq, (br * scrate) / 1000) -
+			      1000;
 			/* Calc recv margin
 			 * M: Receive margin (%)
 			 * N: Ratio of bit rate to clock (N = sampling rate)
-- 
1.9.1

