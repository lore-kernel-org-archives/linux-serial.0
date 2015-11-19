From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 03/25] serial: sh-sci: Drop useless check for zero sampling_rate
Date: Thu, 19 Nov 2015 19:38:42 +0100
Message-ID: <1447958344-836-4-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

sci_port.sampling_rate is always non-zero, except for HSCIF, which uses
sci_baud_calc_hscif() instead of sci_scbrr_calc().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bee5b7025adf45a2..ae136a1632e6298d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1863,13 +1863,7 @@ static void sci_shutdown(struct uart_port *port)
 static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 				   unsigned long freq)
 {
-	if (s->sampling_rate)
-		return DIV_ROUND_CLOSEST(freq, s->sampling_rate * bps) - 1;
-
-	/* Warn, but use a safe default */
-	WARN_ON(1);
-
-	return ((freq + 16 * bps) / (32 * bps) - 1);
+	return DIV_ROUND_CLOSEST(freq, s->sampling_rate * bps) - 1;
 }
 
 /* calculate frame length from SMR */
-- 
1.9.1
