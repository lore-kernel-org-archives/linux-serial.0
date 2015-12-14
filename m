From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 19/27] serial: sh-sci: Correct SCIF type on RZ/A1H
Date: Mon, 14 Dec 2015 19:57:28 +0100
Message-ID: <1450119456-964-20-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Reviewed-by, Acked-by.
---
 drivers/tty/serial/sh-sci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 13c6abe9d842c0a8..5b8504bfd42e9906 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2620,6 +2620,12 @@ static int sci_remove(struct platform_device *dev)
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

