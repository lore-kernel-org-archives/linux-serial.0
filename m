From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v3 1/7] serial: sh-sci: add FIFO trigger bits
Date: Thu,  2 Feb 2017 18:10:14 +0100
Message-ID: <1486055420-31595-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1486055420-31595-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486055420-31595-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, gregkh@linuxfoundation.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Defines the bits controlling FIFO thresholds, adds the additional
HSCIF registers to the register map.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 2 ++
 drivers/tty/serial/sh-sci.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9bc9756..6085839 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -373,6 +373,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[HSSRR]		= { 0x40, 16 },
 			[SCDL]		= { 0x30, 16 },
 			[SCCKS]		= { 0x34, 16 },
+			[HSRTRGR]	= { 0x54, 16 },
+			[HSTTRGR]	= { 0x58, 16 },
 		},
 		.fifosize = 128,
 		.overrun_reg = SCLSR,
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 08073f0..30b6d67 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -29,6 +29,8 @@ enum {
 	SCPDR,				/* Serial Port Data Register */
 	SCDL,				/* BRG Frequency Division Register */
 	SCCKS,				/* BRG Clock Select Register */
+	HSRTRGR,			/* Rx FIFO Data Count Trigger Register */
+	HSTTRGR,			/* Tx FIFO Data Count Trigger Register */
 
 	SCIx_NR_REGS,
 };
@@ -99,6 +101,10 @@ enum {
 #define SCIF_BREAK_CLEAR	(u32)(~(SCIF_PER | SCIF_FER | SCIF_BRK))
 
 /* SCFCR (FIFO Control Register) */
+#define SCFCR_RTRG1	BIT(7)	/* Receive FIFO Data Count Trigger */
+#define SCFCR_RTRG0	BIT(6)
+#define SCFCR_TTRG1	BIT(5)	/* Transmit FIFO Data Count Trigger */
+#define SCFCR_TTRG0	BIT(4)
 #define SCFCR_MCE	BIT(3)	/* Modem Control Enable */
 #define SCFCR_TFRST	BIT(2)	/* Transmit FIFO Data Register Reset */
 #define SCFCR_RFRST	BIT(1)	/* Receive FIFO Data Register Reset */
-- 
2.7.4
