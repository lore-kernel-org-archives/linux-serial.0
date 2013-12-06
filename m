From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 02/47] serial: sh-sci: Convert to clk_prepare/unprepare
Date: Fri,  6 Dec 2013 10:59:09 +0100
Message-ID: <1386323994-12850-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e3384a2..07a5da4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -421,9 +421,9 @@ static void sci_port_enable(struct sci_port *sci_port)
 
 	pm_runtime_get_sync(sci_port->port.dev);
 
-	clk_enable(sci_port->iclk);
+	clk_prepare_enable(sci_port->iclk);
 	sci_port->port.uartclk = clk_get_rate(sci_port->iclk);
-	clk_enable(sci_port->fclk);
+	clk_prepare_enable(sci_port->fclk);
 }
 
 static void sci_port_disable(struct sci_port *sci_port)
@@ -439,8 +439,8 @@ static void sci_port_disable(struct sci_port *sci_port)
 	del_timer_sync(&sci_port->break_timer);
 	sci_port->break_flag = 0;
 
-	clk_disable(sci_port->fclk);
-	clk_disable(sci_port->iclk);
+	clk_disable_unprepare(sci_port->fclk);
+	clk_disable_unprepare(sci_port->iclk);
 
 	pm_runtime_put_sync(sci_port->port.dev);
 }
-- 
1.8.3.2

