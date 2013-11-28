From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 16/16] serial: sh-sci: Remove platform data scbrr_algo_id field
Date: Thu, 28 Nov 2013 22:43:30 +0100
Message-ID: <1385675010-26904-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35261 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab3K1Vne (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 16:43:34 -0500
In-Reply-To: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org

The field isn't set by any board, remote it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 26 +++++---------------------
 include/linux/serial_sci.h  | 10 ----------
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c65d37b..0bdbde1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1770,17 +1770,6 @@ static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 	if (s->sampling_rate)
 		return DIV_ROUND_CLOSEST(freq, s->sampling_rate * bps) - 1;
 
-	switch (s->cfg->scbrr_algo_id) {
-	case SCBRR_ALGO_1:
-		return freq / (16 * bps);
-	case SCBRR_ALGO_2:
-		return DIV_ROUND_CLOSEST(freq, 32 * bps) - 1;
-	case SCBRR_ALGO_3:
-		return freq / (8 * bps);
-	case SCBRR_ALGO_4:
-		return DIV_ROUND_CLOSEST(freq, 16 * bps) - 1;
-	}
-
 	/* Warn, but use a safe default */
 	WARN_ON(1);
 
@@ -2180,17 +2169,12 @@ static int sci_init_single(struct platform_device *dev,
 		break;
 	}
 
-	/* Set the sampling rate if the baud rate calculation algorithm isn't
-	 * specified.
+	/* SCIFA on sh7723 and sh7724 need a custom sampling rate that doesn't
+	 * match the SoC datasheet, this should be investigated. Let platform
+	 * data override the sampling rate for now.
 	 */
-	if (p->scbrr_algo_id == SCBRR_ALGO_NONE) {
-		/* SCIFA on sh7723 and sh7724 need a custom sampling rate that
-		 * doesn't match the SoC datasheet, this should be investigated.
-		 * Let platform data override the sampling rate for now.
-		 */
-		sci_port->sampling_rate = p->sampling_rate ? p->sampling_rate
-					: sampling_rate;
-	}
+	sci_port->sampling_rate = p->sampling_rate ? p->sampling_rate
+				: sampling_rate;
 
 	if (!early) {
 		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 06dc806..22b3640 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -10,15 +10,6 @@
 
 #define SCIx_NOT_SUPPORTED	(-1)
 
-enum {
-	SCBRR_ALGO_NONE,	/* Compute sampling rate in the driver */
-	SCBRR_ALGO_1,		/* clk / (16 * bps) */
-	SCBRR_ALGO_2,		/* DIV_ROUND_CLOSEST(clk, 32 * bps) - 1 */
-	SCBRR_ALGO_3,		/* clk / (8 * bps) */
-	SCBRR_ALGO_4,		/* DIV_ROUND_CLOSEST(clk, 16 * bps) - 1 */
-	SCBRR_ALGO_6,		/* HSCIF variable sample rate algorithm */
-};
-
 #define SCSCR_TIE	(1 << 7)
 #define SCSCR_RIE	(1 << 6)
 #define SCSCR_TE	(1 << 5)
@@ -110,7 +101,6 @@ struct plat_sci_port {
 	unsigned long	capabilities;		/* Port features/capabilities */
 
 	unsigned int	sampling_rate;
-	unsigned int	scbrr_algo_id;		/* SCBRR calculation algo */
 	unsigned int	scscr;			/* SCSCR initialization */
 
 	/*
-- 
1.8.3.2

