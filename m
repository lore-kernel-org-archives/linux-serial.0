From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Date: Thu, 24 Apr 2014 15:54:44 +0900
Message-ID: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-serial@vger.kernel.org

According to the platform data for the legacy-C initialisation of sh-sci
for the r8a7779 SoC and my own testing the SCIx_SH4_SCIF_REGTYPE bit of
scscr needs to be set.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

With the approach taken by this patch sh-sci may be initialised using the
"renesas,scif-r8a7779" compat string but not the generic "renesas,scif"
compat string.  An alternate approach would be to add a binding to allow
setting of this bit to be controlled directly from DT.
---
 .../devicetree/bindings/serial/renesas,sci-serial.txt          |  1 +
 drivers/tty/serial/sh-sci.c                                    | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 53e6c17..bba86de 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -12,6 +12,7 @@ Required properties:
     - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
     - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
     - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
+    - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 88236da..3b5d2f6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2419,6 +2419,7 @@ static int sci_remove(struct platform_device *dev)
 struct sci_port_info {
 	unsigned int type;
 	unsigned int regtype;
+	unsigned int scscr_extra;
 };
 
 static const struct of_device_id of_sci_match[] = {
@@ -2429,6 +2430,13 @@ static const struct of_device_id of_sci_match[] = {
 			.regtype = SCIx_SH4_SCIF_REGTYPE,
 		},
 	}, {
+		.compatible = "renesas,scif-r8a7779",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_SCIF,
+			.regtype = SCIx_SH4_SCIF_REGTYPE,
+			.scscr_extra = SCSCR_CKE1,
+		},
+	}, {
 		.compatible = "renesas,scifa",
 		.data = &(const struct sci_port_info) {
 			.type = PORT_SCIFA,
@@ -2488,7 +2496,7 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	p->flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	p->type = info->type;
 	p->regtype = info->regtype;
-	p->scscr = SCSCR_RE | SCSCR_TE;
+	p->scscr = SCSCR_RE | SCSCR_TE | info->scscr_extra;
 
 	return p;
 }
-- 
1.8.5.2

