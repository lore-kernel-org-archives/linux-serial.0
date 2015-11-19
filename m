From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 09/25] serial: sh-sci: Avoid overflow in sci_baud_calc_hscif()
Date: Thu, 19 Nov 2015 19:38:48 +0100
Message-ID: <1447958344-836-10-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

If bps >= 1048576, the multiplication of "(sr * (1 << (2 * c + 1))" and
"bps" will overflow, and both br and err will contain bogus values.
Skip the current and all higher clock select predividers when overflow
is detected.  Simplify the calculations using intermediates while we're
at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fba1e1eea15dc3a1..97a0f8ef5adc55a2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1870,7 +1870,7 @@ static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 				unsigned int *srr, unsigned int *cks)
 {
-	unsigned int sr, br, c;
+	unsigned int sr, br, a, b, c;
 	int err, recv_margin;
 	int min_err = 1000; /* 100% */
 	int recv_max_margin = 0;
@@ -1880,12 +1880,14 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 	for (sr = 8; sr <= 32; sr++) {
 		for (c = 0; c <= 3; c++) {
 			/* integerized formulas from HSCIF documentation */
-			br = DIV_ROUND_CLOSEST(freq, (sr *
-					      (1 << (2 * c + 1)) * bps));
+			a = sr * (1 << (2 * c + 1));
+			if (bps > UINT_MAX / a)
+				break;
+
+			b = a * bps;
+			br = DIV_ROUND_CLOSEST(freq, b);
 			br = clamp(br, 1U, 256U);
-			err = DIV_ROUND_CLOSEST(freq, (br * bps * sr *
-					       (1 << (2 * c + 1)) / 1000)) -
-					       1000;
+			err = DIV_ROUND_CLOSEST(freq, (br * b) / 1000) - 1000;
 			/* Calc recv margin
 			 * M: Receive margin (%)
 			 * N: Ratio of bit rate to clock (N = sampling rate)
-- 
1.9.1

