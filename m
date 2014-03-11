From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/4] serial: sh-sci: Replace hardcoded 3 by UART_PM_STATE_OFF
Date: Tue, 11 Mar 2014 11:11:20 +0100
Message-ID: <1394532680-4264-4-git-send-email-geert@linux-m68k.org>
References: <1394532680-4264-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394532680-4264-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e0c7db0027b7..cceaaee2b585 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1955,7 +1955,7 @@ static void sci_pm(struct uart_port *port, unsigned int state,
 	struct sci_port *sci_port = to_sci_port(port);
 
 	switch (state) {
-	case 3:
+	case UART_PM_STATE_OFF:
 		sci_port_disable(sci_port);
 		break;
 	default:
-- 
1.7.9.5
