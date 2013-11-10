From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 03/29] serial: sh-sci: Simplify baud rate calculation algorithms
Date: Sun, 10 Nov 2013 04:33:15 +0100
Message-ID: <1384054421-13357-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Rewrite the baud rate register value calculations in easier to read
forms. The computed value isn't modified.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 8 ++++----
 include/linux/serial_sci.h  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 2fc1a0e..91ce9214b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1813,13 +1813,13 @@ static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
 {
 	switch (algo_id) {
 	case SCBRR_ALGO_1:
-		return ((freq + 16 * bps) / (16 * bps) - 1);
+		return freq / (16 * bps);
 	case SCBRR_ALGO_2:
-		return ((freq + 16 * bps) / (32 * bps) - 1);
+		return DIV_ROUND_CLOSEST(freq, 32 * bps) - 1;
 	case SCBRR_ALGO_3:
-		return (((freq * 2) + 16 * bps) / (16 * bps) - 1);
+		return freq / (8 * bps);
 	case SCBRR_ALGO_4:
-		return (((freq * 2) + 16 * bps) / (32 * bps) - 1);
+		return DIV_ROUND_CLOSEST(freq, 16 * bps) - 1;
 	}
 
 	/* Warn, but use a safe default */
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 803068d..eb787d4 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -11,10 +11,10 @@
 #define SCIx_NOT_SUPPORTED	(-1)
 
 enum {
-	SCBRR_ALGO_1,		/* ((clk + 16 * bps) / (16 * bps) - 1) */
-	SCBRR_ALGO_2,		/* ((clk + 16 * bps) / (32 * bps) - 1) */
-	SCBRR_ALGO_3,		/* (((clk * 2) + 16 * bps) / (16 * bps) - 1) */
-	SCBRR_ALGO_4,		/* (((clk * 2) + 16 * bps) / (32 * bps) - 1) */
+	SCBRR_ALGO_1,		/* clk / (16 * bps) */
+	SCBRR_ALGO_2,		/* DIV_ROUND_CLOSEST(clk, 32 * bps) - 1 */
+	SCBRR_ALGO_3,		/* clk / (8 * bps) */
+	SCBRR_ALGO_4,		/* DIV_ROUND_CLOSEST(clk, 16 * bps) - 1 */
 	SCBRR_ALGO_6,		/* HSCIF variable sample rate algorithm */
 };
 
-- 
1.8.1.5

