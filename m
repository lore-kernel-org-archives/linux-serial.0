From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 1/7] serial: sh-sci: add FIFO trigger bits
Date: Fri,  9 Dec 2016 13:36:05 +0100
Message-ID: <1481286971-16667-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Defines the bits controlling FIFO thresholds, adds the additional
HSCIF registers to the register map.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 2 ++
 drivers/tty/serial/sh-sci.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4b26252..385afbe 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -377,6 +377,8 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCPDR]		= sci_reg_invalid,
 		[SCDL]		= { 0x30, 16 },
 		[SCCKS]		= { 0x34, 16 },
+		[HSRTRGR]	= { 0x54, 16 },
+		[HSTTRGR]	= { 0x58, 16 },
 	},
 
 	/*
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index ffa6d68..f51f919 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -29,6 +29,8 @@ enum {
 	SCPDR,				/* Serial Port Data Register */
 	SCDL,				/* BRG Frequency Division Register */
 	SCCKS,				/* BRG Clock Select Register */
+	HSRTRGR,			/* Receive FIFO Data Count Register */
+	HSTTRGR,			/* Transmit FIFO Data Count Register */
 
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
