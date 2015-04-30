From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 12/13] serial: sh-sci: Correct SCIF_ERROR_CLEAR for plain SCIF
Date: Thu, 30 Apr 2015 18:21:36 +0200
Message-ID: <1430410897-12770-13-git-send-email-geert+renesas@glider.be>
References: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

SCIF_ERROR_CLEAR includes SCIFA_ORER, which exists only on SCIFA/SCIFB
and SCIF on sh7705/sh7720/sh7721.

To fix this:
  1. Remove SCIFA_ORER from the definition of SCIF_ERROR_CLEAR,
  2. During initialization, store the error clear mask to use,
     incorporating the overrun bit only if it applies to the SCxSR
     register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 14 +++++++++++---
 drivers/tty/serial/sh-sci.h |  4 ++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 67f796b3f4d51a97..f1591b243bccb2bf 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -84,6 +84,7 @@ struct sci_port {
 	unsigned int		overrun_reg;
 	unsigned int		overrun_mask;
 	unsigned int		error_mask;
+	unsigned int		error_clear;
 	unsigned int		sampling_rate;
 
 
@@ -2327,15 +2328,22 @@ static int sci_init_single(struct platform_device *dev,
 	/*
 	 * Establish some sensible defaults for the error detection.
 	 */
-	sci_port->error_mask = (p->type == PORT_SCI) ?
-			SCI_DEFAULT_ERROR_MASK : SCIF_DEFAULT_ERROR_MASK;
+	if (p->type == PORT_SCI) {
+		sci_port->error_mask = SCI_DEFAULT_ERROR_MASK;
+		sci_port->error_clear = SCI_ERROR_CLEAR;
+	} else {
+		sci_port->error_mask = SCIF_DEFAULT_ERROR_MASK;
+		sci_port->error_clear = SCIF_ERROR_CLEAR;
+	}
 
 	/*
 	 * Make the error mask inclusive of overrun detection, if
 	 * supported.
 	 */
-	if (sci_port->overrun_reg == SCxSR)
+	if (sci_port->overrun_reg == SCxSR) {
 		sci_port->error_mask |= sci_port->overrun_mask;
+		sci_port->error_clear &= ~sci_port->overrun_mask;
+	}
 
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | p->flags;
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 1e1edbd152673e8f..09995f896acd267b 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -77,7 +77,7 @@ enum {
 #define SCIF_DEFAULT_ERROR_MASK (SCIF_PER | SCIF_FER | SCIF_BRK | SCIF_ER)
 
 #define SCIF_RDxF_CLEAR		~(SCIF_DR | SCIF_RDF)
-#define SCIF_ERROR_CLEAR	~(SCIFA_ORER | SCIF_PER | SCIF_FER | SCIF_ER)
+#define SCIF_ERROR_CLEAR	~(SCIF_PER | SCIF_FER | SCIF_ER)
 #define SCIF_TDxE_CLEAR		~(SCIF_TDFE)
 #define SCIF_BREAK_CLEAR	~(SCIF_PER | SCIF_FER | SCIF_BRK)
 
@@ -122,7 +122,7 @@ enum {
 #define SCxSR_RDxF_CLEAR(port) \
 	(((port)->type == PORT_SCI) ? SCI_RDxF_CLEAR : SCIF_RDxF_CLEAR)
 #define SCxSR_ERROR_CLEAR(port) \
-	(((port)->type == PORT_SCI) ? SCI_ERROR_CLEAR : SCIF_ERROR_CLEAR)
+	(to_sci_port(port)->error_clear)
 #define SCxSR_TDxE_CLEAR(port) \
 	(((port)->type == PORT_SCI) ? SCI_TDxE_CLEAR : SCIF_TDxE_CLEAR)
 #define SCxSR_BREAK_CLEAR(port) \
-- 
1.9.1

