From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 3/5] serial: sh-sci: Simplify baud rate calculation algorithms
Date: Tue, 29 Oct 2013 11:29:57 +0100
Message-ID: <1383042599-25151-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34723 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab3J2K3j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Oct 2013 06:29:39 -0400
In-Reply-To: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

Rewrite the baud rate register value calculations in easier to read
forms. The computed value isn't modified.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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

