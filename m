From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH 08/10] serial: sh-sci: fix common SCIFB regmap definition
Date: Wed, 07 Nov 2012 16:00:28 +0900
Message-ID: <509A070C.5040801@renesas.com>
References: <509A0658.1010503@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <509A0658.1010503@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, takashi.yoshii.zj@renesas.com, alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: rjw@sisk.pl, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

About FIFO count, there are two variants of SCIFs which show
a) TX count in upper, RX count in lower byte of FDR register
b) TX count in TFDR register, RX count in RFDR register

Common SCIFB regmap in current source code is defined as "a".
At least 7372 and 73a0 HW manual say their SICFB are "b".

This patch alters the definition to "b", considering the current
one has come from a mistake. The reason is as follows.

The flag SCIFB sh-sci driver means it has 256 byte FIFO.
The count is from 0(empty) to 256(full), that makes 9-bit.
Because FDR is 16-bit register, it can not hold two 9-bits.
That's why, SCIFB can not be "a".

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 63a3bd0..502fa47 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -196,9 +196,9 @@ static struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 		[SCxSR]		= { 0x14, 16 },
 		[SCxRDR]	= { 0x60,  8 },
 		[SCFCR]		= { 0x18, 16 },
-		[SCFDR]		= { 0x1c, 16 },
-		[SCTFDR]	= sci_reg_invalid,
-		[SCRFDR]	= sci_reg_invalid,
+		[SCFDR]		= sci_reg_invalid,
+		[SCTFDR]	= { 0x38, 16 },
+		[SCRFDR]	= { 0x3c, 16 },
 		[SCSPTR]	= sci_reg_invalid,
 		[SCLSR]		= sci_reg_invalid,
 	},
-- 
1.7.12.4

