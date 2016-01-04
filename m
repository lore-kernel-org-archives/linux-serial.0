From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/5] serial: sh-sci: Add more Serial Mode Register documentation
Date: Mon,  4 Jan 2016 14:45:18 +0100
Message-ID: <1451915122-30219-2-git-send-email-geert+renesas@glider.be>
References: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c |  2 +-
 drivers/tty/serial/sh-sci.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6571f4d944c26297..a7c062192e2d3130 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2091,7 +2091,7 @@ static void sci_reset(struct uart_port *port)
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
-	unsigned int baud, smr_val = 0, scr_val = 0, i;
+	unsigned int baud, smr_val = SCSMR_ASYNC, scr_val = 0, i;
 	unsigned int brr = 255, cks = 0, srr = 15, dl = 0, sccks = 0;
 	unsigned int brr1 = 255, cks1 = 0, srr1 = 15, dl1 = 0;
 	struct sci_port *s = to_sci_port(port);
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index fb176025042185c4..7a4fa185b93ef307 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -35,12 +35,27 @@ enum {
 
 
 /* SCSMR (Serial Mode Register) */
+#define SCSMR_C_A	BIT(7)	/* Communication Mode */
+#define SCSMR_CSYNC	BIT(7)	/*   - Clocked synchronous mode */
+#define SCSMR_ASYNC	0	/*   - Asynchronous mode */
 #define SCSMR_CHR	BIT(6)	/* 7-bit Character Length */
 #define SCSMR_PE	BIT(5)	/* Parity Enable */
 #define SCSMR_ODD	BIT(4)	/* Odd Parity */
 #define SCSMR_STOP	BIT(3)	/* Stop Bit Length */
 #define SCSMR_CKS	0x0003	/* Clock Select */
 
+/* Serial Mode Register, SCIFA/SCIFB only bits */
+#define SCSMR_CKEDG	BIT(12)	/* Transmit/Receive Clock Edge Select */
+#define SCSMR_SRC_MASK	0x0700	/* Sampling Control */
+#define SCSMR_SRC_16	0x0000	/* Sampling rate 1/16 */
+#define SCSMR_SRC_5	0x0100	/* Sampling rate 1/5 */
+#define SCSMR_SRC_7	0x0200	/* Sampling rate 1/7 */
+#define SCSMR_SRC_11	0x0300	/* Sampling rate 1/11 */
+#define SCSMR_SRC_13	0x0400	/* Sampling rate 1/13 */
+#define SCSMR_SRC_17	0x0500	/* Sampling rate 1/17 */
+#define SCSMR_SRC_19	0x0600	/* Sampling rate 1/19 */
+#define SCSMR_SRC_27	0x0700	/* Sampling rate 1/27 */
+
 /* Serial Control Register, SCIFA/SCIFB only bits */
 #define SCSCR_TDRQE	BIT(15)	/* Tx Data Transfer Request Enable */
 #define SCSCR_RDRQE	BIT(14)	/* Rx Data Transfer Request Enable */
-- 
1.9.1

