From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH] serial: sh-sci: suppress warning for ports without dma channels
Date: Fri, 22 Sep 2017 20:29:30 +0200
Message-ID: <20170922182930.26543-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Andy Lowe <andy_lowe@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Andy Lowe <andy_lowe@mentor.com>

If a port has no dma channel defined in the device tree, then
don't attempt to allocate a dma channel for the port.
Also suppress the warning message concerning the failure to allocate
a dma channel.  Continue to emit the warning message if a dma
channel is defined but cannot be allocated.

Signed-off-by: Andy Lowe <andy_lowe@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/tty/serial/sh-sci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 945a0b04c37c..ab8a7ea7062f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1490,6 +1490,14 @@ static void sci_request_dma(struct uart_port *port)
 		return;
 
 	s->cookie_tx = -EINVAL;
+
+	/*
+	 * Don't request a dma channel if no channel was specified
+	 * in the device tree.
+	 */
+	if (!of_find_property(port->dev->of_node, "dmas", NULL))
+		return;
+
 	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV);
 	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
 	if (chan) {
-- 
2.14.1
