From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH] serial: imx: only set dma_is_rxing when DMA starts
Date: Thu, 28 Sep 2017 11:03:49 +0100
Message-ID: <1506593029-13849-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Romain Perier <romain.perier@collabora.com>, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

From: Romain Perier <romain.perier@collabora.com>

The variable dma_is_rxing is currently set to 1 in imx_disable_rx_int().
This is problematic as:

- whilst imx_disable_rx_int() is currently always called before
  start_rx_dma() this dependency isn't obvious.
- start_rx_dma() does error checking and might exit without
  enabling DMA. Currently this will result in dma_is_rxing suggesting
  that DMA is being used for recieving.

To avoid these issues, move the setting of dma_is_rxing to
start_rx_dma() when appropriate.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---

This patch has been split out of series: "[PATCH v3 0/6] serial: imx:
various improvements" as this is a stand alone fix and some of the
patches in the series are problematic.

 drivers/tty/serial/imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fe368a4..1691ed2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -714,8 +714,6 @@ static void imx_disable_rx_int(struct imx_port *sport)
 {
 	unsigned long temp;
 
-	sport->dma_is_rxing = 1;
-
 	/* disable the receiver ready and aging timer interrupts */
 	temp = readl(sport->port.membase + UCR1);
 	temp &= ~(UCR1_RRDYEN);
@@ -1074,6 +1072,7 @@ static int start_rx_dma(struct imx_port *sport)
 	desc->callback_param = sport;
 
 	dev_dbg(dev, "RX: prepare for the DMA.\n");
+	sport->dma_is_rxing = 1;
 	sport->rx_cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(chan);
 	return 0;
-- 
1.8.3.1
