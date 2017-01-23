From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 2/7] serial: sh-sci: consider DR (data ready) bit adequately
Date: Mon, 23 Jan 2017 17:04:13 +0100
Message-ID: <1485187458-8195-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

To allow operation with a higher RX FIFO interrupt threshold in PIO
mode, it is necessary to consider the DR bit ("FIFO not full, but no
data received for 1.5 frames") as an indicator that data can be read.
Otherwise the driver will let data rot in the FIFO until the threshold
is reached.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 2c45e79..9323735 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -151,7 +151,7 @@ enum {
 #define SCCKS_XIN	BIT(14)	/* SC_CLK uses bus clock (1) or SCIF_CLK (0) */
 
 #define SCxSR_TEND(port)	(((port)->type == PORT_SCI) ? SCI_TEND   : SCIF_TEND)
-#define SCxSR_RDxF(port)	(((port)->type == PORT_SCI) ? SCI_RDRF   : SCIF_RDF)
+#define SCxSR_RDxF(port)	(((port)->type == PORT_SCI) ? SCI_RDRF   : SCIF_DR | SCIF_RDF)
 #define SCxSR_TDxE(port)	(((port)->type == PORT_SCI) ? SCI_TDRE   : SCIF_TDFE)
 #define SCxSR_FER(port)		(((port)->type == PORT_SCI) ? SCI_FER    : SCIF_FER)
 #define SCxSR_PER(port)		(((port)->type == PORT_SCI) ? SCI_PER    : SCIF_PER)
-- 
2.7.4
