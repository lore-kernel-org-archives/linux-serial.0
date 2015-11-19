From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 16/25] serial: sh-sci: Correct SCIF type on RZ/A1H
Date: Thu, 19 Nov 2015 19:38:55 +0100
Message-ID: <1447958344-836-17-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The "renesas,scif" compatible value is currently used for the SCIF
variant in all Renesas SoCs of the R-Car and RZ families.  However, the
variant used in the RZ family is not the common "SH-4(A)" variant, but
the "SH-2(A) with FIFO data count register" variant, as it has the
"Serial Extension Mode Register" (SCEMR), just like on sh7203, sh7263,
sh7264, and sh7269.

Use the (already documented) SoC-specific "renesas,scif-r7s72100"
compatible value to differentiate.  The "renesas,scif" compatible value
can still be used as a common denominator for SCIF variants with the
"SH-4(A)" register layout (i.e. ignoring the SCEMR register).
Note that currently both variants are treated the same, but this may
change if support for the SCEMR register is ever added.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 41351ae055de661f..b0127f38af744fcf 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2601,6 +2601,12 @@ static int sci_remove(struct platform_device *dev)
 #define SCI_OF_REGTYPE(data)		((unsigned long)(data) & 0xffff)
 
 static const struct of_device_id of_sci_match[] = {
+	/* SoC-specific types */
+	{
+		.compatible = "renesas,scif-r7s72100",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH2_SCIF_FIFODATA_REGTYPE),
+	},
+	/* Generic types */
 	{
 		.compatible = "renesas,scif",
 		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_REGTYPE),
-- 
1.9.1
