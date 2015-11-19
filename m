From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 15/25] serial: sh-sci: Replace struct sci_port_info by type/regtype encoding
Date: Thu, 19 Nov 2015 19:38:54 +0100
Message-ID: <1447958344-836-16-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Store the encoded port and register types directly in of_device_id.data,
instead of using a pointer to a structure.
This saves memory and simplifies the source code, especially when adding
more compatible entries later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 76738c9918885764..41351ae055de661f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2595,42 +2595,27 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
-struct sci_port_info {
-	unsigned int type;
-	unsigned int regtype;
-};
+
+#define SCI_OF_DATA(type, regtype)	(void *)((type) << 16 | (regtype))
+#define SCI_OF_TYPE(data)		((unsigned long)(data) >> 16)
+#define SCI_OF_REGTYPE(data)		((unsigned long)(data) & 0xffff)
 
 static const struct of_device_id of_sci_match[] = {
 	{
 		.compatible = "renesas,scif",
-		.data = &(const struct sci_port_info) {
-			.type = PORT_SCIF,
-			.regtype = SCIx_SH4_SCIF_REGTYPE,
-		},
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_REGTYPE),
 	}, {
 		.compatible = "renesas,scifa",
-		.data = &(const struct sci_port_info) {
-			.type = PORT_SCIFA,
-			.regtype = SCIx_SCIFA_REGTYPE,
-		},
+		.data = SCI_OF_DATA(PORT_SCIFA, SCIx_SCIFA_REGTYPE),
 	}, {
 		.compatible = "renesas,scifb",
-		.data = &(const struct sci_port_info) {
-			.type = PORT_SCIFB,
-			.regtype = SCIx_SCIFB_REGTYPE,
-		},
+		.data = SCI_OF_DATA(PORT_SCIFB, SCIx_SCIFB_REGTYPE),
 	}, {
 		.compatible = "renesas,hscif",
-		.data = &(const struct sci_port_info) {
-			.type = PORT_HSCIF,
-			.regtype = SCIx_HSCIF_REGTYPE,
-		},
+		.data = SCI_OF_DATA(PORT_HSCIF, SCIx_HSCIF_REGTYPE),
 	}, {
 		.compatible = "renesas,sci",
-		.data = &(const struct sci_port_info) {
-			.type = PORT_SCI,
-			.regtype = SCIx_SCI_REGTYPE,
-		},
+		.data = SCI_OF_DATA(PORT_SCI, SCIx_SCI_REGTYPE),
 	}, {
 		/* Terminator */
 	},
@@ -2642,7 +2627,6 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
-	const struct sci_port_info *info;
 	struct plat_sci_port *p;
 	int id;
 
@@ -2653,8 +2637,6 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	if (!match)
 		return NULL;
 
-	info = match->data;
-
 	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
 	if (!p)
 		return NULL;
@@ -2669,8 +2651,8 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	*dev_id = id;
 
 	p->flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
-	p->type = info->type;
-	p->regtype = info->regtype;
+	p->type = SCI_OF_TYPE(match->data);
+	p->regtype = SCI_OF_REGTYPE(match->data);
 	p->scscr = SCSCR_RE | SCSCR_TE;
 
 	return p;
-- 
1.9.1
