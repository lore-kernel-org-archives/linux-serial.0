From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 07/11] serial: sh-sci: Add more Serial Port Control/Data Register documentation
Date: Fri,  3 Jun 2016 12:00:07 +0200
Message-ID: <1464948011-377-8-git-send-email-geert+renesas@glider.be>
References: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Improve documentation for the SCIFA/SCIFB Serial Port Control and Data
Registers:
  - State clearly that the RTS and CTS lines are active-low,
  - Document the bits related to the serial port's SCK, RXD, and TXD
    pins.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
v3:
  - Add Reviewed-by,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 85a2b81ba0a845e5..e7d2bc692a581e9e 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -121,12 +121,18 @@ enum {
 #define HSCIF_SRE	BIT(15)	/* Sampling Rate Register Enable */
 
 /* SCPCR (Serial Port Control Register), SCIFA/SCIFB only */
-#define SCPCR_RTSC	BIT(4)	/* Serial Port RTS Pin / Output Pin */
-#define SCPCR_CTSC	BIT(3)	/* Serial Port CTS Pin / Input Pin */
+#define SCPCR_RTSC	BIT(4)	/* Serial Port RTS# Pin / Output Pin */
+#define SCPCR_CTSC	BIT(3)	/* Serial Port CTS# Pin / Input Pin */
+#define SCPCR_SCKC	BIT(2)	/* Serial Port SCK Pin / Output Pin */
+#define SCPCR_RXDC	BIT(1)	/* Serial Port RXD Pin / Input Pin */
+#define SCPCR_TXDC	BIT(0)	/* Serial Port TXD Pin / Output Pin */
 
 /* SCPDR (Serial Port Data Register), SCIFA/SCIFB only */
-#define SCPDR_RTSD	BIT(4)	/* Serial Port RTS Output Pin Data */
-#define SCPDR_CTSD	BIT(3)	/* Serial Port CTS Input Pin Data */
+#define SCPDR_RTSD	BIT(4)	/* Serial Port RTS# Output Pin Data */
+#define SCPDR_CTSD	BIT(3)	/* Serial Port CTS# Input Pin Data */
+#define SCPDR_SCKD	BIT(2)	/* Serial Port SCK Output Pin Data */
+#define SCPDR_RXDD	BIT(1)	/* Serial Port RXD Input Pin Data */
+#define SCPDR_TXDD	BIT(0)	/* Serial Port TXD Output Pin Data */
 
 /*
  * BRG Clock Select Register (Some SCIF and HSCIF)
-- 
1.9.1
