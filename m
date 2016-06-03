From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 06/11] serial: sh-sci: Add more Serial Port Register documentation
Date: Fri,  3 Jun 2016 12:00:06 +0200
Message-ID: <1464948011-377-7-git-send-email-geert+renesas@glider.be>
References: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Improve documentation for the (H)SCIF Serial Port Register:
  - Make it clear the RTS and CTS lines are active-low,
  - Document the bits related to the serial port's clock pin.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
v3:
  - Add Reviewed-by,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 7a4fa185b93ef307..85a2b81ba0a845e5 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -108,10 +108,12 @@ enum {
 #define SCLSR_ORER	BIT(0)	/* Overrun Error */
 
 /* SCSPTR (Serial Port Register), optional */
-#define SCSPTR_RTSIO	BIT(7)	/* Serial Port RTS Pin Input/Output */
-#define SCSPTR_RTSDT	BIT(6)	/* Serial Port RTS Pin Data */
-#define SCSPTR_CTSIO	BIT(5)	/* Serial Port CTS Pin Input/Output */
-#define SCSPTR_CTSDT	BIT(4)	/* Serial Port CTS Pin Data */
+#define SCSPTR_RTSIO	BIT(7)	/* Serial Port RTS# Pin Input/Output */
+#define SCSPTR_RTSDT	BIT(6)	/* Serial Port RTS# Pin Data */
+#define SCSPTR_CTSIO	BIT(5)	/* Serial Port CTS# Pin Input/Output */
+#define SCSPTR_CTSDT	BIT(4)	/* Serial Port CTS# Pin Data */
+#define SCSPTR_SCKIO	BIT(3)	/* Serial Port Clock Pin Input/Output */
+#define SCSPTR_SCKDT	BIT(2)	/* Serial Port Clock Pin Data */
 #define SCSPTR_SPB2IO	BIT(1)	/* Serial Port Break Input/Output */
 #define SCSPTR_SPB2DT	BIT(0)	/* Serial Port Break Data */
 
-- 
1.9.1
