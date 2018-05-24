From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 1/2] serial: imx: drop CTS/RTS handling from shutdown
Date: Thu, 24 May 2018 19:30:23 +0200
Message-ID: <20180524173024.20936-2-sebastian.reichel@collabora.co.uk>
References: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

According to Documentation/serial/driver the shutdown function should
not disable RTS, so drop it.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 6c53e74244ec..a0fc0327c8a5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1450,7 +1450,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	ucr2 = imx_uart_readl(sport, UCR2);
-	ucr2 &= ~(UCR2_TXEN | UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
+	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
 	imx_uart_writel(sport, ucr2, UCR2);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-- 
2.17.0
