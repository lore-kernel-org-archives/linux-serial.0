From: "George G. Davis" <george_davis@mentor.com>
Subject: [PATCH v2] serial: sh-sci: disable DMA for uart_console
Date: Mon, 13 May 2019 11:47:26 -0400
Message-ID: <1557762446-23811-1-git-send-email-george_davis@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Andy Lowe <andy_lowe@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "George G. Davis" <george_davis@mentor.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

As noted in commit 84b40e3b57ee ("serial: 8250: omap: Disable DMA for
console UART"), UART console lines use low-level PIO only access functions
which will conflict with use of the line when DMA is enabled, e.g. when
the console line is also used for systemd messages. So disable DMA
support for UART console lines.

Fixes: https://patchwork.kernel.org/patch/10929511/
Reported-by: Michael Rodin <mrodin@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: stable@vger.kernel.org
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
v2: Clarify comment regarding DMA support on kernel console,
    add {Tested,Reviewed}-by:, and Cc: linux-stable lines.
---
 drivers/tty/serial/sh-sci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3cd139752d3f..abc705716aa0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1557,6 +1557,13 @@ static void sci_request_dma(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s: port %d\n", __func__, port->line);
 
+	/*
+	 * DMA on console may interfere with Kernel log messages which use
+	 * plain putchar(). So, simply don't use it with a console.
+	 */
+	if (uart_console(port))
+		return;
+
 	if (!port->dev->of_node)
 		return;
 
-- 
2.7.4
