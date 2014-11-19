From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] serial: sh-sci: Change checking for error rate of HSCIF
Date: Thu, 20 Nov 2014 07:58:27 +0900
Message-ID: <1416437907-15160-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org
Cc: horms@verge.net.au, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
List-Id: linux-serial@vger.kernel.org

This changes negative values of error rate to be checked, because these
values are valid as error rate. And this changes in the process of adopting
a value close to 0.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3081e46..ae7ac07 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1812,9 +1812,6 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq,
 			err = DIV_ROUND_CLOSEST(freq, ((br + 1) * bps * sr *
 					       (1 << (2 * c + 1)) / 1000)) -
 					       1000;
-			if (err < 0)
-				continue;
-
 			/* Calc recv margin
 			 * M: Receive margin (%)
 			 * N: Ratio of bit rate to clock (N = sampling rate)
@@ -1829,7 +1826,7 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq,
 			 */
 			recv_margin = abs((500 -
 					DIV_ROUND_CLOSEST(1000, sr << 1)) / 10);
-			if (min_err > err) {
+			if (abs(min_err) > abs(err)) {
 				min_err = err;
 				recv_max_margin = recv_margin;
 			} else if ((min_err == err) &&
-- 
2.1.1

