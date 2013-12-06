From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 04/47] serial: sh-sci: Remove baud rate calculation algorithm 5
Date: Fri,  6 Dec 2013 10:59:11 +0100
Message-ID: <1386323994-12850-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

The algorithm isn't used, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 2 --
 include/linux/serial_sci.h  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6211a2e..86b33f3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1824,8 +1824,6 @@ static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
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

