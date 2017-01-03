From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 02/19] serial: sh-sci: Don't rely on platform data flags when not needed
Date: Wed,  4 Jan 2017 01:06:22 +0200
Message-ID: <20170103230639.19660-3-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The UPF_BOOT_AUTOCONF platform data flag is set by all platforms,
hardcode it.

The UPF_IOREMAP flag is set by a single SH platform and thus needs to be
kept. However, for ARM platforms, we can base the decision on whether an
OF node is present and bypass the platform data flags completely.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1e573611719e..8c58c43fc85d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2453,7 +2453,7 @@ static int sci_remap_port(struct uart_port *port)
 	if (port->membase)
 		return 0;
 
-	if (port->flags & UPF_IOREMAP) {
+	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
 		port->membase = ioremap_nocache(port->mapbase, sport->reg_size);
 		if (unlikely(!port->membase)) {
 			dev_err(port->dev, "can't remap port#%d\n", port->line);
@@ -2475,7 +2475,7 @@ static void sci_release_port(struct uart_port *port)
 {
 	struct sci_port *sport = to_sci_port(port);
 
-	if (port->flags & UPF_IOREMAP) {
+	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
 		iounmap(port->membase);
 		port->membase = NULL;
 	}
@@ -2731,7 +2731,7 @@ static int sci_init_single(struct platform_device *dev,
 	}
 
 	port->type		= p->type;
-	port->flags		= UPF_FIXED_PORT | p->flags;
+	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
 	port->regshift		= p->regshift;
 
 	/*
@@ -2993,7 +2993,6 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 
 	*dev_id = id;
 
-	p->flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	p->type = SCI_OF_TYPE(match->data);
 	p->regtype = SCI_OF_REGTYPE(match->data);
 
-- 
Regards,

Laurent Pinchart

