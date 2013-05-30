From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] serial/imx: disable hardware flow control at startup
Date: Thu, 30 May 2013 15:47:04 +0200
Message-ID: <1369921624-5595-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48529 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756503Ab3E3Nrk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 May 2013 09:47:40 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>

From: Lucas Stach <l.stach@pengutronix.de>

We only want to enable hardware flow control if RTS/CTS pins
are connected.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 147c9e1..8cdfbd3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -761,6 +761,8 @@ static int imx_startup(struct uart_port *port)
 
 	temp = readl(sport->port.membase + UCR2);
 	temp |= (UCR2_RXEN | UCR2_TXEN);
+	if (!sport->have_rtscts)
+		temp |= UCR2_IRTS;
 	writel(temp, sport->port.membase + UCR2);
 
 	if (USE_IRDA(sport)) {
-- 
1.8.2.1

