From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 3/4] serial: imx: Remove unneeded OOM error message
Date: Mon, 27 Oct 2014 14:49:39 -0200
Message-ID: <1414428580-29534-3-git-send-email-fabio.estevam@freescale.com>
References: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1bon0112.outbound.protection.outlook.com ([157.56.111.112]:55028
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751015AbaJ0RYs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 13:24:48 -0400
In-Reply-To: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, fugang.duan@freescale.com, festevam@gmail.com, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

When kzalloc() fails the core MM will already complain about it, so there is
no need to have the error message locally.

Remove the unneeded error message.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7dc210..9e8685e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -991,7 +991,6 @@ static int imx_uart_dma_init(struct imx_port *sport)
 
 	sport->rx_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!sport->rx_buf) {
-		dev_err(dev, "cannot alloc DMA buffer.\n");
 		ret = -ENOMEM;
 		goto err;
 	}
-- 
1.9.1

