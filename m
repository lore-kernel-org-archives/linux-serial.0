From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 10/13] serial: sh-sci: Remove obsolete comment about overrun detection
Date: Thu, 30 Apr 2015 18:21:34 +0200
Message-ID: <1430410897-12770-11-git-send-email-geert+renesas@glider.be>
References: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The code it refers to was removed in commit b545e4f40613be70 ("serial:
sh-sci: Compute overrun_bit without using baud rate algo").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c3e884dd925f43a4..b74a644e4b044b8b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2315,11 +2315,6 @@ static int sci_init_single(struct platform_device *dev,
 			SCI_DEFAULT_ERROR_MASK : SCIF_DEFAULT_ERROR_MASK;
 
 	/*
-	 * Establish sensible defaults for the overrun detection, unless
-	 * the part has explicitly disabled support for it.
-	 */
-
-	/*
 	 * Make the error mask inclusive of overrun detection, if
 	 * supported.
 	 */
-- 
1.9.1

