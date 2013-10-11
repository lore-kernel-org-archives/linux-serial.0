From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 1/4] serial: imx: implement the flush_buffer hook
Date: Fri, 11 Oct 2013 18:30:58 +0800
Message-ID: <1381487461-12850-2-git-send-email-b32955@freescale.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:11744
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932469Ab3JKKpy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Oct 2013 06:45:54 -0400
In-Reply-To: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>

The current driver does not implement the flush_buffer hook for
uart_ops. When we enable the DMA for the driver, and test it with Bluetooth,
we may meet the following bug for TX:

    [1] User application may call the flush operation at any time.
        The uart_flush_buffer() calls the uart_circ_clear() to set
        the xmit->head and xmit->tail with 0.

    [2] The TX DMA callback can be called at any time too.
        The dma_tx_call() will update the xmit->tail.

    If [2] occurs just after the [1], we will get the wrong xmit->tail.

This patch implements the flush_buffer hook to fix this issue.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c07d9bb..708ba89 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1303,6 +1303,16 @@ static void imx_shutdown(struct uart_port *port)
 	clk_disable_unprepare(sport->clk_ipg);
 }
 
+static void imx_flush_buffer(struct uart_port *port)
+{
+	struct imx_port *sport = (struct imx_port *)port;
+
+	if (sport->dma_is_enabled) {
+		sport->tx_bytes = 0;
+		dmaengine_terminate_all(sport->dma_chan_tx);
+	}
+}
+
 static void
 imx_set_termios(struct uart_port *port, struct ktermios *termios,
 		   struct ktermios *old)
@@ -1623,6 +1633,7 @@ static struct uart_ops imx_pops = {
 	.break_ctl	= imx_break_ctl,
 	.startup	= imx_startup,
 	.shutdown	= imx_shutdown,
+	.flush_buffer	= imx_flush_buffer,
 	.set_termios	= imx_set_termios,
 	.type		= imx_type,
 	.release_port	= imx_release_port,
-- 
1.7.2.rc3


