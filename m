From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 02/13] serial: sh-sci: Add (H)SCIF RTS/CTS pin data register bit definitions
Date: Thu, 30 Apr 2015 18:21:26 +0200
Message-ID: <1430410897-12770-3-git-send-email-geert+renesas@glider.be>
References: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add the missing register bit definitions to set the RTS pin and read the
CTS pin on (H)SCIF.

Extracted from patches by Magnus Damm <damm+renesas@opensource.se>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 238ad0c5584b06f2..8b4447e66708aea5 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -70,7 +70,9 @@ enum {
 
 /* SCSPTR (Serial Port Register), optional */
 #define SCSPTR_RTSIO	(1 << 7)	/* Serial Port RTS Pin Input/Output */
+#define SCSPTR_RTSDT	(1 << 6)	/* Serial Port RTS Pin Data */
 #define SCSPTR_CTSIO	(1 << 5)	/* Serial Port CTS Pin Input/Output */
+#define SCSPTR_CTSDT	(1 << 4)	/* Serial Port CTS Pin Data */
 #define SCSPTR_SPB2IO	(1 << 1)	/* Serial Port Break Input/Output */
 #define SCSPTR_SPB2DT	(1 << 0)	/* Serial Port Break Data */
 
-- 
1.9.1

