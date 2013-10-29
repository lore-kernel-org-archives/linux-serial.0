From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/5] serial: sh-sci: Remove baud rate calculation algorithm 5
Date: Tue, 29 Oct 2013 11:29:56 +0100
Message-ID: <1383042599-25151-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34720 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3J2K3j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Oct 2013 06:29:39 -0400
In-Reply-To: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

The algorithm isn't used, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 2 --
 include/linux/serial_sci.h  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 280753f..2fc1a0e 100644
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
index d340497..803068d 100644
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
1.8.1.5

