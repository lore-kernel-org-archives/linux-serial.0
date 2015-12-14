From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 11/27] serial: sh-sci: Make unsigned values in sci_baud_calc_hscif() unsigned
Date: Mon, 14 Dec 2015 19:57:20 +0100
Message-ID: <1450119456-964-12-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Move the -1 offset of br to the assignment to *brr, so br cannot become
negative anymore, and update the clamp() call. Now all unsigned values
in sci_baud_calc_hscif() can become unsigned.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b9eb4b525c0a7571..77e0a582da44947f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1870,7 +1870,8 @@ static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 				unsigned int *srr, unsigned int *cks)
 {
-	int sr, c, br, err, recv_margin;
+	unsigned int sr, br, c;
+	int err, recv_margin;
 	int min_err = 1000; /* 100% */
 	int recv_max_margin = 0;
 
@@ -1880,9 +1881,9 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 		for (c = 0; c <= 3; c++) {
 			/* integerized formulas from HSCIF documentation */
 			br = DIV_ROUND_CLOSEST(freq, (sr *
-					      (1 << (2 * c + 1)) * bps)) - 1;
-			br = clamp(br, 0, 255);
-			err = DIV_ROUND_CLOSEST(freq, ((br + 1) * bps * sr *
+					      (1 << (2 * c + 1)) * bps));
+			br = clamp(br, 1U, 256U);
+			err = DIV_ROUND_CLOSEST(freq, (br * bps * sr *
 					       (1 << (2 * c + 1)) / 1000)) -
 					       1000;
 			/* Calc recv margin
@@ -1908,7 +1909,7 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq, int *brr,
 			else
 				continue;
 
-			*brr = br;
+			*brr = br - 1;
 			*srr = sr - 1;
 			*cks = c;
 		}
-- 
1.9.1

