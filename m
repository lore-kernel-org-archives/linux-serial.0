From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [PATCH 1/1] serial/imx: fail startup if DMA initialization fails
Date: Wed,  3 Aug 2016 15:20:25 +0200
Message-ID: <1470230426-26153-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Hannu Koivisto <hannu.koivisto@vincit.fi>, Martyn Welch <martyn.welch@collabora.co.uk>, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Hannu Koivisto <hannu.koivisto@vincit.fi>

[Ported to newer kernel and added description by Martyn Welch
<martyn.welch@collabora.co.uk>]

Configuration of DMA operation on an imx UART can fail, though the return
value is never checked and this goes unnoticed. Add error checking and fail
if this operation doesn't succeed.

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 08ccfe1..c190986 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1255,8 +1255,14 @@ static int imx_startup(struct uart_port *port)
 
 	/* Can we enable the DMA support? */
 	if (is_imx6q_uart(sport) && !uart_console(port) &&
-	    !sport->dma_is_inited)
-		imx_uart_dma_init(sport);
+	    !sport->dma_is_inited) {
+		retval = imx_uart_dma_init(sport);
+		if (retval) {
+			clk_disable_unprepare(sport->clk_per);
+			clk_disable_unprepare(sport->clk_ipg);
+			return retval;
+		}
+	}
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	/* Reset fifo's and state machines */
-- 
2.7.4
