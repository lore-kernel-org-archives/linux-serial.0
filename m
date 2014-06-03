From: "Wang, Jiada (ESD)" <Jiada_Wang@mentor.com>
Subject: RE: [PATCH 1/4] serial: imx: implement the flush_buffer hook
Date: Tue, 3 Jun 2014 05:51:44 +0000
Message-ID: <857E9EDCA6C0904DB3357321AA9123EBE14C42AE@NA-MBX-01.mgc.mentorg.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
 <1381487461-12850-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:46299 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbaFCFvu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jun 2014 01:51:50 -0400
In-Reply-To: <1381487461-12850-2-git-send-email-b32955@freescale.com>
Content-Language: ja-JP
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc: "dirk.behme@gmail.com" <dirk.behme@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi Shijie

By having this commit,
I am seeing random hit of BUG_ON() in dma_cookie_complete(),
When large data file is set to UART port with relately high baud rate.

I suspect even after dmaengine_terminate_all() is called in .flush_buffer(),
By some reason, the 'terminated sdma channel' 's irq handler is still got called sometimes
Thus cause a extra of dma_cookie_complete() executed randomly.

To Shawn and Sascha
I found your discussion about sdma_disable_channel in
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/103283

this seems like a similar issue to the one I have observed in UART-SDMA usage
my understanding is there is potential race between stop of SDMA channel
and finish of SDMA transfer.
Do you have any ideas how to avoid this race condition?


Thanks,
Jiada

-----Original Message-----
From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Huang Shijie
Sent: Friday, October 11, 2013 7:31 PM
To: gregkh@linuxfoundation.org
Cc: Huang Shijie; shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; linux-serial@vger.kernel.org
Subject: [PATCH 1/4] serial: imx: implement the flush_buffer hook

The current driver does not implement the flush_buffer hook for uart_ops. When we enable the DMA for the driver, and test it with Bluetooth, we may meet the following bug for TX:

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

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index c07d9bb..708ba89 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1303,6 +1303,16 @@ static void imx_shutdown(struct uart_port *port)
 	clk_disable_unprepare(sport->clk_ipg);
 }
 
+static void imx_flush_buffer(struct uart_port *port) {
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



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
