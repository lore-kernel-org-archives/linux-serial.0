From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] serial: imx: disable UCR4_OREN on shutdown
Date: Thu, 24 May 2018 19:30:24 +0200
Message-ID: <20180524173024.20936-3-sebastian.reichel@collabora.co.uk>
References: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

UCR4_OREN is (depending on the configuration) enabled in startup,
but is never disabled. Fix this by disabling it in shutdown.

Reported-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a0fc0327c8a5..31e1df8a8d29 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1422,7 +1422,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
-	u32 ucr1, ucr2;
+	u32 ucr1, ucr2, ucr4;
 
 	if (sport->dma_is_enabled) {
 		dmaengine_terminate_sync(sport->dma_chan_tx);
@@ -1452,6 +1452,10 @@ static void imx_uart_shutdown(struct uart_port *port)
 	ucr2 = imx_uart_readl(sport, UCR2);
 	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
 	imx_uart_writel(sport, ucr2, UCR2);
+
+	ucr4 = imx_uart_readl(sport, UCR4);
+	ucr4 &= ~UCR4_OREN;
+	imx_uart_writel(sport, ucr4, UCR4);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	/*
-- 
2.17.0
