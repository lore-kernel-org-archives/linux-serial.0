From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v4 02/29] serial: sh-sci: Remove baud rate calculation algorithm 5
Date: Thu, 28 Nov 2013 00:18:12 +0100
Message-ID: <1385594319-5758-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385594319-5758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

The algorithm isn't used, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 2 --
 include/linux/serial_sci.h  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 10c98b1..277b669 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1820,8 +1820,6 @@ static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
 		return (((freq * 2) + 16 * bps) / (16 * bps) - 1);
 	case SCBRR_ALGO_4:
 		return (((freq * 2) + 16 * bps) / (32 * bps) - 1);
-	case SCBRR_ALGO_5:
-		return (((freq * 1000 / 32) / bps) - 1);
 	}
 
 	/* Warn, but use a safe default */
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 50fe651..babc5fe 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -15,7 +15,6 @@ enum {
 	SCBRR_ALGO_2,		/* ((clk + 16 * bps) / (32 * bps) - 1) */
 	SCBRR_ALGO_3,		/* (((clk * 2) + 16 * bps) / (16 * bps) - 1) */
 	SCBRR_ALGO_4,		/* (((clk * 2) + 16 * bps) / (32 * bps) - 1) */
-	SCBRR_ALGO_5,		/* (((clk * 1000 / 32) / bps) - 1) */
 	SCBRR_ALGO_6,		/* HSCIF variable sample rate algorithm */
 };
 
-- 
1.8.3.2

