From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 02/33] serial: sh-sci: Prevent compiler warnings on 64-bit
Date: Fri, 21 Aug 2015 20:02:26 +0200
Message-ID: <1440180177-6924-3-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Expressions involving "BIT(...)" create values of type "long", which is
64-bit on 64-bit.  Hence "~BIT(...)" no longer fits in 32-bit, which
will cause future compiler warnings when assigning to 32-bit variables:

    drivers/tty/serial/sh-sci.c: In function 'sci_init_single':
    drivers/tty/serial/sh-sci.h:58:25: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     #define SCI_ERROR_CLEAR ~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER)
			     ^
    drivers/tty/serial/sh-sci.c:2325:27: note: in expansion of macro 'SCI_ERROR_CLEAR'
       sci_port->error_clear = SCI_ERROR_CLEAR;

As these values are (at most) 32-bit register values anyway, cast them
to "u32" at the definition level to prevent such compiler warnings.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/tty/serial/sh-sci.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 1e1edbd152673e8f..fe7108bc022a495a 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -54,10 +54,10 @@ enum {
 
 #define SCI_DEFAULT_ERROR_MASK (SCI_PER | SCI_FER)
 
-#define SCI_RDxF_CLEAR	~(SCI_RESERVED | SCI_RDRF)
-#define SCI_ERROR_CLEAR	~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER)
-#define SCI_TDxE_CLEAR	~(SCI_RESERVED | SCI_TEND | SCI_TDRE)
-#define SCI_BREAK_CLEAR	~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER)
+#define SCI_RDxF_CLEAR	(u32)(~(SCI_RESERVED | SCI_RDRF))
+#define SCI_ERROR_CLEAR	(u32)(~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER))
+#define SCI_TDxE_CLEAR	(u32)(~(SCI_RESERVED | SCI_TEND | SCI_TDRE))
+#define SCI_BREAK_CLEAR	(u32)(~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER))
 
 /* SCxSR (Serial Status Register) on SCIF, SCIFA, SCIFB, HSCIF */
 #define SCIF_ER		BIT(7)	/* Receive Error */
@@ -76,10 +76,10 @@ enum {
 
 #define SCIF_DEFAULT_ERROR_MASK (SCIF_PER | SCIF_FER | SCIF_BRK | SCIF_ER)
 
-#define SCIF_RDxF_CLEAR		~(SCIF_DR | SCIF_RDF)
-#define SCIF_ERROR_CLEAR	~(SCIFA_ORER | SCIF_PER | SCIF_FER | SCIF_ER)
-#define SCIF_TDxE_CLEAR		~(SCIF_TDFE)
-#define SCIF_BREAK_CLEAR	~(SCIF_PER | SCIF_FER | SCIF_BRK)
+#define SCIF_RDxF_CLEAR		(u32)(~(SCIF_DR | SCIF_RDF))
+#define SCIF_ERROR_CLEAR	(u32)(~(SCIFA_ORER | SCIF_PER | SCIF_FER | SCIF_ER))
+#define SCIF_TDxE_CLEAR		(u32)(~(SCIF_TDFE))
+#define SCIF_BREAK_CLEAR	(u32)(~(SCIF_PER | SCIF_FER | SCIF_BRK))
 
 /* SCFCR (FIFO Control Register) */
 #define SCFCR_MCE	BIT(3)	/* Modem Control Enable */
-- 
1.9.1

